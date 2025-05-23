public OnClickDynamicPlayerTextDraw(playerid, PlayerText:textid)
{
	if(textid == TDSITRY[playerid][21])
	{
		for(new txd; txd < 22; txd++)
		{
			PlayerTextDrawHide(playerid, TDSITRY[playerid][txd]);
			CancelSelectTextDraw(playerid);
		}
	}
	//callvoice
	/* if(textid == CallHpLenz[playerid][20])
	{
        callcmd::p(playerid, "");
        TogglePhone[playerid] = 0;
	}

	if(textid == CallHpLenz[playerid][18])
	{
        callcmd::hu(playerid, "");
        TogglePhone[playerid] = 0;
	} */
	//hpnyarrr
	// if(textid == closehplenz[playerid])
	// {
	// 	RemovePlayerAttachedObject(playerid, 9);

	// 	if(!IsPlayerInAnyVehicle(playerid) && !PlayerData[playerid][pInjured] && !PlayerData[playerid][pLoopAnim])
	// 	{
	// 		ClearAnimations(playerid);
	// 	}    
	// 	for(new i = 0; i < 25; i++) {
	// 		PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
	// 	}
	// 	HideHpLenz(playerid);
	// 	TogglePhone[playerid] = 0;
	// 	CancelSelectTextDraw(playerid);
	// }
 	// if(textid == fingerhp[playerid][24])//fingerprint
	// {
	// 	for(new i = 0; i < 25; i++) {
	// 		PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
	// 	}
	// 	ShowHpLenz(playerid);
	// 	SelectTextDraw(playerid, COLOR_LBLUE);
	// }
	// if(textid == airdrophplenz[playerid]) 
	// {
	//     if(pData[playerid][pPhoneStatus] == 0)
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
  	// 	new str[500], count = 0;
	// 		//ShowPlayerDialog(playerid, DIALOG_GIVE, DIALOG_STYLE_INPUT, "Memberikan Barang", "Kantong Yang Ingin Di Berikan:", "Berikan", "Batal");
	// 	foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 5) && i != playerid)
	// 	{
	// 		format(str, sizeof(str), "%sKantong - %s (%d)\n", str, pData[i][pName], i);
	// 		SetPlayerListitemValue(playerid, count++, i);
	// 	}
	// 	if(!count) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Fountain Daily - Airdrop", "Tidak ada player disekitarmu", "Tutup", ""), PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
	// 	else ShowPlayerDialog(playerid, DIALOG_AIRDROP, DIALOG_STYLE_LIST, "Fountain Daily - Airdrop", str, "Pilih", "Tutup");
	// }
	// if(textid == callhplenz[playerid]) 
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
		
	// 	ShowPlayerDialog(playerid, DIALOG_PHONE_DIALUMBER, DIALOG_STYLE_INPUT, "Dial Number", "Masukkan nomor telepon yang mau di telpon disini:", "Call", "Back");
	// }
	// if(textid == adshplenz[playerid])
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
	// 	if(pData[playerid][pVip] < 1)
	// 	{
	// 		return SendErrorMessage(playerid, "You're not a VIP Player.");
	// 	}
	// 	ShowPlayerDialog(playerid,DIALOG_IKLANHP,DIALOG_STYLE_INPUT,"Iklan Via Phone","Masukkan Iklan Disini","Select", "Cancel");
	// }
	// if(textid == bankhplenz[playerid]) 
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
	// 	if(pData[playerid][pVip])
	// 	{
	// 		return ShowPlayerDialog(playerid, DIALOG_IBANK, DIALOG_STYLE_LIST, "{6688FF}I-Bank", "Check Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	// 	}

	// 	ShowPlayerDialog(playerid, DIALOG_IBANK, DIALOG_STYLE_LIST, "{6688FF}I-Bank", "Check Balance\nTransfer Money", "Select", "Cancel");
	// }
	// if(textid == contacthplenz[playerid]) 
	// {
	// 	if (pData[playerid][pPhoneStatus] == 0)
	// 		return Error(playerid, "Your phone must be powered on.");

	// 	if(pData[playerid][pPhoneBook] == 0)
	// 		return Error(playerid, "You dont have a phone book.");

	// 	ShowContacts(playerid);
	// }
	// if(textid == twhplenz[playerid]) 
	// {
	// 	new notif[20];
	// 	if(pData[playerid][pTwitterStatus] == 1)
	// 	{
	// 		notif = "{ff0000}OFF";
	// 	}
	// 	else
	// 	{
	// 		notif = "{3BBD44}ON";
	// 	}

	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}

	// 	new string[100];
	// 	//format(string, sizeof(string), "Tweet\nChangename Twitter({0099ff}%s{ffffff})\nNotification: {ff0000}MAINTENANCE", pData[playerid][pTwittername]);
	// 	format(string, sizeof(string), "Posting Sesuatu\nGanti Nama Account: ({0099ff}%s{ffffff})\nNotify: %s", pData[playerid][pTwittername], notif);
	// 	ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter", string, "Select", "Close");
	// }
	// if(textid == settinghplenz[playerid])
	// {
  	// 	ShowPlayerDialog(playerid, DIALOG_PANELPHONE, DIALOG_STYLE_LIST, "Phone", "Tentang Ponsel\nSettings", "Select", "Back");
	// }
	// if(textid == camerahplenz[playerid])
	// {
	// 	callcmd::selfie(playerid, "");
	// }
	// if(textid == mapshplenz[playerid])
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
	// 	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
	// }
	// if(textid == jobhplenz[playerid])
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
	// 	ShowPlayerDialog(playerid, DIALOG_GPS_JOB, DIALOG_STYLE_LIST, "GPS Jobs & Sidejobs", "{15D4ED}JOB: {ff0000}Courir Drugs\n{15D4ED}JOB: {ffffff}Street Vendor\n{15D4ED}JOB: {ffffff}Cattle\n{15D4ED}JOB: {ffffff}Mechanic\n{15D4ED}JOB: {ffffff}Lumber Jack\n{15D4ED}JOB: {ffffff}Trucker\n{15D4ED}JOB: {ffffff}Penambang Batu\n{15D4ED}JOB: {ffffff}Production\n{15D4ED}JOB: {ffffff}Farmer\n{15D4ED}JOB: {ffffff}Baggage Airport\n{15D4ED}JOB: {ffffff}Pemotong Ayam\n{15D4ED}JOB: {ffffff}Merchant Filler\n{15D4ED}JOB: {ffffff}Penambang Minyak\n{D2D2AB}SIDEJOB: {ffffff}Sweeper\n{D2D2AB}SIDEJOB: {ffffff}Bus\n{D2D2AB}SIDEJOB: {ffffff}Forklift\n{D2D2AB}SIDEJOB: {ffffff}Mower\n{D2D2AB}SIDEJOB: {ffffff}Petani Micin\n{D2D2AB}SIDEJOB: {ffffff}Fruits Farmer\n{D2D2AB}SIDEJOB: {ffffff}Machinist", "Select", "Back");
	// }
	// // if(textid == gojekhplenz[playerid])
	// // {
	// // 	if(pData[playerid][pPhoneStatus] == 0) 
	// // 	{
	// // 		return Error(playerid, "Handphone anda sedang dimatikan");
	// // 	}
	// // 	ShowPlayerDialog(playerid,DIALOG_CALLGOCAR,DIALOG_STYLE_INPUT,"Pesan Singkat","Masukkan Pesan Disini","Select", "Cancel");

	// // }
	// if(textid == musichplenz[playerid])
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
	// 	ShowPlayerDialog(playerid,DIALOG_MUSICHP,DIALOG_STYLE_LIST,"Music","Matikan Musik\nInput Link","Select", "Cancel");
	// }
	//logine
	/* if(textid == masuklogintd[playerid])
	{
		for(new i = 0; i < 15; i++)
		{
			PlayerTextDrawHide(playerid, LoginSpawnTD[playerid][i]);
		}
		PlayerTextDrawHide(playerid, ucpnetd[playerid]);
		PlayerTextDrawHide(playerid, masuklogintd[playerid]);
		CancelSelectTextDraw(playerid);

		new lstring[512];
		format(lstring, sizeof lstring, ""LB_E"Masukkan Password Untuk Melanjutkan.");
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Sign Password", lstring, "Next", "Cancel");
	}
	if(textid == nyepawntd[playerid]) // DONE manggil td ke kick 
	{
	    if(pData[playerid][pilihkarakter] == 0) return Error(playerid, "Anda belum memilih karakter yang akan dimainkan");
		if(pData[playerid][pUdahLogin] == 1) 
		{
			return Kick(playerid);
		}
		new cQuery[256];
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1;", PlayerChar[playerid][pData[playerid][pChar]]);
		mysql_tquery(g_SQL, cQuery, "AssignPlayerData", "d", playerid);
		for(new i = 0; i < 15; i++)
		{
			PlayerTextDrawHide(playerid, MilehChar[playerid][i]);
		}
		PlayerTextDrawHide(playerid, ucptd[playerid]);
		PlayerTextDrawHide(playerid, karaktertd[playerid]);
		PlayerTextDrawHide(playerid, nyepawntd[playerid]);
   	 	CancelSelectTextDraw(playerid);
   	 	pData[playerid][pilihkarakter] = 0;
	}
	if(textid == karaktertd[playerid])
	{
        CheckPlayerChar(playerid);
	} */
    //GOINGTO 2NDPAGE
    if (textid == BankTD23[playerid])
    {

		PlayerTextDrawHide(playerid, BankTD5[playerid]);
		PlayerTextDrawHide(playerid, BankTD6[playerid]);
		PlayerTextDrawHide(playerid, BankTD7[playerid]);
		PlayerTextDrawHide(playerid, BankTD8[playerid]);
		PlayerTextDrawHide(playerid, BankTD9[playerid]);
		PlayerTextDrawHide(playerid, BankTD10[playerid]);
		PlayerTextDrawHide(playerid, BankTD11[playerid]);
		PlayerTextDrawShow(playerid, BankTD12[playerid]);
		PlayerTextDrawShow(playerid, BankTD13[playerid]);
		PlayerTextDrawShow(playerid, BankTD14[playerid]);
		PlayerTextDrawShow(playerid, BankTD15[playerid]);
		PlayerTextDrawShow(playerid, BankTD16[playerid]);
		PlayerTextDrawShow(playerid, BankTD17[playerid]);
		PlayerTextDrawShow(playerid, BankTD18[playerid]);
		PlayerTextDrawShow(playerid, BankTD19[playerid]);
        PlayerTextDrawShow(playerid, BankTD20[playerid]);
        PlayerTextDrawShow(playerid, BankTD21[playerid]);
        PlayerTextDrawShow(playerid, BankTD22[playerid]);
        PlayerTextDrawShow(playerid, BankTD23[playerid]);
		pData[playerid][pToggleAtm] = 0;
        return 1;
    }
    //DEPOSIT
	if (textid == BankTD15[playerid])
    {
		pData[playerid][pToggleAtm] = 0;
		PlayerTextDrawHide(playerid, BankTD0[playerid]);
		PlayerTextDrawHide(playerid, BankTD1[playerid]);
		PlayerTextDrawHide(playerid, BankTD2[playerid]);
		PlayerTextDrawHide(playerid, BankTD3[playerid]);
		PlayerTextDrawHide(playerid, BankTD4[playerid]);
		PlayerTextDrawHide(playerid, BankTD5[playerid]);
		PlayerTextDrawHide(playerid, BankTD6[playerid]);
		PlayerTextDrawHide(playerid, BankTD7[playerid]);
		PlayerTextDrawHide(playerid, BankTD8[playerid]);
		PlayerTextDrawHide(playerid, BankTD9[playerid]);
		PlayerTextDrawHide(playerid, BankTD10[playerid]);
		PlayerTextDrawHide(playerid, BankTD11[playerid]);
		PlayerTextDrawHide(playerid, BankTD12[playerid]);
		PlayerTextDrawHide(playerid, BankTD13[playerid]);
		PlayerTextDrawHide(playerid, BankTD14[playerid]);
		PlayerTextDrawHide(playerid, BankTD15[playerid]);
		PlayerTextDrawHide(playerid, BankTD16[playerid]);
		PlayerTextDrawHide(playerid, BankTD17[playerid]);
		PlayerTextDrawHide(playerid, BankTD18[playerid]);
		PlayerTextDrawHide(playerid, BankTD19[playerid]);
		PlayerTextDrawHide(playerid, BankTD20[playerid]);
		PlayerTextDrawHide(playerid, BankTD21[playerid]);
		PlayerTextDrawHide(playerid, BankTD22[playerid]);
		PlayerTextDrawHide(playerid, BankTD23[playerid]);

		ShowDialogToPlayer(playerid, DIALOG_BANKDEPOSIT);
		CancelSelectTextDraw(playerid);
        return 1;
    }
	//BankAbonLogin
	if (textid == CLOSEBANKABONLOGIN[playerid])
	{
		HideBankAbonLogin(playerid);
		return 1;
	}
	if (textid == WITHDRAWBANKABONLOGIN[playerid])
	{
		HideBankAbonLogin(playerid);
		SendClientMessageEx(playerid, COLOR_WHITE, "You need to login first.");
		return 1;
	}
	if (textid == DEPOSITBANKABONLOGIN[playerid])
	{
		HideBankAbonLogin(playerid);
		SendClientMessageEx(playerid, COLOR_WHITE, "You need to login first.");
		return 1;
	}
	if (textid == TRANSFERBANKABONLOGIN[playerid])
	{
		HideBankAbonLogin(playerid);
		SendClientMessageEx(playerid, COLOR_WHITE, "You need to login first.");
		return 1;
	}
	if (textid == NEWREKBANKABONLOGIN[playerid])
	{
		HideBankAbonLogin(playerid);
		SendClientMessageEx(playerid, COLOR_WHITE, "You need to login first.");
		return 1;
	}
	if (textid == LOGINBANKABONLOGIN[playerid])
	{
		HideBankAbonLogin(playerid);
		new name[32];
		format(name, sizeof(name), "%s", GetRPName(playerid));
		PlayerTextDrawSetString(playerid, NAMEBANKABON[playerid], name);
		new rek[32];
		format(rek, sizeof(rek), "%d",  pData[playerid][pBankRek]);
		PlayerTextDrawSetString(playerid, REKENINGBANKABON[playerid], rek);
		new cash[3200];
		format(cash, sizeof(cash), "%s.00",  FormatMoney(pData[playerid][pBankMoney]));
		PlayerTextDrawSetString(playerid, UANGBANKABON[playerid], cash);
		ShowBankAbonUtama(playerid);
		return 1;
	}

	//BankAbonUtama
	if (textid == CLOSEBANKABON[playerid])
	{
		HideBankAbonUtama(playerid);
		return 1;
	}
	if (textid == WITHDRAWBANKABON[playerid])
	{
		HideBankAbonUtama(playerid);
		ShowDialogToPlayer(playerid, DIALOG_BANKWITHDRAW);
		return 1;
	}
	if (textid == DEPOSITBANKABON[playerid])
	{
		HideBankAbonUtama(playerid);
		ShowDialogToPlayer(playerid, DIALOG_BANKDEPOSIT);
		return 1;
	}
	if (textid == TRANSFERBANKABON[playerid])
	{
		HideBankAbonUtama(playerid);
		ShowDialogToPlayer(playerid, DIALOG_BANKREKENING);
		return 1;
	}
	if (textid == NEWREKBANKABON[playerid])
	{
		if(GetPlayerMoney(playerid) < 500) return Error(playerid, "Not enough money!");
		new query[128], rand = RandomEx(111111, 999999);
		new rek = rand+pData[playerid][pID];
		mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
		mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
		SuccesMsg(playerid, "Berhasil Memperbaharui Bank Rekening Anda");
		GivePlayerMoneyEx(playerid, -500);
		//ShowItemBox(playerid, "Ktp", "Received_1x", 1581, 4);
		ShowItemBox(playerid, "Uang", "Removed_500$", 1212, 4);
		Server_AddMoney(50);
		HideBankAbonUtama(playerid);
		return 1;
	}

	//ATMFountain
	if (textid == CLOSEBUTTON[playerid])
	{
		HideATMFountain(playerid);
		return 1;
	}
	if (textid == CARDSBUTTON[playerid])
	{
		HideATMFountain(playerid);
		DisplayPaycheck(playerid);
		return 1;
	}
	if (textid == DEPOSITATMABON[playerid])
	{
		HideATMFountain(playerid);
		ShowPlayerDialog(playerid, DIALOG_ATMDEPO, DIALOG_STYLE_INPUT, ""LB_E"Bank", "Masukan jumlah uang:", "Transfer", "Cancel");
		return 1;
	}
	if (textid == TRANSFERATMABON[playerid])
	{
		HideATMFountain(playerid);
		ShowPlayerDialog(playerid, DIALOG_ATMREKENING, DIALOG_STYLE_INPUT, ""LB_E"ATM", "Masukan jumlah uang:", "Transfer", "Cancel");
		return 1;
	}
	if (textid == WITHDRAWATMABON[playerid])
	{
		HideATMFountain(playerid);
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"My Balance: "LB_E"%s", FormatMoney(pData[playerid][pBankMoney]));
		ShowPlayerDialog(playerid, DIALOG_ATMWITHDRAW, DIALOG_STYLE_LIST, mstr, "$50\n$200\n$500\n$1.000\n$5.000", "Withdraw", "Cancel");
		return 1;
	}
	//WITHDRAW
	if (textid == BankTD16[playerid])
    {
		pData[playerid][pToggleAtm] = 0;
		PlayerTextDrawHide(playerid, BankTD0[playerid]);
		PlayerTextDrawHide(playerid, BankTD1[playerid]);
		PlayerTextDrawHide(playerid, BankTD2[playerid]);
		PlayerTextDrawHide(playerid, BankTD3[playerid]);
		PlayerTextDrawHide(playerid, BankTD4[playerid]);
		PlayerTextDrawHide(playerid, BankTD5[playerid]);
		PlayerTextDrawHide(playerid, BankTD6[playerid]);
		PlayerTextDrawHide(playerid, BankTD7[playerid]);
		PlayerTextDrawHide(playerid, BankTD8[playerid]);
		PlayerTextDrawHide(playerid, BankTD9[playerid]);
		PlayerTextDrawHide(playerid, BankTD10[playerid]);
		PlayerTextDrawHide(playerid, BankTD11[playerid]);
		PlayerTextDrawHide(playerid, BankTD12[playerid]);
		PlayerTextDrawHide(playerid, BankTD13[playerid]);
		PlayerTextDrawHide(playerid, BankTD14[playerid]);
		PlayerTextDrawHide(playerid, BankTD15[playerid]);
		PlayerTextDrawHide(playerid, BankTD16[playerid]);
		PlayerTextDrawHide(playerid, BankTD17[playerid]);
		PlayerTextDrawHide(playerid, BankTD18[playerid]);
		PlayerTextDrawHide(playerid, BankTD19[playerid]);
		PlayerTextDrawHide(playerid, BankTD20[playerid]);
		PlayerTextDrawHide(playerid, BankTD21[playerid]);
		PlayerTextDrawHide(playerid, BankTD22[playerid]);
		PlayerTextDrawHide(playerid, BankTD23[playerid]);

		ShowDialogToPlayer(playerid, DIALOG_BANKWITHDRAW);
		CancelSelectTextDraw(playerid);
        return 1;
    }
	//TRANSFER
	if (textid == BankTD17[playerid])
    {
		pData[playerid][pToggleAtm] = 0;
		PlayerTextDrawHide(playerid, BankTD0[playerid]);
		PlayerTextDrawHide(playerid, BankTD1[playerid]);
		PlayerTextDrawHide(playerid, BankTD2[playerid]);
		PlayerTextDrawHide(playerid, BankTD3[playerid]);
		PlayerTextDrawHide(playerid, BankTD4[playerid]);
		PlayerTextDrawHide(playerid, BankTD5[playerid]);
		PlayerTextDrawHide(playerid, BankTD6[playerid]);
		PlayerTextDrawHide(playerid, BankTD7[playerid]);
		PlayerTextDrawHide(playerid, BankTD8[playerid]);
		PlayerTextDrawHide(playerid, BankTD9[playerid]);
		PlayerTextDrawHide(playerid, BankTD10[playerid]);
		PlayerTextDrawHide(playerid, BankTD11[playerid]);
		PlayerTextDrawHide(playerid, BankTD12[playerid]);
		PlayerTextDrawHide(playerid, BankTD13[playerid]);
		PlayerTextDrawHide(playerid, BankTD14[playerid]);
		PlayerTextDrawHide(playerid, BankTD15[playerid]);
		PlayerTextDrawHide(playerid, BankTD16[playerid]);
		PlayerTextDrawHide(playerid, BankTD17[playerid]);
		PlayerTextDrawHide(playerid, BankTD18[playerid]);
		PlayerTextDrawHide(playerid, BankTD19[playerid]);
		PlayerTextDrawHide(playerid, BankTD20[playerid]);
		PlayerTextDrawHide(playerid, BankTD21[playerid]);
		PlayerTextDrawHide(playerid, BankTD22[playerid]);
		PlayerTextDrawHide(playerid, BankTD23[playerid]);

		ShowDialogToPlayer(playerid, DIALOG_BANKREKENING);
		CancelSelectTextDraw(playerid);
        return 1;
    }

	//Taruh di OnPlayerClickTextDraw
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(textid == MODELTD[playerid][i])
		{
			if(InventoryData[playerid][i][invExists])
			{
			    MenuStore_UnselectRow(playerid);
				MenuStore_SelectRow(playerid, i);
			    new name[48];
            	strunpack(name, InventoryData[playerid][pData[playerid][pSelectItem]][invItem]);
			}
		}
	}
	if(textid == INVINFO[playerid][1])
	{
		new id = pData[playerid][pSelectItem];

		if(id == -1)
		{
		    Error(playerid,"[Inventory] Tidak Ada Barang Di Slot Tersebut");
		}
		else
		{
		    if(pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
			new string[64];
		    strunpack(string, InventoryData[playerid][id][invItem]);

		    if(!PlayerHasItem(playerid, string))
		    {
		   		Error(playerid,"[Inventory] Kamu Tidak Memiliki Barang Tersebut");
                Inventory_Show(playerid);
			}
			else
			{
				CallLocalFunction("OnPlayerUseItem", "dds", playerid, id, string);
			}
		}
	}
	else if(textid == INVINFO[playerid][3])
	{
		Inventory_Close(playerid);
	}
	else if(textid == INVINFO[playerid][2])
	{
		Error(playerid,"[Inventory] Drop Dinonaktifkan.");
	}
	else if(textid == INVINFO[playerid][6])
	{
		Inventory_Close(playerid);
		GiveItem(playerid);
	}
	else if(textid == INVINFO[playerid][4])
	{
		SelectItemAmount(playerid);
	}

	// Radial Menu TextDraw
	if (GetPVarInt(playerid, "OpenedRadialMenu"))
	{
		CallLocalFunction("hook_OnClickRadial", "ii", playerid, _:textid);
	}

	// Login Menu TextDraw
	if (GetPVarInt(playerid, "OpenedLoginMenu"))
	{
		CallLocalFunction("hook_OnClickLogin", "ii", playerid, _:textid);
	}

	// Phone Menu TextDraw
	if (GetPVarInt(playerid, "PhoneTD"))
	{
		CallLocalFunction("hook_OnClickPhone", "ii", playerid, _:textid);
	}

	return 1;
}

public OnClickDynamicTextDraw(playerid, Text:textid)
{
	if (textid == Text: INVALID_TEXT_DRAW)
	{
		if (GetPVarInt(playerid, "OpenedRadialMenu"))
		{
			HideRadialMenu(playerid);
		}

		if (GetPVarInt(playerid, "PhoneTD") && !GetPVarInt(playerid, "JustOpenedPhone"))
		{
			if (GetPVarInt(playerid, "PhoneTD_Callingscreen") || GetPVarInt(playerid, "PhoneTD_IncomingCallscreen"))
				return 1;
				
			HidePhone(playerid);
		}
	}

	//slot
    if(textid == Slot_TD[2])
    {
    	Slots_Spin(playerid);
    }
    if(textid == Slot_TD[3])
    {
    	if (SlotData[playerid][slotTimer] != -1)
			return Error(playerid, "Spin sedang berlangsung!");

    	ShowPlayerDialog(playerid, DIALOG_SLOTS_BET, DIALOG_STYLE_INPUT, "Change Bet", ""WHITE_E"Masukkan jumlah taruhan ($250 - $500):", "Confirm", "Cancel");
    }
    if(textid == Slot_TD[4])
    {
    	PlayerLeaveSlots(playerid);
    	Slots_Hide(playerid);
    }
	/*if(textid == minumantd[2]) 
	{
 		for(new i = 0; i < 3; i++) {
			TextDrawHideForPlayer(playerid, minumantd[i]);
		}
		TextDrawHideForPlayer(playerid, susutd);
		//CancelSelectTextDraw(playerid);
	}*/
	/*if(textid == susutd)
	{
		callcmd::susutd(playerid, "");
	}
	//panganan
	if(textid == Panganan[2]) 
	{
 		for(new i = 0; i < 3; i++) {
			TextDrawHideForPlayer(playerid, Panganan[i]);
		}
		TextDrawHideForPlayer(playerid, burgertd);
		TextDrawHideForPlayer(playerid, nasbungtd);
		TextDrawHideForPlayer(playerid, kebabtd);
		//CancelSelectTextDraw(playerid);
	}
	if(textid == burgertd)
	{
		callcmd::burgertd(playerid, "");
	}
	if(textid == nasbungtd)
	{
		callcmd::nasbungtd(playerid, "");
	}
	if(textid == kebabtd)
	{
		callcmd::kebabtd(playerid, "");
	}*/
	//USETD
	/*if(textid == UseTD[1]) 
	{
 		for(new i = 0; i < 23; i++) {
			TextDrawHideForPlayer(playerid, UseTD[i]);
		}
		TextDrawHideForPlayer(playerid, snacktd);
		TextDrawHideForPlayer(playerid, sprunktd);
		TextDrawHideForPlayer(playerid, bandagetd);
		TextDrawHideForPlayer(playerid, medicinetd);
		TextDrawHideForPlayer(playerid, obattd);
		TextDrawHideForPlayer(playerid, marijuanatd);
		TextDrawHideForPlayer(playerid, boomboxtd);
		TextDrawHideForPlayer(playerid, berrytd);
		TextDrawHideForPlayer(playerid, gastd);
 		for(new i = 0; i < 3; i++) {
			TextDrawHideForPlayer(playerid, Panganan[i]);
		}
		TextDrawHideForPlayer(playerid, burgertd);
		TextDrawHideForPlayer(playerid, nasbungtd);
		TextDrawHideForPlayer(playerid, kebabtd);
	 	for(new i = 0; i < 3; i++) {
			TextDrawHideForPlayer(playerid, minumantd[i]);
		}
		TextDrawHideForPlayer(playerid, susutd);
		CancelSelectTextDraw(playerid);
	}
	if(textid == bandagetd)
	{
		callcmd::bandagetd(playerid, "");
	}
	if(textid == snacktd)
	{
		callcmd::panganantd(playerid, "");
	}
	if(textid == sprunktd)
	{
		callcmd::minumantd(playerid, "");
	}
	if(textid == boomboxtd)
	{
		callcmd::boomboxtd(playerid, "");
	}
	if(textid == gastd)
	{
		callcmd::gastd(playerid, "");
	}
	if(textid == marijuanatd)
	{
		callcmd::marijuanatd(playerid, "");
	}
	if(textid == obattd)
	{
		callcmd::obattd(playerid, "");
	}
	if(textid == medicinetd)
	{
		callcmd::medicinetd(playerid, "");
	}
	if(textid == berrytd)
	{
		callcmd::berrytd(playerid, "");
	}*/
	//radialpanel
	/*if(textid == closepanel) 
	{
		for(new i = 0; i < 92; i++) {
			TextDrawHideForPlayer(playerid, Text_Global[i]);
		}
		TextDrawHideForPlayer(playerid, klikhome);
		TextDrawHideForPlayer(playerid, klikhome);
		TextDrawHideForPlayer(playerid, klikgps);
		TextDrawHideForPlayer(playerid, klikcall);
		TextDrawHideForPlayer(playerid, klikkontak);
		TextDrawHideForPlayer(playerid, klikmusik);
		TextDrawHideForPlayer(playerid, klikbank);
		TextDrawHideForPlayer(playerid, kliksms);
		TextDrawHideForPlayer(playerid, kliksetting);
		TextDrawHideForPlayer(playerid, klikjob);
		TextDrawHideForPlayer(playerid, klikgocar);
		TextDrawHideForPlayer(playerid, klikads);
		TextDrawHideForPlayer(playerid, kliktwitter);
		TextDrawHideForPlayer(playerid, klikairdrop);
		TextDrawHideForPlayer(playerid, klikgojek);
		TextDrawHideForPlayer(playerid, jamphonenew);
		//TextDrawHideForPlayer(playerid, klikhome);
		//TextDrawHideForPlayer(playerid, klikhome);
		//TextDrawHideForPlayer(playerid, klikgps);
		//TextDrawHideForPlayer(playerid, klikcall);
		//TextDrawHideForPlayer(playerid, klikkontak);
		//TextDrawHideForPlayer(playerid, klikmusik);
		for(new i = 0; i < 12; i++) {
			TextDrawHideForPlayer(playerid, radialpanel[i]);
		}
		TextDrawHideForPlayer(playerid, closepanel);
		TextDrawHideForPlayer(playerid, klambipanel);
		TextDrawHideForPlayer(playerid, idcardpanel);
		TextDrawHideForPlayer(playerid, invenpanel);
		TextDrawHideForPlayer(playerid, housepanel);
		TextDrawHideForPlayer(playerid, healthpanel);
		TextDrawHideForPlayer(playerid, phonepanel);
		TextDrawHideForPlayer(playerid, maskpanel);
		TextDrawHideForPlayer(playerid, carspanel);
		TextDrawHideForPlayer(playerid, lakipanel);
		TextDrawHideForPlayer(playerid, perempuanpanel);
		CancelSelectTextDraw(playerid);
	}
	if(textid == housepanel)
	{
		callcmd::myhouse(playerid, "");
	}
	if(textid == phonepanel)
	{
		callcmd::phone(playerid, "");
	}
	if(textid == maskpanel)
	{
		callcmd::maskbro(playerid, "");
	}
	if(textid == carspanel)
	{
		callcmd::mypvcuy(playerid, "");
	}
	if(textid == healthpanel)
	{
		callcmd::health(playerid, "");
	}
	if(textid == idcardpanel)
	{
		callcmd::showidcard(playerid, "");
	}
	if(textid == invenpanel)
	{
		callcmd::items(playerid, "");
	}
	if(textid == klambipanel)
	{
		TextDrawShowForPlayer(playerid, radialpanel[10]);
		TextDrawShowForPlayer(playerid, radialpanel[11]);
		TextDrawShowForPlayer(playerid, lakipanel);
		TextDrawShowForPlayer(playerid, perempuanpanel);
	}
	if(textid == lakipanel)
	{
		callcmd::lbaju(playerid, "");
	}
	if(textid == perempuanpanel)
	{
		callcmd::pbaju(playerid, "");
	}*/
	

	// PHONE Avalon NEW
	if(textid == klikcall) 
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		
		ShowPlayerDialog(playerid, DIALOG_PHONE_DIALUMBER, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Dial", "Back");
	}
	if(textid == kliksms) 
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}

		ShowPlayerDialog(playerid, DIALOG_PHONE_SENDSMS, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Dial", "Back");
	}
	if(textid == klikbank) 
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
	if(textid == klikkontak) 
	{
		if (pData[playerid][pPhoneStatus] == 0)
			return Error(playerid, "Your phone must be powered on.");

		if(pData[playerid][pPhoneBook] == 0)
			return Error(playerid, "You dont have a phone book.");

		ShowContacts(playerid);
	}
	if(textid == kliktwitter) 
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
		if(pData[playerid][pTwitter] < 1)
		{	
			return Error(playerid, "Anda belum memiliki Twitter, harap download!");
		}

		new string[100];
		//format(string, sizeof(string), "Tweet\nChangename Twitter({0099ff}%s{ffffff})\nNotification: {ff0000}MAINTENANCE", pData[playerid][pTwittername]);
		format(string, sizeof(string), "Tweet\nChangename Twitter({0099ff}%s{ffffff})\nNotification: %s", pData[playerid][pTwittername], notif);
		ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter", string, "Select", "Close");
	}
	if(textid == klikhome) 
	{
		for(new i = 0; i < 92; i++) {
			TextDrawHideForPlayer(playerid, Text_Global[i]);
		}
		TextDrawHideForPlayer(playerid, klikhome);
		TextDrawHideForPlayer(playerid, klikhome);
		TextDrawHideForPlayer(playerid, klikgps);
		TextDrawHideForPlayer(playerid, klikcall);
		TextDrawHideForPlayer(playerid, klikkontak);
		TextDrawHideForPlayer(playerid, klikmusik);
		TextDrawHideForPlayer(playerid, klikbank);
		TextDrawHideForPlayer(playerid, kliksms);
		TextDrawHideForPlayer(playerid, kliksetting);
		TextDrawHideForPlayer(playerid, klikjob);
		TextDrawHideForPlayer(playerid, klikgocar);
		TextDrawHideForPlayer(playerid, klikads);
		TextDrawHideForPlayer(playerid, kliktwitter);
		TextDrawHideForPlayer(playerid, klikairdrop);
		TextDrawHideForPlayer(playerid, klikgojek);
		TextDrawHideForPlayer(playerid, jamphonenew);
		CancelSelectTextDraw(playerid);
	}
	if(textid == kliksetting)
	{
		ShowPlayerDialog(playerid, DIALOG_TOGGLEPHONE, DIALOG_STYLE_LIST, "Setting", "Phone On\nPhone Off", "Select", "Back");
	}
	//if(textid == cameratd)
	//{
	//	callcmd::selfie(playerid, "");
	//}
	if(textid == klikgps)
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
	}
	if(textid == klikmusik)
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowPlayerDialog(playerid,DIALOG_MUSICHP,DIALOG_STYLE_LIST,"Music","Matikan Musik\nInput Link","Select", "Cancel");
	}
	if(textid == klikjob)
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
	// if(textid == klikgojek)
	// {
	// 	InfoMsg(playerid, "{ff0000}Sabar Mas Bro Masih Pengembangan Aplikasi.");
	// }
	// if(textid == klikgocar)
	// {
	// 	if(pData[playerid][pPhoneStatus] == 0) 
	// 	{
	// 		return Error(playerid, "Handphone anda sedang dimatikan");
	// 	}
	// 	ShowPlayerDialog(playerid,DIALOG_CALLGOCAR,DIALOG_STYLE_INPUT,"Pesan Singkat","Masukkan Pesan Disini","Select", "Cancel");
	// }
	return 1;
}
