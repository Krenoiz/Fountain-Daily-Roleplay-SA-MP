CMD:respawnsapd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "Kamu harus menjadi admin.");

	for(new ii = 0; ii < MAX_PLAYERS; ii++)
	{
		if(IsValidVehicle(pData[ii][pFactionVeh]))
		{
			DestroyVehicle(pData[ii][pFactionVeh]);
			pData[ii][pFactionVeh] = INVALID_VEHICLE_ID;
			pData[ii][pFactionVeh] = 0;
		}
	}

    SendClientMessage(playerid, COLOR_WHITE, "Semua kendaraan faction SAPD telah dihancurkan.");
    return 1;
}



CMD:despawnpd(playerid, params[])
{
	// Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956))
	{
		if(pData[playerid][pFaction] != 1)
	        return Error(playerid, "You must be at police officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        // if(pData[playerid][pFactionVeh] != vehicleid)
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan yang kamu spawn.");

    	DestroyVehicle(pData[playerid][pFactionVeh]);
		pData[playerid][pFactionVeh] = INVALID_VEHICLE_ID;
		pData[playerid][pFactionVeh] = 0;
    	GameTextForPlayer(playerid, "~w~SAPD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}

CMD:spawnpd(playerid, params[])
{
    // Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
	{
		if(pData[playerid][pFaction] != 1)
	        return Error(playerid, "You must be at police officer faction!.");

		if(pData[playerid][pFactionVeh] != 0) 
			return Error(playerid, "Anda sudah mengeluarkan 1 kendaraan.!");

	    new ZENN[10000], String[10000];
	    strcat(ZENN, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Police Ls\tCars\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sf\tCars\n");// 597
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Lv\tCars\n");// 598
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Rancher\tCars\n"); // 599
		strcat(ZENN, String);
		format(String, sizeof(String), "Police S.W.A.T\tCars\n"); // 601
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Enforcer\tCars\n"); // 427
		strcat(ZENN, String);
		format(String, sizeof(String), "Police F.B.I Truck\tCars\n"); // 528
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Infernus\tSport Cars\n"); // 411
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sultan\tUnique Cars\n"); // 560
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sanchez\tMotorcycle\n"); // 468
		strcat(ZENN, String);
		format(String, sizeof(String), "Police HPV-1000\tMotorcycle\n");  // 523
		strcat(ZENN, String);
		format(String, sizeof(String), "Police TowTruck\tTruck\n");// 525
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Maverick\tHelicopter\n"); // 497
		strcat(ZENN, String);
		format(String, sizeof(String), "limosin\tCars\n"); // 409
		strcat(ZENN, String);
		format(String, sizeof(String), "Batman cars\tCars\n"); // 568
		strcat(ZENN, String);
		ShowPlayerDialog(playerid,DIALOG_SAPD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:PD", ZENN, "Spawn","Cancel");
	}
	return 1;
}

// STATISTIC VEHICLE SAPD //
#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SAPD_GARAGE)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(596, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000, 1);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
					new vehicleid = GetPlayerVehicleID(playerid);
        			if(pData[playerid][pFactionVeh] != vehicleid)
					//AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					if(pData[playerid][pFaction] != 1)
	        		return Error(playerid, "You must be at police officer faction!.");
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0,  1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(597, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000, 1);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
					//AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(598, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000, 0);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
					//AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 3:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0,1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(599, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 4:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(601, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 5:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(427, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 6:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(528, 1538.4564,-1650.4598,5.8906,182.8028, -1, -1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
					new tmpobjid;
					tmpobjid = CreateDynamicObject(19601,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "scratchedmetal", -16764058);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, 3.061, -0.650, 0.000, 0.000, 180.000);
				    tmpobjid = CreateDynamicObject(2985,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -16764058);
				    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", -16764058);
				    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", -16764058);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, -1.100, 0.410, 0.000, 0.000, 90.000);
				    tmpobjid = CreateDynamicObject(359,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -1);
				    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", -1);
				    SetDynamicObjectMaterial(tmpobjid, 8, -1, "none", "none", -1);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.930, -1.601, 0.719, 90.000, 0.000, 90.000);
				    tmpobjid = CreateDynamicObject(359,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -1);
				    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", -1);
				    SetDynamicObjectMaterial(tmpobjid, 8, -1, "none", "none", -1);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.930, -1.601, 0.819, -90.000, 0.000, 90.000);
				    tmpobjid = CreateDynamicObject(19917,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -1);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, 1.681, -0.158, -7.199, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(2978,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -16764058);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.000, -2.669, 0.293, -97.899, 0.000, 360.000);
				    tmpobjid = CreateDynamicObject(19314,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.080, 2.570, 0.270, 0.000, 90.000, 0.000);
				    tmpobjid = CreateDynamicObject(1094,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -16764007);
				    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", -16764007);
				   	AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.010, 0.000, -0.610, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(1090,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -16764058);
				    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", -16764007);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -1.061, 0.000, -0.590, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(1187,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", -16764058);
				    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", -16764058);
				    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", -16764058);
				    SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", -16764058);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.890, -2.759, -0.479, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(1046,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, -0.815, -0.240, 2.599, 0.000, 0.000);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 7:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(411, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
					new tmpobjid;
					tmpobjid = CreateDynamicObject(19419,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, 0.000, 0.720, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}POLICE", 100, "Ariel", 25, 0, 0, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.153, 1.979, -1.360, 0.000, 0.000, -0.699);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}POLICE", 100, "Ariel", 25, 0, 0, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -1.078, -1.862, -1.360, 0.000, 0.000, -179.299);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 8:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(560, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1029);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1030);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1031);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1033);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1139);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1140);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1170);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1010);//nos
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
			    	SetVehicleNumberPlate(pData[playerid][pFactionVeh], "KEPOLISIAN");
				 	new tmpobjid;
				 	tmpobjid = CreateDynamicObject(19620,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, 0.000, 0.910, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(2733,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Ariel", 20, 0, 0, -1, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, -0.200, 0.820, 270.000, 90.000, 0.000);
				    tmpobjid = CreateDynamicObject(2655,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Ariel", 20, 0, 0, -1, 2);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -1.080, -0.100, 0.100, 180.000, 90.000, 90.000);
				    tmpobjid = CreateDynamicObject(2655,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Ariel", 20, 0, 0, -1, 2);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.080, -0.100, 0.100, 180.000, -90.000, -90.000);
				    tmpobjid = CreateDynamicObject(2655,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Ariel", 20, 0, 0, -1, 2);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -1.080, -0.060, -0.200, -180.000, -90.000, 90.000);
				    tmpobjid = CreateDynamicObject(2655,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Ariel", 20, 0, 0, -1, 2);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.080, -0.060, -0.200, -180.000, 90.000, -90.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 130, "Ariel", 30, 0, -1, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -2.299, 3.450, -0.210, 0.000, 290.000, 91.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 130, "Ariel", 20, 0, -1, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 2.460, -2.640, -0.970, 0.000, 350.000, -91.000);
				    tmpobjid = CreateDynamicObject(1956,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.059, -0.100, -0.019, 0.000, 90.000, 0.000);
				    tmpobjid = CreateDynamicObject(1956,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -1.059, -0.100, -0.019, 0.000, -90.000, 0.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 120, "courier", 9, 1, -1, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.099, 2.539, -1.250, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 120, "courier", 9, 1, -1, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.990, -2.739, -1.259, 360.000, 360.000, 542.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "LS        PD", 130, "Fixedsys", 25, 0, -16777216, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 1.099, 2.129, -1.079, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "LS        PD", 130, "Fixedsys", 25, 0, -16777216, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -1.099, -2.310, -1.079, 0.000, 0.000, 180.000);
				    tmpobjid = CreateDynamicObject(1182,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_wood01", 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.920, 2.650, -0.159, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(367,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.070, 0.299, 0.610, 0.000, 0.000, 90.000);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 9:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(468, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
			    	new tmpobjid;
			    	tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}POLICE", 140, "Ariel", 15, 1, 0, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.090, 2.934, 0.894, 38.800, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}POLICE", 140, "Ariel", 15, 1, 0, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.154, -1.205, -2.262, -36.500, 0.199, 178.199);
				    tmpobjid = CreateDynamicObject(19797,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.000, 0.586, 0.335, -6.999, 0.000, 178.699);
				    tmpobjid = CreateDynamicObject(18646,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, -0.819, 0.400, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19797,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "{0000ff}*", 90, "Ariel", 25, 1, 0, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.741, -3.157, -1.034, 0.000, -9.199, 171.700);
				    tmpobjid = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterialText(tmpobjid, 0, "{0000ff}*", 90, "Ariel", 25, 1, 0, 0, 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.089, 2.193, -1.113, -0.699, 0.000, 1.699);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 10:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(523, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
			    	SetVehicleNumberPlate(pData[playerid][pFactionVeh], "KEPOLISIAN");
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 11:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(525, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 12:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(497, 1565.8274,-1697.7952,28.3956,88.9368, 0, 1, 120000,1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
					new tmpobjid;
					tmpobjid = CreateDynamicObject(18646,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.000, -6.986, 0.975, 178.500, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(18646,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], 0.049, 0.855, -0.606, 179.700, 0.000, 0.000);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			case 13:
			{
				if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.4630,-1649.9493,5.8906) || IsPlayerInRangeOfPoint(playerid, 8.0, 1565.8232,-1697.7433,28.3956)) 
				{
					pData[playerid][pFactionVeh] = CreateVehicle(409, 1538.4564,-1650.4598,5.8906,182.8028, 0, 1, 120000, 1);
					AddVehicleComponent(pData[playerid][pFactionVeh], 1098);
					PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
					new tmpobjid;
					tmpobjid = CreateDynamicObject(19307,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, 2896, "law_coffintxd", "metleg_32_law", 0);
				    SetDynamicObjectMaterial(tmpobjid, 1, 14802, "lee_bdupsflat", "USAflag", 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.710, 3.422, -0.090, 0.000, 0.000, 270.000);
				    tmpobjid = CreateDynamicObject(19307,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 0, 2896, "law_coffintxd", "metleg_32_law", 0);
				    SetDynamicObjectMaterial(tmpobjid, 1, 19162, "newpolicehats", "policehatmap2", 0);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.710, 3.422, -0.090, 0.000, 0.000, -90.000);
				    tmpobjid = CreateDynamicObject(19348,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", -16777216);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.710, -3.420, -0.320, 10.000, 0.000, 0.000);
				    tmpobjid = CreateDynamicObject(19348,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
				    SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", -16777216);
				    AttachDynamicObjectToVehicle(tmpobjid, pData[playerid][pFactionVeh], -0.710, -3.420, -0.320, 10.000, 0.000, 0.000);
					SetVehicleHealth(pData[playerid][pFactionVeh], 5000);
					SetVehicleFuel(pData[playerid][pFactionVeh], 2000);
				}
				Info(playerid, "You have succefully spawned SAPD Vehicles '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
			}
			
		}
		PutPlayerInVehicle(playerid, pData[playerid][pFactionVeh], 0);
	}
    return 1;
}


CMD:callsign(playerid, params[])
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
		return Usage(playerid, "/callsign [callsign]");

	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 0)
	{
		vehicle3Dtext[vehicleid] = Create3DTextLabel(string, COLOR_WHITE, 0.0, 0.0, 0.0, 10.0, 0, 1);
		Attach3DTextLabelToVehicle(vehicle3Dtext[vehicleid], vehicleid, 0.0, -2.8, 0.0);
		vehiclecallsign[vehicleid] = 1;
		SendClientMessage(playerid, COLOR_RED, "CALLSIGN: {FFFFFF}Type {FFFF00}/callsign {FFFFFF}again to remove.");
	}
	return 1;
}
