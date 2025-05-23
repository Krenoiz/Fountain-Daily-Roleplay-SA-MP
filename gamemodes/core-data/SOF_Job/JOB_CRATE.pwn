// JOB CRATE COMPONENT //
new CarryCrate[MAX_PLAYERS]; // Player sedang Membawa Crate
// new objectcrate,
	// Text3D:objecttext,
	// Component Object
	// objectcratecompo,
	// Text3D:objecttextcompo,
	// Material Object
	// objectcratemats,
	// Text3D:objecttextmats;

// Variable Dapat Type Crate
new CarryCrateFish[MAX_PLAYERS],
	CarryCrateCompo[MAX_PLAYERS],
	CarryCrateMats[MAX_PLAYERS],
	CarryCrateFood[MAX_PLAYERS];

CMD:getcrate(playerid, params[])
{
	if(pData[playerid][pTruckerTime] > 0) return Error(playerid, "You must be waiting "YELLOW_E"%d "GREY_E"second again to begin jobs.", pData[playerid][pTruckerTime]);

	// Fish
    if(IsPlayerInRangeOfPoint(playerid, 1.5, 2836.4575,-1539.7030,11.0991))
    {
		if(CrateFish != 0)
		{
		    if(CarryCrate[playerid] == 1) return SCM(playerid, COLOR_YELLOW, "WARNING: "WHITE_E"Kamu sudah membawa Crates, Tidak dapat membawa lagi");

        	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan untuk menggunakan command");

			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
			SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
			SCM(playerid, ARWIN, "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"pickup Crate's Fish with price "LG_E"$2"WHITE_E", put in your car use '/loadfish'");
			GivePlayerMoneyEx(playerid, -2);
			CarryCrate[playerid] =1;
			CarryCrateFish[playerid] =1;
			CrateFish -= 1;
			Server_Save();

		}
		else
		{
			Error(playerid, "There it's Stock crates is empty!");
	 	}
	}
	//compo
    if(IsPlayerInRangeOfPoint(playerid, 1.5, 315.07, 926.53, 20.46))
    {
		if(CrateComponent != 0)
		{
		    if(CarryCrate[playerid] == 1) return SCM(playerid, COLOR_YELLOW, "WARNING: "WHITE_E"Kamu sudah membawa Crates, Tidak dapat membawa lagi");

        	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan untuk menggunakan command");

			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
			SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
			SCM(playerid, ARWIN, "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"pickup Crate's Component with price "LG_E"$2"WHITE_E", put in your car use '/loadcompo'");
			GivePlayerMoneyEx(playerid, -2);
			CarryCrate[playerid] =1;
			CarryCrateCompo[playerid] =1;
			CrateComponent -= 1;
			Server_Save();

		}
		else
		{
			Error(playerid, "There it's Stock crates is empty!");
	 	}
	}
	// Material
    if(IsPlayerInRangeOfPoint(playerid, 1.5, -1425.71, -1528.95, 102.13))
    {
		if(CrateMaterial != 0)
		{
		    if(CarryCrate[playerid] == 1) return SCM(playerid, COLOR_YELLOW, "WARNING: "WHITE_E"Kamu sudah membawa Crates, Tidak dapat membawa lagi");

        	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan untuk menggunakan command");

			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
			SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
			SCM(playerid, ARWIN, "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"pickup Crate's Material with price "LG_E"$2"WHITE_E", put in your car use '/loadmats'");
			GivePlayerMoneyEx(playerid, -2);
			CarryCrate[playerid] =1;
			CarryCrateMats[playerid] =1;
			CrateMaterial -= 1;
			Server_Save();

		}
		else
		{
			Error(playerid, "There it's Stock crates is empty!");
	 	}
	}
	//Food
  	if(IsPlayerInRangeOfPoint(playerid, 1.5, 1107.0780,-321.0744,73.9922))
    {
		if(CrateFood != 0)
		{
		    if(CarryCrate[playerid] == 1) return SCM(playerid, COLOR_YELLOW, "WARNING: "WHITE_E"Kamu sudah membawa Crates, Tidak dapat membawa lagi");

        	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan untuk menggunakan command");

			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
			SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
			SCM(playerid, ARWIN, "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"pickup Crate's Food with price "LG_E"$2"WHITE_E", put in your car use '/loadfood'");
			GivePlayerMoneyEx(playerid, -2);
			CarryCrate[playerid] =1;
			CarryCrateFood[playerid] =1;
			CrateFood -= 1;
			Server_Save();

		}
		else
		{
			Error(playerid, "There it's Stock crates is empty!");
	 	}
	}
	return 1;
}

CMD:loadfish(playerid, params[])
{
	if(CarryCrateFish[playerid] == 0) return Error(playerid, "Anda belum mengambil crates ikan");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[500];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "Kamu harus dekat dengan kendaraan truck!");

	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 499 || GetVehicleModel(carid) == 428 || GetVehicleModel(carid) == 498) return Error(playerid, "There it's vehicles is not trucker categories!");

	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan nya di dalam kendaraan");

	if(CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");

	if(vCrateData[carid][vCrateFish] == 5) return Error(playerid, "There it's vehicles maximum crates stock, dont load crates again.");

	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid,CRATES);
	CarryCrate[playerid] =0;
	CarryCrateFish[playerid] =0;
	vCrateData[carid][vCrateFish]++;
	format(String, sizeof(String), "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"Loaded '"YELLOW_E"%d/5"WHITE_E"'Crates(Fish).", vCrateData[carid][vCrateFish]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}

CMD:loadcompo(playerid, params[])
{
	if(CarryCrateCompo[playerid] == 0) return Error(playerid, "Kamu belum mengambil Component Crates");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[500];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "Kamu harus dekat dengan kendaraan truck!");

	if(GetVehicleModel(carid) == 499 || GetVehicleModel(carid) == 428 || GetVehicleModel(carid) == 498) return Error(playerid, "There it's vehicles is not trucker categories!");

	if(CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");

    if(vCrateData[carid][vCrateCompo] == 5) return Error(playerid, "There it's vehicles maximum crates stock, dont load crates again.");

	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid,CRATES);
	CarryCrateCompo[playerid] =0;
	CarryCrate[playerid] =0;
	vCrateData[carid][vCrateCompo]++;
	format(String, sizeof(String), "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"Loaded '"YELLOW_E"%d/5"WHITE_E"' Crates(Component).", vCrateData[carid][vCrateCompo]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}

CMD:loadmats(playerid, params[])
{
	if(CarryCrateMats[playerid] == 0) return Error(playerid, "Anda belum mengambil crates material");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[500];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "Kamu harus dekat dengan kendaraan truck!");

	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 499
	|| GetVehicleModel(carid) == 428
	|| GetVehicleModel(carid) == 498) return Error(playerid, "There it's vehicles is not trucker categories!");

	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan nya di dalam kendaraan");

	if(CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");

	if(vCrateData[carid][vCrateMats] == 5) return Error(playerid, "There it's vehicles maximum crates stock, dont load crates again.");

	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid,CRATES);
	CarryCrate[playerid] =0;
	CarryCrateMats[playerid] =0;
	vCrateData[carid][vCrateMats]++;
	format(String, sizeof(String), "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"Loaded '"YELLOW_E"%d/5"WHITE_E"'Crates(Material).", vCrateData[carid][vCrateMats]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}
CMD:loadfood(playerid, params[])
{
	if(CarryCrateMats[playerid] == 0) return Error(playerid, "Anda belum mengambil crates food");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[500];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "Kamu harus dekat dengan kendaraan truck!");

	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 499
	|| GetVehicleModel(carid) == 428
	|| GetVehicleModel(carid) == 498) return Error(playerid, "There it's vehicles is not trucker categories!");

	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan nya di dalam kendaraan");

	if(CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");

	if(vCrateData[carid][vCrateFood] == 5) return Error(playerid, "There it's vehicles maximum crates stock, dont load crates again.");

	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid,CRATES);
	CarryCrate[playerid] =0;
	CarryCrateMats[playerid] =0;
	vCrateData[carid][vCrateFood]++;
	format(String, sizeof(String), "CRATE: "WHITE_E"You have "LG_E"succesfully "WHITE_E"Loaded '"YELLOW_E"%d/5"WHITE_E"'Crates(Material).", vCrateData[carid][vCrateFood]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}
CMD:unloadfish(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan ini di dalam kendaraan");

	if(CarryCrate[playerid] == 1) return Error(playerid, "Saat ini kamu sedang membawa sebuah crates");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[2280];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "You must be a nearest trucker vehicle!");

	if(vCrateData[carid][vCrateFish] == 0) return Error(playerid, "There it's vehicles not crates stock "YELLOW_E"(Storage: %d/5)", vCrateData[carid][vCrateFish]);

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
	SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
	CarryCrate[playerid] =1;
	CarryCrateFish[playerid] =1;
	vCrateData[carid][vCrateFish] -=1;
	format(String, sizeof(String), "VEHICLE: "WHITE_E"You have succesfully Unloaded Crates Fish (Crate Stock: '"YELLOW_E"%d/5"WHITE_E"').", vCrateData[carid][vCrateFish]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}

CMD:unloadcompo(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan ini di dalam kendaraan");

	if(CarryCrate[playerid] == 1) return Error(playerid, "Saat ini kamu sedang membawa sebuah crates");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

	new Float:Cpos[3];
	new String[2280];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "You must be a nearest trucker vehicle!");

    if(vCrateData[carid][vCrateCompo] == 0) return Error(playerid, "There it's vehicles not crates component stock "YELLOW_E"(Component Crates: %d/5)", vCrateData[carid][vCrateCompo]);

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
	SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
	CarryCrate[playerid] =1;
	CarryCrateCompo[playerid] =1;
	vCrateData[carid][vCrateCompo] -=1;
	format(String, sizeof(String), "VEHICLE: "WHITE_E"You have succesfully Unloaded Crates Component (Crate Stock: '"YELLOW_E"%d/5"WHITE_E"').", vCrateData[carid][vCrateCompo]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}

CMD:unloadmats(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan ini di dalam kendaraan");

	if(CarryCrate[playerid] == 1) return Error(playerid, "Saat ini kamu sedang membawa sebuah crates");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[2280];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "You must be a nearest trucker vehicle!");

	if(vCrateData[carid][vCrateMats] == 0) return Error(playerid, "There it's vehicles not crates stock "YELLOW_E"(Storage: %d/5)", vCrateData[carid][vCrateMats]);

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
	SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
	CarryCrate[playerid] =1;
	CarryCrateMats[playerid] =1;
	vCrateData[carid][vCrateMats] -=1;
	format(String, sizeof(String), "VEHICLE: "WHITE_E"You have succesfully Unloaded Crates Material (Crate Stock: '"YELLOW_E"%d/5"WHITE_E"').", vCrateData[carid][vCrateMats]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}
CMD:unloadfood(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu tidak dapat melakukan ini di dalam kendaraan");

	if(CarryCrate[playerid] == 1) return Error(playerid, "Saat ini kamu sedang membawa sebuah crates");

	new carid = Vehicle_Nearest(playerid);

	if (carid == -1)
		return Error(playerid, "There is no vehicle nearby.");

 	new Float:Cpos[3];
	new String[2280];
	GetVehiclePos(carid,Cpos[0],Cpos[1],Cpos[2]);
	if(IsPlayerInRangeOfPoint(playerid,7.0,Cpos[0],Cpos[1],Cpos[2]))  return Error(playerid, "You must be a nearest trucker vehicle!");

	if(vCrateData[carid][vCrateFood] == 0) return Error(playerid, "There it's vehicles not crates stock "YELLOW_E"(Storage: %d/5)", vCrateData[carid][vCrateFood]);

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
	SetPlayerAttachedObject(playerid, CRATES, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
	CarryCrate[playerid] =1;
	CarryCrateMats[playerid] =1;
	vCrateData[carid][vCrateFood] -=1;
	format(String, sizeof(String), "VEHICLE: "WHITE_E"You have succesfully Unloaded Crates Material (Crate Stock: '"YELLOW_E"%d/5"WHITE_E"').", vCrateData[carid][vCrateFood]);
	SendClientMessage(playerid, ARWIN, String);
	// SavePlayerAccount(playerid);
	return 1;
}

CMD:sellcrate(playerid, params[])
{
	if(pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
	{
		if (pData[playerid][pJualCrateDelay] > 0)
			return Error(playerid, "Please wait %d minutes before selling again.", pData[playerid][pJualCrateDelay]);

		// Fish
	    if(IsPlayerInRangeOfPoint(playerid, 2.0, 2791.7188,-2456.6025,13.6327))
		{
			if (CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");
			
			if (CarryCrateFish[playerid] == 1) 
			{
				// Penjualan Crate Fish
				if (CarryCrateCompo[playerid] == 1) return Error(playerid, "Kamu tidak dapat menjual Crate Component di sini");
				ClearAnimations(playerid);
				RemovePlayerAttachedObject(playerid, CRATES);
				pData[playerid][pTruckerTime] = 180;

				new String[2280];
				format(String, sizeof(String), "JOB: "WHITE_E"You have "LG_E"succesfully "WHITE_E"selling Crates(Fish). in your payment in "YELLOW_E"'/mysalary.");
				SendClientMessage(playerid, ARWIN, String);
				AddPlayerSalary(playerid, "Crate (Fish)", 300);
				CarryCrate[playerid] = 0;
				CarryCrateFish[playerid] = 0;
				Food += 37;
			} 
			else if (CarryCrateMats[playerid] == 1) 
			{
				// Penjualan Crate Material
				if (CarryCrateFish[playerid] == 1) return Error(playerid, "Kamu tidak dapat menjual Crates Fish di sini");
				ClearAnimations(playerid);
				RemovePlayerAttachedObject(playerid, CRATES);
				pData[playerid][pTruckerTime] = 180;
				new String[2280];
				format(String, sizeof(String), "JOB: "WHITE_E"You have "LG_E"succesfully "WHITE_E"selling Crates(Material). in your payment in "YELLOW_E"'/mysalary.");
				SendClientMessage(playerid, ARWIN, String);
				AddPlayerSalary(playerid, "Crate (Material)", 300);
				CarryCrate[playerid] = 0;
				CarryCrateMats[playerid] = 0;
			} 
			else 
			{
				return Error(playerid, "Anda tidak membawa crates yang bisa dijual.");
			}
			Server_Save();
		}
		// Compo
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 797.60, -617.48, 16.00))
		{
			if(CarryCrateFish[playerid] == 1) return Error(playerid, "Kamu tidak dapat menjual Crates Fish di sini");
			if(CarryCrateMats[playerid] == 1) return Error(playerid, "Anda tidak membawa crates component");
			
			if(CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");

			if(CarryCrateCompo[playerid] == 0) return Error(playerid, "Anda tidak membawa crates component");

			ClearAnimations(playerid);
			RemovePlayerAttachedObject(playerid,CRATES);
			pData[playerid][pTruckerTime] = 180;
			new String[2280];
			format(String, sizeof(String), "JOB: "WHITE_E"You have "LG_E"succesfully "WHITE_E"selling Crates(Component). in your payment in "YELLOW_E"'/mysalary.");
			SendClientMessage(playerid, ARWIN, String);
			AddPlayerSalary(playerid, "Crate (Component)", 300);
			CarryCrate[playerid] =0;
			CarryCrateCompo[playerid] =0;
			Component += 250;
			Server_Save();
		}
	
		if(IsPlayerInRangeOfPoint(playerid, 2.0, -381.44, -1426.13, 25.93))
		{
			if(CarryCrateFish[playerid] == 1) return Error(playerid, "Kamu tidak dapat menjual Crates Food di sini");
			if(CarryCrateCompo[playerid] == 1) return Error(playerid, "Anda tidak membawa crates food");

			if(CarryCrate[playerid] == 0) return Error(playerid, "Kamu harus membawa sebuah crates");

			if(CarryCrateFood[playerid] == 0) return Error(playerid, "Anda tidak membawa crates Food");

			ClearAnimations(playerid);
			RemovePlayerAttachedObject(playerid,CRATES);
			pData[playerid][pTruckerTime] = 180;
			new String[2280];
			format(String, sizeof(String), "JOB: "WHITE_E"You have "LG_E"succesfully "WHITE_E"selling Crates(Food). in your payment in "YELLOW_E"'/mysalary.");
			SendClientMessage(playerid, ARWIN, String);
			AddPlayerSalary(playerid, "Crate (Food)", 300);
			CarryCrate[playerid] =0;
			CarryCrateFood[playerid] =0;
			Food += 50;
			Server_Save();
		}


		if (pData[playerid][pJumlahJualCrate] >= 5)
		{
			pData[playerid][pJumlahJualCrate] = 0;
			pData[playerid][pJualCrateDelay] = 15;
		}
	}
	else return Error(playerid, "You are not in trucker");
	return 1;
}

CMD:dropcrate(playerid, params[])
{
	if(isnull(params))
	{
 		Usage(playerid, "/dropcrate [info]");
 		Info(playerid, "[compo] [fish] [mats] [food]");
   		return 1;
	}
	if(strcmp(params,"fish",true) == 0)
	{
		if(CarryCrate[playerid] == 0) return Error(playerid, "You must in carry 1 crate");

		if(CarryCrateFish[playerid] == 0) return Error(playerid, "Anda tidak membawa crates ikan");

		RemovePlayerAttachedObject(playerid, CRATES);
		ClearAnimations(playerid);
		StopLoopingAnim(playerid);
  	  	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		CarryCrate[playerid] =0;
		CarryCrateFish[playerid] =0;
	}
	if(strcmp(params,"compo",true) == 0)
	{
		if(CarryCrate[playerid] == 0) return Error(playerid, "You must in carry 1 crate");

		if(CarryCrateCompo[playerid] == 0) return Error(playerid, "Anda tidak membawa crates component");

		RemovePlayerAttachedObject(playerid, CRATES);
		ClearAnimations(playerid);
		CarryCrate[playerid] =0;
		CarryCrateCompo[playerid] =0;
	}
	if(strcmp(params,"mats",true) == 0)
	{
		if(CarryCrate[playerid] == 0) return Error(playerid, "You must in carry 1 crate");

		if(CarryCrateMats[playerid] == 0) return Error(playerid, "Anda tidak membawa crates mats");

		RemovePlayerAttachedObject(playerid, CRATES);
		ClearAnimations(playerid);
		CarryCrate[playerid] =0;
		CarryCrateMats[playerid] =0;
	}
	if(strcmp(params,"food",true) == 0)
	{
		if(CarryCrate[playerid] == 0) return Error(playerid, "You must in carry 1 crate");

		if(CarryCrateFood[playerid] == 0) return Error(playerid, "Anda tidak membawa crates food");

		RemovePlayerAttachedObject(playerid, CRATES);
		ClearAnimations(playerid);
		CarryCrate[playerid] =0;
		CarryCrateFood[playerid] =0;
	}
	return 1;
}

CMD:cratemission(playerid, params[])
{
	if(pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
	{
		if(pData[playerid][pTruckerTime] > 0) return Error(playerid, "You must be waiting "YELLOW_E"%d "GREY_E"second again to begin jobs.", pData[playerid][pTruckerTime]);

		new location[4096], lstr[596];
		strcat(location,"Type Crates\tAvailable Stock\tPrice\n",sizeof(location));
		format(lstr,sizeof(lstr), "Fish Crates\t"YELLOW_E"%d\t"LG_E"$300\n", CrateFish);
		strcat(location,lstr,sizeof(location));
		format(lstr,sizeof(lstr), "Component Crates\t"YELLOW_E"%d\t"LG_E"$500\n", CrateComponent);
		strcat(location,lstr,sizeof(location));
		format(lstr,sizeof(lstr), "Material Crates\t"YELLOW_E"%d\t$500\n", CrateMaterial);
		strcat(location,lstr,sizeof(location));
	    ShowPlayerDialog(playerid, DIALOG_CRATE_EXPORT, DIALOG_STYLE_TABLIST_HEADERS, "Crates Export Locations", location, "Select", "Cancel");
	}
	else return Error(playerid, "You are not in trucker driver");
	return 1;
}

CMD:getjobcrate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07)) return SendClientMessage(playerid, -1, "{FF0000}[INFO JOB] > {CECECE}Untuk memulai hari kerja sebagai Supir Trucker, Anda harus berada di Trucker");
	{
		if(pData[playerid][pJobTime] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", pData[playerid][pJobTime]);
		{
			if (pData[playerid][pJob] > 0) 
			{
				if (!pData[playerid][pVip]) 
				{
					return Error(playerid, "Hanya pemain VIP yang bisa memiliki pekerjaan kedua.");
				}
				if (pData[playerid][pJob2] > 0) 
				{
					return Error(playerid, "Anda sudah memiliki kedua pekerjaan.");
				} 
				else 
				{
					SuccesMsg(playerid, "Anda Memilih Pekerjaan Sebagai ~p~Trucker");
					pData[playerid][pJob2] = 3; 
				}
			} 
			else 
			{
				SuccesMsg(playerid, "Anda Memilih Pekerjaan Sebagai ~p~Trucker");
				pData[playerid][pJob] = 3;
			}
		}  
	}    
	return 1;
}
CMD:endjobcrate(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07)) 
    {
        return SendClientMessage(playerid, COLOR_GREY, "Anda harus di Tempat Pemberhentian Kerja Trucker!");
    }
    if (pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
    {
        if (pData[playerid][pJob] == 3) 
        {
            pData[playerid][pJob] = 0;
        }
        if (pData[playerid][pJob2] == 3) 
        {
            pData[playerid][pJob2] = 0;
        }

        SuccesMsg(playerid, "Anda resign menjadi ~p~Trucker");
    }
    else
    {
        Error(playerid, "Anda tidak memiliki pekerjaan sebagai ~p~Trucker.");
    }

    return 1;
}