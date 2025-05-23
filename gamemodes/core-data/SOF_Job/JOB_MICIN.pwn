/*
	if(Tempat Haram(Job Micin))
	{
		Tempat Job Micin: 1566.0966, 23.2508, 24.1641;
		Tempat Olah Micin: -394.7127, -419.5467, 16.2109;
		Point Farm Micin: 2808.1736,-2230.7356,4.0762;	
	}

	NEW:
	AddPlayerClass(127,280.2542,309.1504,999.1484,335.5019,0,0,0,0,0,0); // micin sell point
	AddPlayerClass(127,-2939.1243,-555.9492,1.9919,264.6878,0,0,0,0,0,0); // micin ngambil point
	AddPlayerClass(127,-2816.1821,-1529.3898,140.8438,177.8234,0,0,0,0,0,0); // micin jaul point
*/

CMD:getjobmicin(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1019.4918,-1970.6510,13.1530)) return SendClientMessage(playerid, -1, "{FF0000}[INFO JOB] > {CECECE}Untuk memulai hari kerja sebagai Petani, Anda harus berada di Sawah");
	{
		if(pData[playerid][pSideJobTime] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", pData[playerid][pSideJobTime]);
		SetPlayerCheckpoint(playerid, 989.2662,-2029.9761,6.7350, 1.0);
		SendClientMessage(playerid,COLOR_YELLOW,"COMMAND : /aboutmicin Untuk Info Lebih Lanjut");
		SendClientMessage(playerid,COLOR_WHITE,"Check Point Micin Sudah Ada Silahkan Cek GPS!");
	}
	return 1;
}
CMD:aboutmicin(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_MICIN, DIALOG_STYLE_LIST, "Micin Help Menu", "Lokasi Pemrosesan Micin\nLokasi Penjualan Micin", "Select", "Close");
    return 1;
}
CMD:endjobmicin(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1019.4918,-1970.6510,13.1530)) return SendClientMessage(playerid, 0xCECECEFF, "Anda harus di Tempat Pemberhentian Kerja Micin!");
	{
		RemovePlayerAttachedObject(playerid,0);
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_YELLOW,"Kamu Telah Berhenti Kerja");
	}	
	return 1;
}
CMD:jualmicin(playerid, params[])
{
	// if(pData[playerid][pCharacterStory] == 0) return Error(playerid, "Anda tidak memiliki Story Character!");
	//if(pData[playerid][pLevel] < 5) return Error(playerid, "Level anda belum mencukupi.");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1681.0054,-1222.3292,15.7242))
		return Error(playerid, "Anda tidak berada di tempat Penjualan Micin");
	{   
		if(pData[playerid][pPaketMicin] < 1) return Error(playerid, "Anda tidak memiliki Paket Micin 3");

		GivePlayerMoneyEx(playerid, 200);
		Server_AddMoney(400);
		pData[playerid][pPaketMicin] -= 3;
		pData[playerid][pSideJobTime] += 60;
		CrateFood += 1;
		SendClientMessage(playerid, COLOR_LBLUE, "INFO: "WHITE_E"Anda telah menjual 3 Paket Micin dan mendapatkan "LG_E"$200");
		//InfoTD_MSG(playerid, 3000, "~r~Micin -1");
		SuccesMsg(playerid, "Anda Berhasil Menjual Paket Micin");
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);		
	}
	return 1;
}
CMD:prosesmicin(playerid, params[])
{
	// if(pData[playerid][pCharacterStory] == 0) return Error(playerid, "Anda tidak memiliki Story Character");
	// if(pData[playerid][pLevel] < 5) return Error(playerid, "level anda belum mencukupi");
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1022.6033,-1957.5007,13.1530))
	{
		if( pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
		if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda tidak dapat melakukannya sekarang");
		if(pData[playerid][pMicin] < 7) return Error(playerid, "Micin kamu tidak cukup untuk di proses menjadi 3 paket (Butuh:7 Micin)");
		if(pData[playerid][pPaketMicin] == 15) return Error(playerid, "Anda sudah membawa 15 Packet Micin!");
		pData[playerid][pActivityTime] += 5;
		pData[playerid][pMicinStatus] = 1;
		pData[playerid][pSideJobTime] += 60;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		//pData[playerid][pProsesMicin] = SetTimerEx("ProsessMicin", 1000, false, "i", playerid);
		//PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengolah Micin...");
		//PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		//ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		pData[playerid][pProsesMicin] = SetTimerEx("ProsessMicin", 1000, true, "id", playerid, 1);
    	PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengolah Micin...");
    	PlayerTextDrawShow(playerid, ActiveTD[playerid]);
    	ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
    }
	else
	{
 		Error(playerid, "Kamu tidak berada di tempat pengolahan Micin");
	}
    return 1;
}
function ProsessMicin(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pMicinStatus] != 1) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, 1022.6033,-1957.5007,13.1530))
			{
				if(pData[playerid][pActivityTime] >= 100)
				{
					SuccesMsg(playerid, "Anda Berhasil Memproses Micin");
					InfoTD_MSG(playerid, 3000, "~g~PaketMicin +3");
					pData[playerid][pMicin] -= 7;
					pData[playerid][pPaketMicin] += 3;
					TogglePlayerControllable(playerid, 1);
					KillTimer(pData[playerid][pProsesMicin]);
					pData[playerid][pActivityTime] = 0;
					pData[playerid][pMicinStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
				}
				else
				{
					KillTimer(pData[playerid][pProsesMicin]);
					pData[playerid][pActivityTime] = 0;
					pData[playerid][pMicinStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					return 1;
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
            if(IsPlayerInRangeOfPoint(playerid, 3.0, 1022.6033,-1957.5007,13.1530))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			}
		}
	}
	return 1;
}
