
CMD:lockpick(playerid, params[])
{
	if(pData[playerid][pRedMoney] < 5000) return Error(playerid, "Anda tidak memiliki uang merah $5.000!");
	if(pData[playerid][pCharacterStory] == 0) return Error(playerid, "Anda tidak memiliki Story Character!");
	if(pData[playerid][pLevel] < 5) return Error(playerid, "Level kamu kurang dari 5.");
	if(pData[playerid][pFamily] == -1) return Error(playerid, "Kamu bukan family bro.");
	if(!IsPlayerInRangeOfPoint(playerid,5.0, 287.7309, -105.9845, 1001.5156)) return Error(playerid, "Bukan tempat perakitan lockpick mas bro");
	{
    	if(GetPVarInt(playerid, "ngudud") > gettime())
    		return Error(playerid, "Kamu Masih Membuat Lockpick Bro.");

		SendClientMessage(playerid, COLOR_WHITE,"You're in create please wait...");
		pData[playerid][pActivity] = SetTimerEx("Lockpick", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Create...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		InRob[playerid] = 1;
		SetPVarInt(playerid, "ngudud", gettime() + 20);
	}
	return 1;
}

function Lockpick(playerid)
{
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Lockpick Creating!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 4;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
			pData[playerid][pRedMoney] -= 5000;
	    	pData[playerid][pLockPick] += 1;
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully creat the lockpick and your money {ff0000}-$5000");
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


function StatusMesin(playerid, vehicleid)
{
	if(!GetEngineStatus(vehicleid))
	{
		foreach(new ii : PVehicles)
		{
			if(vehicleid == pvData[ii][cVeh])
			{
				if(pvData[ii][cTicket] >= 2000)
					return Error(playerid, "Kendaraan ini sudah ditilang oleh Polisi! /mv - untuk memeriksa");
			}
		}
		new Float: f_vHealth;
		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0) return Error(playerid, "The car won't start - it's totalled!");
		if(GetVehicleFuel(vehicleid) <= 0.0) return Error(playerid, "The car won't start - there's no fuel in the tank!");
		
		new rand = random(3);
		if(rand == 0)
		{
			SwitchVehicleEngine(vehicleid, true);
			SuccesMsg(playerid, "Mesin kendaraan Menyala Anda Berhasil Membobol!");
			pData[playerid][pLockPick] -= 1;
			//InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~g~START", 1000, 3);
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berhasil menghidupkan kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));
		}
		if(rand == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE,"Mesin kendaraan tidak dapat menyala, silahkan coba lagi!");
			SwitchVehicleEngine(vehicleid, false);
			//InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~r~CAN'T START", 1000, 3);
		}
		if(rand == 2)
		{
			SwitchVehicleEngine(vehicleid, false);
			//InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			SendClientMessage(playerid, COLOR_WHITE,"Mesin kendaraan tidak dapat menyala, silahkan coba lagi!");
			//GameTextForPlayer(playerid, "~w~ENGINE ~g~START", 1000, 3);
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berhasil menghidupkan kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));
		}
	}
	else
	{
		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mematikan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
		SwitchVehicleEngine(vehicleid, false);
		SendClientMessage(playerid, COLOR_WHITE,"Mesin kendaraan mati!");
		//Info(playerid, "Engine turn off..");
		//InfoTD_MSG(playerid, 4000, "Vehicle Engine OFF");
	}
	return 1;
}


CMD:robbank(playerid, params[])
{
	new count;
	if(pData[playerid][pFamily] == -1)
	{
		return Error(playerid, "You are not in family!");
	}
	if(pData[playerid][pFamilyRank] < 5)
	{
		return Error(playerid, "You must family level 5 - 6!");
	}
    if (pData[playerid][RobbankTime] >= gettime())
	{
        return Error(playerid, "Kamu harus menunggu %d detik sebelum bisa merampok bank.", pData[playerid][RobbankTime] - gettime());
    }
    if (pData[playerid][IsLoggedIn] == false) 
	{
        return Error(playerid, "Kamu harus login terlebih dahulu!");
    }
    if (pData[playerid][pInjured] >= 1) {
        return Error(playerid, "Kamu tidak bisa menggunakan perintah ini saat sedang terluka!");
    }
    if (pData[playerid][pLockPick] == 0) 
	{ 
        return Error(playerid, "Kamu tidak memiliki lockpick!");
    }
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, 2301.8899, -13.0780, 5001.0859)) 
	{
        return Error(playerid, "Kamu tidak berada di lokasi bank!");
    }

    foreach(new i : Player)
    {
        if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
        {
            count++;
        }
    }
	if(count < 1)
	{
		return Info(playerid, "Anggota SAPD harus minimal 4++ untuk melakukan perampokan.");
	}

    foreach(new i : Player)
    {
        if(pData[i][pFaction] == 3 && pData[i][pOnDuty] == 1)
        {
            count++;
        }
    }
	if(count < 1)
	{
		return Info(playerid, "Anggota SAMD harus minimal 2++ untuk melakukan perampokan.");
	}

	pData[playerid][pActivity] = SetTimerEx("RobBank", 7000, true, "idd", playerid);

	PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Rob BANK...");
	PlayerTextDrawShow(playerid, ActiveTD[playerid]);
	ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1, 1, 1, 1, 1, 1, 1);

	return 1;
}

//Bank
function RobBank(playerid)
{
	// new rand = RandomEx(1,2);
    // if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	// {
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 1)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal membobol Bank, Lakukan lagi sebelum Polisi datang");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	    // if(pData[playerid][pActivityTime] >= 100)
	    // {
		//     if(rand == 2)
		//     {
		//     	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
		//     	TogglePlayerControllable(playerid, 1);
		//     	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		// 		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		// 		KillTimer(pData[playerid][pActivity]);
		// 		pData[playerid][pEnergy] -= 8;
		// 		pData[playerid][pActivityTime] = 0;
		//     	Info(playerid, "Anda gagal membobol Bank, Lakukan lagi sebelum Polisi datang");
		//         TogglePlayerControllable(playerid, 1);
		// 		return 1;
		// 	}
		// }
 		// else if(pData[playerid][pActivityTime] < 100)
 		// {
	    // 	pData[playerid][pActivityTime] += 5;
		// 	SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    // 	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		// }
	    // if(pData[playerid][pActivityTime] >= 100)
	    // {
		//     if(rand == 3)
		//     {
		//     	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
		//     	TogglePlayerControllable(playerid, 1);
		//     	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		// 		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		// 		KillTimer(pData[playerid][pActivity]);
		// 		pData[playerid][pEnergy] -= 8;
		// 		pData[playerid][pActivityTime] = 0;
		// 		pData[playerid][pLockPick] -= 1;
		// 		Info(playerid, "Locpick patah silakan coba kembali");
		//     	Info(playerid, "Anda gagal membobol Bank, Lakukan lagi sebelum Polisi datang");
		//         TogglePlayerControllable(playerid, 1);
		// 		return 1;
		// 	}
		// }
 		// else if(pData[playerid][pActivityTime] < 100)
 		// {
	    // 	pData[playerid][pActivityTime] += 5;
		// 	SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    // 	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		// }
// 	    if(pData[playerid][pActivityTime] >= 100)
// 	    {
// 		    if(rand == 2)
// 		    {
// 		    	InfoTD_MSG(playerid, 8000, "Robbery ~g~Succesfully!");
// 		    	TogglePlayerControllable(playerid, 1);
// 		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 				KillTimer(pData[playerid][pActivity]);
// 				pData[playerid][pHunger] -= 5;
// 				pData[playerid][pEnergy] -= 8;
// 				pData[playerid][pActivityTime] = 0;
// 				pData[playerid][pLockPick] -= 1;
// 				ClearAnimations(playerid);
// 				pData[playerid][RobbankTime] = gettime() + 172800;
// 		    	new RandRobBank = Random(5000, 11000);
// 		    	pData[playerid][pRedMoney] += RandRobBank;
// 		    	Info(playerid, "Anda berhasil merampok BANK, cepat pergi dari lokasi sebelum polisi datang");
// 		    	new string[1280];
// 				format(string, sizeof(string), "You takes Robbery Bank Red Money "LG_E"$%d", RandRobBank);
//                 SendClientMessage(playerid, ARWIN, string);
// 				SendAdminMessage(COLOR_RED, "* %s Has Robbery Bank Pliss Admin Spec", pData[playerid][pName]);
// 				SendClientMessageToAll(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan Di Bank' {ffffff}warga harap menjauh dari perampokan");
//                 if(pData[playerid][pFaction] == 1)
// 				{
// 					SendFactionMessage(1, COLOR_BLUE, "ALARM: "WHITE_E"saat ini sedang terjadi perampokan BANK di "YELLOW_E"Lokasi: Downton Los santos");
// 				}
// 				new dc[128];
// 				format(dc, sizeof(dc),  "```UCP : %s Dengan Nama IC %s Merampok Bank.```", pData[playerid][pUCP], ReturnName(playerid));
// 				SendDiscordMessage(17, dc);
// 			}
// 		}
// 	 	else if(pData[playerid][pActivityTime] < 100)
// 		{
// 		   	pData[playerid][pActivityTime] += 5;
// 			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 		   	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
// 		}
// 	}
// 	return 1;
// }

	if (pData[playerid][pActivityTime] >= 100)
	{
		InfoTD_MSG(playerid, 8000, "Robbery ~g~Successfully!");
		TogglePlayerControllable(playerid, 1);
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pHunger] -= 50;
		pData[playerid][pEnergy] -= 50;
		pData[playerid][pActivityTime] = 0;
		pData[playerid][pLockPick] -= 1;
		ClearAnimations(playerid);
		pData[playerid][RobbankTime] = gettime() + 2 * 3600;

		new RandRobBank = Random(5000, 11000);
		pData[playerid][pRedMoney] += RandRobBank;

		Info(playerid, "Anda berhasil merampok BANK, cepat pergi dari lokasi sebelum polisi datang");

		new string[1280];
		format(string, sizeof(string), "You takes Robbery Bank Red Money "LG_E"$%d", RandRobBank);
		SendClientMessage(playerid, ARWIN, string);


		// SendAdminMessage(COLOR_RED, "* %s Has Robbery Bank Pliss Admin Spec", pData[playerid][pName]);
		// SendClientMessageToAll(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan Di Bank' {ffffff}warga harap menjauh dari perampokan");

		if (pData[playerid][pFaction] == 1)
		{
			SendFactionMessage(1, COLOR_BLUE, "ALARM: "WHITE_E"saat ini sedang terjadi perampokan BANK di "YELLOW_E"Lokasi: Downton Los Santos");
		}

		new dc[128];
		format(dc, sizeof(dc), "```UCP : %s Dengan Nama IC %s Merampok Bank.```", pData[playerid][pUCP], ReturnName(playerid));
		SendDiscordMessage(17, dc);
	}
	else if (pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	}

	return 1;
}

CMD:robatm(playerid, params[])
{
	new count;
	if(pData[playerid][pFamily] == -1)
	{
		return Error(playerid, "You are not in family!");
	}
	//if(pData[playerid][pFamily] != -1) return Error(playerid, "Kamu bukan family");
	if(pData[playerid][IsLoggedIn] == false)
	{
		return Error(playerid, "You must logged in!");
	}
	if(pData[playerid][pInjured] >= 1) 
	{
		return Error(playerid, "You can't use this at this moment!");
	}
	if(pData[playerid][pLockPick] == 0) 
	{
		return Error(playerid, "Kamu tidak ada lockpick");
	}
	if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery Atm", pData[playerid][RobbankTime] - gettime());

    foreach(new i : Player)
    {
        if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
        {
            count++;
        }
    }

	if(count < 2)
	{
		return Info(playerid, "Anggota SAPD harus minimal 2++ untuk melakukan perampokan.");
	}

    foreach(new i : Player)
    {
        if(pData[i][pFaction] == 3 && pData[i][pOnDuty] == 1)
        {
            count++;
        }
    }

	if(count < 1)
	{
		return Info(playerid, "Anggota SAMD harus minimal 1++ untuk melakukan perampokan.");
	}

	new id = -1;
	id = GetClosestATM(playerid);

	if(id > -1)
	{
		pData[playerid][pActivity] = SetTimerEx("RobAtm", 5000, true, "idd", playerid);

		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Rob ATM...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1, 1, 1, 1, 1, 1, 1);
	}

	return 1;
}

//Atm
function RobAtm(playerid)
{
    new id = -1;
	id = GetClosestATM(playerid);
	if(pData[playerid][pActivityTime] >= 100)
	{
		InfoTD_MSG(playerid, 8000, "Robbery ~g~Succesfully!");
		TogglePlayerControllable(playerid, 1);
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pHunger] -= 25;
		pData[playerid][pEnergy] -= 25;
		pData[playerid][pActivityTime] = 0;
		ClearAnimations(playerid);
		new RandRobAtm = Random(650, 750);
		pData[playerid][pRedMoney] += RandRobAtm;
		Info(playerid, "Anda berhasil merampok ATM, cepat pergi dari lokasi sebelum polisi datang");
		new string[1280];
		format(string, sizeof(string), "You takes Robbery ATM Money "LG_E"$%d", RandRobAtm);
        SendClientMessage(playerid, ARWIN, string);
        pData[playerid][RobbankTime] = gettime() + 2 * 3600;
		// SendAdminMessage(COLOR_RED, "* %s Has Robbery Atm Pliss Admin Spec", pData[playerid][pName]);
		// SendClientMessageToAllEx(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan ATM Location: %s' {ffffff}warga harap menjauh dari perampokan", GetLocation(AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]));
        if(pData[playerid][pFaction] == 1)
		{
			SendFactionMessage(1, COLOR_BLUE, "ALARM: "WHITE_E"saat ini sedang terjadi perampokan ATM di "YELLOW_E"Lokasi: %s",GetLocation(AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]));
		}
		new dc[128];
		format(dc, sizeof(dc),  "```UCP : %s Dengan Nama IC %s Merampok Atm.```", pData[playerid][pUCP], ReturnName(playerid));
		SendDiscordMessage(17, dc);
		}
	 	else if(pData[playerid][pActivityTime] < 100)
		{
		   	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		   	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	return 1;
}
	// new rand = RandomEx(1,12);
    // if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	// {
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 1)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, Lakukan lagi sebelum Polisi datang");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 2)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, Lakukan lagi sebelum Polisi datang");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 3)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, alat perampokan anda hancur");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 4)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, alat perampokan anda hancur");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 5)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 			pData[playerid][pLockPick] -= 1;
	// 			Info(playerid, "Lockipick pecah");
	// 	    	Info(playerid, "Anda gagal meretas ATM, Lakukan lagi sebelum Polisi datang");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 6)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, alat perampokan anda hancur");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 7)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, alat perampokan anda hancur");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 8)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, Lakukan lagi sebelum Polisi datang");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 9)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, alat perampokan anda hancur");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
	//     if(pData[playerid][pActivityTime] >= 100)
	//     {
	// 	    if(rand == 10)
	// 	    {
	// 	    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
	// 	    	TogglePlayerControllable(playerid, 1);
	// 	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	// 			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	// 			KillTimer(pData[playerid][pActivity]);
	// 			pData[playerid][pEnergy] -= 8;
	// 			pData[playerid][pActivityTime] = 0;
	// 	    	Info(playerid, "Anda gagal meretas ATM, alat perampokan anda hancur");
	// 	        TogglePlayerControllable(playerid, 1);
	// 			return 1;
	// 		}
	// 	}
 	// 	else if(pData[playerid][pActivityTime] < 100)
 	// 	{
	//     	pData[playerid][pActivityTime] += 5;
	// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	//     	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	// 	}
// 	    if(pData[playerid][pActivityTime] >= 100)
// 	    {
// 		    if(rand == 11)
// 		    {
// 		    	InfoTD_MSG(playerid, 8000, "Robbery ~g~Succesfully!");
// 		    	TogglePlayerControllable(playerid, 1);
// 		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 				KillTimer(pData[playerid][pActivity]);
// 				pData[playerid][pHunger] -= 5;
// 				pData[playerid][pEnergy] -= 8;
// 				pData[playerid][pActivityTime] = 0;
// 				ClearAnimations(playerid);
// 		    	new RandRobAtm = Random(650, 750);
// 		    	pData[playerid][pRedMoney] += RandRobAtm;
// 		    	Info(playerid, "Anda berhasil merampok ATM, cepat pergi dari lokasi sebelum polisi datang");
// 		    	new string[1280];
// 				format(string, sizeof(string), "You takes Robbery ATM Money "LG_E"$%d", RandRobAtm);
//                 SendClientMessage(playerid, ARWIN, string);
//                 pData[playerid][RobbankTime] = gettime() + 172800;
// 				SendAdminMessage(COLOR_RED, "* %s Has Robbery Atm Pliss Admin Spec", pData[playerid][pName]);
// 				SendClientMessageToAllEx(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan ATM Location: %s' {ffffff}warga harap menjauh dari perampokan", GetLocation(AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]));
//                 if(pData[playerid][pFaction] == 1)
// 				{
// 					SendFactionMessage(1, COLOR_BLUE, "ALARM: "WHITE_E"saat ini sedang terjadi perampokan ATM di "YELLOW_E"Lokasi: %s",GetLocation(AtmData[id][atmX], AtmData[id][atmY], AtmData[id][atmZ]));
// 				}
// 				new dc[128];
// 				format(dc, sizeof(dc),  "```UCP : %s Dengan Nama IC %s Merampok Atm.```", pData[playerid][pUCP], ReturnName(playerid));
// 				SendDiscordMessage(17, dc);
// 			}
// 		}
// 	 	else if(pData[playerid][pActivityTime] < 100)
// 		{
// 		   	pData[playerid][pActivityTime] += 5;
// 			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 		   	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
// 		}
// 	}
// 	return 1;
// }

/*CMD:robwarung(playerid, params[])
{
    new count;
    if(pData[playerid][pFaction] != 8 && pData[playerid][pFaction] != 9 && pData[playerid][pFaction] != 10 && pData[playerid][pFaction] != 11) return Error(playerid, "kamu harus menjadi seorang badside");

    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1921.74, -2069.82, 13.56) && IsPlayerInRangeOfPoint(playerid, 2.0, 2346.44, -1354.39, 24.01) && IsPlayerInRangeOfPoint(playerid, 2.0, 1915.47, -1768.66, 13.66)) return Error(playerid, "Kamu tidak berada di tempat rob warung");
    if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery bank", pData[playerid][RobbankTime] - gettime());
    if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "You must logged in!");
    if(pData[playerid][pInjured] >= 1) return Error(playerid, "You can't use this at this moment!");
    if(pData[playerid][pLockPick] != 2) return Error(playerid, "Kamu Tidak mempunyai 2 lockpick");
    {
        pData[playerid][pActivity] = SetTimerEx("RobWaroeng", 1000, true, "idd", playerid); // 3mnt
        SendClientMessageToAll(-1, "ALARM : Terjadi perampokan di warung-!");

        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Rob Warung...");
        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
        TogglePlayerControllable(playerid, 0);
        ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1, 1, 1, 1, 1, 1, 1);
    }
    return 1;
}
function RobWaroeng(playerid)
{
    new rand = RandomEx(1,4);
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
    {
        if(pData[playerid][pActivityTime] >= 100)
        {
		    if(rand == 1)
		    {
		    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
		    	TogglePlayerControllable(playerid, 1);
		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				KillTimer(pData[playerid][pActivity]);
				pData[playerid][pEnergy] -= 8;
				pData[playerid][pActivityTime] = 0;
		    	Info(playerid, "Anda gagal membobol waroeng, Lakukan lagi sebelum Polisi datang");
		        TogglePlayerControllable(playerid, 1);
				return 1;
			}
		}
 		else if(pData[playerid][pActivityTime] < 100)
 		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	    if(pData[playerid][pActivityTime] >= 100)
	    {
		    if(rand == 2)
		    {
		    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
		    	TogglePlayerControllable(playerid, 1);
		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				KillTimer(pData[playerid][pActivity]);
				pData[playerid][pEnergy] -= 8;
				pData[playerid][pActivityTime] = 0;
				pData[playerid][pLockPick] -= 1;
				Info(playerid, "Lockpick patah rob bizz gagal");
		    	Info(playerid, "Anda gagal membobol waroeng, Lakukan lagi sebelum Polisi datang");
		        TogglePlayerControllable(playerid, 1);
				return 1;
			}
		}
 		else if(pData[playerid][pActivityTime] < 100)
 		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	    if(pData[playerid][pActivityTime] >= 100)
	    {
		    if(rand == 3)
		    {
		    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
		    	TogglePlayerControllable(playerid, 1);
		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				KillTimer(pData[playerid][pActivity]);
				pData[playerid][pEnergy] -= 8;
				pData[playerid][pActivityTime] = 0;
		    	Info(playerid, "Anda gagal membobol waroeng, Lakukan lagi sebelum Polisi datang");
		        TogglePlayerControllable(playerid, 1);
				return 1;
			}
		}
 		else if(pData[playerid][pActivityTime] < 100)
 		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	    if(pData[playerid][pActivityTime] >= 100)
		{
            if(rand == 4)
            {
                InfoTD_MSG(playerid, 8000, "Robbery ~g~Succesfully!");
                TogglePlayerControllable(playerid, 1);
                HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
                PlayerTextDrawHide(playerid, ActiveTD[playerid]);
                KillTimer(pData[playerid][pActivity]);
                pData[playerid][pHunger] -= 5;
                pData[playerid][pEnergy] -= 8;
                pData[playerid][pActivityTime] = 0;
                pData[playerid][pLockPick] -= 2; //jumlah lockpick yang digunakan untuk ngerob warungnya
                ShowItemBox(playerid, "Lockpick", "REMOVE_2x", 11746, 3);
                ClearAnimations(playerid);
                pData[playerid][RobbankTime] = gettime() + 172800;
                new RandomRobWarung = Random(2000, 3000);
                pData[playerid][pRedMoney] += RandomRobWarung;
                Info(playerid, "Anda berhasil merampok warung, cepat pergi dari lokasi sebelum polisi datang");
                new string[1280];
                format(string, sizeof(string), "You takes Robbery Bank Red Money "LG_E"$%d", RandomRobWarung);
                SendClientMessage(playerid, ARWIN, string);
            }
        }
        else if(pData[playerid][pActivityTime] < 100)
        {
            pData[playerid][pActivityTime] += 5;
            SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
            PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
        }
    }
    return 1;
}*/
CMD:Robbiz(playerid, params[])
{
	new count;
	if(pData[playerid][pFamily] == -1)
	{
		return Error(playerid, "You are not in family!");
	}
	if(pData[playerid][IsLoggedIn] == false) 
	{
		return Error(playerid, "You must logged in!");
	}
	if(pData[playerid][pInjured] >= 1) 
	{
		return Error(playerid, "You can't use this at this moment!");
	}
	if(pData[playerid][pLockPick] == 0) 
	{
		return Error(playerid, "Kamu tidak ada lockpick"); 
	}
	if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery Atm", pData[playerid][RobbankTime] - gettime());
	if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 3.0, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
	{
		foreach(new i : Player)
		{
			if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
			{
				count++;
			}
		}

		if(count < 3)
		{
			return Info(playerid, "Anggota SAPD harus minimal 3++ untuk melakukan perampokan.");
		}

		foreach(new i : Player)
		{
			if(pData[i][pFaction] == 3 && pData[i][pOnDuty] == 1)
			{
				count++;
			}
		}

		if(count < 1)
		{
			return Info(playerid, "Anggota SAMD harus minimal 1++ untuk melakukan perampokan.");
		}

		Info(playerid, "You're in robbery please wait...");
				
		pData[playerid][pActivity] = SetTimerEx("RobBizz", 6000, true, "i", playerid);
    			
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant",	4.0, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

function RobBizz(playerid)
{
	if(pData[playerid][pActivityTime] >= 100)
		{
		InfoTD_MSG(playerid, 8000, "Robbery ~g~Succesfully!");
		TogglePlayerControllable(playerid, 1);
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pHunger] -= 35;
		pData[playerid][pEnergy] -= 35;
		pData[playerid][pActivityTime] = 0;
		pData[playerid][pLockPick] -= 1;
		ClearAnimations(playerid);
		InRob[playerid] = 0;
		pData[playerid][RobbankTime] = gettime() + 2 * 3600;
		new RandRobBizz = Random(650, 750);
		pData[playerid][pRedMoney] += RandRobBizz;
		Info(playerid, "Anda berhasil merampok BIZZ, cepat pergi dari lokasi sebelum polisi datang");
		new string[1280];
		format(string, sizeof(string), "You takes Robbery Bizz Red Money "LG_E"$%d", RandRobBizz);
        SendClientMessage(playerid, ARWIN, string);
		// SendAdminMessage(COLOR_RED, "* %s Has Robbery Bisnis Pliss Admin Spec", pData[playerid][pName]);
		// SendClientMessageToAllEx(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan Bisnis ID: %d' {ffffff}warga harap menjauh dari perampokan", GetPlayerVirtualWorld(playerid));
        if(pData[playerid][pFaction] == 1)
		{
			SendFactionMessage(1, COLOR_RED, "**[Warning]{FFFFFF} Alarm Berbunyi Di bisnis ID: %d", GetPlayerVirtualWorld(playerid));
		}
		new dc[128];
		format(dc, sizeof(dc),  "```UCP : %s Dengan Nama IC %s Merampok Bisnis.```", pData[playerid][pUCP], ReturnName(playerid));
		SendDiscordMessage(17, dc);
		}
	 	else if(pData[playerid][pActivityTime] < 100)
		{
		   	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		   	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	}
	return 1;
}
// 	new rand = RandomEx(1,4);
//     if(!IsValidTimer(pData[playerid][pActivity])) return 0;
// 	{
// 	    if(pData[playerid][pActivityTime] >= 100)
// 	    {
// 		    if(rand == 1)
// 		    {
// 		    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
// 		    	TogglePlayerControllable(playerid, 1);
// 		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 				KillTimer(pData[playerid][pActivity]);
// 				pData[playerid][pEnergy] -= 8;
// 				pData[playerid][pActivityTime] = 0;
// 		    	Info(playerid, "Anda gagal membobol Bank, Lakukan lagi sebelum Polisi datang");
// 		        TogglePlayerControllable(playerid, 1);
// 				return 1;
// 			}
// 		}
//  		else if(pData[playerid][pActivityTime] < 100)
//  		{
// 	    	pData[playerid][pActivityTime] += 5;
// 			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
// 		}
// 	    if(pData[playerid][pActivityTime] >= 100)
// 	    {
// 		    if(rand == 2)
// 		    {
// 		    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
// 		    	TogglePlayerControllable(playerid, 1);
// 		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 				KillTimer(pData[playerid][pActivity]);
// 				pData[playerid][pEnergy] -= 8;
// 				pData[playerid][pActivityTime] = 0;
// 				pData[playerid][pLockPick] -= 1;
// 				Info(playerid, "Lockpick patah rob bizz gagal");
// 		    	Info(playerid, "Anda gagal membobol Bank, Lakukan lagi sebelum Polisi datang");
// 		        TogglePlayerControllable(playerid, 1);
// 				return 1;
// 			}
// 		}
//  		else if(pData[playerid][pActivityTime] < 100)
//  		{
// 	    	pData[playerid][pActivityTime] += 5;
// 			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
// 		}
// 	    if(pData[playerid][pActivityTime] >= 100)
// 	    {
// 		    if(rand == 3)
// 		    {
// 		    	InfoTD_MSG(playerid, 8000, "Robbery ~r~Failed!");
// 		    	TogglePlayerControllable(playerid, 1);
// 		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 				KillTimer(pData[playerid][pActivity]);
// 				pData[playerid][pEnergy] -= 8;
// 				pData[playerid][pActivityTime] = 0;
// 		    	Info(playerid, "Anda gagal membobol Bank, Lakukan lagi sebelum Polisi datang");
// 		        TogglePlayerControllable(playerid, 1);
// 				return 1;
// 			}
// 		}
//  		else if(pData[playerid][pActivityTime] < 100)
//  		{
// 	    	pData[playerid][pActivityTime] += 5;
// 			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
// 		}
// 	    if(pData[playerid][pActivityTime] >= 100)
// 	    {
// 		    if(rand == 4)
// 		    {
// 		    	InfoTD_MSG(playerid, 8000, "Robbery ~g~Succesfully!");
// 		    	TogglePlayerControllable(playerid, 1);
// 		    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 				PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 				KillTimer(pData[playerid][pActivity]);
// 				pData[playerid][pHunger] -= 5;
// 				pData[playerid][pEnergy] -= 8;
// 				pData[playerid][pActivityTime] = 0;
// 				pData[playerid][pLockPick] -= 1;
// 				ClearAnimations(playerid);
// 				InRob[playerid] = 0;
// 				pData[playerid][RobbankTime] = gettime() + 172800;
// 		    	new RandRobBizz = Random(650, 750);
// 		    	pData[playerid][pRedMoney] += RandRobBizz;
// 		    	Info(playerid, "Anda berhasil merampok BIZZ, cepat pergi dari lokasi sebelum polisi datang");
// 		    	new string[1280];
// 				format(string, sizeof(string), "You takes Robbery Bizz Red Money "LG_E"$%d", RandRobBizz);
//                 SendClientMessage(playerid, ARWIN, string);
// 				SendAdminMessage(COLOR_RED, "* %s Has Robbery Bisnis Pliss Admin Spec", pData[playerid][pName]);
// 				SendClientMessageToAllEx(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan Bisnis ID: %d' {ffffff}warga harap menjauh dari perampokan", GetPlayerVirtualWorld(playerid));
//                 if(pData[playerid][pFaction] == 1)
// 				{
// 					SendFactionMessage(1, COLOR_RED, "**[Warning]{FFFFFF} Alarm Berbunyi Di bisnis ID: %d", GetPlayerVirtualWorld(playerid));
// 				}
// 				new dc[128];
// 				format(dc, sizeof(dc),  "```UCP : %s Dengan Nama IC %s Merampok Bisnis.```", pData[playerid][pUCP], ReturnName(playerid));
// 				SendDiscordMessage(17, dc);
// 			}
// 		}
// 	 	else if(pData[playerid][pActivityTime] < 100)
// 		{
// 		   	pData[playerid][pActivityTime] += 5;
// 			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 		   	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
// 		}
// 	}
// 	return 1;
// }

//rob Old
/*function Robb(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 15;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	GiveMoneyRob(playerid, 1, 50000);
	    	SetPVarInt(playerid, "Robb", gettime() + 3000);
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
CMD:lockpick(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid,2.0, 291.35, -106.30, 1001.51)) return Error(playerid, "SALAH PINTU");
	if(pData[playerid][pFamily] >= 1)
	{
		Info(playerid, "You're in create please wait...");
		pData[playerid][pActivity] = SetTimerEx("Lockpick", 100, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Create...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		InRob[playerid] = 1;
	}
	else
	{
		Error(playerid, "Anda Bukan Anggota Family!");
  	}
	return 1;
}

function Lockpick(playerid)
{
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Lockpick Creating!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 4;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	        GivePlayerMoneyEx(playerid, -5000);
	    	pData[playerid][pLockPick] += 1;
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully creat the lockpick and your money -$5000");
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
CMD:robbery(playerid, params[])
{
    new id = -1;
	id = GetClosestATM(playerid);
	//new Float:x, Float:y, Float:z, String[100];
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	if(pData[playerid][pLevel] < 10)
			return Error(playerid, "You must level 10 to use this!");
	if(pData[playerid][pLockPick] == 1)
			return Error(playerid, "Kamu Tidak mempunyai lockpick");

	if(IsPlayerConnected(playerid))
	{
        if(isnull(params))
		{
            SyntaxMsg(playerid, "USAGE: /robbery [name]");
            Info(playerid, "Names: atm, biz, bank");
            return 1;
        }
		if(strcmp(params,"biz",true) == 0)
		{
			new count;
    		foreach(new i : Player)
    		{
        		if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
        		{
           		count++;
        		}
    		}
    		if(count < 2)
    		{
        		return Error(playerid, "Setidaknya harus ada 2+ Aparat yang on duty untuk membobol.");
    		}
            if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
			{
	    		if(GetPVarInt(playerid, "Robb") > gettime())
					return Error(playerid, "Delays Rob, please wait.");
                if(GetPlayerWeapon(playerid) != WEAPON_SHOTGUN) return Error(playerid, "You Need Shotgun.");

				Info(playerid, "You're in robbery please wait...");
				SendAdminMessage(COLOR_RED, "* %s Has Robbery Bisnis Pliss Admin Spec", pData[playerid][pName]);
				SendClientMessageToAllEx(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan Bisnis ID: %d' {ffffff}warga harap menjauh dari perampokan", GetPlayerVirtualWorld(playerid));
				foreach(new i : Player)
				{
					if(pData[i][pPhone] == bData[pData[playerid][pInBiz]][bPh])
					{
						SCM(i, COLOR_RED, "[WARNING]"WHITE_E" Alarm Berbunyi Di bisnis anda!");
					}
				}
                SendFactionMessage(1, COLOR_RED, "**[Warning]{FFFFFF} Alarm Berbunyi Di bisnis ID: %d", GetPlayerVirtualWorld(playerid));
				
				pData[playerid][pActivity] = SetTimerEx("Robb", 6000, true, "i", playerid);
    			
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant",	4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
        }
		else if(strcmp(params,"atm",true) == 0)
		{
			new count;
    		foreach(new i : Player)
    		{
        		if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
        		{
           		count++;
        		}
    		}
    		if(count < 2)
    		{
        		return Error(playerid, "Setidaknya harus ada 2+ Aparat yang on duty untuk membobol atm.");
    		}
			if(id > -1)
			{
				if(GetPVarInt(playerid, "Robb") > gettime())
					return Error(playerid, "Delays Rob, please wait.");
                if(GetPlayerWeapon(playerid) != WEAPON_BAT) return Error(playerid, "You Need baseball.");
				Info(playerid, "You're in robbery please wait...");
				SendAdminMessage(COLOR_RED, "* %s Has Robbery Atm Pliss Admin Spec", pData[playerid][pName]);
				SendClientMessageToAllEx(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan ATM Location: %s' {ffffff}warga harap menjauh dari perampokan", GetLocation(x, y, z));
				//SendFactionMessage(playerid, COLOR_RED, "**[Warning]{FFFFFF} Telah Terjadi Pembobolan Atm di Location: %s", GetLocation(x, y, z));
				//SendFactionMessage(playerid, COLOR_RED, String);

				pData[playerid][pActivity] = SetTimerEx("Robb", 6000, true, "i", playerid);
    			
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid,"SWORD", "sword_4", 4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
		}
		if(strcmp(params,"bank",true) == 0)
		{
			new count;
    		foreach(new i : Player)
    		{
        		if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
        		{
           		count++;
        		}
    		}
    		if(count < 2)
    		{
        		return Error(playerid, "Setidaknya harus ada 2+ Aparat yang on duty untuk membobol bank.");
    		}
            if(IsPlayerInRangeOfPoint(playerid, 2.5, 1412.1685, -999.0665, 10.8763))
			{
	    		if(GetPVarInt(playerid, "Robb") > gettime())
					return Error(playerid, "Delays Rob, please wait.");
                if(GetPlayerWeapon(playerid) != WEAPON_SHOTGUN) return Error(playerid, "You Need Shotgun.");

				Info(playerid, "You're in robbery please wait...");
				SendAdminMessage(COLOR_RED, "* %s Has Robbery Bank Pliss Admin Spec", pData[playerid][pName]);
				SendClientMessageToAll(COLOR_RED, "[ALARM KOTA] {FFFF00}'Telah Terjadi Perampokan Di Bank' {ffffff}warga harap menjauh dari perampokan");
                //SendFactionMessage(playerid, COLOR_RED, "**[Warning]{FFFFFF} Telah Terjadi Perampokan diBank!");
                //SendClientMessageToAll(COLOR_RED, "**[Warning]{FFFFFF} Telah Terjadi Perampokan diBank harap menjauh!");

				pData[playerid][pActivity] = SetTimerEx("Robb", 6000, true, "i", playerid);
				Server_MinMoney(10000);

				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant",	4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
        }
	}
	return 1;
}*/
