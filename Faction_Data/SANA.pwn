CMD:respawnsana(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "Kamu harus menjadi admin.");

	for(new ii = 0; ii < MAX_PLAYERS; ii++)
	{
		if(IsValidVehicle(pData[ii][pSpawnSana]))
		{
			DestroyVehicle(pData[ii][pSpawnSana]);
			pData[ii][pSpawnSana] = INVALID_VEHICLE_ID;
			pData[ii][pSpawnSana] = 0;
		}
	}
    SendClientMessage(playerid, COLOR_WHITE, "Semua kendaraan faction SANA telah dihancurkan.");
    return 1;
}
CMD:despawnsana(playerid, params[])
{
	// Sana Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 743.5262, -1332.2343, 13.8414) || IsPlayerInRangeOfPoint(playerid, 8.0, 741.9764,-1371.2441,25.8835))
	{
		if(pData[playerid][pFaction] != 4)
	        return Error(playerid, "You must be at Sana officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

		DestroyVehicle(pData[playerid][pSpawnSana]);
		pData[playerid][pSpawnSana] = INVALID_VEHICLE_ID;
    	// DestroyVehicle(SANAVeh[playerid]);
		pData[playerid][pSpawnSana] = 0;
    	GameTextForPlayer(playerid, "~w~SANA Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnsana(playerid, params[])
{
    // Sana Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 743.5262, -1332.2343, 13.8414))
	{
		if(pData[playerid][pFaction] != 4)
	        return Error(playerid, "You must be at Sana officer faction!.");

		if(pData[playerid][pSpawnSana] != 0) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new Zanv[10000], String[10000];
	    strcat(Zanv, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Sanew\tCars\n");// 596
		strcat(Zanv, String);
		format(String, sizeof(String), "Sanew\tMotorcycle\n");// 597
		strcat(Zanv, String);
		format(String, sizeof(String), "Helicopter\tMotor Mabur\n");// 598
		strcat(Zanv, String);
		format(String, sizeof(String), "Sultan\tCars\n"); // 599
		strcat(Zanv, String);
		format(String, sizeof(String), "Landstalker\tCars\n"); // 599
		strcat(Zanv, String);
		ShowPlayerDialog(playerid,DIALOG_SANA_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles San Andreas Agency", Zanv, "Spawn","Cancel");
	}
	return 1;
}

// STATISTIC VEHICLE SANA //
#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SANA_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 743.5262, -1332.2343, 13.8414))
				{
					pData[playerid][pSpawnSana] = CreateVehicle(582, 751.3419,-1345.3467,13.8993,265.8653, 158, 158, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSana], 5000);
					SetVehicleFuel(pData[playerid][pSpawnSamd], 2000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 743.5262, -1332.2343, 13.8414))
				{
					pData[playerid][pSpawnSana] = CreateVehicle(586, 751.3419,-1345.3467,13.8993,265.8653, 158, 158, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSana], 5000);
					SetVehicleFuel(pData[playerid][pSpawnSamd], 2000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 743.5262, -1332.2343, 13.8414))
				{
					pData[playerid][pSpawnSana] = CreateVehicle(488, 741.9764, -1371.2441, 25.8835, 359.9998, 0, 1, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSana], 5000);
					SetVehicleFuel(pData[playerid][pSpawnSamd], 2000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
			case 3:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 743.5262, -1332.2343, 13.8414))
				{
					pData[playerid][pSpawnSana] = CreateVehicle(560, 751.3419,-1345.3467,13.8993,265.8653, 158, 158, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSana], 5000);
					SetVehicleFuel(pData[playerid][pSpawnSamd], 2000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 743.5262, -1332.2343, 13.8414))
				{
					pData[playerid][pSpawnSana] = CreateVehicle(400, 751.3419,-1345.3467,13.8993,265.8653, 158, 158, 120000, 1);
					SetVehicleHealth(pData[playerid][pSpawnSana], 5000);
					SetVehicleFuel(pData[playerid][pSpawnSamd], 2000);
					//AddVehicleComponent(SAPDVeh[playerid], 1098);
				}
				Info(playerid, "You have succefully spawned SANA Vehicles '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
			}
		}
		PutPlayerInVehicle(playerid,pData[playerid][pSpawnSana], 0);
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
