forward hook_OnClickRadial(playerid, PlayerText: textid);
public hook_OnClickRadial(playerid, PlayerText: textid)
{
    if (textid == RadialCloseButton[playerid])
    {
        HideRadialMenu(playerid);
    }

    if (textid == RadialButton[playerid][0])
    {
        HideRadialMenu(playerid);
	   	callcmd::phone(playerid, "");
	   	SelectTextDraw(playerid, COLOR_BLUE);
	
    }

    if (textid == RadialButton[playerid][1])
    {
        HideRadialMenu(playerid);
		callcmd::i(playerid, "");
		SelectTextDraw(playerid, COLOR_BLUE);
    }

    if (textid == RadialButton[playerid][2])
    {
        HideRadialMenu(playerid);
        ShowPlayerDialog(playerid, DIALOG_TRYTD, DIALOG_STYLE_LIST, "{FF9999}Fountain Daily Roleplay {FFFFFF}- Identitas", "Lihat KTP\t\t\n{BEBEBE}Tunjukan KTP\t\t\nLihat SIM\t\t\n{BEBEBE}Tunjukan SIM\n", "Pilih", "Batal");
    }

    if (textid == RadialButton[playerid][3])
    {
		HideRadialMenu(playerid);
        ShowPlayerDialog(playerid, CAR_MENU, DIALOG_STYLE_LIST, "Car Menu", "Mesin\nBuka/Kunci Kendaraan\nBuka/Tutup Trunk\nBuka/Tutup Hood\nCek Bagasi[Maintennace]\nLampu\nCek insu\nCek kendaraan\nNeon", "Pilih", "Tidak");	
    }

    if (textid == RadialButton[playerid][4])
    {
		HideRadialMenu(playerid);

		callcmd::toys(playerid, "");
        /* if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Perintah ini hanya dapat digunakan dengan berjalan kaki, keluar dari kendaraan Anda!");
		if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Anda harus login untuk melampirkan objek ke karakter Anda!");
		new string[350];
		if(pToys[playerid][0][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 1\n");
		}
		else strcat(string, ""dot"Slot 1 "RED_E"(Used)\n");

		if(pToys[playerid][1][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 2\n");
		}
		else strcat(string, ""dot"Slot 2 "RED_E"(Used)\n");

		if(pToys[playerid][2][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 3\n");
		}
		else strcat(string, ""dot"Slot 3 "RED_E"(Used)\n");

		if(pToys[playerid][3][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 4\n");
		}
		else strcat(string, ""dot"Slot 4 "RED_E"(Used)\n");

		if(pToys[playerid][4][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 5\n");
		}
		else strcat(string, ""dot"Slot 5 "RED_E"(Used)\n");

		if(pToys[playerid][5][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 6\n");
		}
		else strcat(string, ""dot"Slot 6 "RED_E"(Used)\n");

		strcat(string, ""dot""RED_E"Reset Toys");


		ShowPlayerDialog(playerid, DIALOG_TOY, DIALOG_STYLE_LIST, "{FF9999}Fountain Daily {FFFFFF} - Aksesoris", string, "Select", "Cancel");
   		SetCameraBehindPlayer(playerid); */
    }

    if (textid == RadialButton[playerid][5])
    {
		HideRadialMenu(playerid);
        if(pData[playerid][pFaction] == 1)
        {
			if(!pData[playerid][pOnDuty])
        		return Error(playerid, "Duty Dulu.");
            foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 1) && i != playerid)
			{
				ShowPlayerDialog(playerid, DIALOG_SAPDPANEL, DIALOG_STYLE_LIST, "{4fb6ff}Fountain Daily {ffffff} - SAPD Panel", "Borgol\nBuka Borgol\nMasukkan/Keluarkan paksa ( car )\nGendong\nPeriksa\nAmbil Barang Paksa", "Select", "Cancel");
			}
		}
		if(pData[playerid][pFaction] == 3)
        {
			if(!pData[playerid][pOnDuty])
        		return Error(playerid, "On Duty Dulu.");
            foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 1) && i != playerid)
			{
				ShowPlayerDialog(playerid, DIALOG_EMS1, DIALOG_STYLE_LIST, "{4fb6ff}Fountain Daily {ffffff} - SAMD Panel", "Revive\nGendong\nCheck Health\nInvoice Manual\nTreatment\nHealBone\nLoadInjured\nDropInjured", "Select", "Cancel");
			}
		}
		callcmd::faconline(playerid, "");
    }

	return 1;
}