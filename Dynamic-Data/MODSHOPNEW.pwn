#define MAX_MODSHOP 100

enum mods
{
	Float:ModsPos[3],
	Text3D:ModsText,
	ModsPickup,
	ModsVw,
	ModsInt
};
new ModsPoint[MAX_MODSHOP][mods];

stock SaveModsPoint()
{
	new idx = 1, File:file;
	new string[200];
	while(idx < MAX_MODSHOP)
	{
		format(string, sizeof(string), "%f|%f|%f|%d|%d\r\n",
		ModsPoint[idx][ModsPos][0],
		ModsPoint[idx][ModsPos][1],
		ModsPoint[idx][ModsPos][2],
		ModsPoint[idx][ModsVw],
		ModsPoint[idx][ModsInt]);
	    if(idx == 1)
	    {
	        file = fopen("Modspoint.cfg", io_write);
		}
		else
		{
		    file = fopen("Modspoint.cfg", io_append);
		}
		fwrite(file, string);
		fclose(file);
		idx++;
	}
	return 1;
}

stock LoadModsPoint()
{
	new minfo[5][256];
	new string[200];
	new File:file = fopen("Modspoint.cfg", io_read);
	if(file)
	{
	    new idx = 1;
		while(idx < MAX_MODSHOP)
		{
			fread(file, string);
			split(string, minfo, '|');
			ModsPoint[idx][ModsPos][0] = floatstr(minfo[0]);
			ModsPoint[idx][ModsPos][1] = floatstr(minfo[1]);
			ModsPoint[idx][ModsPos][2] = floatstr(minfo[2]);
			ModsPoint[idx][ModsVw] = strval(minfo[3]);
			ModsPoint[idx][ModsInt] = strval(minfo[4]);
			if(ModsPoint[idx][ModsPos][0])
			{
				ModsPoint[idx][ModsPickup] = CreateDynamicPickup(1274, 23, ModsPoint[idx][ModsPos][0], ModsPoint[idx][ModsPos][1], ModsPoint[idx][ModsPos][2], ModsPoint[idx][ModsVw], ModsPoint[idx][ModsInt]);
				format(string, 128, "[ID:%d]\n{00FF00}Modshop Point\n{FFFFFF}use '/buy' here", idx);
				ModsPoint[idx][ModsText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, ModsPoint[idx][ModsPos][0], ModsPoint[idx][ModsPos][1], ModsPoint[idx][ModsPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ModsPoint[idx][ModsVw], ModsPoint[idx][ModsInt], -1, 10.0);
			}
			idx++;
		}
	}
	return 1;
}

CMD:creatempoint(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    new String[200];
	if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);
 	for(new idx=1; idx<MAX_MODSHOP; idx++)
	{
	    if(!ModsPoint[idx][ModsPos][0])
	    {
	        new Float:X, Float:Y, Float:Z;
	        GetPlayerPos(playerid, X, Y, Z);
	        ModsPoint[idx][ModsPos][0] = X;
	        ModsPoint[idx][ModsPos][1] = Y;
	        ModsPoint[idx][ModsPos][2] = Z;
	        ModsPoint[idx][ModsVw] = GetPlayerVirtualWorld(playerid);
	        ModsPoint[idx][ModsInt] = GetPlayerInterior(playerid);
	        ModsPoint[idx][ModsPickup] = CreateDynamicPickup(1274, 23, X, Y, Z, ModsPoint[idx][ModsVw], ModsPoint[idx][ModsInt]);
	        format(String, 128, "[ID:%d]\n{00FF00}Modshop Point\n{FFFFFF}use '/buy' here", idx);
			ModsPoint[idx][ModsText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, X, Y, Z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ModsPoint[idx][ModsVw], ModsPoint[idx][ModsInt], -1, 10.0);
			idx = MAX_MODSHOP;
			SaveModsPoint();
		}
	}
	return 1;
}

CMD:editmpoint(playerid, params[])
{
	new id, String[200];
	if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);
	if(sscanf(params, "s[32]", params))
	{
	    Usage(playerid, "/editmpoint [Opsi]");
	    Info(playerid, "Posisi");
	    return 1;
	}
	if(!strcmp(params, "posisi", true, 6))
	{
	    if(sscanf(params, "s[32]i", params, id)) return Usage(playerid, "/editGym posisi [id]");
		if(!ModsPoint[id][ModsPos][0])
		{
			SendClientMessage(playerid, COLOR_GREY, "invalid ModsPoint id");
			return 1;
		}
		new Float:X, Float:Y, Float:Z;
  		GetPlayerPos(playerid, X, Y, Z);
		DestroyDynamicPickup(ModsPoint[id][ModsPickup]);
		DestroyDynamic3DTextLabel(ModsPoint[id][ModsText]);
		ModsPoint[id][ModsPickup] = CreateDynamicPickup(1274, 23, X, Y, Z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 150.0);
  		format(String, 128, "[ID:%d]\n{00FF00}Modshop Point\n{FFFFFF}use '/buy' here", id);
		ModsPoint[id][ModsText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, X, Y, Z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ModsPoint[id][ModsVw], ModsPoint[id][ModsInt], -1, 10.0);
		GetPlayerPos(playerid, ModsPoint[id][ModsPos][0], ModsPoint[id][ModsPos][1], ModsPoint[id][ModsPos][2]);
		SaveModsPoint();
	}
	return 1;
}

CMD:deletempoint(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	new idx;
	if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);
	if(sscanf(params, "i", idx)) return Usage(playerid, "/deletegym [id]");
	if(!ModsPoint[idx][ModsPos][0])
	{
		SendClientMessage(playerid, COLOR_GREY, "invalid ModsPoint id");
		return 1;
	}
	ModsPoint[idx][ModsPos][0] = 0.0;
 	ModsPoint[idx][ModsPos][1] = 0.0;
  	ModsPoint[idx][ModsPos][2] = 0.0;
  	DestroyDynamicPickup(ModsPoint[idx][ModsPickup]);
	DestroyDynamic3DTextLabel(ModsPoint[idx][ModsText]);
	SaveModsPoint();
	return 1;
}
