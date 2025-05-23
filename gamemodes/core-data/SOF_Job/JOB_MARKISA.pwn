// MARKISA SIDEJOBS

CreateJoinMarkisaPoint()
{
    new markisajobs[260];
    CreateDynamicPickup(1239, 23, -407.6156,-1759.3079,8.5762, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengambil Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -407.6156,-1759.3079,8.5762, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, -410.4478,-1761.2164,8.5753, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengambil Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -410.4478,-1761.2164,8.5753, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, -413.7302,-1763.3217,8.3955, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengambil Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -413.7302,-1763.3217,8.3955, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, -416.6203,-1765.2493,8.3672, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengambil Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -416.6203,-1765.2493,8.3672, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	//
	
	CreateDynamicPickup(1239, 23, -408.2620,-1744.6216,7.6970, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengolah Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -408.2620,-1744.6216,7.6970, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, -407.6417,-1746.5704,7.5845, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengolah Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -407.6417,-1746.5704,7.5845, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, -406.1527,-1743.8396,7.9037, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengolah Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -406.1527,-1743.8396,7.9037, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, -405.4801,-1745.7380,7.7987, -1);
	format(markisajobs, sizeof(markisajobs), "{08DBFC}[FRUITS]\n{ffffff}Tekan {ffff00}ALT\n{ffffff}Untuk Mengolah Buah");
	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, -405.4801,-1745.7380,7.7987, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
}
// 	CreateDynamicPickup(1239, 23, 1549.8295,-25.0993,21.3317, -1);
// 	format(markisajobs, sizeof(markisajobs), "{08DBFC}[MENJUAL MARKISA : 4]\n{ffffff}Gunakan Perintah{ffff00}/sellmarkisa\n{ffffff}Untuk Menjual Markisa");
// 	CreateDynamic3DTextLabel(markisajobs, COLOR_LBLUE, 1549.8295,-25.0993,21.3317, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
// }


function ProsesMegambilMarkisa(playerid, type)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pGetMarkisaStatus] != 1) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.0, -407.6156,-1759.3079,8.5762) || IsPlayerInRangeOfPoint(playerid, 1.0, -413.7302,-1763.3217,8.3955)
			|| IsPlayerInRangeOfPoint(playerid, 1.0, -410.4478,-1761.2164,8.5753) || IsPlayerInRangeOfPoint(playerid, 1.0, -416.6203,-1765.2493,8.3672))
			{
				if(pData[playerid][pActivityTime] >= 100)
				{
					SuccesMsg(playerid, "Anda Berhasil Megambil Buah");
					new kg = RandomEx(1, 10);
					pData[playerid][pMarkisa] += kg;
					Info(playerid, "Anda mendapatkan hasil Megambil Buah sebanyak "GREEN_E"%d.", kg);
					//notification.Show(playerid, "Info", "Anda berhasil memetik markisa.", "ld_chat:thumbup");
					TogglePlayerControllable(playerid, 1);
					KillTimer(pData[playerid][pProsesMarkisa]);
					pData[playerid][pActivityTime] = 1;
					pData[playerid][pGetMarkisaStatus] = 0;
					pData[playerid][pEnergy] -= 3;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					ClearAnimations(playerid);
				}
				else
				{
					KillTimer(pData[playerid][pProsesMarkisa]);
					pData[playerid][pActivityTime] = 1;
					pData[playerid][pGetMarkisaStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					return 1;
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
            if(IsPlayerInRangeOfPoint(playerid, 1.0, -407.6156,-1759.3079,8.5762) || IsPlayerInRangeOfPoint(playerid, 1.0, -413.7302,-1763.3217,8.3955)
			|| IsPlayerInRangeOfPoint(playerid, 1.0, -410.4478,-1761.2164,8.5753) || IsPlayerInRangeOfPoint(playerid, 1.0, -416.6203,-1765.2493,8.3672))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 0, 0, 0, 0, 0, 1);
			}
		}
	}
	return 1;
}

function ProsesMarkisa(playerid, type)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pProsesMarkisaStatus] != 1) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.0, -408.2620,-1744.6216,7.6970) || IsPlayerInRangeOfPoint(playerid, 1.0, -406.1527,-1743.8396,7.9037)
		    || IsPlayerInRangeOfPoint(playerid, 1.0, -407.6417,-1746.5704,7.5845) || IsPlayerInRangeOfPoint(playerid, 1.0, -405.4801,-1745.7380,7.7987))
			{
				if(pData[playerid][pActivityTime] >= 100)
				{
					SuccesMsg(playerid, "Anda berhasil Memproses  Buah");
					new kg = RandomEx(1, 3);
					pData[playerid][pMarkisa] -= kg;
					pData[playerid][pMarkisaSeed] += kg;
					Info(playerid, "Anda mendapatkan hasil proses  Buah jumlah "GREEN_E"%d.", kg);
					//notification.Show(playerid, "Info", "Anda berhasil memproses  Buah.", "ld_chat:thumbup");
					TogglePlayerControllable(playerid, 1);
					KillTimer(pData[playerid][pProsesPabrik]);
					pData[playerid][pActivityTime] = 1;
					pData[playerid][pProsesMarkisaStatus] = 0;
					pData[playerid][pEnergy] -= 3;
					pData[playerid][pJobTime] += 120;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					ClearAnimations(playerid);
				}
				else
				{
					KillTimer(pData[playerid][pProsesPabrik]);
					pData[playerid][pActivityTime] = 1;
					pData[playerid][pProsesMarkisaStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					return 1;
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
            if(IsPlayerInRangeOfPoint(playerid, 1.0, -408.2620,-1744.6216,7.6970) || IsPlayerInRangeOfPoint(playerid, 1.0, -406.1527,-1743.8396,7.9037)
		    || IsPlayerInRangeOfPoint(playerid, 1.0, -407.6417,-1746.5704,7.5845) || IsPlayerInRangeOfPoint(playerid, 1.0, -405.4801,-1745.7380,7.7987))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			}
		}
	}
	return 1;
}

CMD:getfruits(playerid, params[])
{
    if(pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
        return Error(playerid, "Anda bukan Petani buah");
	new total = pData[playerid][pMarkisa];
	if(total > 50) return Error(playerid, "buah terlalu penuh di Inventory! Maximal 30.");
	if( pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
	if(pData[playerid][pJobTime] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", pData[playerid][pJobTime]);
    if(IsPlayerInRangeOfPoint(playerid, 1.0, -407.6156,-1759.3079,8.5762) || IsPlayerInRangeOfPoint(playerid, 1.0, -413.7302,-1763.3217,8.3955)
	|| IsPlayerInRangeOfPoint(playerid, 1.0, -410.4478,-1761.2164,8.5753) || IsPlayerInRangeOfPoint(playerid, 1.0, -416.6203,-1765.2493,8.3672))
	{
		if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda tidak dapat melakukannya sekarang");
		if(pData[playerid][pMarkisa] >= 30) return Error(playerid, "Anda sudah membawa 30 buah mohon untuk di proses dahulu!");

    	if(GetPVarInt(playerid, "njikuk") > gettime())
        	return Error(playerid, "Mohon Tunggu bersabar(Don't Spam).");

		//ShowProgressbar(playerid, 10, "Mengambil...");
	    TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 0, 0, 0, 0, 0, 1);
		pData[playerid][pGetMarkisaStatus] = 1;
		pData[playerid][pProsesMarkisa] = SetTimerEx("ProsesMegambilMarkisa", 1000, true, "id", playerid, 3);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengambil...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		SetPVarInt(playerid, "njikuk", gettime() + 10);
	}
	else return Error(playerid, "Anda tidak ditempat Megambil Buah");
	return 1;
}

CMD:prosesfruits(playerid, params[])
{
    if(pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
        return Error(playerid, "Anda bukan Petani buah");
	new total = pData[playerid][pMarkisaSeed];
	if(total > 50) return Error(playerid, "buah terlalu penuh di Inventory! Maximal 30.");
	if( pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
    if(IsPlayerInRangeOfPoint(playerid, 1.0, -408.2620,-1744.6216,7.6970) || IsPlayerInRangeOfPoint(playerid, 1.0, -406.1527,-1743.8396,7.9037)
    || IsPlayerInRangeOfPoint(playerid, 1.0, -407.6417,-1746.5704,7.5845) || IsPlayerInRangeOfPoint(playerid, 1.0, -405.4801,-1745.7380,7.7987))
	{
		if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda tidak dapat melakukannya sekarang");
		if(pData[playerid][pMarkisa] < 1) return Error(playerid, "Anda Tidak Memiliki  Buah!.");
		if(pData[playerid][pMarkisaSeed] >= 30) return Error(playerid, "Anda sudah membawa 30 Buah Olahan!");

    	if(GetPVarInt(playerid, "prosese") > gettime())
        	return Error(playerid, "Mohon Tunggu bersabar(Don't Spam).");

		//ShowProgressbar(playerid, 10, "Mengolah...");
	    TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		pData[playerid][pProsesMarkisaStatus] = 1;
		pData[playerid][pProsesPabrik] = SetTimerEx("ProsesMarkisa", 1000, true, "id", playerid, 3);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengolah...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		SetPVarInt(playerid, "prosese", gettime() + 10);
	}
	else return Error(playerid, "Anda tidak ditempat proses  Buah");
	return 1;
}

CMD:sellfruits(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, -381.44, -1426.13, 25.93))
		return Error(playerid, "Kamu Tidak Berada Di Pedagang Store!");

    if(pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
        return Error(playerid, "Anda bukan Pekerja Buah");

	if(pData[playerid][pMarkisaSeed] < 1) return Error(playerid, "You dont have fruits!");
	{
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan Jumlah Buah\n"WHITE_E"Fruits Price"GREEN_E"$80 / item");
		ShowPlayerDialog(playerid, DIALOG_SELL_MARKISA, DIALOG_STYLE_INPUT, "Fruits", mstr, "Sell", "Cancel");
	}
	return 1;
}
CMD:getjobfruits(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -427.3491,-1754.4265,7.1587)) return SendClientMessage(playerid, -1, "{FF0000}[INFO JOB] > {CECECE}Untuk memulai hari kerja sebagai Petani Buah, Anda harus berada di Ladang");
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
					SuccesMsg(playerid, "Anda Memilih Pekerjaan Sebagai ~p~Fruits Farm");
					pData[playerid][pJob2] = 12; 
				}
			} 
			else 
			{
				SuccesMsg(playerid, "Anda Memilih Pekerjaan Sebagai ~p~Fruits Farm");
				pData[playerid][pJob] = 12;
			}
		}  
	}    
	return 1;
}
CMD:endjobfruits(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -427.3491,-1754.4265,7.1587)) 
    {
        return SendClientMessage(playerid, COLOR_GREY, "Anda harus di Tempat Pemberhentian Kerja Fruits Farm!");
    }
    if (pData[playerid][pJob] == 12 || pData[playerid][pJob2] == 12)
    {
        if (pData[playerid][pJob] == 12) 
        {
            pData[playerid][pJob] = 0;
        }
        if (pData[playerid][pJob2] == 12) 
        {
            pData[playerid][pJob2] = 0;
        }

        SuccesMsg(playerid, "Anda resign menjadi ~p~Fruits Farm");
    }
    else
    {
        Error(playerid, "Anda tidak memiliki pekerjaan sebagai ~p~Fruits Farm.");
    }

    return 1;
}