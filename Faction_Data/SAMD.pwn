CMD:respawnsamd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "Kamu harus menjadi admin.");

	for(new ii = 0; ii < MAX_PLAYERS; ii++)
	{
		if(IsValidVehicle(pData[ii][pSpawnSamd]))
		{
			DestroyVehicle(pData[ii][pSpawnSamd]);
			pData[ii][pSpawnSamd] = INVALID_VEHICLE_ID;
			pData[ii][pSpawnSamd] = 0;
		}
	}
    SendClientMessage(playerid, COLOR_WHITE, "Semua kendaraan faction SAMD telah dihancurkan.");
    return 1;
}

CMD:despawnmd(playerid, params[])
{
	// Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1131.5339, -1332.3248, 13.5797) || IsPlayerInRangeOfPoint(playerid, 8.0, 1162.8176, -1313.8239, 32.2215))
	{
		if(pData[playerid][pFaction] != 3)
	        return Error(playerid, "You must be at medical officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
		// if(pData[playerid][pSpawnSamd] != vehicleid)
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan yang kamu spawn.");

        // if(!IsEngineVehicle(vehicleid))
		// 	return Error(playerid, "Kamu tidak berada didalam kendaraan.");
		DestroyVehicle(pData[playerid][pSpawnSamd]);
		pData[playerid][pSpawnSamd] = INVALID_VEHICLE_ID;
    	// DestroyVehicle(SAMDVeh[playerid]);
		pData[playerid][pSpawnSamd] = 0;
    	GameTextForPlayer(playerid, "~w~SAMD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnmd(playerid, params[])
{
    // Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1131.5339, -1332.3248, 13.5797))
	{
		if(pData[playerid][pFaction] != 3)
	        return Error(playerid, "You must be at medical officer faction!.");

		if(pData[playerid][pSpawnSamd] != 0) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new Zann[10000], String[10000];
	    strcat(Zann, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Ambulance\tCars\n");// 596
		strcat(Zann, String);
		format(String, sizeof(String), "Fire Truck\tCars\n");// 597
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter\tCars\n");// 598
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter 2\tCars\n"); // 599
		strcat(Zann, String);
		format(String, sizeof(String), "Premier\tSport Cars\n"); // 599
		strcat(Zann, String);
		ShowPlayerDialog(playerid,DIALOG_SAMD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:MD", Zann, "Spawn","Cancel");
	}
	return 1;
}

// STATISTIC VEHICLE SAMD //
/*#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SAMD_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(416, 1120.0265, -1317.1208, 13.8679, 271.4225, 1, 3, 120000, 1);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(407, 1120.0265, -1317.1208, 13.8679, 271.4225, -1, 3, 120000, 1);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
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
					SAMDVeh[playerid] = CreateVehicle(487, 1162.8176, -1313.8239, 32.2215, 270.7216, -1,3,120000,1);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1131.5339, -1332.3248, 13.5797))
				{
					SAMDVeh[playerid] = CreateVehicle(426, 1120.0265, -1317.1208, 13.8679, 271.4225, 1,1,120000,1);
					AddVehicleComponent(SAMDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SAMD Vehicles '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
			}
		}
		pData[playerid][pSpawnSamd] = 1;
		PutPlayerInVehicle(playerid, SAMDVeh[playerid], 0);
	}
    return 1;
}*/

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
