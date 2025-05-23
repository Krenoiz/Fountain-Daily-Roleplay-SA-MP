CMD:respawnsags(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "Kamu harus menjadi admin.");

	for(new ii = 0; ii < MAX_PLAYERS; ii++)
	{
		if(IsValidVehicle(pData[ii][pSpawnSags]))
		{
			DestroyVehicle(pData[ii][pSpawnSags]);
			pData[ii][pSpawnSags] = INVALID_VEHICLE_ID;
			pData[ii][pSpawnSags] = 0;
		}
	}
    SendClientMessage(playerid, COLOR_WHITE, "Semua kendaraan faction SAGS telah dihancurkan.");
    return 1;
}

CMD:despawnsags(playerid, params[])
{
	// Sags Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1480.0067, -1828.6716, 13.5469) || IsPlayerInRangeOfPoint(playerid, 8.0, 1424.6909, -1789.1492, 33.4297))
	{
		if(pData[playerid][pFaction] != 2)
	        return Error(playerid, "You must be at SAGS officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

		DestroyVehicle(pData[playerid][pSpawnSags]);
		pData[playerid][pSpawnSags] = INVALID_VEHICLE_ID;
    	// DestroyVehicle(SAGSVeh[playerid]);
		pData[playerid][pSpawnSags] = 0;
    	GameTextForPlayer(playerid, "~w~SAGS Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnsags(playerid, params[])
{
    // Sags Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1480.0067, -1828.6716, 13.5469))
	{
		if(pData[playerid][pFaction] != 2)
	        return Error(playerid, "You must be at  officer faction!.");

		if(pData[playerid][pSpawnSags] != 0) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new Zanv[10000], String[10000];
	    strcat(Zanv, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Sags\tCars\n");// 596
		strcat(Zanv, String);
		format(String, sizeof(String), "Sags\tMotorcycle\n");// 597
		strcat(Zanv, String);
		format(String, sizeof(String), "Helicopter\tMotor Mabur\n");// 598
		strcat(Zanv, String);/*
		format(String, sizeof(String), "Helicopter 2\tCars\n"); // 599
		strcat(Zann, String);
		format(String, sizeof(String), "Premier\tSport Cars\n"); // 599
		strcat(Zann, String);*/
		ShowPlayerDialog(playerid,DIALOG_SAGS_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles San Andreas Agency", Zanv, "Spawn","Cancel");
	}
	return 1;
}

// STATISTIC VEHICLE SAGS //
#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SAGS_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1480.0067, -1828.6716, 13.5469))
				{
					pData[playerid][pSpawnSags] = CreateVehicle(409, 1480.2012,-1841.9386,13.5469,273.5804, 0, 1, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSags], 5000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAGS Vehicles '"YELLOW_E"/despawnsags"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1480.0067, -1828.6716, 13.5469))
				{
					pData[playerid][pSpawnSags] = CreateVehicle(522, 1480.2012,-1841.9386,13.5469,273.5804, 0, 1, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSags], 5000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAGS Vehicles '"YELLOW_E"/despawnsags"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1480.0067, -1828.6716, 13.5469))
				{
					pData[playerid][pSpawnSags] = CreateVehicle(487, 1424.6909, -1789.1492, 33.4297, 2.2475, 0, 1, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSags], 5000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAGS Vehicles '"YELLOW_E"/despawnsags"WHITE_E"' to despawn vehicles");
			}/*
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(563, 1162.8176, -1313.8239, 32.2215, 270.7216, 0, 1,120000, 0);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 3:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(487, 1162.8176, -1313.8239, 32.2215, 270.7216,0,1,120000,0);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(426, 1120.0265, -1317.1208, 13.8679, 271.4225,0,1,120000,0);
					AddVehicleComponent(SAMDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}*/
		}
		PutPlayerInVehicle(playerid,pData[playerid][pSpawnSags], 0);
		// pData[playerid][pSpawnSags] = 1;
		// PutPlayerInVehicle(playerid, SAGSVeh[playerid], 0);
	}
    return 1;
}

/*CMD:callsign(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
	new string[32];
	if(!IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You're not in a vehicle.");

	if (pData[playerid][pFaction] != 1 && pData[playerid][pFaction] != 3)
		return Error(playerid, "You must be a SAPD or SAMD!");

	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 1)
	{
 		Delete3DTextLabel(vehicle3Dtext[vehicleid]);
	    vehiclecallsign[vehicleid] = 0;
	    SendClientMessage(playerid, COLOR_RED, "CALLSIGN: {FFFFFF}Callsign removed.");
	    return 1;
	}
	if(sscanf(params, "s[32]",string))
		return SendSyntaxMessage(playerid, "/callsign [callsign]");

	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 0)
	{
		vehicle3Dtext[vehicleid] = Create3DTextLabel(string, COLOR_WHITE, 0.0, 0.0, 0.0, 10.0, 0, 1);
		Attach3DTextLabelToVehicle(vehicle3Dtext[vehicleid], vehicleid, 0.0, -2.8, 0.0);
		vehiclecallsign[vehicleid] = 1;
		SendClientMessage(playerid, COLOR_RED, "CALLSIGN: {FFFFFF}Type {FFFF00}/callsign {FFFFFF}again to remove.");
	}
	return 1;
}*/
