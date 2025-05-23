/*CMD:trackph(playerid, params[])
{
    new number;
    if(sscanf(params, "u", number)) {
        return Usage(playerid, "/trackph [number]");
    }

    if(pData[playerid][pFaction] != 1) {
        return Error(playerid, "You are not part of SAPD.");
    }

    // Check if the player exists and has a phone
    if(pData[number][pPhone] == 0) {
        return Error(playerid, "The player does not have a phone.");
    }

    // Check if the phone is online
    if(pData[number][pPhoneStatus] == 0) {
        return Error(playerid, "The phone is currently offline.");
    }

    // Ensure the player is not inside an interior or virtual world
    if(GetPlayerInterior(playerid) >= 1 || GetPlayerVirtualWorld(playerid) >= 1) {
        return SendClientMessage(playerid, COLOR_GREY, "You are in an interior or a virtual world, cannot track this phone.");
    }

    // Check if the player is on admin duty and prevent them from tracking
    if(pData[playerid][pAdminDuty] >= 1) {
        return SendClientMessage(playerid, COLOR_GREY, "You cannot track players while on admin duty.");
    }

    // Loop through all players and match the phone number
    new otherid = -1;
    foreach(new ii : Player) {
        if(pData[ii][pPhone] == number) {
            otherid = ii;
            break;
        }
    }

    if(otherid == -1) {
        return Error(playerid, "This phone number is not assigned to any player or is inactive.");
    }

    // Ensure the target player is logged in and connected
    if(pData[otherid][IsLoggedIn] == false || !IsPlayerConnected(otherid)) {
        return Error(playerid, "This number is not active or the player is not connected.");
    }

    // Proceed to track the phone location
    new zone[MAX_ZONE_NAME];
    GetPlayer3DZone(otherid, zone, sizeof(zone));
    new Float:sX, Float:sY, Float:sZ;
    GetPlayerPos(otherid, sX, sY, sZ);
    SetPlayerCheckpoint(playerid, sX, sY, sZ, 5.0);

    Info(playerid, "Tracking player with phone number: %d", pData[otherid][pPhone]);
    Info(playerid, "Player Name: %s", pData[otherid][pName]);
    Info(playerid, "Player Twitter: %s", pData[otherid][pTwittername]);
    Info(playerid, "Location: %s", zone);

    return 1;
}*/

/*CMD:trackatm(playerid, params[])
{
    if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");

	new atmid;
	if(sscanf(params, "d", atmid)) return Usage(playerid, "/trackatm [Id]");
	if(!Iter_Contains(ATMS, atmid)) return Error(playerid, "Maaf ATM dengan id {FFFF00}%d{FFFFFF} Tidak dapat ditemukan.", atmid);

	SetPlayerCheckpoint(playerid, AtmData[atmid][atmX]-3, AtmData[atmid][atmY], AtmData[atmid][atmZ], 3.0);
	Info(playerid, "Berhasil mendapatkan lokasi atm dengan id {FFFF00}%d", atmid);
    return 1;   	
}

CMD:tr(playerid, params[])
{
    if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");
		
    new mstr[128];
	if(IsPlayerConnected(playerid))
	{
        if(isnull(params))
		{
            Usage(playerid, "USAGE: /tr [name]");
            Info(playerid, "Names: ph, bis, house(coming)");
            return 1;
        }
		if(strcmp(params,"ph",true) == 0)
		{
			format(mstr, sizeof(mstr), "Input Phone Number to Track");
			ShowPlayerDialog(playerid, DIALOG_TRACK_PH, DIALOG_STYLE_INPUT, "Track Phone", mstr, "Track", "Cancel");
        }
        if(strcmp(params,"bis",true) == 0)
		{
   			format(mstr, sizeof(mstr), "Input Business Number to show information");
			ShowPlayerDialog(playerid, DIALOG_INFO_BIS, DIALOG_STYLE_INPUT, "Business", mstr, "Enter", "Cancel");
        }
        if(strcmp(params,"house",true) == 0)
		{
   			format(mstr, sizeof(mstr), "Input House Number to show information");
			ShowPlayerDialog(playerid, DIALOG_INFO_HOUSE, DIALOG_STYLE_INPUT, "House", mstr, "Enter", "Cancel");
        }
	}
	return 1;
}


CMD:mdc(playerid, params[])
{
    if(pData[playerid][pFaction] != 1)
		return Error(playerid, "You are not faction!");
		
 	new
  	string[10 * 32];
   	format(string, sizeof(string),"Phone\nBusiness\nHouse");
	ShowPlayerDialog(playerid, DIALOG_TRACK, DIALOG_STYLE_LIST, "SAPD Data Information", string, "Select", "Cancel");
	return 1;
}

forward CheckingBis(playerid);
public CheckingBis(playerid)
{
    if(pData[playerid][pActivity]) return 0;
	{
	   	if(pData[playerid][pActivityTime] >= 100)
	   	{
	    	InfoTD_MSG(playerid, 8000, "Checking done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 3;
			pData[playerid][pActivityTime] = 0;
			ShowBis(playerid);
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
  			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
 			PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	   	}
	}
	return 1;
}

forward CheckingHouse(playerid);
public CheckingHouse(playerid)
{
    if(pData[playerid][pActivity]) return 0;
	{
	   	if(pData[playerid][pActivityTime] >= 100)
	   	{
	    	InfoTD_MSG(playerid, 8000, "Checking done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 3;
			pData[playerid][pActivityTime] = 0;
			ShowHouse(playerid);
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
  			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
 			PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	   	}
	}
	return 1;
}

forward ShowHouse(playerid);
public ShowHouse(playerid)
{
	new Float: dist;
	new hid = GetPVarInt(playerid, "IDHouse");
	dist = GetPlayerDistanceFromPoint(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	new line9[900];
	new type[128];
	if(hData[hid][hType] == 1)
	{
		type = "Small";
	}
	else if(hData[hid][hType] == 2)
	{
		type = "Medium";
	}
	else if(hData[hid][hType] == 3)
	{
		type = "Big";
	}
	else
	{
		type = "Unknow";
	}
	format(line9, sizeof(line9), "House Number: {FFFF00}%d\n{FFFFFF}House Owner: {FFFF00}%s\n{FFFFFF}House Type: {FFFF00}%s\n{FFFFFF}Location: {FFFF00}%s\n{FFFFFF}Distance: {FFFF00}%.1f m",
	hid, hData[hid][hOwner], type, GetLocation(hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]), dist);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "House Info", line9, "Close","");

	return 1;
}

forward ShowBis(playerid);
public ShowBis(playerid)
{
	new line9[900];
	new type[128];
	new Float: dist;
	new bid = GetPVarInt(playerid, "IDBisnis");
	dist = GetPlayerDistanceFromPoint(playerid, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]);

	if(bData[bid][bType] == 1)
	{
		type = "Fast Food";
	}
	else if(bData[bid][bType] == 2)
	{
		type = "Market";
	}
	else if(bData[bid][bType] == 3)
	{
		type = "Clothes";
	}
	else if(bData[bid][bType] == 4)
	{
		type = "Equipment";
	}
	else
	{
		type = "Unknow";
	}
	format(line9, sizeof(line9), "Bisnis ID: {FFFF00}%d\n{FFFFFF}Bisnis Owner: {FFFF00}%s\n{FFFFFF}Bisnis Name: {FFFF00}%s\n{FFFFFF}Bisnis Type: {FFFF00}%s\n{FFFFFF}Location: {FFFF00}%s\n{FFFFFF}Distance: {FFFF00}%.1f m",
	bid, bData[bid][bOwner], bData[bid][bName], type, GetLocation(bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]), dist);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Bisnis Info", line9, "Close","");
	return 1;
}

forward trackph(playerid, to_player, number);
public trackph(playerid, to_player, number)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(to_player, x, y, z);
	SetPlayerCheckpoint(playerid, x, y, z, 50.0);
	Info(playerid, "You Has Succesfull Track Ph Number %d", number);
	return 1;
}*/
