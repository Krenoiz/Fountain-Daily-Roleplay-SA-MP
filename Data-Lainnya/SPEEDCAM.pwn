#define MAX_SPEEDCAM 50

enum E_SPEEDCAM
{
	Float:camX,
	Float:camY,
	Float:camZ,
	Float:camRX,
	Float:camRY,
	Float:camRZ,
	camWorld,
	camInt,
	camSpeed,
	//TEMP
	camObj,
	Text3D:camLabel
};

new camData[MAX_SPEEDCAM][E_SPEEDCAM],
	Iterator:Speedcam<MAX_SPEEDCAM>;

Speedcam_Save(id)
{
	new dquery[2048];
	format(dquery, sizeof(dquery), "UPDATE speedcam SET camx='%f', camy='%f', camz='%f', camrx='%f', camry='%f', camrz='%f', camworld='%d', camint='%d', camspeed='%d' WHERE ID='%d'",
	camData[id][camX],
	camData[id][camY],
	camData[id][camZ],
	camData[id][camRX],
	camData[id][camRY],
	camData[id][camRZ],
	camData[id][camWorld],
	camData[id][camInt],
	camData[id][camSpeed],
	id);

	return mysql_tquery(g_SQL, dquery);
}

Speedcam_Refresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamicObject(camData[id][camObj]))
			DestroyDynamicObject(camData[id][camObj]);

		if(IsValidDynamic3DTextLabel(camData[id][camLabel]))
			DestroyDynamic3DTextLabel(camData[id][camLabel]);

		new tstr[1024];
		format(tstr, sizeof(tstr), "Speedcam ID: %d\n{ffffff}Location: {ffff00}%s\n{ffffff}Max Speed: {ffff00}%d/Mph\n{ffffff}Notifications at the police", id, GetLocation(camData[id][camX], camData[id][camY], camData[id][camZ]), camData[id][camSpeed]);
        camData[id][camObj] = CreateDynamicObject(18880, camData[id][camX], camData[id][camY], camData[id][camZ], camData[id][camRX], camData[id][camRY], camData[id][camRZ], camData[id][camWorld], camData[id][camInt], -1, 90.0, 90.0);
       	camData[id][camLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, camData[id][camX], camData[id][camY], camData[id][camZ]+3.5, 5.0);
	}		
	return 1;
}

function LoadSpeedcam()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new camid;
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", camid);
		    cache_get_value_name_float(i, "camx", camData[camid][camX]);
		    cache_get_value_name_float(i, "camy", camData[camid][camY]);
		    cache_get_value_name_float(i, "camz", camData[camid][camZ]);
		   	cache_get_value_name_float(i, "camrx", camData[camid][camRX]);
		    cache_get_value_name_float(i, "camry", camData[camid][camRY]);
		    cache_get_value_name_float(i, "camrz", camData[camid][camRZ]);
		    cache_get_value_name_int(i, "camworld", camData[camid][camWorld]);
			cache_get_value_name_int(i, "camint", camData[camid][camInt]);
			cache_get_value_name_int(i, "camspeed", camData[camid][camSpeed]);
			Speedcam_Refresh(camid);
			Iter_Add(Speedcam, camid);
	    }
	    printf("[SPEED CAM] Number of Speedcam loaded: %d.", rows);
	}
}


function GetSpeedCam(playerid)
{
	if(pData[playerid][TimerSpeedcam] <= 0)
	{
		foreach(new camid : Speedcam)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, camData[camid][camX], camData[camid][camY], camData[camid][camZ]))
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new vehid = GetPlayerVehicleID(playerid);
					foreach(new ii : PVehicles)
					{
						if(vehid == pvData[ii][cVeh])
						{
							if(GetVehicleSpeed(pvData[ii][cVeh]) > camData[camid][camSpeed])
							{
								pData[playerid][TimerSpeedcam] = 20;
								Info(playerid, "Kamu melebehi batas kecepatan di wilayah ini, kecepatan mu %.0f/Mph", GetVehicleSpeed(pvData[ii][cVeh]));
								SendFactionMessage(1, COLOR_RADIO, "{004BFF}Vehicle : Location: [{FFFF00}%s{004BFF}] Model: [{FFFF00}%s{004BFF}]", GetLocation(camData[camid][camX], camData[camid][camY], camData[camid][camZ]), GetVehicleName(pvData[ii][cVeh]));
								SendFactionMessage(1, COLOR_RADIO, "{004BFF}Perpetrator: Phone: [{FFFF00}%d{004BFF}] Plate : [{FFFF00}%s{004BFF}] Speed : {FFFF00}%.0f/Mph", pData[playerid][pPhone], pvData[ii][cPlate], GetVehicleSpeed(pvData[ii][cVeh]));
								return 1;
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

//--------

//----------[ Speedcam Commands ]-----------
CMD:createspeedcam(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new camid = Iter_Free(Speedcam), query[512];

	if(camid == -1) return Error(playerid, "You cant create more speedcam!");

	new maxspeed;
	if(sscanf(params, "d", maxspeed))
		return Usage(playerid, "/createspeedcam [maxspeed/mph]");

	if(maxspeed < 10 || maxspeed > 250)
		return Error(playerid, "Max speed only 10 - 250/Mph");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	camData[camid][camX] = x+0.0;
	camData[camid][camY] = y+0.0;
	camData[camid][camZ] = z-1.0;
	camData[camid][camRX] = camData[camid][camRY] = camData[camid][camRZ] = 0.0;
	camData[camid][camWorld] = GetPlayerVirtualWorld(playerid);
	camData[camid][camInt] = GetPlayerInterior(playerid);
	camData[camid][camSpeed] = maxspeed;

	SendStaffMessage(COLOR_LIGHTRED, "%s telah membuat speedcam ID: %d.", pData[playerid][pAdminname], camid);
  	Speedcam_Refresh(camid);
	Iter_Add(Speedcam, camid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO speedcam SET ID='%d', camspeed='%d'", camid, camData[camid][camSpeed]);
	mysql_tquery(g_SQL, query, "OnSpeedcamCreated", "i", camid);
	return 1;
}

function OnSpeedcamCreated(camid)
{
	Speedcam_Save(camid);
	return 1;
}

CMD:editspeedcam(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
    	return PermissionError(playerid);

    static
     camid,
      type[24],
       string[128];

    if(sscanf(params, "ds[24]S()[128]", camid, type, string))
    {
        Usage(playerid, "/editspeedcam [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} position, location, maxspeed, delete");
        return 1;
    }

    if(!Iter_Contains(Speedcam, camid)) 
		return Error(playerid, "Invalid ID.");

	if(!strcmp(type, "position", true))
    {
    	if(pData[playerid][EditingSPEEDCAM] != -1) 
			return Error(playerid, "You're already editing.");

    	if(!IsPlayerInRangeOfPoint(playerid, 30.0, camData[camid][camX], camData[camid][camY], camData[camid][camZ])) 
			return Error(playerid, "You're not near the speedcam you want to edit.");

		pData[playerid][EditingSPEEDCAM] = camid;
		EditDynamicObject(playerid, camData[camid][camObj]);
    }
	if(!strcmp(type, "location", true))
    {
    	new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		camData[camid][camX] = x+2.0;
		camData[camid][camY] = y+2.0;
		camData[camid][camZ] = z+0.5;

		Speedcam_Refresh(camid);
        Speedcam_Save(camid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of Speedcam ID: %d.", pData[playerid][pAdminname], camid);
    }
    if(!strcmp(type, "maxspeed", true))
    {
    	new ammount;

        if(sscanf(string, "d", ammount))
            return Usage(playerid, "/editspeedcam [id] [maxspeed] [ammount]");

        if(ammount < 10 || ammount > 250)
        	return Error(playerid, "Max speed tidak bisa kurang dari 10 dan lebih dari 250");

		camData[camid][camSpeed] = ammount;

		Speedcam_Refresh(camid);
        Speedcam_Save(camid);

		SendAdminMessage(COLOR_RED, "%s has adjusted the maxspeed of Speedcam ID: %d to %d/Mph.", pData[playerid][pAdminname], camid, ammount);
    }
    else if(!strcmp(type, "delete", true))
    {
		new query[512];
		if(IsValidDynamicObject(camData[camid][camObj]))
			DestroyDynamicObject(camData[camid][camObj]);

		if(IsValidDynamic3DTextLabel(camData[camid][camLabel]))
			DestroyDynamic3DTextLabel(camData[camid][camLabel]);

		camData[camid][camX] = camData[camid][camY] = camData[camid][camZ] = camData[camid][camRX] = camData[camid][camRY] = camData[camid][camRZ] = 0.0;
		camData[camid][camWorld] = camData[camid][camInt] = 0;
		camData[camid][camObj] = -1;
		camData[camid][camLabel] = Text3D: -1;

		Iter_Remove(Speedcam, camid);
		
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM speedcam WHERE id=%d", camid);
		mysql_tquery(g_SQL, query);
		SendStaffMessage(COLOR_LIGHTRED, "Staff %s menghapus Speedcam ID %d.", pData[playerid][pAdminname], camid);
	}
    return 1;
}

CMD:gotospeedcam(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new camid;
	if(sscanf(params, "d", camid))
		return Usage(playerid, "/gotospeedcam [id]");

	if(!Iter_Contains(Speedcam, camid))
		return Error(playerid, "Invalid ID.");

	SetPlayerPos(playerid, camData[camid][camX]+0.5, camData[camid][camY]+0.5, camData[camid][camZ]+0.5);
	SetPlayerInterior(playerid, camData[camid][camInt]);
	SetPlayerVirtualWorld(playerid, camData[camid][camWorld]);
	Info(playerid, "Kamu telah diteleport menuju speedcam id: %d", camid);
	return 1;
}

/*
----------[ENUM PLAYER IN GM.pwn]--------
 	//SPEEDCAM
 	EditingSPEEDCAM,
 	TimerSpeedcam,


-----------[NATIVE.pwn]-----------
pData[playerid][EditingSPEEDCAM] = -1;


----------[PUBLIC ONPLAYERUPDATE]----------
	//SPEEDLIMIT




---------[FUNCTION.pwn NERF TIMER SPEEDCAM]-----------
		// Speedcam Timer
		if(pData[ii][TimerSpeedcam] > 0)
		{
			pData[ii][TimerSpeedcam]--;
		}





--------[ON PLAYER EDITDYNAMIC OBJECT]-------------

	if(pData[playerid][EditingSPEEDCAM] != -1 && Iter_Contains(Speedcam, pData[playerid][EditingSPEEDCAM]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new camid = pData[playerid][EditingSPEEDCAM];
	        camData[camid][camX] = x;
	        camData[camid][camY] = y;
	        camData[camid][camZ] = z;
	        camData[camid][camRX] = rx;
	        camData[camid][camRY] = ry;
	        camData[camid][camRZ] = rz;

	        SetDynamicObjectPos(objectid, camData[camid][camX], camData[camid][camY], camData[camid][camZ]);
	        SetDynamicObjectRot(objectid, camData[camid][camRX], camData[camid][camRY], camData[camid][camRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, camData[camid][camLabel], E_STREAMER_X, camData[camid][camX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, camData[camid][camLabel], E_STREAMER_Y, camData[camid][camY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, camData[camid][camLabel], E_STREAMER_Z, camData[camid][camZ] + 3.5);

		    Speedcam_Save(camid);
	        pData[playerid][EditingSPEEDCAM] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new camid = pData[playerid][EditingSPEEDCAM];
	        SetDynamicObjectPos(objectid, camData[camid][camX], camData[camid][camY], camData[camid][camZ]);
	        SetDynamicObjectRot(objectid, camData[camid][camRX], camData[camid][camRY], camData[camid][camRZ]);
	        pData[playerid][EditingSPEEDCAM] = -1;
	    }
	}
*
