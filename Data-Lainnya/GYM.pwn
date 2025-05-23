#define MAX_GYMOBJECT 10
#define MAX_GYMPOINT 10

enum GYMObjectInfo
{
	Float:GYMOBJPos[6],
	GYMvw,
	GYMint,
	Text3D:GYMOBJText,
	GYMOBJType,
	GYMOBJObject,
	GYMOBJUsed,
	GYMOBJCondition
};
new GYMInfo[MAX_GYMOBJECT][GYMObjectInfo];
new gymEdit[MAX_PLAYERS];
new gymEditID[MAX_PLAYERS];

new Float:gymObjectPos[MAX_PLAYERS][3];
new Float:gymObjectRot[MAX_PLAYERS][3];

enum bbInfo
{
	Float:bbPos[3],
	Text3D:bbText,
	bbPickup,
	GymVw,
	GymInt
};
new GymPoint[MAX_GYMPOINT][bbInfo];

//Function
stock SaveGYMObject()
{
	new idx = 1, File:file;
	new string[1024];
	while(idx < MAX_GYMOBJECT)
	{
		format(string, 1024, "%d|%d|%d|%f|%f|%f|%f|%f|%f|%d|%d\r\n",
		GYMInfo[idx][GYMOBJType],
		GYMInfo[idx][GYMOBJCondition],
		GYMInfo[idx][GYMOBJUsed],
		GYMInfo[idx][GYMOBJPos][0],
		GYMInfo[idx][GYMOBJPos][1],
		GYMInfo[idx][GYMOBJPos][2],
		GYMInfo[idx][GYMOBJPos][3],
		GYMInfo[idx][GYMOBJPos][4],
		GYMInfo[idx][GYMOBJPos][5],
        GYMInfo[idx][GYMvw],
		GYMInfo[idx][GYMint]);
		if(idx == 1)
		{
		    file = fopen("machine.cfg", io_write);
		}
		else
		{
		    file = fopen("machine.cfg", io_append);
		}
		fwrite(file, string);
		fclose(file);
		idx++;
	}
	print("Machine Berhasil Disimpan");
	return 1;
}

stock LoadGYMObject()
{
	new rinfo[15][1024];
	new string[1024];
	new File:file = fopen("machine.cfg", io_read);
	if(file)
	{
	    new idx = 1;
	    while(idx < MAX_GYMOBJECT)
	    {
	        fread(file, string);
	        split(string, rinfo, '|');
	        GYMInfo[idx][GYMOBJType] = strval(rinfo[0]);
			GYMInfo[idx][GYMOBJCondition] = strval(rinfo[1]);
			GYMInfo[idx][GYMOBJUsed] = strval(rinfo[2]);
			GYMInfo[idx][GYMOBJPos][0] = floatstr(rinfo[3]);
			GYMInfo[idx][GYMOBJPos][1] = floatstr(rinfo[4]);
			GYMInfo[idx][GYMOBJPos][2] = floatstr(rinfo[5]);
			GYMInfo[idx][GYMOBJPos][3] = floatstr(rinfo[6]);
			GYMInfo[idx][GYMOBJPos][4] = floatstr(rinfo[7]);
			GYMInfo[idx][GYMOBJPos][5] = floatstr(rinfo[8]);
			GYMInfo[idx][GYMvw] = strval(rinfo[9]);
			GYMInfo[idx][GYMint] = strval(rinfo[10]);
	        if(GYMInfo[idx][GYMOBJPos][0])
			{
				if(GYMInfo[idx][GYMOBJType] == 1)
			    {
					GYMInfo[idx][GYMOBJObject] = CreateDynamicObject(2627, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], GYMInfo[idx][GYMOBJPos][3], GYMInfo[idx][GYMOBJPos][4], GYMInfo[idx][GYMOBJPos][5], GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint]);
				}
				if(GYMInfo[idx][GYMOBJType] == 2)
			    {
					GYMInfo[idx][GYMOBJObject] = CreateDynamicObject(2630, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], GYMInfo[idx][GYMOBJPos][3], GYMInfo[idx][GYMOBJPos][4], GYMInfo[idx][GYMOBJPos][5], GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint]);
				}
				if(GYMInfo[idx][GYMOBJType] == 3)
			    {
					GYMInfo[idx][GYMOBJObject] = CreateDynamicObject(1985, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], GYMInfo[idx][GYMOBJPos][3], GYMInfo[idx][GYMOBJPos][4], GYMInfo[idx][GYMOBJPos][5], GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint]);
				}
				format(string, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
			}
			idx++;
		}
	}
	print("Machine Berhasil Dimuat");
	return 1;
}

stock SaveGym()
{
	new idx = 1, File:file;
	new string[200];
	while(idx < MAX_GYMPOINT)
	{
		format(string, sizeof(string), "%f|%f|%f|%d|%d\r\n",
		GymPoint[idx][bbPos][0],
		GymPoint[idx][bbPos][1],
		GymPoint[idx][bbPos][2],
		GymPoint[idx][GymVw],
		GymPoint[idx][GymInt]);
	    if(idx == 1)
	    {
	        file = fopen("gympoint.cfg", io_write);
		}
		else
		{
		    file = fopen("gympoint.cfg", io_append);
		}
		fwrite(file, string);
		fclose(file);
		idx++;
	}
	return 1;
}

stock LoadGym()
{
	new minfo[5][256];
	new string[200];
	new File:file = fopen("gympoint.cfg", io_read);
	if(file)
	{
	    new idx = 1;
		while(idx < MAX_GYMPOINT)
		{
			fread(file, string);
			split(string, minfo, '|');
			GymPoint[idx][bbPos][0] = floatstr(minfo[0]);
			GymPoint[idx][bbPos][1] = floatstr(minfo[1]);
			GymPoint[idx][bbPos][2] = floatstr(minfo[2]);
			GymPoint[idx][GymVw] = strval(minfo[3]);
			GymPoint[idx][GymInt] = strval(minfo[4]);
			if(GymPoint[idx][bbPos][0])
			{
				GymPoint[idx][bbPickup] = CreateDynamicPickup(1274, 23, GymPoint[idx][bbPos][0], GymPoint[idx][bbPos][1], GymPoint[idx][bbPos][2], GymPoint[idx][GymVw], GymPoint[idx][GymInt]);
				format(string, 128, "[ID:%d]\n{00FF00}Gym point\n{FFFFFF}use '/buy' here", idx);
				GymPoint[idx][bbText] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, GymPoint[idx][bbPos][0], GymPoint[idx][bbPos][1], GymPoint[idx][bbPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GymPoint[idx][GymVw], GymPoint[idx][GymInt], -1, 10.0);
			}
			idx++;
		}
	}
	return 1;
}
//Adm Cmd
CMD:createmachine(playerid, params[])
{
	new String[200];
	if(pData[playerid][pAdmin] < 7) return SendClientMessageEx(playerid, COLOR_WHITE, "{A9A9A9}ERROR: Unknown command, see '/help'");
    new choice[32], Float:X, Float:Y, Float:Z;
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "USE: /createmachine [bike,treadmill,boxing]");
		return 1;
	}
	for(new idx=1; idx<MAX_GYMOBJECT; idx++)
	{
	    if(strcmp(choice, "bike", true) == 0)
		{
		    if(!GYMInfo[idx][GYMOBJPos][0])
		    {
		        GetPlayerPos(playerid, X, Y, Z);
		        GYMInfo[idx][GYMOBJPos][0] = X;
		        GYMInfo[idx][GYMOBJPos][1] = Y;
		        GYMInfo[idx][GYMOBJPos][2] = Z;
		        GYMInfo[idx][GYMOBJPos][3] = X;
		        GYMInfo[idx][GYMOBJPos][4] = Y;
		        GYMInfo[idx][GYMOBJPos][5] = Z;
		        GYMInfo[idx][GYMOBJCondition] = 1000;
		        GYMInfo[idx][GYMOBJType] = 2;
		        GYMInfo[idx][GYMvw] = GetPlayerVirtualWorld(playerid);
	        	GYMInfo[idx][GYMint] = GetPlayerInterior(playerid);
		        GYMInfo[idx][GYMOBJObject] = CreateDynamicObject(2630, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], GYMInfo[idx][GYMOBJPos][3], GYMInfo[idx][GYMOBJPos][4], GYMInfo[idx][GYMOBJPos][5], GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint]);
      			format(String, sizeof(String), "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				idx = MAX_GYMOBJECT;
				SaveGYMObject();
			}
		}
		else if(strcmp(choice, "treadmill", true) == 0)
		{
		    if(!GYMInfo[idx][GYMOBJPos][0])
		    {
		        GetPlayerPos(playerid, X, Y, Z);
		        GYMInfo[idx][GYMOBJPos][0] = X;
		        GYMInfo[idx][GYMOBJPos][1] = Y;
		        GYMInfo[idx][GYMOBJPos][2] = Z;
		        GYMInfo[idx][GYMOBJPos][3] = X;
		        GYMInfo[idx][GYMOBJPos][4] = Y;
		        GYMInfo[idx][GYMOBJPos][5] = Z;
		        GYMInfo[idx][GYMOBJCondition] = 1000;
		        GYMInfo[idx][GYMOBJType] = 1;
		        GYMInfo[idx][GYMvw] = GetPlayerVirtualWorld(playerid);
	        	GYMInfo[idx][GYMint] = GetPlayerInterior(playerid);
		        GYMInfo[idx][GYMOBJObject] = CreateDynamicObject(2627, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], GYMInfo[idx][GYMOBJPos][3], GYMInfo[idx][GYMOBJPos][4], GYMInfo[idx][GYMOBJPos][5], GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint]);
      			format(String, sizeof(String), "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				idx = MAX_GYMOBJECT;
				SaveGYMObject();
			}
		}
		else if(strcmp(choice, "boxing", true) == 0)
		{
		    if(!GYMInfo[idx][GYMOBJPos][0])
		    {
		        GetPlayerPos(playerid, X, Y, Z);
		        GYMInfo[idx][GYMOBJPos][0] = X;
		        GYMInfo[idx][GYMOBJPos][1] = Y;
		        GYMInfo[idx][GYMOBJPos][2] = Z;
		        GYMInfo[idx][GYMOBJPos][3] = X;
		        GYMInfo[idx][GYMOBJPos][4] = Y;
		        GYMInfo[idx][GYMOBJPos][5] = Z;
		        GYMInfo[idx][GYMOBJCondition] = 1000;
		        GYMInfo[idx][GYMOBJType] = 3;
		        GYMInfo[idx][GYMvw] = GetPlayerVirtualWorld(playerid);
	        	GYMInfo[idx][GYMint] = GetPlayerInterior(playerid);
		        GYMInfo[idx][GYMOBJObject] = CreateDynamicObject(1985, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], GYMInfo[idx][GYMOBJPos][3], GYMInfo[idx][GYMOBJPos][4], GYMInfo[idx][GYMOBJPos][5], GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint]);
      			format(String, sizeof(String), "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				idx = MAX_GYMOBJECT;
				SaveGYMObject();
			}
		}
	}
	return 1;
}

CMD:editmachine(playerid, params[])
{
	new id, String[200], amount;
	if(pData[playerid][pAdmin] < 7) return SendClientMessageEx(playerid, COLOR_WHITE, "{25FF00}SERVER: {FFFFFF}Command tidak ada, Gunakan /help untuk melihat daftar Command.");
	if(sscanf(params, "s[32]", params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "USE: /editmachine [posisi,condition]");
	    return 1;
	}
	if(!strcmp(params, "posisi", true, 6))
	{
	    if(sscanf(params, "s[32]i", params, id)) return SendClientMessage(playerid, COLOR_WHITE, "/editgymobject posisi [id]");
		if(!GYMInfo[id][GYMOBJPos][0])
		{
			SendClientMessage(playerid, COLOR_GREY, "invalid id");
			return 1;
		}
		gymEdit[playerid] = 1;
		gymEditID[playerid] = id;
		GetDynamicObjectPos(GYMInfo[id][GYMOBJObject], gymObjectPos[playerid][0], gymObjectPos[playerid][1], gymObjectPos[playerid][2]);
		GetDynamicObjectRot(GYMInfo[id][GYMOBJObject], gymObjectRot[playerid][0], gymObjectRot[playerid][1], gymObjectRot[playerid][2]);
		EditDynamicObject(playerid, GYMInfo[id][GYMOBJObject]);
  		DestroyDynamic3DTextLabel(GYMInfo[id][GYMOBJText]);
  		format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", id, GYMInfo[id][GYMOBJCondition]);
		GYMInfo[id][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[id][GYMOBJPos][0], GYMInfo[id][GYMOBJPos][1], GYMInfo[id][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0);
		SaveGYMObject();
	}
	if(!strcmp(params, "condition", true, 9))
	{
	    if(sscanf(params, "s[32]ii", params, id, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/editgymobject condition [id] [amount]");
		if(!GYMInfo[id][GYMOBJPos][0])
		{
			SendClientMessage(playerid, COLOR_GREY, "invalid id");
			return 1;
		}
		GYMInfo[id][GYMOBJCondition] = amount;
		DestroyDynamic3DTextLabel(GYMInfo[id][GYMOBJText]);
    	format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", id, GYMInfo[id][GYMOBJCondition]);
		GYMInfo[id][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[id][GYMOBJPos][0], GYMInfo[id][GYMOBJPos][1], GYMInfo[id][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[id][GYMvw], GYMInfo[id][GYMint], -1, 10.0);
		SaveGYMObject();
	}
	return 1;
}

CMD:deletemachine(playerid, params[])
{
	new idx;
	if(pData[playerid][pAdmin] < 7) return SendClientMessageEx(playerid, COLOR_WHITE, "{25FF00}SERVER: {FFFFFF}Command tidak ada, Gunakan /help untuk melihat daftar Command.");
	if(sscanf(params, "i", idx)) return SendClientMessage(playerid, COLOR_WHITE, "USE: /deletemachine [id]");
	if(!GYMInfo[idx][GYMOBJPos][0])
	{
		SendClientMessage(playerid, COLOR_GREY, "invalid id");
		return 1;
	}
	GYMInfo[idx][GYMOBJPos][0] = 0.0;
 	GYMInfo[idx][GYMOBJPos][1] = 0.0;
  	GYMInfo[idx][GYMOBJPos][2] = 0.0;
	GYMInfo[idx][GYMOBJPos][3] = 0.0;
 	GYMInfo[idx][GYMOBJPos][4] = 0.0;
  	GYMInfo[idx][GYMOBJPos][5] = 0.0;
  	GYMInfo[idx][GYMOBJType] = 0;
  	GYMInfo[idx][GYMOBJCondition] = 0;
  	DestroyDynamicObject(GYMInfo[idx][GYMOBJObject]);
  	DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
	SaveGYMObject();
	return 1;
}

CMD:creategym(playerid, params[])
{
    new String[200];
	if(pData[playerid][pAdmin] < 7) return Error(playerid, "Unknown command, see '/help'");
 	for(new idx=1; idx<MAX_GYMPOINT; idx++)
	{
	    if(!GymPoint[idx][bbPos][0])
	    {
	        new Float:X, Float:Y, Float:Z;
	        GetPlayerPos(playerid, X, Y, Z);
	        GymPoint[idx][bbPos][0] = X;
	        GymPoint[idx][bbPos][1] = Y;
	        GymPoint[idx][bbPos][2] = Z;
	        GymPoint[idx][GymVw] = GetPlayerVirtualWorld(playerid);
	        GymPoint[idx][GymInt] = GetPlayerInterior(playerid);
	        GymPoint[idx][bbPickup] = CreateDynamicPickup(1274, 23, X, Y, Z, GymPoint[idx][GymVw], GymPoint[idx][GymInt]);
	        format(String, 128, "[ID:%d]\n{00FF00}Gym point\n{FFFFFF}use '/buy' here", idx);
			GymPoint[idx][bbText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, X, Y, Z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GymPoint[idx][GymVw], GymPoint[idx][GymInt], -1, 10.0);
			idx = MAX_GYMPOINT;
			SaveGym();
		}
	}
	return 1;
}

CMD:editgym(playerid, params[])
{
	new id, String[200];
	if(pData[playerid][pAdmin] < 7) return SendClientMessageEx(playerid, COLOR_RED, "<!>{FFFFFF}Error.");
	if(sscanf(params, "s[32]", params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "USE: /editGym [Opsi]");
	    SendClientMessage(playerid, COLOR_WHITE, "Opsi: Posisi");
	    return 1;
	}
	if(!strcmp(params, "posisi", true, 6))
	{
	    if(sscanf(params, "s[32]i", params, id)) return SendClientMessage(playerid, COLOR_WHITE, "/editGym posisi [id]");
		if(!GymPoint[id][bbPos][0])
		{
			SendClientMessage(playerid, COLOR_GREY, "invalid GymPoint id");
			return 1;
		}
		new Float:X, Float:Y, Float:Z;
  		GetPlayerPos(playerid, X, Y, Z);
		DestroyDynamicPickup(GymPoint[id][bbPickup]);
		DestroyDynamic3DTextLabel(GymPoint[id][bbText]);
		GymPoint[id][bbPickup] = CreateDynamicPickup(1274, 23, X, Y, Z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 150.0);
  		format(String, 128, "[ID:%d]\n{00FF00}Gym point\n{FFFFFF}use '/buy' here", id);
		GymPoint[id][bbText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, X, Y, Z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GymPoint[id][GymVw], GymPoint[id][GymInt], -1, 10.0);
		GetPlayerPos(playerid, GymPoint[id][bbPos][0], GymPoint[id][bbPos][1], GymPoint[id][bbPos][2]);
		SaveGym();
	}
	return 1;
}

CMD:deletegym(playerid, params[])
{
	new idx;
	if(pData[playerid][pAdmin] < 7) return SendClientMessageEx(playerid, COLOR_WHITE, "<!>{FFFFFF}Error.");
	if(sscanf(params, "i", idx)) return SendClientMessage(playerid, COLOR_WHITE, "USE: /deletegym [id]");
	if(!GymPoint[idx][bbPos][0])
	{
		SendClientMessage(playerid, COLOR_GREY, "invalid GymPoint id");
		return 1;
	}
	GymPoint[idx][bbPos][0] = 0.0;
 	GymPoint[idx][bbPos][1] = 0.0;
  	GymPoint[idx][bbPos][2] = 0.0;
  	DestroyDynamicPickup(GymPoint[idx][bbPickup]);
	DestroyDynamic3DTextLabel(GymPoint[idx][bbText]);
	SaveGym();
	return 1;
}

//player cmd
CMD:fitness2(playerid, params[])
{
	new String[200];

	if(pData[playerid][pGymVip] < 1)
		return SendClientMessage(playerid, -1, "ERROR: Anda tidak memiliki GYM Membership");

    if(pData[playerid][pEnergy] < 15)
    	return SendClientMessage(playerid, -1, "ERROR: Anda kekurangan Energi untuk melakukan Fitness");

    /*if(pData[playerid][pFitnessTimer] > 0)
    {
    	SendClientMessage(playerid, -1, "ERROR: Anda harus menunggu %d menit untuk melakukan Fitness kembali", pData[playerid][pFitnessTimer]);
		return 1;
	}*/
    for(new idx = 1; idx < sizeof(GYMInfo); idx++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2.5, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2]))
		{
		    if(GYMInfo[idx][GYMOBJType] == 1)
			{
				pData[playerid][pFitnessTimer] = 1*60;
				pData[playerid][pFitnessType] = 1;
				GYMInfo[idx][GYMOBJCondition] -= Random(50, 100);
				DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
				format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				//SetPlayerPos(playerid, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2]+0.5);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_sprint", 4.1, 0, 0, 0, 0, 9999999);
				SetCameraBehindPlayer(playerid);

				pData[playerid][pActivity] = SetTimerEx("FitnessTime", 1300, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Progress..");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

				Streamer_Update(playerid);
			}
			if(GYMInfo[idx][GYMOBJType] == 2)
			{
				pData[playerid][pFitnessTimer] = 1*60;
				pData[playerid][pFitnessType] = 2;
	         	GYMInfo[idx][GYMOBJCondition] -= Random(50, 100);
				DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
				format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				SetPlayerPos(playerid, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2]+0.5);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_bike_faster", 4.1, 0, 0, 0, 0, 9999999);
				SetCameraBehindPlayer(playerid);

				pData[playerid][pActivity] = SetTimerEx("FitnessTime", 1300, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Progress..");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

				Streamer_Update(playerid);
			}
			if(GYMInfo[idx][GYMOBJType] == 3)
			{
				pData[playerid][pFitnessTimer] = 1*60;
				pData[playerid][pFitnessType] = 3;
	         	GYMInfo[idx][GYMOBJCondition] -= Random(50, 100);
				DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
				format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
				GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
				ApplyAnimation(playerid, "GYMNASIUM", "GYMshadowbox", 4.1, 0, 0, 0, 0, 9999999);
				SetCameraBehindPlayer(playerid);

				pData[playerid][pActivity] = SetTimerEx("FitnessTime", 1300, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Progress..");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

				Streamer_Update(playerid);
			}
			return idx;
		}
	}
 	return 1;
}

CMD:fstyle(playerid, params[])
{
	for(new a = 1; a < sizeof(GymPoint); a++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, GymPoint[a][bbPos][0], GymPoint[a][bbPos][1], GymPoint[a][bbPos][2]))
		{
			if(pData[playerid][pGymVip] >= 1)
			{
				ShowPlayerDialog(playerid, DIALOG_FSTYLE, DIALOG_STYLE_LIST, "Fighting Moves(Gym Membership)", "Boxing		$200.00\nElbow		$300.00\nKneehead	$400.00\nKung-Fu	$400.00\nGrabKick	$200.00\nNormal - Style", "Learn", "Cancel");
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_FSTYLE, DIALOG_STYLE_LIST, "Fighting Moves", "Boxing		$200.00\nElbow		$300.00\nKneehead	$400.00\nKung-Fu	$400.00\nGrabKick	$200.00\nNormal - Style", "Learn", "Cancel");
			}
		}
	}
	return 1;
}

