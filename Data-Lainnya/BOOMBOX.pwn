new vehicleStream[MAX_VEHICLES][128];

enum
{
	MUSIC_NONE,
	MUSIC_BOOMBOX,
	MUSIC_VEHICLE
};

enum enumURL
{
	NameURL[32],
	LinkURL[100],
};

new const ListURLMusic[][enumURL] =
{
	{"LeeSadSong", "http://mboxdrive.com/Maafkanaku.mp3"},
	{"DjAngel", "http://mboxdrive.com/DJANGEL.mp3"},
	{"Ga Kuat Nahan", "http://mboxdrive.com/Kenthu.mp3"},
	{"Tak Seindah Malam Kemarin", "http://mboxdrive.com/Dba.mp3"},
	{"Sampe Bawah", "http://mboxdrive.com/Party.mp3"},
	{"Love Story", "http://d.zaix.ru/mfLg.txt"},
	{"Jeff Kalee Strawberry", "http://mboxdrive.com/INDOLUCKY.mp3"},
	{"Someone You Loved", "http://d.zaix.ru/krgQ.mp3"},
	{"Dj All Night", "http://d.zaix.ru/kDiA.png"}
};

IsPlayerInRangeOfDynamicObject(playerid, objectid, Float:radius)
{
	if(IsValidDynamicObject(objectid))
	{
		new
		    interiorid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_INTERIOR_ID),
			worldid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_WORLD_ID),
		    Float:x,
		    Float:y,
		    Float:z;

		GetDynamicObjectPos(objectid, x, y, z);

		if(interiorid == -1) {
		    interiorid = GetPlayerInterior(playerid);
		} if(worldid == -1) {
		    worldid = GetPlayerVirtualWorld(playerid);
		}

		if(IsPlayerInRangeOfPoint(playerid, radius, x, y, z) && GetPlayerInterior(playerid) == interiorid && GetPlayerVirtualWorld(playerid) == worldid)
		{
		    return 1;
		}
	}

	return 0;
}

stock SetMusicStream(type, playerid, url[])
{
	switch(type)
	{
		case MUSIC_BOOMBOX:
		{
		    foreach(new i : Player)
		    {
		        if(pData[i][pBoomboxListen] == playerid)
		        {
				    if(isnull(url) && pData[i][pStreamType] == type)
				    {
				        StopAudioStreamForPlayer(i);
			            pData[i][pStreamType] = MUSIC_NONE;
			        }
			        else if(pData[i][pStreamType] == MUSIC_NONE || pData[i][pStreamType] == MUSIC_BOOMBOX)
			        {
			            PlayAudioStreamForPlayer(i, url);
			            pData[i][pStreamType] = type;
			        }
				}
			}

			strcpy(pData[playerid][pBoomboxURL], url, 128);
		}
		case MUSIC_VEHICLE:
		{
		    foreach(new i : Player)
		    {
		        if(IsPlayerInVehicle(i, playerid))
		        {
				    if(isnull(url) && pData[i][pStreamType] == type)
				    {
		        		StopAudioStreamForPlayer(i);
	            		pData[i][pStreamType] = MUSIC_NONE;
			        }
	    		    else if(pData[i][pStreamType] == MUSIC_NONE || pData[i][pStreamType] == MUSIC_VEHICLE)
			        {
	    		        PlayAudioStreamForPlayer(i, url);
	           		 	pData[i][pStreamType] = type;
					}
				}
			}

			strcpy(vehicleStream[playerid], url, 128);
		}
	}
}

stock DestroyBoombox(playerid)
{
	if(pData[playerid][pBoomboxPlaced])
	{
    	DestroyDynamicObject(pData[playerid][pBoomboxObject]);
		DestroyDynamic3DTextLabel(pData[playerid][pBoomboxText]);

		pData[playerid][pBoomboxObject] = INVALID_OBJECT_ID;
		pData[playerid][pBoomboxText] = Text3D:INVALID_3DTEXT_ID;
        pData[playerid][pBoomboxPlaced] = 0;
        pData[playerid][pBoomboxURL] = 0;
	}
}

stock GetNearbyBoombox(playerid)
{
	foreach(new i : Player)
	{
	    if(pData[i][pBoomboxPlaced] && IsPlayerInRangeOfDynamicObject(playerid, pData[i][pBoomboxObject], 30.0))
	    {
	        return i;
		}
	}

	return INVALID_PLAYER_ID;
}

CMD:boombox(playerid, params[])
{
	new option[10], param[128];

	if(pData[playerid][pBoombox] != 1)
		return Error(playerid, "You don't have a Boombox!");

	if(sscanf(params, "s[10]S()[128]", option, param))
	    return Usage(playerid, "/boombox [ place, pickup, list, url ]");

	//if(pData[playerid][pTazedTime] > 0 || pData[playerid][pInjured] > 0 || pData[playerid][pHospital] > 0 || pData[playerid][pTied] > 0 || pData[playerid][pCuffed] > 0 || pData[playerid][pJailTime] > 0)
	    //return Error(playerid, "Kamu tidak dapat menggunakan command ini saat ini.");
	
	if(IsPlayerInAnyVehicle(playerid))
	    return Error(playerid, "You can't use this command in the vehicle!");

	if(!strcmp(option, "place", true))
	{
	    if(pData[playerid][pBoomboxPlaced])
	        return Error(playerid, "You've put the Boombox!");

	    if(GetNearbyBoombox(playerid) != INVALID_PLAYER_ID)
	        return Error(playerid, "Around your place there are already other people's Boomboxes, please move");

		new
		    Float:x,
	    	Float:y,
	    	Float:z,
	    	Float:a,
			string[128];

		format(string, sizeof(string), "{62da92}[Boombox]\n{FFFFFF}Use {FFFF00}'/boombox'{FFFFFF} to play music.", GetName(playerid));

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

	    pData[playerid][pBoomboxPlaced] = 1;
    	pData[playerid][pBoomboxObject] = CreateDynamicObject(2229, x, y, z - 1.0, 0.0, 0.0, a, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    	pData[playerid][pBoomboxText] = CreateDynamic3DTextLabel(string, COLOR_ORANGE, x, y, z - 0.8, 10.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid));
        pData[playerid][pBoomboxURL] = 0;

    	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s put the boombox below", ReturnName(playerid));
	}
	else if(!strcmp(option, "pickup", true))
	{
	    if(!pData[playerid][pBoomboxPlaced])
	        return Error(playerid, "You haven't put Boombox!");

	    if(!IsPlayerInRangeOfDynamicObject(playerid, pData[playerid][pBoomboxObject], 3.0))
	        return Error(playerid, "You are not within reach of your Boombox!");

		SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s pick up the boombox and turn off the music.", ReturnName(playerid));
		DestroyBoombox(playerid);
	}
    else if(!strcmp(option, "url", true))
	{
        if(!pData[playerid][pBoomboxPlaced])
	        return Error(playerid, "You haven't put Boombox!");

	    if(!IsPlayerInRangeOfDynamicObject(playerid, pData[playerid][pBoomboxObject], 3.0))
	        return Error(playerid, "You are not within reach of your Boombox!");

    	pData[playerid][pMusicType] = MUSIC_BOOMBOX;
    	ShowPlayerDialog(playerid, DIALOG_BOOMBOX_URL, DIALOG_STYLE_INPUT, "URL Music", "Please enter the URL of the music you want to play:", "Input", "Close");
	}
	else if(!strcmp(option, "list", true))
	{
		new str[2048];

		if(!pData[playerid][pBoomboxPlaced])
	        return Error(playerid, "You haven't put Boombox!");

	    if(!IsPlayerInRangeOfDynamicObject(playerid, pData[playerid][pBoomboxObject], 3.0))
	        return Error(playerid, "You are not within reach of your Boombox!");
		
		if(isnull(str))
		{
			format(str, sizeof(str), "Song Title\n");			
			
			for(new i = 0; i < sizeof(ListURLMusic); i ++)
			{
				format(str, sizeof(str), "%s\n%s\n", str, ListURLMusic[i][NameURL]);
			}
		}

		pData[playerid][pMusicType] = MUSIC_BOOMBOX;

		ShowPlayerDialog(playerid, DIALOG_BOOMBOX_LIST, DIALOG_STYLE_TABLIST_HEADERS, "List Music", str, "Select", "Close");
	}
	else if(!strcmp(option, "stop", true))
	{
		Servers(playerid, "You have turn off the music.");
		SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s turn off the music.", ReturnName(playerid));
		pData[playerid][pStreamType] = MUSIC_NONE;
		pData[playerid][pBoomboxURL] = 0;
		StopAudioStreamForPlayer(playerid);
	}

	return 1; 
}

CMD:destroybb(playerid, params[])
{
	new boomboxid;

	if(pData[playerid][pAdmin] < 4)
	    return Error(playerid, "You don't have permission to use this command.");

	if((boomboxid = GetNearbyBoombox(playerid)) == INVALID_PLAYER_ID)
		return Error(playerid, "You are not within reach of your Boombox!");

	Servers(playerid, "You have destroyed {FF0000}%s {FFFFFF}Boombox", GetName(boomboxid));
	DestroyBoombox(boomboxid);

	return 1;
}
