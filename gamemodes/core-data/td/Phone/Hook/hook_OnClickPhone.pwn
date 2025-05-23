forward hook_OnClickPhone(playerid, PlayerText: textid);
public hook_OnClickPhone(playerid, PlayerText: textid)
{
	if (textid == PhoneTDButton[playerid][0])
	{
		ShowPhoneMainscreen(playerid);
	}

	if (textid == PhoneTDButton[playerid][1])
	{
		RemovePlayerAttachedObject(playerid, 9);

		if(!IsPlayerInAnyVehicle(playerid) && !PlayerData[playerid][pInjured] && !PlayerData[playerid][pLoopAnim])
		{
			ClearAnimations(playerid);
		}    
		TogglePhone[playerid] = 0;
		HidePhone(playerid);
	}

	if(textid == PhoneTD_CallPickupButton[playerid])
	{
        callcmd::p(playerid, "");
        TogglePhone[playerid] = 0;
	}

	if(textid == PhoneTD_CallRejectButton[playerid])
	{
        callcmd::hu(playerid, "");
        TogglePhone[playerid] = 0;
	}

	if(textid == PhoneTD_CallCloseButton[playerid])
	{
        callcmd::hu(playerid, "");
        TogglePhone[playerid] = 0;
	}

	if(textid == PhoneTDApkButton[playerid][5]) // Air Drop 
	{
	    if(pData[playerid][pPhoneStatus] == 0)
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
  		new str[500], count = 0;
			//ShowPlayerDialog(playerid, DIALOG_GIVE, DIALOG_STYLE_INPUT, "Memberikan Barang", "Kantong Yang Ingin Di Berikan:", "Berikan", "Batal");
		foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 5) && i != playerid)
		{
			format(str, sizeof(str), "%sKantong - %s (%d)\n", str, pData[i][pName], i);
			SetPlayerListitemValue(playerid, count++, i);
		}
		if(!count) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Fountain Daily - Airdrop", "Tidak ada player disekitarmu", "Tutup", ""), PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
		else ShowPlayerDialog(playerid, DIALOG_AIRDROP, DIALOG_STYLE_LIST, "Fountain Daily - Airdrop", str, "Pilih", "Tutup");
	}
	if(textid == PhoneTDApkButton[playerid][11]) // Call
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		
		ShowPlayerDialog(playerid, DIALOG_PHONE_DIALUMBER, DIALOG_STYLE_INPUT, "Dial Number", "Masukkan nomor telepon yang mau di telpon disini:", "Call", "Back");
	}
	if(textid == PhoneTDApkButton[playerid][2]) // Ads
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		if(pData[playerid][pVip] < 1)
		{
			return SendErrorMessage(playerid, "You're not a VIP Player.");
		}
		ShowPlayerDialog(playerid,DIALOG_IKLANHP,DIALOG_STYLE_INPUT,"Iklan Via Phone","Masukkan Iklan Disini","Select", "Cancel");
	}
	if(textid == PhoneTDApkButton[playerid][3]) // Bank
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		if(pData[playerid][pVip])
		{
			return ShowPlayerDialog(playerid, DIALOG_IBANK, DIALOG_STYLE_LIST, "{6688FF}I-Bank", "Check Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
		}

		ShowPlayerDialog(playerid, DIALOG_IBANK, DIALOG_STYLE_LIST, "{6688FF}I-Bank", "Check Balance\nTransfer Money", "Select", "Cancel");
	}
	if(textid == PhoneTDApkButton[playerid][4]) // Taxi
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowTaxiDuties(playerid);
	}
	if(textid == PhoneTDApkButton[playerid][9]) // Contacts
	{
		if (pData[playerid][pPhoneStatus] == 0)
			return Error(playerid, "Your phone must be powered on.");

		if(pData[playerid][pPhoneBook] == 0)
			return Error(playerid, "You dont have a phone book.");

		ShowContacts(playerid);
	}
	if(textid == PhoneTDApkButton[playerid][8]) // Twitter
	{
		new notif[20];
		if(pData[playerid][pTwitterStatus] == 1)
		{
			notif = "{ff0000}OFF";
		}
		else
		{
			notif = "{3BBD44}ON";
		}

		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}

		new string[100];
		//format(string, sizeof(string), "Tweet\nChangename Twitter({0099ff}%s{ffffff})\nNotification: {ff0000}MAINTENANCE", pData[playerid][pTwittername]);
		format(string, sizeof(string), "Posting Sesuatu\nGanti Nama Account: ({0099ff}%s{ffffff})\nNotify: %s", pData[playerid][pTwittername], notif);
		ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter", string, "Select", "Close");
	}
	if(textid == PhoneTDApkButton[playerid][6]) // Bank
	{
  		ShowPlayerDialog(playerid, DIALOG_PANELPHONE, DIALOG_STYLE_LIST, "Phone", "Tentang Ponsel\nSettings", "Select", "Back");
	}
	if(textid == PhoneTDApkButton[playerid][10]) // Bank
	{
		callcmd::selfie(playerid, "");
	}
	if(textid == PhoneTDApkButton[playerid][7]) // Bank
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
	}
	if(textid == PhoneTDApkButton[playerid][1]) // Job
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		
		ShowPlayerDialog(playerid, DIALOG_GPS_JOB, DIALOG_STYLE_LIST, "GPS Jobs & Sidejobs", "{15D4ED}JOB: {ff0000}Courir Drugs\
			\n{15D4ED}JOB: {ffffff}Street Vendor\
			\n{15D4ED}JOB: {ffffff}Cattle\
			\n{15D4ED}JOB: {ffffff}Mechanic\
			\n{15D4ED}JOB: {ffffff}Lumber Jack\
			\n{15D4ED}JOB: {ffffff}Trucker\
			\n{15D4ED}JOB: {ffffff}Penambang Batu\
			\n{15D4ED}JOB: {ffffff}Production\
			\n{15D4ED}JOB: {ffffff}Farmer\
			\n{15D4ED}JOB: {ffffff}Baggage Airport\
			\n{15D4ED}JOB: {ffffff}Pemotong Ayam\
			\n{15D4ED}JOB: {ffffff}Merchant Filler\
			\n{15D4ED}JOB: {ffffff}Penambang Minyak\
			\n{15D4ED}JOB: {ffffff}Taxi Driver\
			\n{D2D2AB}SIDEJOB: {ffffff}Sweeper\
			\n{D2D2AB}SIDEJOB: {ffffff}Bus\
			\n{D2D2AB}SIDEJOB: {ffffff}Forklift\
			\n{D2D2AB}SIDEJOB: {ffffff}Fisher\
			\n{D2D2AB}SIDEJOB: {ffffff}Petani Micin\
			\n{D2D2AB}SIDEJOB: {ffffff}Fruits Farmer\
			\n{D2D2AB}SIDEJOB: {ffffff}Machinist\
			\n{D2D2AB}SIDEJOB: {ffffff}Baggage", "Select", "Back");
	}
	if(textid == PhoneTDApkButton[playerid][0]) // Music
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowPlayerDialog(playerid,DIALOG_MUSICHP,DIALOG_STYLE_LIST,"Music","Matikan Musik\nInput Link","Select", "Cancel");
	}

	return 1;
}