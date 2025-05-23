CreateJoinTaxiPoint()
{
	// //JOBS
	// new strings[128];
	// CreateDynamicPickup(1239, 23, 332.6749,-1844.2972,4.2963, -1);
	// format(strings, sizeof(strings), "DAPUR PEDAGANG\nUse: /lockerbahan, /menumasak\nAmbil sesuai pesanan pelanggan");
	// CreateDynamic3DTextLabel(strings, COLOR_WHITE, 332.6749,-1844.2972,4.2963, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Taxi
}

CheckPassengers(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) == vehicleid && i != GetVehicleDriver(vehicleid))
			{

				return 1;

			}
		}
	}
	return 0;
}

CMD:lockerbahan(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 332.6749,-1844.2972,4.2963))
	{
		if(pData[playerid][pFaction] == 5)
		{
			ShowPlayerDialog(playerid, DIALOG_TAKEFOOD, DIALOG_STYLE_LIST, "GO FOOD", "Sanck\nSprunk", "Take", "Close");
		}
		else
		{
			Error(playerid, "Anda bukan anggota go car");
		}
	}
	else
	{
		Error(playerid, "Anda tidak berada di checkpoint");
	}
}

CMD:gofare(playerid, params[])
{
	if(pData[playerid][pFaction] != 5)
        return Error(playerid, "Kamu bukan anggota San Andreas Go Car.");

	if(pData[playerid][pOnDuty] <= 0)
		return Error(playerid, "Kamu harus On duty untuk menjalankan pekerjaan");
		
	new vehicleid = GetPlayerVehicleID(playerid);
	//new modelid = GetVehicleModel(vehicleid);
		
	/*if(modelid != 438 && modelid != 420)
		return Error(playerid, "Anda harus mengendarai transportasi go car");*/
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "Anda bukan driver.");
	
	
	if(pData[playerid][pFare] == 0)
	{
		if(CheckPassengers(vehicleid) != 1) return Error(playerid,"Tidak ada penumpang!");
		GetPlayerPos(playerid, Float:pData[playerid][pFareOldX], Float:pData[playerid][pFareOldY], Float:pData[playerid][pFareOldZ]);
		pData[playerid][pFareTimer] = SetTimerEx("FareUpdate", 1000, true, "ii", playerid, GetVehiclePassenger(vehicleid));
		pData[playerid][pFare] = 1;
		pData[playerid][pTotalFare] = 5;
		new formatted[128];
		format(formatted,128,"%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, TDEditor_TD);
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		Info(playerid, "Anda telah mengaktifkan go car fare, silahkan menuju ke tempat tujuan!");
		//passanger
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), TDEditor_TD);
		TextDrawShowForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		TextDrawSetString(DPvehfare[GetVehiclePassenger(vehicleid)], formatted);
		Info(GetVehiclePassenger(vehicleid), "Go Car fare telah aktif!");
	}
	else
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
		KillTimer(pData[playerid][pFareTimer]);
		Info(playerid, "Anda telah menonaktifkan fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
		//passanger
		Info(GetVehiclePassenger(vehicleid), "fare telah di non aktifkan pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), TDEditor_TD);
		TextDrawHideForPlayer(GetVehiclePassenger(vehicleid), DPvehfare[GetVehiclePassenger(vehicleid)]);
		pData[playerid][pFare] = 0;
		pData[playerid][pTotalFare] = 0;
	}
	return 1;
}

function FareUpdate(playerid, passanger)
{	
	new formatted[128];
	GetPlayerPos(playerid,pData[playerid][pFareNewX],pData[playerid][pFareNewY],pData[playerid][pFareNewZ]);
	new Float:totdistance = GetDistanceBetweenPoints(pData[playerid][pFareOldX],pData[playerid][pFareOldY],pData[playerid][pFareOldZ], pData[playerid][pFareNewX],pData[playerid][pFareNewY],pData[playerid][pFareNewZ]);
    if(totdistance > 300.0)
    {
		new argo = RandomEx(4, 10);
	    pData[playerid][pTotalFare] = pData[playerid][pTotalFare]+argo;
		format(formatted,128,"%s", FormatMoney(pData[playerid][pTotalFare]));
		TextDrawShowForPlayer(playerid, DPvehfare[playerid]);
		TextDrawSetString(DPvehfare[playerid], formatted);
		GetPlayerPos(playerid,Float:pData[playerid][pFareOldX],Float:pData[playerid][pFareOldY],Float:pData[playerid][pFareOldZ]);
		//passanger
		TextDrawShowForPlayer(passanger, DPvehfare[passanger]);
		TextDrawSetString(DPvehfare[passanger], formatted);
	}
	return 1;
}


CMD:gocarlist(playerid, params[])
{
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 5)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""GREEN_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Member Go Car", lstr, "Close", "");
	return 1;
}

