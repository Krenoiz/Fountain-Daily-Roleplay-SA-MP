CMD:ah(playerid)
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new line3[5000];
	if(pData[playerid][pAdmin] >= 1)
	{
		strcat(line3, "{ffc800}[Trial Volunter]: {ffffff}/a, /asks, /ans, /aheal, /getip, /aka, /akaip, \n");
		strcat(line3, "{ffc800}[Trial Volunter]: {ffffff}/aeject, /pvlist, /ainsu, /apv, /aveh, /near, /checkveh, /apm, /checkmask \n");
		strcat(line3, "{ffc800}[Trial Volunter]: {ffffff}/respawndmv, /respawnjobs, /adminjail, /checkucp, /caps, /kick, /adminjail, /delcs, /setcs \n\n");
	}
	if(pData[playerid][pAdmin] >= 2)
	{
		strcat(line3, "{ffc800}[Helper]: {ffffff}/reports, /ar, /dr, /goto, /slap, /caps, /adelays, /gethere, /goto /setvw, /setint \n");
		strcat(line3, "{ffc800}[Helper]: {ffffff}/sendveh, /getveh , /gotoveh, /respawnveh, /goto(ls,sf,lv,hq,asgh,bank,asgh), /sethp /tlist, /lt, /ft \n");
		strcat(line3, "{ffc800}[Helper]: {ffffff}/ostats, /jetpack, /owarn, /ojail, /jail, /kick, /banchar, /unban, /warn, /respawnrad \n\n");
		
	}
	if(pData[playerid][pAdmin] >= 3)
	{
		strcat(line3, "{ffc800}[Admin Level 1]: {ffffff}/peject, /acuff, /auncuff, /banucp, /clearreports, /clearask, /setbone, /banoff \n");
		strcat(line3, "{ffc800}[Admin Level 1]: {ffffff}/roadblock(destroyroadblock/all), /spike(destroy(all)spike) \n");
		strcat(line3, "{ffc800}[Admin Level 1]: {ffffff}/ann, /cd, /banip, /unbanip, /genetercar, /enterveh \n");
		strcat(line3, "{ffc800}[Admin Level 1]: {ffffff}/settwittername, /aclaimpv, /flipme \n\n");
	}
	if(pData[playerid][pAdmin] >= 4)
	{
		strcat(line3, "{ffc800}[Admin Level 2]: {ffffff}/settime, /setweather, /gotoco, /veh, /destroyveh\n");
		strcat(line3, "{ffc800}[Admin Level 2]: {ffffff}/setname, /setam, /setfaction, /resetweap, /setgender, /setstress,\n\n");
	
	}
	if(pData[playerid][pAdmin] >= 5)
	{
		strcat(line3, "{ffc800}[Admin Level 3]: {ffffff}/dv, /sethbe, /bansos, /atrack, /cleardelays\n");
		strcat(line3, "{ffc800}[Admin Level 3]: {ffffff}/setfs, /fcreate(delete,list,int), /resetstress, /fixtire\n");
		strcat(line3, "{ffc800}[Admin Level 3]: {ffffff}/destroybb, /gotogs, /gotogate, /createhouse(edit), /typehouses \n\n");
	}
	if(pData[playerid][pAdmin] >= 6)
	{
		strcat(line3, "{ffc800}[Admin Level 4]: {ffffff}/giveweap, /setprice /kickall, /setstat, /createactor(edit,delete,goto), /createdoor(edit), /takemoney, \n");
		strcat(line3, "{ffc800}[Admin Level 4]: {ffffff}/p2p /rr /setjob1/2 /kickfaction /kickfam /godlenz, /setgold, /givegold, /gotohouse\n");
		strcat(line3, "{ffc800}[Admin Level 4]: {ffffff}/createrobbery(delete,goto), /creategarkot(edit), /editposisi, /createpv(delete), /createrent(edit)\n");
		strcat(line3, "{ffc800}[Admin Level 4]: {ffffff}/creategarkot(edit), /createberry(edit,remove,goto), /createlocker(edit,goto), /creatempoint(edit,delete)\n");
		strcat(line3, "{ffc800}[Admin Level 4]: {ffffff}/createladang(edit,goto), /createtrash(edit,remove,goto), /createvending(edit,delete,goto)\n\n");
	}
	if(pData[playerid][pAdmin] >= 7)
	{
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/setbankmoney, /givebankmoney, /ahealall, /editnohp, /setadminname,  /setmoney, /setmask /takegold \n");
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/editnorek, /setchp, /vfix /setfix, /setcomponent, /setmaterial, /up, /creategs(edit), /givemoney\n");
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/createpark(remove,goto), /setparkpos, /createmachine(edit,delete), /creategym(edit,delete), /spw \n");
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/createatm(edit,remove,goto), /createbiz (edit), /createworkshop(edit,goto), /createvoucher, /gethereall\n");
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/respawnpacket, /createtree(edit,remove,goto), /creategarage(remove,edit,goto), /createspeedcam(edit,goto) \n");
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/playsong, /playnearsong, /dewa, /biru, /badut, /asignal, /createore(edit,remove,goto), /cariuang, /deluang, /deluangs\n");
		strcat(line3, "{ffc800}[Moderator]: {ffffff}/setstock /setvip, /creategate, /gedit, /anticheat, /gkedit \n\n");
	}
 	
	strcat(line3, "\n"BLUE_E"Fountain Daily:RP "WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: All admin commands log is saved in database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Fountain Daily:RP: "YELLOW_E"Staff Commands", line3, "OK","");
	return true;
}
CMD:gethereall(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
	{
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not authorized to use this command.");
	}
	if(sscanf(params, "s", "confirm"))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Usage: /gethereall [confirm]");
		return 1;
	}

    foreach(new i : Player)
	{
	    if(pData[i][pSpawned])
		{
		    SendPlayerToPlayer(i, playerid);
		}
	}
	SendClientMessage(playerid, COLOR_GREY2, "Teleported all online player to your position.");
    SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has teleported all online player on his/her position.", GetRPName(playerid));
    return 1;
}
CMD:near(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new id = -1;
	id = GetClosestATM(playerid);
	
	if(id > -1)
	{
		{
			SendClientMessageEx(playerid, -1, "{FFFF00}[i]{FFFFFF} ATM yang berada didekatmu adalah id %d", id);
		}
	}
	return 1;
}
CMD:resetstress(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "Anda tidak bisa akses perintah ini!");

    new lstr[1024];
	format(lstr, sizeof(lstr), "Admin | %s: {ffffff}Telah Mereset Stress Kepada Semua Player Online Dikota", pData[playerid][pAdminname]);
	SendClientMessageToAll(COLOR_LIGHTRED, lstr);
	foreach(new pid : Player)
	{
	    pData[pid][pBladder] = 0;
	}
	return 1;
}
// CMD:giveweapon(playerid, params[])
// {
//     new weaponid = GetPlayerWeaponEx(playerid);
//     new ammo = GetPlayerAmmoEx(playerid);
    
    
//     if (!weaponid)
//         return Error(playerid, "You are not holding a weapon.");
        
//     new otherid;
//     if(sscanf(params, "ud", otherid, ammo))
//          return SendClientMessage(playerid, COLOR_WHITE,"/giveweapon [playerid]");

//     if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 5.0))
//         return Error(playerid, "You must in near target player.");
        
//     if(ammo < 1 || ammo > 300)
//             return Error(playerid, "You have specified an invalid weapon ammo, 1 - 300");

//     Info(playerid, "Anda telah memberikan weapon %s kepada %s.", ReturnWeaponName(weaponid) , ReturnName(otherid));
//     Info(otherid, "%s telah memberikan weapon %s kepada anda.", ReturnName(playerid), ReturnWeaponName(weaponid));
//     GivePlayerWeaponEx(otherid, weaponid, ammo);
//     GivePlayerWeaponEx(playerid, weaponid, -ammo);
//     return 1;
// }

CMD:resettrash(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	for(new i = 0; i < MAX_Trash; i++)
	{
		//if(TrashData[i][Sampah] < 1) return Error(playerid, "Tidak ada sampah di sini");
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
		{
			//if(PlayerInfo[playerid][pProgress] == 1) return Error(playerid, "Tunggu Sebentar");
			StartPlayerLoadingBar(playerid, 3, "Ditunggu...");
			//pData[playerid][sampahsaya]++;
			//ShowItemBox(playerid, "Sampah", "ADD_1x", 2840, 2);
			//Inventory_Update(playerid);
			TrashData[i][Sampah] = 0;
			new query[128], str[512];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE trash SET sampah='%d' WHERE ID='%d'", TrashData[i][Sampah], i);
			mysql_tquery(g_SQL, query);
			Trash_Save(i);
			if(IsValidDynamic3DTextLabel(TrashData[i][TrashLabel]))
			DestroyDynamic3DTextLabel(TrashData[i][TrashLabel]);
			format(str, sizeof(str), "[ID : %d]Trash Capacity {FFFF00}%d/100\n{ffffff}Tekan {00FF00}[ Y ] {ffffff}Untuk Membuang Sampah\nGunakan /bin untuk memungut sampah", i, TrashData[i][Sampah]);
			TrashData[i][TrashLabel] = CreateDynamic3DTextLabel(str, ARWIN, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]+1.0, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, TrashData[i][TrashWorld], TrashData[i][TrashInt], -1, 10.0);
		}
	}
	return 1;
}
CMD:setmask(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
        return Error(playerid, "You don't have use permission");

    new targetid, option;
    if(sscanf(params,"ui", targetid, option)) return Usage(playerid, "/setmask [playerid] [number mask]");
    if(!IsPlayerConnected(targetid)) return Error(playerid, "There is player not connect");
    SendStaffMessage(COLOR_LIGHTRED, "%s telah mengubah mask number "BLUE_E"%s "YELLOW_E"menjadi = %d", pData[playerid][pAdminname], ReturnName(targetid), option);
    Servers(targetid, "Admin "BLUE_E"%s "YELLOW_E"telah merubah no mask kamu menjadi = %d",  pData[playerid][pAdminname], option);
    pData[targetid][pMaskID] = option;
    return 1;
}

CMD:netstats(playerid, const params[])
{
    new stats[752];

    GetNetworkStats(stats, sizeof(stats));
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""WHITE_E"Network Stats", stats, "Close", "");

    return 1;
}

CMD:editnohp(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
        return Error(playerid, "You don't have use permission");

    new targetid, option;
    if(sscanf(params,"ui", targetid, option)) return Usage(playerid, "/editnohp [playerid] [number phone]");
    if(!IsPlayerConnected(targetid)) return Error(playerid, "There is player not connect");
    SendStaffMessage(COLOR_LIGHTRED, "%s telah mengubah phone number "BLUE_E"%s "YELLOW_E"menjadi = %d", pData[playerid][pAdminname], ReturnName(targetid), option);
    Servers(targetid, "Admin "BLUE_E"%s "YELLOW_E"telah merubah no hp kamu menjadi = %d", pData[playerid][pAdminname], option);
    pData[targetid][pPhone] = option;
    return 1;
}
CMD:editnorek(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
        return Error(playerid, "You don't have use permission");

    new targetid, option;
    if(sscanf(params,"ui", targetid, option)) return Usage(playerid, "/editnorek [playerid] [ bank rek]");
    if(!IsPlayerConnected(targetid)) return Error(playerid, "There is player not connect");
    SendStaffMessage(COLOR_LIGHTRED, "%s telah mengubah rekening "BLUE_E"%s "YELLOW_E"menjadi = %d", pData[playerid][pAdminname], ReturnName(targetid), option);
    Servers(targetid, "Admin "BLUE_E"%s "YELLOW_E"telah merubah no rekening kamu menjadi = %d", pData[playerid][pAdminname], option);
    pData[targetid][pBankRek] = option;
    return 1;
}

CMD:aheall(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(PlayerData[playerid][pAdmin] < 4)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	foreach (new i : Player) {
		SetPlayerHealthEx(i, pData[i][pMaxHealth]);
		pData[i][pInjured] = 0;
		pData[i][pHospital] = 0;
		pData[i][pSick] = 0;
		HideTdDeath(i);
		UpdateDynamic3DTextLabelText(pData[i][pInjuredLabel], COLOR_ORANGE, "");

		ClearAnimations(i);
		ApplyAnimation(i, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
	}
	SendClientMessageToAllEx(COLOR_LIGHTRED, "[ADMIN]: %s Telah Membangunkan Orang Yang pingsan dikota.", pData[playerid][pAdminname]);
	return 1;
}
CMD:ahealall(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	foreach (new i : Player) {
	    SetPlayerHealth(i, pData[i][pMaxHealth]);
	}
	SendClientMessageToAllEx(COLOR_LIGHTRED, "[ADMIN]: %s Telah Memberikan Kesehatan Semua Player Yang Dikota.", pData[playerid][pAdminname]);
	//SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Playerhax ]", pData[playerid][pName]);
	return 1;
}
CMD:apikontol(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	RandomFire();

	GetDynamicObjectPos(g_aFireObjects[0], fX, fY, fZ);
	SendServerMessage(playerid, "You have created a random fire (%s).", GetLocation(fX, fY, fZ));
	return 1;
}

CMD:akillapi(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	for (new i = 0; i < sizeof(g_aFireObjects); i ++)
	{
	    g_aFireExtinguished[i] = 0;

	    if (IsValidDynamicObject(g_aFireObjects[i]))
	        DestroyDynamicObject(g_aFireObjects[i]);
	}
	SendServerMessage(playerid, "You have killed the fire.");
	return 1;
}
CMD:setchp(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	static
	    id = 0,
		Float:amount;

    if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "df", id, amount))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		{
		    id = GetPlayerVehicleID(playerid);

		    if (sscanf(params, "f", amount))
		        return SendSyntaxMessage(playerid, "/setcarhp [vehicle id] [amount]");

			if (amount < 0.0)
			    return SendErrorMessage(playerid, "The amount can't be below 0.");

			SetVehicleHealth(id, amount);
			SendServerMessage(playerid, "You have set the health of vehicle ID: %d to %.1f.", id, amount);
			return 1;
		}
		else return SendSyntaxMessage(playerid, "/setcarhp [vehicle id] [amount]");
	}
	if (!IsValidVehicle(id))
	    return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

	if (amount < 0.0)
	    return SendErrorMessage(playerid, "The amount can't be below 0.");

	SetVehicleHealth(id, amount);
	SendServerMessage(playerid, "You have set the health of vehicle ID: %d to %.1f.", id, amount);
	return 1;
}
CMD:gotols(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
	if(pData[playerid][pHelper] < 1)
	{
	    return PermissionError(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid),1529.6,-1691.2,13.3);
    else SetPlayerPos(playerid,1529.6,-1691.2,13.3);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotosf(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
	if(pData[playerid][pHelper] < 1)
	{
	    return PermissionError(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), -2015.261108, 154.379516, 27.687500);
    else SetPlayerPos(playerid, -2015.261108, 154.379516, 27.687500);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotolv(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
	if(pData[playerid][pHelper] < 1)
	{
	    return PermissionError(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), 1699.2,1435.1, 10.7);
    else SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotohq(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
	if(pData[playerid][pHelper] < 1)
	{
	    return PermissionError(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), 216.2500, 1822.8402, 6.4141);
    else SetPlayerPos(playerid, 216.2500, 1822.8402, 6.4141);
	SendClientMessage(playerid,COLOR_LIGHTRED,"TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotobank(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
	if(pData[playerid][pHelper] < 1)
	{
		return PermissionError(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), 1457.5571, -1040.2914, 23.8281);
	else SetPlayerPos(playerid, 1457.5571, -1040.2914, 23.8281);
	SendClientMessage(playerid, COLOR_LIGHTRED, "TELEPORT: You have been teleported!");
	return 1;
}
CMD:gotoasgh(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
	if(pData[playerid][pHelper] < 1)
	{
		return PermissionError(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), 1212.5688,-1328.3711,13.5602);
	else SetPlayerPos(playerid, 1212.5688,-1328.3711,13.5602);
	SendClientMessage(playerid, COLOR_LIGHTRED, "TELEPORT: You have been teleported!");
	return 1;
}
CMD:p2p(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    new otherid;

	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "ud", playerid, otherid))
        return Usage(playerid, "/playertoplayer [playerid/PartOfName] ke [playerid]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");

	if(pData[playerid][pSpawned] == 0 || pData[otherid][pSpawned] == 0)
		return Error(playerid, "Player/Target sedang tidak spawn!");

	if(pData[playerid][pJail] > 0 || pData[otherid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");

	if(pData[playerid][pArrest] > 0 || pData[otherid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");

	// if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
	// 	return Error(playerid, "Anda tidak dapat menarik Admin dengan level paling tinggi");

    SendPlayerToPlayer(playerid, otherid);

    // Servers(playerid, "Anda menarik %s.", pData[otherid][pName]);
    Servers(otherid, "Admin {ff0000}%s {ffffff}telah mengirim player %s ke anda.", pData[otherid][pAdminname], pData[playerid][pName]);
    return 1;
}
CMD:giveredmoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givemoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");

	pData[otherid][pRedMoney] += money;

	Servers(playerid, "Kamu telah memberikan redmoney %s(%d) dengan jumlah %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah memberikan redmoney kepada anda dengan jumlah %s!", pData[playerid][pAdminname], FormatMoney(money));

	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEREDMONEY", playerid, otherid, tmp);
	return 1;
}
CMD:genterveh(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

	new vehicleid, Float:pos[3];
	if (sscanf(params,"d",vehicleid))
	    return Usage(playerid,"/genterveh [vehicle id]");

	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	SetVehiclePos(vehicleid,pos[0]+2,pos[1],pos[2]);

	if (GetPlayerVirtualWorld(playerid) != 0)
		SetVehicleVirtualWorld(vehicleid,GetPlayerVirtualWorld(playerid));

	if (GetPlayerInterior(playerid) != 0)
		LinkVehicleToInterior(vehicleid,GetPlayerInterior(playerid));

	PutPlayerInVehicle(playerid,vehicleid,0);
	Info(playerid,"You've get vehicle id %d.",vehicleid);
	return 1;
}
CMD:enterveh(playerid,params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new vehicleid;
	if (sscanf(params,"d",vehicleid))
	    return Usage(playerid,"/enterveh [vehicle id]");

	PutPlayerInVehicle(playerid,vehicleid,0);
	Info(playerid,"You've enter car id %d.",vehicleid);
	return 1;
}
CMD:setfs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
	{
		new String[10000], giveplayerid, fightstyle;
		if(sscanf(params, "ud", giveplayerid, fightstyle))
		{
			Usage(playerid, "</setfightstyle [playerid] [fightstyle]");
			Info(playerid, "INFO: Available fighting styles: 4, 5, 6, 7, 15, 26.");
			return 1;
		}

		if(fightstyle > 3 && fightstyle < 8 || fightstyle == 15 || fightstyle == 26)
		{
			format(String, sizeof(String), " Your fighting style has been changed to %d.", fightstyle);
			SendClientMessageEx(giveplayerid,COLOR_LIGHTRED,String);
			format(String, sizeof(String), " You have changed 's fighting style to %d.", fightstyle);
			SendClientMessageEx(playerid,COLOR_LIGHTRED,String);
			SetPlayerFightingStyle(giveplayerid, fightstyle);
			//pData[playerid][pFightStyle] = fightstyle;
			return 1;
		}
	}

	return 1;
}
// CMD:dsveh(playerid, params[])
// {
// 	// Sags Vehicle
// 	//if(IsPlayerInRangeOfPoint(playerid, 8.0, 1480.0067, -1828.6716, 13.5469) || IsPlayerInRangeOfPoint(playerid, 8.0, 1424.6909, -1789.1492, 33.4297))
// 	{
// 		if(pData[playerid][pAdmin] < 2)
//         	return PermissionError(playerid);
	        
// 		//new vehicleid = GetPlayerVehicleID(playerid);
//         //if(!IsEngineVehicle(vehicleid))
// 			//return Error(playerid, "Kamu tidak berada didalam kendaraan.");

//     	DestroyVehicle(SAGSVeh[playerid]);
// 		DestroyVehicle(SANAVeh[playerid]);
// 		DestroyVehicle(SAMDVeh[playerid]);
// 		DestroyVehicle(SAPDVeh[playerid]);
// 		DestroyVehicle(GOCARVehicles[playerid]);
// 		//pData[playerid][pSpawnSags] = 0;
//     	GameTextForPlayer(playerid, "~w~Vehicles ~r~Despawned", 3500, 3);
//     }
//     return 1;
// }


CMD:dv(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 4) return Error(playerid, "You don't have permission to use this command.");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidVehicle(vehicleid)) return Error(playerid, "Kendaraan Ini Tidak Bisa Di Hapus!");
	{
	    DestroyVehicle(vehicleid);
		vehicleid = INVALID_VEHICLE_ID;
	}
	return 1;
}
CMD:setjob1(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

	new
        jobid,
		otherid;

	if(sscanf(params, "ud", otherid, jobid))
        return Usage(playerid, "/setjob1 [playerid/PartOfName] [jobid]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(jobid < 0 || jobid > 16)
        return Error(playerid, "Invalid ID. 0 - 16.");

	pData[otherid][pJob] = jobid;
	pData[otherid][pExitJob] = 0;

	Servers(playerid, "Anda telah menset job1 player %s(%d) menjadi %s(%d).", pData[otherid][pName], otherid, GetJobName(jobid), jobid);
	Servers(otherid, "Admin %s telah menset job1 anda menjadi %s(%d)", pData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setjob2(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

	new
        jobid,
		otherid;

	if(sscanf(params, "ud", otherid, jobid))
        return Usage(playerid, "/setjob2 [playerid/PartOfName] [jobid]");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");

	if(jobid < 0 || jobid > 16)
        return Error(playerid, "Invalid ID. 0 - 16.");

	pData[otherid][pJob2] = jobid;
	pData[otherid][pExitJob] = 0;

	Servers(playerid, "Anda telah menset job2 player %s(%d) menjadi %s(%d).", pData[otherid][pName], otherid, GetJobName(jobid), jobid);
	Servers(otherid, "Admin %s telah menset job2 anda menjadi %s(%d)", pData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setgender(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 3)
		return PermissionError(playerid);	

	new gender, otherid;
	if(sscanf(params, "udd", otherid, gender))
	{
	    Usage(playerid, "/setgender <ID> <1 = Laki Laki || 0 = Perempuan>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player tidak on!");
	if(gender > 2)
		return Error(playerid, "Level can't be higher than 2!");
	if(gender < 0)
		return Error(playerid, "Level can't be lower than 0!");
	pData[otherid][pGender] = gender;	
	SendClientMessageEx(otherid, COLOR_LIGHTRED, "GENDER: "WHITE_E"Gender anda telah di ubah oleh Adm "YELLOW_E"%s", pData[playerid][pAdminname]);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "GENDER: "WHITE_E"Anda telah mengubah gender pemain "YELLOW_E"%s", pData[otherid][pName]);
	new query[256];
    format(query, sizeof(query), "UPDATE players SET gender=%d WHERE reg_id=%d", gender, otherid);
    mysql_tquery(g_SQL, query);
	return 1;
}


CMD:kickfam(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7) return Error(playerid,"Harus Admin .");
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/kickfam [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");


	pData[otherid][pFamilyRank] = 0;
	pData[otherid][pFamily] = -1;
	Servers(playerid, "Anda telah mengeluarkan %s dari anggota family.", pData[otherid][pName]);
	Servers(otherid, "%s telah mengeluarkan anda dari anggota family.", pData[playerid][pName]);
	return 1;
}
CMD:kickfaction(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");

	if(pData[playerid][pAdmin] < 6)
		return Error(playerid, "You are not admin!");
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/kickfaction [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");


	pData[otherid][pFactionRank] = 0;
	pData[otherid][pFaction] = 0;
	pData[otherid][pFactionLead] = 0;
	Servers(playerid, "Anda telah mengeluarkan %s dari faction.", pData[otherid][pName]);
	Servers(otherid, "%s telah mengkick anda dari faction.", pData[playerid][pName]);
	return 1;
}
CMD:setfix(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
     		return PermissionError(playerid);
	new jumlah;
	if(sscanf(params, "ud", jumlah))
        return Usage(playerid, "/setfix <jumlah>");
    if(IsPlayerInAnyVehicle(playerid)) 
	{
        SetValidVehicleHealth(GetPlayerVehicleID(playerid), jumlah);
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        //Servers(playerid, "CMD KHUSUS KODOK!");
    }
	return 1;
}
CMD:apm(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    static
        otherid,
        text[128];

    if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);

    if(sscanf(params, "us[128]", otherid, text))
        return SendSyntaxMessage(playerid, "/apm [playerid/PartOfName] [message]");

    if(otherid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

	SendStaffMessage(COLOR_LIGHTRED, "%s PM to: %s "RED_E"%s", pData[playerid][pAdminname], pData[otherid][pName], text);
    SendClientMessageEx(otherid, COLOR_LIGHTRED, "PM from Admin: "RED_E"%s", text);
    Servers(COLOR_LIGHTRED, "(!) "YELLOW_E"%s "WHITE_E"PMED to "RED_E"%s"WHITE_E"(%d) for: "YELLOW_E"%s", pData[playerid][pAdminname], pData[otherid][pName], otherid, text);
    return 1;
}
CMD:boost(playerid, params[]) 
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    new Float:speed;
    if (sscanf(params, "f", speed))
        return SendSyntaxMessage(playerid, "/boost [speed]");

    if(speed < 1 || speed > 10000)
            return Error(playerid, "You have specified an invalid weapon ammo, 1 - 10000");

    if (!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You must in any vehicle to use this command!");

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "You must to be driver to use this command!");

    new vehicleid = GetPlayerVehicleID(playerid);
    SetVehicleSpeed(vehicleid, GetVehicleSpeed(vehicleid)+speed);
    return 1;
}

CMD:lt(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    static
        Float:x,
        Float:y,
        Float:z,
        Float:subparam;
        
    if (isnull(params)) {    
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x + 1, y, z);
    } else {
        if (!sscanf(params, "f", subparam)) {
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(playerid, x + subparam, y, z);
            return 1;
        }
    }
    return 1;
}
CMD:ft(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    static
        Float:x,
        Float:y,
        Float:z,
        Float:subparam;
        
    if (isnull(params)) {
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x + 1, y + 1, z);
    } else {
        if (!sscanf(params, "f", subparam)) {
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(playerid, x + subparam, y + subparam, z);
            return 1;
        }
    }
    return 1;
}
CMD:up(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
			return PermissionError(playerid);

	new Float:POS[3], jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/terbang [playerid id/name] <jumlah>");

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + jumlah);
	if(IsPlayerInAnyVehicle(otherid))
	{
		RemovePlayerFromVehicle(otherid);
		//OnPlayerExitVehicle(otherid, GetPlayerVehicleID(otherid));
	}
	//SendStaffMessage(COLOR_LIGHTRED, " player %s telah terbang kelangit ketujuh", pData[otherid][pName]);

	PlayerPlaySound(otherid, 1130, 0.0, 0.0, 0.0);
	return 1;
}
CMD:setcomponent(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setcomponent <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pComponent] = money;
	
	Servers(playerid, "Kamu telah menset component %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin %s telah menset component kepada anda dengan jumlah %d!", pData[playerid][pAdminname], money);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETCOMPONENT", playerid, otherid, tmp);
	return 1;
}

CMD:setmaterial(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setmaterial <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pMaterial] = money;
	
	Servers(playerid, "Kamu telah menset material %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin %s telah menset material kepada anda dengan jumlah %d!", pData[playerid][pAdminname], money);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMATERIAL", playerid, otherid, tmp);
	return 1;
}

CMD:setfam(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	new famid, otherid;
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, famid))
        return Usage(playerid, "/setfam [playerid/PartOfName] [-1 = untuk reset]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");

	if(famid == 0)
	{
		pData[otherid][pFamily] = 0;
		//pData[otherid][fLeader] = 0;
		pData[otherid][pFamilyRank] = 0;
		Servers(playerid, "You have removed %s's from family.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your family stats.", pData[playerid][pName]);
	}
	else
	{
		pData[otherid][pFamily] = famid;
		pData[otherid][pFamilyRank] = 6;
		Servers(playerid, "You have set %s's family ID %d with Member.", pData[otherid][pName], famid);
		Servers(otherid, "%s has set your family ID to %d with Member.", pData[playerid][pName], famid);
	}
    return 1;
}

CMD:setver(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	new verid, otherid;
    if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, verid))
        return Usage(playerid, "/setfam [playerid/PartOfName] [-1 = untuk reset]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");

	if(verid == 0)
	{
		pData[otherid][pVerified] = 0;
		//pData[otherid][fLeader] = 0;
		pData[otherid][pVerifiedRank] = 0;
		Servers(playerid, "You have removed %s's from family.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your family stats.", pData[playerid][pName]);
	}
	else
	{
		pData[otherid][pVerified] = verid;
		pData[otherid][pVerifiedRank] = 6;
		Servers(playerid, "You have set %s's family ID %d with Member.", pData[otherid][pName], verid);
		Servers(otherid, "%s has set your family ID to %d with Member.", pData[playerid][pName], verid);
	}
    return 1;
}
CMD:playerhax(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Playerhax ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:jetpackhax(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Jetpack ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}

CMD:enableejrun(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Enableejrun ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather1(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather2(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather3(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather4(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather5(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather6(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}


CMD:weather7(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather8(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:weather9(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Weather ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:speedheck(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Speed Heck ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:rem(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ REM ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:afire(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Random Fire ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:fspawn(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Fek Spawn ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}
CMD:dgun(playerid, params[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AntiCmd: {778899}%s terkick karena menggunakan command ilegal [ Spawn Senjata ]", pData[playerid][pName]);
 	Kick(playerid);
	return 1;
}

CMD:givecoin(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	static
	    userid,
	    amount;

	if (pData[playerid][pAdmin] < 201)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ud", userid, amount))
		return SendSyntaxMessage(playerid, "/givecoin [playerid/name] [amount]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	pData[userid][pCoin] += amount;

	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has given %d Fountain Daily COIN to %s.", pData[playerid][pAdminname], amount, GetName(userid));
	return 1;
}
CMD:arelease(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return Error(playerid, "You don't have permission to use this command..");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/arelease <ID/Name> Menyalahgunakan akan mendapatkan sanksi berat");
	    return true;
	}

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

	if(pData[otherid][pArrest] == 0)
	    return Error(playerid, "The player isn't in arrest!");

	pData[otherid][pArrest] = 0;
	pData[otherid][pArrestTime] = 0;
	pData[otherid][pHunger] = 100;
	pData[otherid][pEnergy] = 100;
	pData[otherid][pBladder] = 100;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPositionEx(otherid, 1541.0924,-1675.4509,13.5519,90.7043, 2000);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	new str[150];
	format(str,sizeof(str),"Admin: %s mengeluarkan %s dari penjara!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	return true;
}


CMD:makequiz(playerid, params[])
{
    if (pData[playerid][pAlogin] == 0)
        return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if (pData[playerid][pAdmin] < 7)
        return Error(playerid, "Kamu harus menjadi Moderator.");
    {
        new tmp[128], string[256], str[256], prg, pr;
        if (sscanf(params, "s", tmp)) {
            Usage(playerid, "/makequiz [option]");
            Usage(playerid, "question, answer, price, pricegold, end");
            Info(playerid, "Tolong buat jawabannya dulu.");
            return 1;
        }

        if (!strcmp(tmp, "question", true, 8))
        {
            if (sscanf(params, "s[128]s[256]", tmp, str)) 
                return Usage(playerid, "/makequiz question [question]");
            if (quiz == 1) 
                return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
            if (answermade == 0) 
                return Error(playerid, "Tolong buat jawaban dulu...");
            if (qprs == 0) 
                return Error(playerid, "Tolong tambahkan hadiah terlebih dahulu.");

            format(string, sizeof(string), "{7fffd4}[QUIZ]: {ffff00}%s?, Hadiah {00FF00}%d$, {FFFFFF}dan {00FF00}%dgold.", str, qprs, goldgua);
            SendClientMessageToAll(0xFFFF00FF, string);
            SendClientMessageToAll(-1, "{ffff00}Anda bisa memberi jawaban dengan menggunakan /answer.");
            quiz = 1;
        }
        else if (!strcmp(tmp, "answer", true, 6))
        {
            if (sscanf(params, "s[128]s[256]", tmp, str)) 
                return Usage(playerid, "/makequiz answer [answer]");
            if (quiz == 1) 
                return Info(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
            answers = str;
            answermade = 1;
            format(string, sizeof(string), "Anda telah membuat jawaban, {00FF00}%s.", str);
            SendClientMessage(playerid, 0xFFFFFFFF, string);
        }
        else if (!strcmp(tmp, "price", true, 5))
        {
            if (sscanf(params, "s[128]d", tmp, pr)) 
                return Usage(playerid, "/makequiz price [amount]");
            if (quiz == 1) 
                return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
            if (answermade == 0) 
                return Error(playerid, "Membuat jawabannya lebih dulu...");
            if (pr <= 0) 
                return Error(playerid, "Buat harga lebih besar dari 0!");
            qprs = pr;
            format(string, sizeof(string), "Anda telah menempatkan {00FF00}%d sebagai jumlah hadiah untuk kuis.", pr);
            SendClientMessage(playerid, 0xFFFFFFFF, string);
        }
        else if (!strcmp(tmp, "pricegold", true, 7))
        {
            if (sscanf(params, "s[128]d", tmp, prg)) 
                return Usage(playerid, "/makequiz pricegold [amount]");
            if (quiz == 1) 
                return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
            if (answermade == 0) 
                return Error(playerid, "Membuat jawabannya lebih dulu...");
            if (prg <= 0) 
                return Error(playerid, "Buat harga lebih besar dari 0!");

            goldgua = prg;
            printf("Debug: goldgua = %d", goldgua); // Debug untuk memeriksa nilai
            format(string, sizeof(string), "Anda telah menempatkan {00FF00}%d sebagai jumlah hadiah untuk kuis.", prg);
            SendClientMessage(playerid, 0xFFFFFFFF, string);
        }
        else if (!strcmp(tmp, "end", true, 3))
        {
            if (quiz == 0) 
                return Error(playerid, "Sayangnya tidak ada kuis dari admin server.");
            printf("Debug sebelum reset: goldgua = %d", goldgua); // Debug sebelum reset
            SendClientMessageToAll(0xFF0000FF, "Sayangnya Admin server telah mengakhiri kuis tersebut.");
            answermade = 0;
            quiz = 0;
            qprs = 0;
            goldgua = 0;
            answers = "";
            printf("Debug setelah reset: goldgua = %d", goldgua); // Debug setelah reset
        }
    }
    return 1;
}

CMD:answer(playerid, params[])
{
    new tmp[256], string[256];
    if (quiz == 0) 
        return Error(playerid, "Sayangnya tidak ada kuis dari admin server.");
    if (sscanf(params, "s[256]", tmp)) 
        return Usage(playerid, "/answer [jawaban]");

    if (strcmp(tmp, answers, true) == 0)
    {
        GivePlayerMoneyEx(playerid, qprs);
        pData[playerid][pGold] += goldgua;
        printf("Debug: pGold untuk player %d = %d", playerid, pData[playerid][pGold]); // Debug setelah hadiah
        format(string, sizeof(string), "[QUIZ]: %s telah memberikan jawaban yang benar '%s' dari kuis dan mendapatkan hadiah {00FF00}%d$, {FFFFFF}dan {00FF00}%dgold.", ReturnName(playerid), answers, qprs, goldgua);
        SendClientMessageToAll(0xFFFF00FF, string);
        answermade = 0;
        quiz = 0;
        qprs = 0;
        goldgua = 0;
        answers = "";
    }
    else
    {
        Error(playerid, "Jawaban yang salah, coba keberuntungan Anda lain kali.");
    }
    return 1;
}

/*CMD:makequiz(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return Error(playerid, "Kamu harus menjadi Moderator.");
	{
		new tmp[128], string[256], str[256], prg, pr;
		if(sscanf(params, "s", tmp)) {
			Usage(playerid, "/makequiz [option]");
			Usage(playerid, "question, answer, price, pricegold, end");
			Info(playerid, "Tolong buat jawabannya dulu.");
			return 1;
		}
		if(!strcmp(tmp, "question", true, 8))
		{
			if(sscanf(params, "s[128]s[256]", tmp, str)) return Usage(playerid, "/makequiz question [question]");
			if (quiz == 1) return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
			if (answermade == 0) return Error(playerid, "tolong buat jawaban dulu...");
			if (goldgua == 0) return Error(playerid, "Tolong tambahkan gold terlebih dahulu.");
			if (qprs == 0) return Error(playerid, "Tolong tambahkan hadiah terlebih dahulu.");
			format(string, sizeof(string), "{7fffd4}[QUIZ]: {ffff00}%s?, Hadiah {00FF00}%d$, {FFFFFF}dan {00FF00}%dgold.", str, qprs, goldgua);
			SendClientMessageToAll(0xFFFF00FF, string);
			SendClientMessageToAll(-1,"{ffff00}Anda bisa memberi jawaban dengan menggunakan /answer.");
			quiz = 1;
		}
		else if(!strcmp(tmp, "answer", true, 6))
		{
			if(sscanf(params, "s[128]s[256]", tmp, str)) return Usage(playerid, "/makequiz answer [answer]");
			if (quiz == 1) return Info(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
			answers = str;
			answermade = 1;
			format(string, sizeof(string), "Anda telah membuat jawaban, {00FF00}%s.", str);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "price", true, 5))
		{
			if(sscanf(params, "s[128]d", tmp, pr)) return Usage(playerid, "/makequiz price [amount]");
			if (quiz == 1) return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan / makequiz end.");
			if (answermade == 0) return Error(playerid, " Membuat jawabannya lebih dulu...");
			if (pr <= 0) return Error(playerid, "buat harga lebih besar dari 0!");
			qprs = pr;
			format(string, sizeof(string), "Anda telah menempatkan {00FF00}%d sebagai jumlah hadiah untuk kuis.", pr);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "pricegold", true, 7))
		{
			if(sscanf(params, "s[128]d", tmp, prg)) return Usage(playerid, "/makequiz pricegold [amount]");
			if (quiz == 1) return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan / makequiz end.");
			if (answermade == 0) return Error(playerid, " Membuat jawabannya lebih dulu...");
			if (prg <= 0) return Error(playerid, "buat harga lebih besar dari 0!");
			goldgua = prg;
			format(string, sizeof(string), "Anda telah menempatkan {00FF00}%d sebagai jumlah hadiah untuk kuis.", prg);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "end", true, 3))
		{
			if (quiz == 0) return Error(playerid, "Sayangnya tidak ada kuis dari admin server.");
			SendClientMessageToAll(0xFF0000FF, "Sayangnya Admin server telah mengakhiri kuis tersebut.");
			answermade = 0;
			quiz = 0;
			qprs = 0;
			goldgua = 0;
			answers = "";
		}
	}
	return 1;
}

CMD:answer(playerid, params[])
{
	new tmp[256], string[256];
	if (quiz == 0) return Error(playerid, "Sayangnya tidak ada kuis dari admin server.");
	if (sscanf(params, "s[256]", tmp)) return Usage(playerid, "/answer [jawaban]");
	if(strcmp(tmp, answers, true)==0)
	{
		GivePlayerMoneyEx(playerid, qprs);
		pData[playerid][pGold] += goldgua;
		format(string, sizeof(string), "[QUIZ]: %s telah memberikan jawaban yang benar '%s' dari kuis dan mendapatkan hadiah {00FF00}%d$, {FFFFFF}dan {00FF00}%dgold.", ReturnName(playerid), answers, qprs, goldgua);
		SendClientMessageToAll(0xFFFF00FF, string);
		answermade = 0;
		quiz = 0;
		qprs = 0;
		goldgua = 0;
		answers = "";
	}
	else
	{
		Error(playerid,"Jawaban yang salah coba keberuntungan Anda lain kali.");
	}
	return 1;
}*/

CMD:hcmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Junior Helper Commands:"LB2_E"\n\
 	/aduty /h /asay /o /goto /sendto /gethere /freeze /unfreeze\n\
	/kick /slap /caps /acuff /auncuff /reports /ar /dr");

	strcat(line3, "\n\n"WHITE_E"Senior Helper Commands:"LB2_E"\n\
 	/spec /peject /astats /ostats /jetpack\n\
    /jail /unjail");

	strcat(line3, "\n\n"WHITE_E"Head Helper Commands:"LB2_E"\n\
	/respawnsapd /respawnsags /respawnsamd /respawnsana /respawnjobs\n");
 	
	strcat(line3, "\n"BLUE_E"Fountain Daily:RP "WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: All admin commands log is saved in database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Fountain Daily:RP: "YELLOW_E"Staff Commands", line3, "OK","");
	return true;
}
CMD:staff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return Error(playerid, "Anda bukan staff");
    new count = 0, line3[512];
    line3[0] = '\0'; 

    foreach(new i:Player)
    {
        if(pData[i][pAdmin] > 0)
        {
            format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s (ID: %i)", line3, GetStaffRank(i), pData[i][pAdminname], i);
            count++;
        }
    }

    if(count > 0)
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", "There are no admin online!", "Close", "");
    }
    
    return 1;
}


CMD:admins(playerid, params[])
{
    new count = 0, line3[512];
    line3[0] = '\0'; 

    foreach(new i:Player)
    {
        if(pData[i][pAtemin] > 0 || pData[i][pAdmin] == 1)
        {
            format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s (ID: %i)", line3, GetStaffRank(i), pData[i][pAdminname], i);
            count++;
        }
    }

    if(count > 0)
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", "There are no admin online!", "Close", "");
    }
    
    return 1;
}


CMD:adminjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new count = 0, line3[512];
	foreach(new i:Player)
	{
		if(pData[i][pJail] > 0)
		{
			format(line3, sizeof(line3), "%s\n"WHITE_E"%s(ID: %d) [Jail Time: %d seconds]", line3, pData[i][pName], i, pData[i][pJailTime]);
			count++;
		}
	}
	if(count > 0)
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", line3, "Close", "");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", "There are no player in jail!", "Close", "");
	}
	return 1;
}

CMD:aod(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");

    if(pData[playerid][pAdmin] < 2)
            return Error(playerid, "Anda bukan staff");
            
    if(!strcmp(pData[playerid][pAdminname], "None"))
        return Error(playerid, "Kamu harus membuat Nama Admin mu terlebih dahulu!");
    
    new Float:health, Float:armour;
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);

    if(!pData[playerid][pAdminDuty])
    {
        pData[playerid][pHealth] = health;
        pData[playerid][pArmour] = armour;

        if(pData[playerid][pAdmin] > 0)
        {
            SetPlayerColorEx(playerid, 0xFF000000);
            pData[playerid][pAdminDuty] = 1;
            SetPlayerName(playerid, pData[playerid][pAdminname]);
            SendStaffMessage(COLOR_LIGHTRED, "%s telah on duty admin dengan nama %s.", pData[playerid][pName], pData[playerid][pAdminname]);
            SetPlayerHealthEx(playerid, pData[playerid][pMaxHealth]);
            SetPlayerArmourEx(playerid, 100);
        }
        else
        {
            SetPlayerColorEx(playerid, COLOR_GREEN);
            pData[playerid][pAdminDuty] = 1;
            SetPlayerName(playerid, pData[playerid][pAdminname]);
            SendStaffMessage(COLOR_LIGHTRED, "{7fffd4}%s telah on helper duty dengan nama %s.", pData[playerid][pName], pData[playerid][pAdminname]);
            SetPlayerHealthEx(playerid, pData[playerid][pMaxHealth]);
            SetPlayerArmourEx(playerid, 0);
        }
    }
    else
    {
        if(pData[playerid][pFaction] != -1 && pData[playerid][pOnDuty]) 
            SetFactionColor(playerid);
        else 
            SetPlayerColorEx(playerid, COLOR_WHITE);
                
        SetPlayerName(playerid, pData[playerid][pName]);
        pData[playerid][pAdminDuty] = 0;
        SendStaffMessage(COLOR_LIGHTRED, "%s telah off admin duty.", pData[playerid][pAdminname]);
        if(IsValidDynamic3DTextLabel(pData[playerid][AdminTag]))
            DestroyDynamic3DTextLabel(pData[playerid][AdminTag]);

        SetPlayerHealth(playerid, pData[playerid][pHealth]);
        SetPlayerArmour(playerid, pData[playerid][pArmour]);
    }    
    return 1;
}

CMD:asay(playerid, params[]) 
{
    new text[225];

    if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

    if(sscanf(params,"s[225]",text))
        return Usage(playerid, "/asay [text]");
        
    SendClientMessageToAllEx(COLOR_LIGHTRED,"%s %s says: %s", GetStaffRank(playerid), pData[playerid][pAdminname], ColouredText(text));
    return 1;
}

CMD:h(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/h <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "{1e90ff}[Helper Chat] (%s{1e90ff}) "WHITEP_E"%s(%i): {ffffff}%s", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return 1;
}

CMD:a(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/a <text>");
	    return true;
	}

	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		line = " ";
		strcat(line, params[i]);

		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "{007FFF}%s {00FF00}%s(%i): {ffffff}%s", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(pData[ii][pAlogin] == 1)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAlogin] == 1)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return true;
}

CMD:togooc(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

    if(TogOOC == 0)
    {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s has disabled global OOC chat.", pData[playerid][pAdminname]);
        TogOOC = 1;
    }
    else
    {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s has enabled global OOC chat (DON'T SPAM).", pData[playerid][pAdminname]);
        TogOOC = 0;
    }
    return 1;
}
CMD:o(playerid, params[])
{
    if(TogOOC == 1 && pData[playerid][pAdmin] < 1 && pData[playerid][pHelper] < 1) 
            return Error(playerid, "An administrator has disabled global OOC chat.");

	if(pData[playerid][pTogO])
	    return SendErrorMessage(playerid, "You must enabled your OOC Chats.");

    new togoocc = (pData[playerid][pTogO] != 0);

    if(isnull(params))
        return Usage(playerid, "/o [global OOC]");

    new VipColor[30];
	if(pData[playerid][pVip] == 1)
	{
		VipColor = "{33ee33}";
	}
	else if(pData[playerid][pVip] == 2)
	{
		VipColor = "{ffff00}";
	}
	else if(pData[playerid][pVip] == 3)
	{
		VipColor = "{ff00ff}";
	}
	else if(pData[playerid][pVip] == 4)
	{
		VipColor = "{020203}";
	}
	else
	{
		VipColor = "{00ffff}";
	}
    if(strlen(params) < 90)
    {
        foreach (new i : Player) if(pData[i][IsLoggedIn] == true && pData[i][pSpawned] == 1, pData[i][pTogO] != 1 || togoocc)
        {
			if (pData[playerid][pAdminDuty] == 1) 
			{
				new staffRank[32];
				format(staffRank, sizeof(staffRank), "%s", GetStaffRank(playerid));

				// Kirim pesan ke client dengan pangkat staf
				SendClientMessageEx(i, COLOR_WHITE, "(( %s %s{FFFFFF}: %s {FFFFFF}))", staffRank, pData[playerid][pAdminname], ColouredText(params));
			}
            else
            {
                SendClientMessageEx(i, COLOR_WHITE, "(( %s %s %s{FFFFFF} (%d): %s ))", VipColor, pData[playerid][pCustomRank], pData[playerid][pName], playerid, params);
            }
        }
    }
    else
        return Error(playerid, "The text to long, maximum character is 90");

    return 1;
}



CMD:goto(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/goto [playerid/PartOfName]");

	// if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
	// 	return Error(playerid, "Anda tidak dapat goto ke Admin dengan level paling tinggi");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SendPlayerToPlayer(playerid, otherid);
	Servers(otherid, "%s has been teleported to you.", pData[playerid][pName]);
	Servers(playerid, "You has teleport to %s position.", pData[otherid][pName]);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s teleport ke player %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:sendto(playerid, params[])
{
    static
        type[24],
		otherid;

    if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "us[32]", otherid, type))
    {
        Usage(playerid, "/send [player] [name]");
        Info(playerid, "[NAMES]:{FFFFFF} ls, lv, sf, ooczone");
        return 1;
    }
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!strcmp(type,"ls")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1482.0356,-1724.5726,13.5469);
        }
        else 
		{
            SetPlayerPosition(otherid,1482.0356,-1724.5726,13.5469,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    else if(!strcmp(type,"sf")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),-1425.8307,-292.4445,14.1484);
        }
        else 
		{
            SetPlayerPosition(otherid,-1425.8307,-292.4445,14.1484,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    else if(!strcmp(type,"lv")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1686.0118,1448.9471,10.7695);
        }
        else 
		{
            SetPlayerPosition(otherid,1686.0118,1448.9471,10.7695,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
    else if(!strcmp(type,"ooczone")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		        return Error(playerid, "Pemain tersebut sedang menggunakan kendaraan");

		SetPlayerPosition(otherid,2183.71, -1017.67, 1020.63,750);
		SetPlayerFacingAngle(otherid,179.4088);
		SetPlayerInterior(otherid, 1);
		SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
	    Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = 1;
	    pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
		pData[otherid][pInFamily] = -1;
    }
   	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah mengirim player ke tempat spawn %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
    return 1;
}

CMD:gethere(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    new otherid;

	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/gethere [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");
	
	if(pData[playerid][pSpawned] == 0 || pData[otherid][pSpawned] == 0)
		return Error(playerid, "Player/Target sedang tidak spawn!");
		
	if(pData[playerid][pJail] > 0 || pData[otherid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");
		
	if(pData[playerid][pArrest] > 0 || pData[otherid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");

	if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
		return Error(playerid, "Anda tidak dapat menarik Admin dengan level paling tinggi");

    SendPlayerToPlayer(otherid, playerid);

    Servers(playerid, "Anda menarik %s.", pData[otherid][pName]);
    Servers(otherid, "%s telah menarik mu.", pData[playerid][pName]);
   	new dc[128];
	format(dc, sizeof(dc),  "%s Menarik %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
    return 1;
}

CMD:freeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/freeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[playerid][pFreeze] = 1;

    TogglePlayerControllable(otherid, 0);
    Servers(playerid, "You have frozen %s's movements.", ReturnName(otherid));
	Servers(otherid, "You have been frozen movements by admin %s.", pData[playerid][pAdminname]);
    return 1;
}
CMD:unstuck(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);

    static otherid;
    if(sscanf(params, "u", otherid)) return Usage(playerid, "/unstuck [playerid/PartOfName]");
    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
		
    if((gettime() - PlayerData[otherid][pStuck]) > 60) return SendErrorMessage(playerid, "This player is'nt request anything.");
    PlayerData[otherid][pStuck] = (gettime()-60);

    switch (GetPVarInt(otherid, "stuckHelp")) {
        case 1: {
            SetPlayerVirtualWorld(otherid, 0);
        }
        case 2: {
            SetPlayerInterior(otherid, 0);
        }
        case 3: {
            SetPlayerPos(otherid, 1482.0356,-1724.5726,13.5469);
            SetPlayerVirtualWorld(otherid, 0);
            SetPlayerInterior(otherid, 0);
        }
        case 4: {
            SetPlayerPos(otherid, 1482.0356,-1724.5726,13.5469);
            SetPlayerVirtualWorld(otherid, 0);
            SetPlayerInterior(otherid, 0);
        }
        case 5: {
            SetPVarInt(otherid, "GiveUptime", 0);
            SetPlayerHealthEx(otherid, pData[otherid][pMaxHealth]);
			pData[otherid][pInjured] = 0;
			pData[otherid][pHospital] = 0;
			pData[otherid][pSick] = 0;
			HideTdDeath(otherid);
			UpdateDynamic3DTextLabelText(pData[otherid][pInjuredLabel], COLOR_ORANGE, "");

			ClearAnimations(otherid);
			ApplyAnimation(otherid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
            SetPlayerArmedWeapon(otherid, 0);
        }
        case 6: 
		{
            TogglePlayerControllable(otherid, 1);
        }
        case 7..8: 
		{
			if (pData[otherid][pInDoor] == -1)
			{
				Error(playerid, "Last door tidak ditemukan, gunakan '/goto' untuk bantu secara langsung");
			}
			else
			{
				new did = pData[otherid][pInDoor];
				SetPlayerPositionEx(otherid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				pData[otherid][pInDoor] = -1;
			}
        }
		case 9:
		{
			new vid = GetPVarInt(otherid, "ClickedVeh");
			SetPVarInt(otherid, "VehicleKilled", 1);

			SetVehicleToRespawn(pvData[vid][cVeh]);
		}
    }
	pData[playerid][pointU]++;
    Servers(otherid, "STUCK: Staff {ff0000}%s {ffffff}accept your request.", pData[playerid][pAdminname]);
    SendStaffMessage(COLOR_LIGHTRED, "STUCK: %s accept %s request.", pData[playerid][pAdminname], pData[otherid][pName]);
    return 1;
}
CMD:unfreeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unfreeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[playerid][pFreeze] = 0;

    TogglePlayerControllable(otherid, 1);
    Servers(playerid, "You have unfrozen %s's movements.", ReturnName(otherid));
	Servers(otherid, "You have been unfrozen movements by admin %s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:aheal(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aheal [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(!pData[otherid][pInjured])
        return Error(playerid, "Tidak bisa revive karena tidak injured.");

	pData[otherid][pHead] = 100;
	pData[otherid][pPerut] = 100;
	pData[otherid][pLFoot] = 100;
	pData[otherid][pRFoot] = 100;
	pData[otherid][pLHand] = 100;
	pData[otherid][pRHand] = 100;

    SetPlayerHealthEx(otherid, pData[otherid][pMaxHealth]);
    pData[otherid][pInjured] = 0;
	pData[otherid][pHospital] = 0;
	pData[otherid][pSick] = 0;
	HideTdDeath(otherid);
	UpdateDynamic3DTextLabelText(pData[otherid][pInjuredLabel], COLOR_ORANGE, "");

    ClearAnimations(otherid);
	ApplyAnimation(otherid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);

    SendStaffMessage(COLOR_LIGHTRED, "Staff %s have revived player %s.", pData[playerid][pAdminname], ReturnName(otherid));
    Info(otherid, "Staff %s has revived your character.", pData[playerid][pAdminname]);
    return 1;
}

CMD:spec(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
    if(!isnull(params) && !strcmp(params, "off", true))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            return Error(playerid, "You are not spectating any player.");

		pData[pData[playerid][pSpec]][playerSpectated]--;
        PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
        PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

        SetSpawnInfo(playerid, 0, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
		TogglePlayerSpectating(playerid, false);
		SetPlayerColorEx(playerid, 0xFF000000);
		pData[playerid][pSpec] = -1;
		Servers(playerid, "You are no longer in spectator mode.");
        return 0;
    }
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/spectate [playerid/PartOfName] - Type '/spec off' to stop spectating.");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(otherid == playerid)
		return Error(playerid, "You can't spectate yourself bro..");

	if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
		return Error(playerid, "Anda tidak dapat spec Admin dengan level paling tinggi");

	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}

    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
        GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);

        pData[playerid][pInt] = GetPlayerInterior(playerid);
        pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }
    SetPlayerInterior(playerid, GetPlayerInterior(otherid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(otherid));
    TogglePlayerSpectating(playerid, 1);

    if(IsPlayerInAnyVehicle(otherid))
	{
		new vID = GetPlayerVehicleID(otherid);
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(otherid));
		if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
	    {
	    	Servers(playerid, "You are now spectating %s(%i) who is driving a %s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
		}
		else
		{
		    Servers(playerid, "You are now spectating %s(%i) who is a passenger in %s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
		}
	}
    else
	{
        PlayerSpectatePlayer(playerid, otherid);
	}
	pData[otherid][playerSpectated]++;
    SendModMessage(COLOR_LIGHTRED, "%s now spectating %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
    Servers(playerid, "You are now spectating %s (ID: %d).", pData[otherid][pName], otherid);
	SetPlayerColorEx(playerid, 0xFF000000);
    pData[playerid][pSpec] = otherid;
   	new dc[128];
	format(dc, sizeof(dc),  "%s now spectating %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
    return 1;
}

CMD:slap(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new Float:POS[3], otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/slap <ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 201)
		return Error(playerid, "Anda tidak dapat slapped Admin dengan level paling tinggi");

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 9.0);
	if(IsPlayerInAnyVehicle(otherid)) 
	{
		RemovePlayerFromVehicle(otherid);
		//OnPlayerExitVehicle(otherid, GetPlayerVehicleID(otherid));
	}
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah men-slap player %s", pData[playerid][pAdminname], pData[otherid][pName]);

	PlayerPlaySound(otherid, 1130, 0.0, 0.0, 0.0);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men slap player %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:caps(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
 	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/caps <ID>");
	    Info(playerid, "Function: Will disable caps for the player, type again to enable caps.");
	    return 1;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!GetPVarType(otherid, "Caps"))
	{
	    // Disable Caps
	    SetPVarInt(otherid, "Caps", 1);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah menon-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	else
	{
	    // Enable Caps
		DeletePVar(otherid, "Caps");
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah meng-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	return 1;
}

CMD:peject(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/peject <ID>");
	    return 1;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!IsPlayerInAnyVehicle(otherid))
	{
		Error(playerid, "Player tersebut tidak berada dalam kendaraan!");
		return 1;
	}

	new vv = GetVehicleModel(GetPlayerVehicleID(otherid));
	Servers(playerid, "You have successfully ejected %s(%i) from their %s.", pData[otherid][pName], otherid, GetVehicleModelName(vv - 400));
	Servers(otherid, "%s(%i) has ejected you from your %s.", pData[playerid][pName], playerid, GetVehicleModelName(vv));
	RemovePlayerFromVehicle(otherid);
	return 1;
}

CMD:ainv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/ainv [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");
		
	DisplayItems(playerid, otherid);
	return 1;
}

CMD:astats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/check [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DisplayStats(playerid, otherid);
	return 1;
}

CMD:adelays(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/check [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DelaysPlayer(playerid, otherid);
	return 1;
}

CMD:ostats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new name[24], PlayerName[24];
	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/ostats <player name>");
 		return 1;
 	}
		

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /stats on them.");
	  		return 1;
	  	}
	}

	// Load User Data
    new cVar[500];
    new cQuery[600];

	strcat(cVar, "email,admin,helper,level,levelup,vip,vip_time,gold,reg_date,last_login,money,bmoney,brek,hours,minutes,seconds,");
	strcat(cVar, "gender,age,faction,family,warn,job,job2,interior,world,ucp,reg_id,phone,phonestatus, twittername");

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT %s FROM players WHERE username='%e' LIMIT 1", cVar, name);
	mysql_tquery(g_SQL, cQuery, "LoadStats", "is", playerid, name);
	return true;
}

CMD:acuff(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid, mstr[128];		
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/acuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot handcuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
        return Error(playerid, "The player must be onfoot before you can cuff them.");

    if(pData[otherid][pCuffed])
        return Error(playerid, "The player is already cuffed at the moment.");

    pData[otherid][pCuffed] = 1;
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);

    format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, mstr);

    Servers(playerid, "Player %s telah berhasil di cuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin %s telah mengcuffed anda.", pData[playerid][pName]);
    return 1;
}

CMD:auncuff(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/auncuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot uncuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(!pData[otherid][pCuffed])
        return Error(playerid, "The player is not cuffed at the moment.");

    static
        string[64];

    pData[otherid][pCuffed] = 0;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, string);
	Servers(playerid, "Player %s telah berhasil uncuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin %s telah uncuffed tangan anda.", pData[playerid][pName]);
    return 1;
}

CMD:jetpack(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
    {
        pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(otherid, SPECIAL_ACTION_USEJETPACK);
        Servers(playerid, "You have spawned a jetpack for %s.", pData[otherid][pName]);
    }
    return 1;
}

CMD:getip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
		
	new otherid, PlayerIP[16], giveplayer[24];
	if(sscanf(params, "u", otherid))
 	{
  		Usage(playerid, "/getip <ID>");
		return 1;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(pData[otherid][pAdmin] == 5)
 	{
  		Error(playerid, "You can't get the server owners ip!");
  		Servers(otherid, "%s(%i) tried to get your IP!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	Servers(playerid, "%s(%i)'s IP: %s", giveplayer, otherid, PlayerIP);
	return 1;
}

CMD:aka(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new otherid, PlayerIP[16], query[128];
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/aka <ID/Name>");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(pData[otherid][pAdmin] == 201)
 	{
  		Error(playerid, "You can't AKA the server owner!");
  		Servers(otherid, "%s(%i) tried to AKA you!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", PlayerIP);
	mysql_tquery(g_SQL, query, "CheckPlayerIP", "is", playerid, PlayerIP);
	return true;
}

CMD:akaip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new query[128];
	if(isnull(params))
	{
	    Usage(playerid, "/akaip <IP>");
		return true;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", params);
	mysql_tquery(g_SQL, query, "CheckPlayerIP2", "is", playerid, params);
	return true;
}

CMD:checkmask(playerid, params[]) //TESTER
{
	if(pData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);
	new query[128];
	if(isnull(params))
	{
	    Usage(playerid, "/checkmask <MASK ID>");
		return true;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE maskid='%s'", params);
	mysql_tquery(g_SQL, query, "CheckPlayerMask", "is", playerid, params);
	return true;
}
CMD:lastlogin(playerid, params[])
{

    if (pData[playerid][pAdmin] < 2)
    {
        return PermissionError(playerid);
    }

    new query[256];

    if (strlen(params) == 0)
    {
        Usage(playerid, "/lastlogin <Ex: Cassandra_Innesa>");
        return true;
    }

    mysql_format(g_SQL, query, sizeof(query), "SELECT last_login FROM players WHERE username='%s'", params);

    mysql_tquery(g_SQL, query, "CheckPlayerLastLogin", "is", playerid, params);

    return true;
}

CMD:vmodels(playerid, params[])
{
    new string[3500];

    if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
    {
        format(string,sizeof(string), "%s%d - %s\n", string, i+400, g_arrVehicleNames[i]);
    }
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Vehicle Models", string, "Close", "");
    return 1;
}

CMD:vehname(playerid, params[]) 
{

	if(pData[playerid][pAdmin] >= 4) 
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle Search:");

		new
			string[128];

		if(isnull(params)) return Error(playerid, "No keyword specified.");
		if(!params[2]) return Error(playerid, "Search keyword too short.");

		for(new v; v < sizeof(g_arrVehicleNames); v++) 
		{
			if(strfind(g_arrVehicleNames[v], params, true) != -1) {

				if(isnull(string)) format(string, sizeof(string), "%s (ID %d)", g_arrVehicleNames[v], v+400);
				else format(string, sizeof(string), "%s | %s (ID %d)", string, g_arrVehicleNames[v], v+400);
			}
		}

		if(!string[0]) Error(playerid, "No results found.");
		else if(string[127]) Error(playerid, "Too many results found.");
		else SendClientMessageEx(playerid, COLOR_WHITE, string);

		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
	}
	else
	{
		PermissionError(playerid);
	}
	return 1;
}

// CMD:owarn(playerid, params[])
// {
// 	if (pData[playerid][pAlogin] == 0)
// 		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
// 	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
// 	if(pData[playerid][pAdmin] < 2)
// 	    return PermissionError(playerid);
	
// 	new player[24], tmp[50], PlayerName[MAX_PLAYER_NAME];
// 	if(sscanf(params, "s[24]s[50]", player, tmp))
// 		return Usage(playerid, "/owarn <name> <reason>");

// 	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

// 	foreach(new ii : Player)
// 	{
// 		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

// 	    if(strfind(PlayerName, player, true) != -1)
// 		{
// 			Error(playerid, "Player is online, you can use /warn on him.");
// 	  		return 1;
// 	  	}
// 	}
// 	new query[512];
// 	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id,warn FROM players WHERE username='%s'", player);
// 	mysql_tquery(g_SQL, query, "OWarnPlayer", "iss", playerid, player, tmp);
// 	return 1;
// }

// function OWarnPlayer(adminid, NameToWarn[], warnReason[])
// {
// 	if(cache_num_rows() < 1)
// 	{
// 		return Error(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToWarn);
// 	}
// 	else
// 	{
// 	    new RegID, warn;
// 		cache_get_value_index_int(0, 0, RegID);
// 		cache_get_value_index_int(0, 1, warn);
// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s memberikan warning kepada player %s.", pData[adminid][pAdminname], NameToWarn);
// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: [Reason: %s]", warnReason);
// 		// SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah memberi warning(offline) player %s. [Reason: %s]", pData[adminid][pAdminname], NameToWarn, warnReason);
// 		new str[150];
// 		format(str,sizeof(str),"Admin: %s memberi %s warn(offline). Alasan: %s!", GetRPName(adminid), NameToWarn, warnReason);
// 		LogServer("Admin", str);
// 		new query[512];
// 		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET warn=%d WHERE reg_id=%d", warn+1, RegID);
// 		mysql_tquery(g_SQL, query);
// 	}
// 	return 1;
// }
// CMD:ojail(playerid, params[])
// {
// 	if (pData[playerid][pAlogin] == 0)
// 		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
// 	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
// 	if(pData[playerid][pAdmin] < 2)
// 	    return PermissionError(playerid);

// 	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
// 	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
// 		return Usage(playerid, "/ojail <name> <time in minutes)> <reason>");

// 	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");
// 	if(datez < 1 || datez > 60)
// 	{
//  		if(pData[playerid][pAdmin] < 5)
//    		{
// 			Error(playerid, "Jail time must remain between 1 and 60 minutes");
//   			return 1;
//    		}
// 	}
// 	foreach(new ii : Player)
// 	{
// 		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

// 	    if(strfind(PlayerName, player, true) != -1)
// 		{
// 			Error(playerid, "Player is online, you can use /jail on him.");
// 	  		return 1;
// 	  	}
// 	}
// 	new query[512];
// 	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%s'", player);
// 	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, player, tmp, datez);
// 	return 1;
// }

// function OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
// {
// 	if(cache_num_rows() < 1)
// 	{
// 		return Error(adminid, "Account "GREY2_E"'%s' "WHITE_E"does not exist.", NameToJail);
// 	}
// 	else
// 	{
// 	    new RegID, JailMinutes = jailTime * 60;
// 		new jail = 1;
// 		cache_get_value_index_int(0, 0, RegID);

// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah menjail player %s selama %d menit", pData[adminid][pAdminname], NameToJail, jailTime);
// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", jailReason);
// 		// SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: "GREY2_E"Admin %s telah menjail(offline) player %s selama %d menit. [Reason: %s]", pData[adminid][pAdminname], NameToJail, jailTime, jailReason);
// 		new query[512];
// 		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail_time=%d WHERE reg_id=%d", JailMinutes, RegID);
// 		mysql_tquery(g_SQL, query);
// 		new tquery[512];
// 		mysql_format(g_SQL, tquery, sizeof(tquery), "UPDATE players SET jail=%d WHERE reg_id=%d", jail, RegID);
// 		mysql_tquery(g_SQL, tquery);
// 	}
// 	return 1;
// }
/*CMD:ojail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
		return Usage(playerid, "/ojail <name> <time in minutes)> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");
	if(datez < 1 || datez > 60)
	{
 		if(pData[playerid][pAdmin] < 5)
   		{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
  			return 1;
   		}
	}
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /jail on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, player, tmp, datez);
	return 1;
}

function OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToJail);
	}
	else
	{
	    new RegID, JailMinutes = jailTime * 60;
		cache_get_value_index_int(0, 0, RegID);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: {ffff00}Admin %s telah menjail(offline) player %s selama %d menit. [Reason: %s]", pData[adminid][pAdminname], NameToJail, jailTime, jailReason);
		new str[150];
		format(str,sizeof(str),"Admin: %s memberi %s jail(offline) selama %d menit. Alasan: %s!", GetRPName(adminid), NameToJail, jailTime, jailReason);
		LogServer("Admin", str);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail=%d WHERE reg_id=%d", JailMinutes, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}*/

// CMD:jails(playerid, params[])
// {
// 	if (pData[playerid][pAlogin] == 0)
// 		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
// 	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
//    	if(pData[playerid][pAdmin] < 2)
//    		if(pData[playerid][pHelper] < 2)
//      		return PermissionError(playerid);

// 	new reason[60], timeSec, otherid;
// 	if(sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
// 	{
// 	    Usage(playerid, "/jail <ID/Name> <time in minutes> <reason>)");
// 	    return true;
// 	}

// 	if(!IsPlayerConnected(otherid))
//         return Error(playerid, "Player belum masuk!");

// 	if(pData[otherid][pJail] > 0)
// 	{
// 	    Servers(playerid, "%s(%i) is already jailed (gets out in %d minutes)", pData[otherid][pName], otherid, pData[otherid][pJailTime]);
// 	    Info(playerid, "/unjail <ID/Name> to unjail.");
// 	    return true;
// 	}
// 	if(pData[otherid][pSpawned] == 0)
// 	{
// 	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
// 	    return true;
// 	}
// 	if(reason[0] != '*' && strlen(reason) > 60)
// 	{
// 	 	Error(playerid, "Reason too long! Must be smaller than 60 characters!");
// 	   	return true;
// 	}
// 	if(timeSec < 1 || timeSec > 60)
// 	{
// 	    if(pData[playerid][pAdmin] < 5)
// 	 	{
// 			Error(playerid, "Jail time must remain between 1 and 60 minutes");
// 	    	return 1;
// 	  	}
// 	}
// 	pData[otherid][pJail] = 1;
// 	pData[otherid][pHunger] = 1000;
// 	pData[otherid][pEnergy] = 1000;
// 	pData[otherid][pBladder] = 1000;
// 	pData[otherid][pJailTime] = timeSec * 60;
// 	JailPlayer(otherid);
// 	if(reason[0] == '*')
// 	{
// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah menjail player %s selama %d menit.", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
// 		new str[150];
// 		format(str,sizeof(str),"Admin: %s memberi %s jail selama %d menit!", GetRPName(playerid), GetRPName(otherid), timeSec);
// 		LogServer("Admin", str);
// 	}
// 	else
// 	{
// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah menjail player %s selama %d menit", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
// 		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", reason);
// 		// SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: {ffff00}Admin %s telah menjail player %s selama %d menit. {ffff00}[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], timeSec, reason);
// 		new str[150];
// 		format(str,sizeof(str),"Admin: %s memberi %s jail selama %d menit. Alasan: %s!", GetRPName(playerid), GetRPName(otherid), timeSec, reason);
// 		LogServer("Admin", str);
// 	}
// 	new dc[128];
// 	format(dc, sizeof(dc),  "Admin: %s memberi %s jail selama %d menit. Alasan: %s!", GetRPName(playerid), GetRPName(otherid), timeSec, reason);
// 	SendDiscordMessage(9, dc);
// 	return 1;
// }




CMD:unjail(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/unjail <ID/Name>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][pJail] == 0)
	    return Error(playerid, "The player isn't in jail!");

	pData[otherid][pJail] = 0;
	pData[otherid][pJailTime] = 0;
	pData[otherid][pHunger] = 100;
	pData[otherid][pEnergy] = 100;
	pData[otherid][pBladder] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPos(otherid, 1529.6,-1691.2,13.3);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah unjailed %s", pData[playerid][pAdminname], pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s merilis %s dari penjara", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	new dc[128];
	format(dc, sizeof(dc),  "Admin: %s merilis %s dari penjara", GetRPName(playerid), GetRPName(otherid));
	SendDiscordMessage(9, dc);
	return true;
}
CMD:tlist(playerid)
{
    if(pData[playerid][pAdmin] < 2) return Error(playerid, "ADMIN DEK");
	new mstr[4000];
	mstr = "Player Name\tTweet Name\n";
	foreach (new i : Player)
	{
		if(pData[i][pTweet] == 1)
		{
			format(mstr, sizeof(mstr), "%s%s[%d]\t"YELLOW_E"%s\n", mstr, pData[i][pName], i, pData[i][pTname]);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "List Tweet Account", mstr, "Close","");
		}
	}
	return 1;
}
CMD:kick(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    static
        reason[128];

	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "us[128]", otherid, reason))
        return Usage(playerid, "/kick [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was kicked by admin %s", pData[otherid][pName], pData[playerid][pAdminname], reason);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", reason);
    // SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: {ffff00}%s was kicked by admin %s. Reason: %s.", pData[otherid][pName], pData[playerid][pAdminname], reason);
  	new str[150];
	format(str,sizeof(str),"Admin: %s kicked %s Alasan: %s!", GetRPName(playerid), GetRPName(otherid), reason);
	LogServer("Admin", str);
    KickEx(otherid);
    return 1;
}

CMD:banchar(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new ban_time, datez, tmp[60], otherid;
	if(sscanf(params, "uds[60]", otherid, datez, tmp))
	{
	    Usage(playerid, "/ban <ID/Name> <time (in days) 0 for permanent> <reason> ");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
 	if(datez < 0) Error(playerid, "Please input a valid ban time.");
	if(pData[playerid][pAdmin] < 2)
	{
		if(datez > 10 || datez <= 0) return Error(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
	}
	/*if(otherid == playerid)
	    return Error(playerid, "You are not able to ban yourself!");*/
	if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
	{
		Servers(otherid, "** %s(%i) has just tried to ban you!", pData[playerid][pName], playerid);
 		Error(playerid, "You are not able to ban a admin with a higher level than you!");
 		return true;
   	}
	new PlayerIP[16], giveplayer[24];
	
   	//SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	if(datez != 0)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah membanned player %s selama %dhari", pData[playerid][pAdminname], giveplayer, datez);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", tmp);
		// SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned player %s selama %d hari. {ffff00}[Reason: %s]", pData[playerid][pAdminname], giveplayer, datez, tmp);
		new str[150];
		format(str,sizeof(str),"Admin: %s banned %s selama %d hari Alasan: %s!", GetRPName(playerid), GetRPName(otherid), datez, tmp);
		LogServer("Admin", str);
	}
	else
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned permanent player %s. {ffff00}[Reason: %s]", pData[playerid][pAdminname], giveplayer, tmp);
		new str[150];
		format(str,sizeof(str),"Admin: %s banned permanen %s Alasan: %s!", GetRPName(playerid), GetRPName(otherid), tmp);
		LogServer("Admin", str);
	}
	//SetPlayerPosition(otherid, 227.46, 110.0, 999.02, 360.0000, 10);
	BanPlayerMSG(otherid, playerid, tmp);
 	if(datez != 0)
    {
		Servers(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		Servers(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contack admin for unbanned!.", datez);
		ban_time = datez;
	}
	new string [192];
	mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", pData[otherid][pID], TYPE_BAN, tmp, pData[playerid][pAdminname]);
	mysql_query(g_SQL, string, false);
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", giveplayer, PlayerIP, pData[playerid][pAdminname], tmp, gettime(), ban_time);
	mysql_tquery(g_SQL, query);
	KickEx(otherid);

	return true;
}

CMD:banucpoff(playerid, params[])
{
    if (pData[playerid][pAlogin] == 0)
        return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdminDuty] != 1) 
        return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    new ucpName[24], datez, reason[50];
    if(sscanf(params, "s[24]D(0)s[50]", ucpName, datez, reason)) {
        Usage(playerid, "/banucpoff <UCPName> <time (in days) 0 for permanent> <reason>");
        return true;
    }

    if(strlen(reason) > 50)
        return Error(playerid, "Reason must be shorter than 50 characters.");

    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '', '%s', '%s', %i, %i)", 
                 ucpName, pData[playerid][pAdminname], reason, gettime(), datez != 0 ? gettime() + (datez * 86400) : 0);
    mysql_tquery(g_SQL, query);

    if(datez != 0) {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned UCP %s selama %d hari.", pData[playerid][pAdminname], ucpName, datez);
        SendClientMessageToAllEx(COLOR_LIGHTRED, "{ffff00}[Reason: %s].", reason);
    } else {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned permanen UCP %s.", pData[playerid][pAdminname], ucpName);
        SendClientMessageToAllEx(COLOR_LIGHTRED, "{ffff00}[Reason: %s].", reason);
    }

    new log[192];
    format(log, sizeof(log), "Admin: %s banned UCP %s selama %d hari. Alasan: %s", pData[playerid][pAdminname], ucpName, datez, reason);
    LogServer("Admin", log);

    return true;
}


CMD:banucp(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2) 
	{
        return PermissionError(playerid);
    }

    new ban_time, datez, tmp[60], otherid;
    if(sscanf(params, "uds[60]", otherid, datez, tmp)) {
        Usage(playerid, "/banucp <ID/UCPName> <time (in days) 0 for permanent> <reason>");
        return true;
    }

    if(otherid < 0 || otherid >= MAX_PLAYERS) {
        Error(playerid, "Invalid player ID.");
        return true;
    }

    if(datez < 0) {
        Error(playerid, "Please input a valid ban time.");
        return true;
    }

    if(pData[playerid][pAdmin] < 2) {
        if(datez > 10 || datez <= 0) {
            Error(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
            return true;
        }
    }

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin]) {
        Servers(otherid, "** %s(%i) has just tried to ban you!", pData[playerid][pName], playerid);
        Error(playerid, "You are not able to ban an admin with a higher level than you!");
        return true;
    }

    new PlayerIP[16];
    GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

    if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
    else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
    else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
    else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
    else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
    else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
    else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
    else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
    else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";

    if(datez != 0) {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned player %s selama %d hari.", pData[playerid][pAdminname], pData[otherid][pUCP], datez);
        SendClientMessageToAllEx(COLOR_LIGHTRED, " {ffff00}[Reason: %s].", tmp);
        new str[150];
        format(str, sizeof(str), "Admin: %s banned ucp %s selama %d hari Alasan: %s!", GetRPName(playerid), pData[otherid][pUCP], datez, tmp);
        LogServer("Admin", str);
    } else {
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah membanned permanent player %s.", pData[playerid][pAdminname], pData[otherid][pUCP]);
        SendClientMessageToAllEx(COLOR_LIGHTRED, " {ffff00}[Reason: %s].", tmp);
        new str[150];
        format(str, sizeof(str), "Admin: %s banned ucp permanen %s Alasan: %s!", GetRPName(playerid), pData[otherid][pUCP], tmp);
        LogServer("Admin", str);
    }

    BanPlayerMSG(otherid, playerid, tmp);

    if(datez != 0) {
        Servers(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
        ban_time = gettime() + (datez * 86400);
    } else {
        Servers(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contact admin for unbanning!.");
        ban_time = datez;
    }
	new string [192];
	mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", pData[otherid][pID], TYPE_BAN, tmp, pData[playerid][pAdminname]);
	mysql_query(g_SQL, string, false);
    new query[248];
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", pData[otherid][pUCP], PlayerIP, pData[playerid][pAdminname], tmp, gettime(), ban_time);
    mysql_tquery(g_SQL, query);
    KickEx(otherid);
    return true;
}

CMD:unban(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
   	if(pData[playerid][pAdmin] < 2)
			return PermissionError(playerid);
	
	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/unban <ban name>");
	    return true;
	}
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT name,ip FROM banneds WHERE name = '%e'", tmp);
	mysql_tquery(g_SQL, query, "OnUnbanQueryData", "is", playerid, tmp);
	return 1;
}

function OnUnbanQueryData(adminid, BannedName[])
{
	if(cache_num_rows() > 0)
	{
		new banIP[16], query[128];
		cache_get_value_name(0, "ip", banIP);
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE ip = '%s'", banIP);
		mysql_tquery(g_SQL, query);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: %s(%i) has unbanned %s from the server.", pData[adminid][pAdminname], adminid, BannedName);
		new str[150];
		format(str,sizeof(str),"Admin: %s unban %s dari server!", GetRPName(adminid), BannedName);
		LogServer("Admin", str);
	}
	else
	{
		Error(adminid, "No player named '%s' found on the ban list.", BannedName);
	}
	return 1;
}

CMD:unbanucp(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
   	if(pData[playerid][pAdmin] < 2)
			return PermissionError(playerid);
	
	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/unbanucp <ucp name>");
	    return true;
	}
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT name FROM banneds WHERE name = '%e'", tmp);
	mysql_tquery(g_SQL, query, "UnbanUCP", "is", playerid, tmp);
	return 1;
}

function UnbanUCP(adminid, BannedName[])
{
	if(cache_num_rows() > 0)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE name = '%s'", BannedName);
		mysql_tquery(g_SQL, query);

		SendStaffMessage(COLOR_LIGHTRED, "Server: %s(%i) has unbanned %s from the server.", pData[adminid][pAdminname], adminid, BannedName);
		new str[150];
		format(str,sizeof(str),"Admin: %s unban ucp %s dari server!", GetRPName(adminid), BannedName);
		LogServer("Admin", str);
	}
	else
	{
		Error(adminid, "No player named '%s' found on the ban list.", BannedName);
	}
	return 1;
}

// CMD:warn(playerid, params[])
// {
// 	if (pData[playerid][pAlogin] == 0)
// 		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
// 	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
//     static
//         reason[32];

//     if(pData[playerid][pAdmin] < 2)
//         if(pData[playerid][pHelper] < 3)
// 			return PermissionError(playerid);
// 	new otherid;
//     if(sscanf(params, "us[32]", otherid, reason))
//         return Usage(playerid, "/warn [playerid/PartOfName] [reason]");

//     if(!IsPlayerConnected(otherid))
//         return Error(playerid, "Player belum masuk!");

//     if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
//         return Error(playerid, "The specified player has higher authority.");

// 	pData[otherid][pWarn]++;
// 	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s memberikan warning kepada player %s.", pData[playerid][pAdminname],  pData[otherid][pName]);
// 	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: [Reason: %s] [Total Warning: %d/20]", reason, pData[otherid][pWarn]);
// 	// SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah memberikan warning kepada player %s. [Reason: %s] [Total Warning: %d/20]", pData[playerid][pAdminname], pData[otherid][pName], reason, pData[otherid][pWarn]);
	
// 	new dc[128];
// 	format(dc, sizeof(dc),  "Admin %s telah memberikan warning kepada player %s. [Reason: %s] [Total Warning: %d/20]", pData[playerid][pAdminname], pData[otherid][pName], reason, pData[otherid][pWarn]);
// 	SendDiscordMessage(9, dc);

//     return 1;
// }

CMD:unwarn(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 2)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unwarn [playerid/PartOfName]");

	if(pData[otherid][pWarn] == 0) return Error(playerid, "Warning kamu sudah 0!");
	
    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[otherid][pWarn] -= 1;
    Servers(playerid, "You have unwarned 1 point %s's warnings.", pData[otherid][pName]);
	Servers(otherid, "%s has unwarned 1 point your warnings.", pData[playerid][pAdminname]);
    SendStaffMessage(COLOR_LIGHTRED, "Admin %s has unwarned 1 point to %s's warnings.", pData[playerid][pAdminname], pData[otherid][pName]);
    new str[150];
	format(str,sizeof(str),"Admin: %s unwarn %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);

	return 1;
}

/*CMD:dv(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5) return Error(playerid, "Permisioon Error.");
    new vehicleid = GetPlayerVehicleID(playerid);
    DestroyVehicle(vehicleid);
    return 1;
}*/

// CMD:respawnsapd(playerid, params[])
// {
// 	if(pData[playerid][pAdmin] < 1)
// 		if(pData[playerid][pHelper] < 3)
// 			return PermissionError(playerid);
			
// 	for(new x;x<sizeof(pFactionVeh);x++)
// 	{
// 		if(IsVehicleEmpty(pFactionVeh[x]))
// 		{
// 			SetVehicleToRespawn(pFactionVeh[x]);
// 			SetValidVehicleHealth(pFactionVeh[x], 2000);
// 			SetVehicleFuel(pFactionVeh[x], 1000);
// 			SwitchVehicleDoors(pFactionVeh[x], false);
// 		}
// 	}
// 	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned SAPD vehicles.", pData[playerid][pAdminname]);
// 	return 1;
// }

/*CMD:despawnsapd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);

	for(new x;x<sizeof(SAPDVehicles);x++)
	{
		if(IsVehicleEmpty(SAPDVehicles[x]))
		{
			DestroyVehicle(SAPDVehicles[x]);
			SetValidVehicleHealth(SAPDVehicles[x], 2000);
			SetVehicleFuel(SAPDVehicles[x], 1000);
			SwitchVehicleDoors(SAPDVehicles[x], false);
		}
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s has despawn SAPD vehicles.", pData[playerid][pAdminname]);
	return 1;
}*/

// CMD:respawnsags(playerid, params[])
// {
// 	if(pData[playerid][pAdmin] < 1)
// 		if(pData[playerid][pHelper] < 3)
// 			return PermissionError(playerid);
			
// 	for(new x;x<sizeof(SAGSVehicles);x++)
// 	{
// 		if(IsVehicleEmpty(SAGSVehicles[x]))
// 		{
// 			SetVehicleToRespawn(SAGSVehicles[x]);
// 			SetValidVehicleHealth(SAGSVehicles[x], 2000);
// 			SetVehicleFuel(SAGSVehicles[x], 1000);
// 			SwitchVehicleDoors(SAGSVehicles[x], false);
// 		}
// 	}
// 	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned SAGS vehicles.", pData[playerid][pAdminname]);
// 	return 1;
// }

// CMD:respawnsamd(playerid, params[])
// {
// 	if(pData[playerid][pAdmin] < 1)
// 		if(pData[playerid][pHelper] < 3)
// 			return PermissionError(playerid);
			
// 	for(new x;x<sizeof(SAMDVehicles);x++)
// 	{
// 		if(IsVehicleEmpty(SAMDVehicles[x]))
// 		{
// 			SetVehicleToRespawn(SAMDVehicles[x]);
// 			SetValidVehicleHealth(SAMDVehicles[x], 2000);
// 			SetVehicleFuel(SAMDVehicles[x], 1000);
// 			SwitchVehicleDoors(SAMDVehicles[x], false);
// 		}
// 	}
// 	SendStaffMessage(COLOR_LIGHTRED, "%s has respawned SAMD vehicles.", pData[playerid][pAdminname]);
// 	return 1;
// }

// CMD:respawnsana(playerid, params[])
// {
// 	if(pData[playerid][pAdmin] < 1)
// 		if(pData[playerid][pHelper] < 3)
// 			return PermissionError(playerid);
			
// 	for(new x;x<sizeof(SANAVehicles);x++)
// 	{
// 		if(IsVehicleEmpty(SANAVehicles[x]))
// 		{
// 			SetVehicleToRespawn(SANAVehicles[x]);
// 			SetValidVehicleHealth(SANAVehicles[x], 2000);
// 			SetVehicleFuel(SANAVehicles[x], 1000);
// 			SwitchVehicleDoors(SANAVehicles[x], false);
// 		}
// 	}
// 	SendStaffMessage(COLOR_LIGHTRED, "Admin %s has respawned SANA vehicles.", pData[playerid][pAdminname]);
// 	return 1;
// }

CMD:respawndmv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(DmvVeh);x++)
	{
		if(IsVehicleEmpty(DmvVeh[x]))
		{
			SetVehicleToRespawn(DmvVeh[x]);
			SetValidVehicleHealth(DmvVeh[x], 2000);
			SetVehicleFuel(DmvVeh[x], 1000);
			SwitchVehicleDoors(DmvVeh[x], false);
		}
	}
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Admin %s has respawned DMV vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnjobs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SweepVeh);x++)
	{
		if(IsVehicleEmpty(SweepVeh[x]))
		{
			SetVehicleToRespawn(SweepVeh[x]);
			SetValidVehicleHealth(SweepVeh[x], 2000);
			SetVehicleFuel(SweepVeh[x], 1000);
			SwitchVehicleDoors(SweepVeh[x], false);
		}
	}
	for(new xx;xx<sizeof(BusVeh);xx++)
	{
		if(IsVehicleEmpty(BusVeh[xx]))
		{
			SetVehicleToRespawn(BusVeh[xx]);
			SetValidVehicleHealth(BusVeh[xx], 2000);
			SetVehicleFuel(BusVeh[xx], 1000);
			SwitchVehicleDoors(BusVeh[xx], false);
		}
	}
	/*for(new xx;xx<sizeof(KurirCar);xx++)
	{
		if(IsVehicleEmpty(KurirCar[xx]))
		{
			SetVehicleToRespawn(KurirCar[xx]);
			SetValidVehicleHealth(KurirCar[xx], 2000);
			SetVehicleFuel(KurirCar[xx], 1000);
			SwitchVehicleDoors(KurirCar[xx], false);
		}
	}*/
	for(new xx;xx<sizeof(ForVeh);xx++)
	{
		if(IsVehicleEmpty(ForVeh[xx]))
		{
			SetVehicleToRespawn(ForVeh[xx]);
			SetValidVehicleHealth(ForVeh[xx], 2000);
			SetVehicleFuel(ForVeh[xx], 1000);
			SwitchVehicleDoors(ForVeh[xx], false);
		}
	}
	for(new xx;xx<sizeof(BaggageVeh);xx++)
	{
		if(IsVehicleEmpty(BaggageVeh[xx]))
		{
			SetVehicleToRespawn(BaggageVeh[xx]);
			SetValidVehicleHealth(BaggageVeh[xx], 2000);
			SetVehicleFuel(BaggageVeh[xx], 1000);
			SwitchVehicleDoors(BaggageVeh[xx], false);
		}
	}
	for(new xx;xx<sizeof(BoatVeh);xx++)
	{
		if(IsVehicleEmpty(BoatVeh[xx]))
		{
			SetVehicleToRespawn(BoatVeh[xx]);
			SetValidVehicleHealth(BoatVeh[xx], 2000);
			SetVehicleFuel(BoatVeh[xx], 1000);
			SwitchVehicleDoors(BoatVeh[xx], false);
		}
	}
	for(new xx;xx<sizeof(BusVehCd);xx++)
	{
		if(IsVehicleEmpty(BusVehCd[xx]))
		{
			SetVehicleToRespawn(BusVehCd[xx]);
			SetValidVehicleHealth(BusVehCd[xx], 2000);
			SetVehicleFuel(BusVehCd[xx], 1000);
			SwitchVehicleDoors(BusVehCd[xx], false);
		}
	}
    // for(new x;x<sizeof(PizzaVeh);x++)
	// {
	// 	if(IsVehicleEmpty(PizzaVeh[x]))
	// 	{
	// 		SetVehicleToRespawn(PizzaVeh[x]);
	// 		SetValidVehicleHealth(PizzaVeh[x], 2000);
	// 		SetVehicleFuel(PizzaVeh[x], 1000);
	// 		SwitchVehicleDoors(PizzaVeh[x], false);
	// 	}
	// }
	for(new x;x<sizeof(StreakVeh);x++)
	{
		if(IsVehicleEmpty(StreakVeh[x]))
		{
			SetVehicleToRespawn(StreakVeh[x]);
			SetValidVehicleHealth(StreakVeh[x], 2000);
			SetVehicleFuel(StreakVeh[x], 1000);
			SwitchVehicleDoors(StreakVeh[x], false);
		}
	}
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Admin %s has respawned Jobs vehicles.", pData[playerid][pAdminname]);
	return 1;
}

RespawnNearbyVehicles(playerid, Float:radi)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i=1; i<MAX_VEHICLES; i++)
    {
        if(GetVehicleModel(i))
        {
            new Float:posx, Float:posy, Float:posz;
            new Float:tempposx, Float:tempposy, Float:tempposz;
            GetVehiclePos(i, posx, posy, posz);
            tempposx = (posx - x);
            tempposy = (posy - y);
            tempposz = (posz - z);
            if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
            {
				if(IsVehicleEmpty(i))
				{
					//SetVehicleToRespawn(i);
					SetTimerEx("RespawnPV", 3000, false, "d", i);
					SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s telah merespawn kendaraan disekitar dengan radius %d.", pData[playerid][pAdminname], radi);
					SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Jika kendaraan lumber pribadi anda terkena respawn admin gunakan /v park untuk meload kembali lumber anda!");
				}
			}
        }
    }
}

CMD:respawnrad(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
		
	new rad;
	if(sscanf(params, "d", rad)) return Usage(playerid, "/respawnrad [radius] | respawn vehicle nearest");
	
	if(rad > 50) return Error(playerid, "Maximal 50 radius");
	RespawnNearbyVehicles(playerid, rad);
	return 1;
}
CMD:rr(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new rad;
	if(sscanf(params, "d", rad)) return Usage(playerid, "/respawnrad [radius] | respawn vehicle nearest");

	if(rad > 25000) return Error(playerid, "Maximal 25.000 radius");
	RespawnNearbyVehicles(playerid, rad);
	return 1;
}
//----------------------------[ Admin Level 2 ]-----------------------
CMD:sethp(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethp [playerid id/name] <jumlah>");
	if(jumlah > 100)
		return Error(playerid, "Max 100 Hp!");
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerHealthEx(otherid, jumlah);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah hp player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set hp anda", pData[playerid][pAdminname]);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel hp %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men set hp %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:setbone(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setbone [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pHead] = jumlah;
	pData[otherid][pPerut] = jumlah;
	pData[otherid][pLFoot] = jumlah;
	pData[otherid][pRFoot] = jumlah;
	pData[otherid][pLHand] = jumlah;
	pData[otherid][pRHand] = jumlah;
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah Kondisi tulang player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set Kondisi tulang anda", pData[playerid][pAdminname]);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men set Tulang %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:setam(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setam [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(jumlah > 95)
	{
		SetPlayerArmourEx(otherid, 98);
	}
	else
	{
		SetPlayerArmourEx(otherid, jumlah);
	}
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah armor player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set armor anda", pData[playerid][pAdminname]);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel armor %s!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Admin", str);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men set Armor %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:afuel(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 3)
     		return PermissionError(playerid);

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		SetVehicleFuel(GetPlayerVehicleID(playerid), 2500);
		Servers(playerid, "Vehicle Fueled!");
	}
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:vfix(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 3)
     		return PermissionError(playerid);
	
    if(IsPlayerInAnyVehicle(playerid)) 
	{
        SetValidVehicleHealth(GetPlayerVehicleID(playerid), 1000);
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        Servers(playerid, "Vehicle Fixed!");
    }
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:setskin(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    new
        skinid,
		otherid;

    if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, skinid))
        return Usage(playerid, "/skin [playerid/PartOfName] [skin id]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(skinid < 0 || skinid > 299)
        return Error(playerid, "Invalid skin ID. Skins range from 0 to 299.");

    SetPlayerSkinEx(otherid, skinid);
	pData[otherid][pSkin] = skinid;

    Servers(playerid, "You have set %s's skin to ID: %d.", ReturnName(otherid), skinid);
    Servers(otherid, "%s has set your skin to ID: %d.", ReturnName(playerid), skinid);
    return 1;
}

CMD:akill(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);
	new reason[60], otherid;
	if(sscanf(params, "uS(*)[60]", otherid, reason))
	{
	    Usage(playerid, "/akill <ID/Name> <optional: reason>");
	    return 1;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	SetPlayerHealth(otherid, 0.0);

	if(reason[0] != '*')
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Servers: Admin %s has killed %s. "GREY_E"[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], reason);
	}
	else
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Servers: Admin %s has killed %s.", pData[playerid][pAdminname], pData[otherid][pName]);
	}
	return 1;
}

CMD:ann(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

 	if(isnull(params))
    {
	    Usage(playerid, "/announce <msg>");
	    return 1;
	}
	// Check for special trouble-making input
   	if(strfind(params, "~x~", true) != -1)
		return Error(playerid, "~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1)
		return Error(playerid, "The constant key is not allowed in announce.");
	if(strfind(params, "/q", true) != -1)
		return Error(playerid, "You are not allowed to type /q in announcement!");

	// Count tildes (uneven number = faulty input)
	new iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1)
		return Error(playerid, "You either have an extra ~ or one is missing in the announcement!");
	
	new str[512];
	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);
	return true;
}

CMD:settime(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

	new time, mstr[128];
	if(sscanf(params, "d", time))
	{
		Usage(playerid, "/time <time ID>");
		return true;
	}

	SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%i) has changed the time to: "YELLOW_E"%d", pData[playerid][pAdminname], playerid, time);

	format(mstr, sizeof(mstr), "~r~Time changed: ~b~%d", time);
	GameTextForAll(mstr, 3000, 5);

	SetWorldTime(time);
	WorldTime = time;
	foreach(new ii : Player)
	{
		SetPlayerTime(ii, time, 0);
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    new weatherid;

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "d", weatherid))
        return Usage(playerid, "/setweather [weather ID]");

    SetWeather(weatherid);
	WorldWeather = weatherid;
	foreach(new ii : Player)
	{
		SetPlayerWeather(ii, weatherid);
	}
    SetGVarInt("g_Weather", weatherid);
    SendClientMessageToAllEx(COLOR_LIGHTRED,"Server: %s have changed the weather ID %d", pData[playerid][pAdminname], weatherid);
    return 1;
}

CMD:gotoco(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new Float: pos[3], int;
	if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return Usage(playerid, "/gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

	Servers(playerid, "Anda telah terteleportasi ke kordinat tersebut.");
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerInterior(playerid, int);
	return 1;
}

CMD:cd(playerid)
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
	if(Count != -1) return Error(playerid, "There is already a countdown in progress, wait for it to end!");

	Count = 6;
	countTimer = SetTimer("pCountDown", 1000, 1);

	foreach(new ii : Player)
	{
		showCD[ii] = 1;
	}
	SendClientMessageToAllEx(COLOR_LIGHTRED, "[SERVER] "LB_E"Admin %s has started a global countdown!", pData[playerid][pAdminname]);
	return 1;
}

//---------------[ Admin Level 3 ]------------
cmd:banoff(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 3)
	    return PermissionError(playerid);

	new player[24], datez, reason[50];
	if(sscanf(params, "s[24]D(0)s[50]", player, datez, reason))
	{
	    Usage(playerid, "/banoff <ban name> <time in days (0 for permanent ban)> <reason>");
	    Info(playerid, "Will ban a player while he is offline. If time isn't specified it will be a perm ban.");
	    return true;
	}
	if(strlen(reason) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		new PlayerName[24];
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /ban on him.");
	  		return true;
	  	}
	}

	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT ip FROM players WHERE username='%s'", player);
	mysql_tquery(g_SQL, query, "OnOBanQueryData", "issi", playerid, player, reason, datez);
	return true;
}

CMD:bandip(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/banip <IP Address>");
		return true;
	}
	if(strfind(params, "*", true) != -1 && pData[playerid][pAdmin] != 5)
	{
		Error(playerid, "You are not authorized to ban ranges.");
  		return true;
  	}

	SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%d) IP banned address %s.", pData[playerid][pAdminname], playerid, params);
	new str[150];
	format(str,sizeof(str),"Admin: %s banned IP %s!", GetRPName(playerid), params);
	LogServer("Admin", str);

	new tstr[128];
	format(tstr, sizeof(tstr), "banip %s", params);
	SendRconCommand(tstr);
	return 1;
}

CMD:unbanip(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/unbanip <IP Address>");
		return true;
	}
	new mstr[128];
	format(mstr, sizeof(mstr), "unbanip %s", params);
	SendRconCommand(mstr);
	format(mstr, sizeof(mstr), "reloadbans");
	SendRconCommand(mstr);
	Servers(playerid, "You have unbanned IP address %s.", params);
	new str[150];
	format(str,sizeof(str),"Admin: %s unbanned IP %s!", GetRPName(playerid), params);
	LogServer("Admin", str);
	return 1;
}

CMD:reloadweap(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/reloadweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    SetWeapons(otherid);
    Servers(playerid, "You have reload %s's weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin %s have reload your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:resetweap(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/resetweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    ResetPlayerWeaponsEx(otherid);
    Servers(playerid, "You have reset %s's weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin %s have reset your weapons.", pData[playerid][pAdminname]);
   	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah mereset senjata %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
    return 1;
}

CMD:setlevel(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setlevel [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pLevel] = jumlah;
	SetPlayerScore(otherid, jumlah);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah level player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set level anda", pData[playerid][pAdminname]);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level %s ke level %d!", GetRPName(playerid), GetRPName(otherid), jumlah);
	LogServer("Admin", str);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men set Level %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:sethbe(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethbe [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pHunger] = jumlah;
	pData[otherid][pEnergy] = jumlah;
	pData[otherid][pSick] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah hbe player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set HBE anda", pData[playerid][pAdminname]);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men set HBE %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}
CMD:setstress(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setstress [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pBladder] = jumlah;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(COLOR_LIGHTRED, "%s telah men set jumlah stress player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah men set stress anda", pData[playerid][pAdminname]);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah men stress stress %s", pData[playerid][pAdminname], pData[otherid][pName], otherid);
	SendDiscordMessage(9, dc);
	return 1;
}

//----------------------------[ Admin Level 4 ]---------------
CMD:setname(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
	new otherid, tmp[20];
	if(sscanf(params, "is[20]", otherid, tmp))
	{
	   	Usage(playerid, "/setname <ID/Name> <newname>");
	    return 1;
	}
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player belum masuk!");
	if(pData[otherid][IsLoggedIn] == false)	return Error(playerid, "That player is not logged in.");
	
	if(strlen(tmp) < 4) return Error(playerid, "New name can't be shorter than 4 characters!");
	if(strlen(tmp) > 20) return Error(playerid, "New name can't be longer than 20 characters!");
	
	if(!IsValidName(tmp)) return Error(playerid, "Name contains invalid characters, please doublecheck!");
	UpdateWeapons(otherid);
	UpdatePlayerData(otherid);
	KickEx(otherid);
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", tmp);
	mysql_tquery(g_SQL, query, "SetName", "iis", otherid, playerid, tmp);
	return 1;
}


// SetName Callback
function SetName(otherplayer, playerid, nname[])
{
	if(!cache_num_rows())
	{
		new oldname[24], newname[24], query[248], id;
		GetPlayerName(otherplayer, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(otherplayer, "Admin %s telah mengganti nickname anda menjadi (%s)", pData[playerid][pAdminname], nname);
		Info(otherplayer, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah mengganti nickname player %s(%d) menjadi %s", pData[playerid][pAdminname], oldname, otherplayer, nname);
		new str[150];
		format(str,sizeof(str),"Admin: %s mengganti nama %s menjadi %s!", GetRPName(playerid), GetRPName(otherplayer), nname);
		LogServer("Admin", str);
		
		SetPlayerName(otherplayer, nname);
		GetPlayerName(otherplayer, newname, sizeof(newname));
		pData[otherplayer][pName] = newname;
		pData[otherplayer][pID] = id;
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
			}
		}
		foreach(new w : Workshop)
		{
			if(!strcmp(wsData[w][wOwner], oldname, true))
			{
				format(wsData[w][wOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE workshop SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, w);
				mysql_tquery(g_SQL, query);
				Workshop_Refresh(w);
			}
		}
		foreach(new v : Vendings)
		{
			if(!strcmp(VendingData[v][vendingOwner], oldname, true))
			{
				format(VendingData[v][vendingOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vending SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, v);
				mysql_tquery(g_SQL, query);
				Vending_RefreshObject(v);
				Vending_RefreshText(v);	
			}
		}	
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
	}
    return 1;
}

function ChangeName(playerid, nname[])
{
	if(!cache_num_rows())
	{
		if(pData[playerid][pGold] < 500) return Error(playerid, "Not enough gold!");
		pData[playerid][pGold] -= 500;
		
		new oldname[24], newname[24], query[248], id;
		GetPlayerName(playerid, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(playerid, "Anda telah mengganti nickname anda menjadi (%s)", nname);
		Info(playerid, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(COLOR_LIGHTRED, "Player %s(%d) telah mengganti nickname menjadi %s(%d)", oldname, playerid, nname, playerid);
		
		SetPlayerName(playerid, nname);
		GetPlayerName(playerid, newname, sizeof(newname));
		pData[playerid][pName] = newname;
		pData[playerid][pID] = id;
		
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
			}
		}
		foreach(new w : Workshop)
		{
			if(!strcmp(wsData[w][wOwner], oldname, true))
			{
				format(wsData[w][wOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE workshop SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, w);
				mysql_tquery(g_SQL, query);
				Workshop_Refresh(w);
			}
		}
		foreach(new v : Vendings)
		{
			if(!strcmp(VendingData[v][vendingOwner], oldname, true))
			{
				format(VendingData[v][vendingOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vending SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, v);
				mysql_tquery(g_SQL, query);
				Vending_RefreshObject(v);
				Vending_RefreshText(v);	
			}
		}	
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

function NonRPName(playerid, nname[])
{
	if(!cache_num_rows())
	{		
		new oldname[24], newname[24], query[248], id;
		GetPlayerName(playerid, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(playerid, "Anda telah mengganti nickname anda menjadi (%s)", nname);
		SendStaffMessage(COLOR_LIGHTRED, "Player %s(%d) telah mengganti nickname menjadi %s(%d), Reason: Non RP Name", oldname, playerid, nname, playerid);
		
		SetPlayerName(playerid, nname);
		GetPlayerName(playerid, newname, sizeof(newname));
		pData[playerid][pName] = newname;
		pData[playerid][pID] = id;
		
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
			}
		}
		foreach(new w : Workshop)
		{
			if(!strcmp(wsData[w][wOwner], oldname, true))
			{
				format(wsData[w][wOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE workshop SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, w);
				mysql_tquery(g_SQL, query);
				Workshop_Refresh(w);
			}
		}
		foreach(new v : Vendings)
		{
			if(!strcmp(VendingData[v][vendingOwner], oldname, true))
			{
				format(VendingData[v][vendingOwner], 24, "%s", newname);
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vending SET owner='%s', ownerid='%d' WHERE ID=%d", newname, id, v);
				mysql_tquery(g_SQL, query);
				Vending_RefreshObject(v);
				Vending_RefreshText(v);	
			}
		}	
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

CMD:setvip(playerid, params[])
{

    if (pData[playerid][pAlogin] == 0)
        return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");

    if (pData[playerid][pAdminDuty] != 1) 
        return Error(playerid, "Kamu harus on duty sebagai admin!");


    if (pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);
    
    new alevel, dayz, otherid, tmp[64], expirationDate[32];
    
    if (sscanf(params, "udd", otherid, alevel, dayz))
    {
        Usage(playerid, "/setvip <ID/Name> <level 0 - 4> <time (in days) 0 for permanent>");
        return true;
    }
    if (!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
    
    if (alevel > 4)
        return Error(playerid, "Level can't be higher than 4!");
    if (alevel < 0)
        return Error(playerid, "Level can't be lower than 0!");
    if (dayz < 0)
        return Error(playerid, "Time can't be lower than 0!");
        
    if (pData[otherid][IsLoggedIn] == false)
    {
        Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
        return true;
    }
    
    pData[otherid][pVip] = alevel;
    
    if (dayz == 0)
    {
        pData[otherid][pVipTime] = 0;
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%d) telah menset VIP kepada %s(%d) ke level %s permanent time!", 
            pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, GetVipRank(otherid));
        
        new str[150];
        format(str, sizeof(str), "Admin: %s menyetel VIP ke %s, permanen jenis %s!", GetRPName(playerid), GetRPName(otherid), GetVipRank(otherid));
        LogServer("Admin", str);
        

        format(expirationDate, sizeof(expirationDate), "Lifetime");
    }
    else
    {

        pData[otherid][pVipTime] = gettime() + (dayz * 86400);
        
        new year, month, day;
        getdate(year, month, day);
        day += dayz; 
        if (day > 30) 
        {
            month += day / 30;
            day = day % 30;
        }
        if (month > 12) 
        {
            year += month / 12;
            month = month % 12;
        }

        format(expirationDate, sizeof(expirationDate), "%02d/%02d/%04d", day, month, year);
        
        SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%d) telah menset VIP kepada %s(%d) selama %d hari ke level %s!", 
            pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, dayz, GetVipRank(otherid));
        
        new str[150];
        format(str, sizeof(str), "Admin: %s menyetel VIP ke %s selama %d hari jenis %s!", GetRPName(playerid), GetRPName(otherid), dayz, GetVipRank(otherid));
        LogServer("Admin", str);
    }

    pData[otherid][pVipExpirationDate] = expirationDate;
    
    format(tmp, sizeof(tmp), "%d(%d days)", alevel, dayz);
	StaffCommandLog("SETVIP", playerid, otherid, tmp);
    return 1;
}
CMD:giveweap(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    static
        weaponid,
        ammo;
		
	new otherid;
    if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    if(sscanf(params, "udI(250)", otherid, weaponid, ammo))
        return Usage(playerid, "/givewep [playerid/PartOfName] [weaponid] [ammo]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "You cannot give weapons to disconnected players.");


    if(weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
        return Error(playerid, "You have specified an invalid weapon.");

    if(ammo < 1 || ammo > 500)
        return Error(playerid, "You have specified an invalid weapon ammo, 1 - 500");

    GivePlayerWeaponEx(otherid, weaponid, ammo);
    Servers(playerid, "You have give %s a %s with %d ammo.", pData[otherid][pName], ReturnWeaponName(weaponid), ammo);
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan senjata %s(%d) ke %s!", GetRPName(playerid), ReturnWeaponName(weaponid), ammo, GetRPName(otherid));
	LogServer("Admin", str);
	SendAdminMessage(COLOR_LIGHTRED, "%s Telah menggunakan CMD Spawn senjata", pData[playerid][pAdminname]);
	new dc[128];
	format(dc, sizeof(dc),  "%s giveweap %s dengan %d ammo ke player %s.", pData[otherid][pAdminname], ReturnWeaponName(weaponid), ammo, GetRPName(otherid));
	SendDiscordMessage(9, dc);
    return 1;
}

CMD:setfaction(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	new fid, rank, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
    	if(pData[playerid][pFactionModerator] < 1)	
        return PermissionError(playerid);

    if(sscanf(params, "udd", otherid, fid, rank))
        return Usage(playerid, "/setfaction [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW 5.GOCAR] [rank 1-13]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 5)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");
		
	if(rank < 1 || rank > 13)
        return Error(playerid, "You have specified an invalid rank 1 - 12.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed %s's from faction.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your faction.", pData[playerid][pName]);
		new str[150];
		format(str,sizeof(str),"Admin: %s mengeluarkan %s dari fraksi!", GetRPName(playerid), GetRPName(otherid));
		LogServer("Admin", str);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionRank] = rank;
		Servers(playerid, "You have set %s's faction ID %d with rank %d.", pData[otherid][pName], fid, rank);
		Servers(otherid, "%s has set your faction ID to %d with rank %d.", pData[playerid][pName], fid, rank);
		new str[150];
		format(str,sizeof(str),"Admin: %s menyetel faction id %d & rank %d ke %s!", GetRPName(playerid), fid, rank, GetRPName(otherid));
		LogServer("Admin", str);
	}
	
	format(tmp, sizeof(tmp), "%d(%d rank)", fid, rank);
	StaffCommandLog("SETFACTION", playerid, otherid, tmp);
    return 1;
}

CMD:setleader(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	new fid, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 5)
		if(pData[playerid][pFactionModerator] < 1)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, fid))
        return Usage(playerid, "/setleader [playerid/PartOfName] [0.None, 1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW, 5.GOCAR]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 5)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionLead] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed %s's from faction leader.", pData[otherid][pName]);
		Servers(otherid, "%s has removed your faction leader.", pData[playerid][pName]);
		new str[150];
		format(str,sizeof(str),"Admin: %s mengeluarkan %s dari ketu fraksi!", GetRPName(playerid), GetRPName(otherid));
		LogServer("Admin", str);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionLead] = fid;
		pData[otherid][pFactionRank] = 13;
		Servers(playerid, "You have set %s's faction ID %d with leader.", pData[otherid][pName], fid);
		Servers(otherid, "%s has set your faction ID to %d with leader.", pData[playerid][pName], fid);
		new str[150];
		format(str,sizeof(str),"Admin: %s menyetel ketua faction id %d ke %s!", GetRPName(playerid), fid, GetRPName(otherid));
		LogServer("Admin", str);
	}
	
	format(tmp, sizeof(tmp), "%d", fid);
	StaffCommandLog("SETLEADER", playerid, otherid, tmp);
    return 1;
}

CMD:takemoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new money, otherid;
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/takemoney <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(money > pData[otherid][pMoney])
		return Error(playerid, "Player doesn't have enough money to deduct from!");

	GivePlayerMoneyEx(otherid, -money);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%i) has taken away money "RED_E"%s {ffff00}from %s", pData[playerid][pAdminname], FormatMoney(money), pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s mengambil %s dari %s !", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	return true;
}
CMD:takecoin(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new coin, otherid;
	if(sscanf(params, "ud", otherid, coin))
	{
	    Usage(playerid, "/takecoin <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(coin > pData[otherid][pCoin])
		return Error(playerid, "Player doesn't have enough coin to deduct from!");

	pData[otherid][pCoin] -= coin;
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%i) has taken away coin "RED_E"%d {ffff00}from %s", pData[playerid][pAdminname], coin, pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s mengambil %d coin dari %s !", GetRPName(playerid), coin, GetRPName(otherid));
	LogServer("Admin", str);
	return 1;
}
CMD:takegold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new gold, otherid;
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/takegold <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(gold > pData[otherid][pGold])
		return Error(playerid, "Player doesn't have enough gold to deduct from!");

	pData[otherid][pGold] -= gold;
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Server: Admin %s(%i) has taken away gold "RED_E"%d {ffff00}from %s", pData[playerid][pAdminname], gold, pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"Admin: %s mengambil %d Gold dari %s !", GetRPName(playerid), gold, GetRPName(otherid));
	LogServer("Admin", str);
	return 1;
}

CMD:veh(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    static
        model[32],
        color1,
        color2;

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "s[32]I(0)I(0)", model, color1, color2))
        return Usage(playerid, "/veh [model id/name] <color 1> <color 2>");

    if((model[0] = GetVehicleModelByName(model)) == 0)
        return Error(playerid, "Invalid model ID.");

    static
        Float:x,
        Float:y,
        Float:z,
        Float:a,
        vehicleid;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);


    vehicleid = CreateVehicle(model[0], x, y, z, a, color1, color2, 600);
	AdminVehicle{vehicleid} = true;

    if(GetPlayerInterior(playerid) != 0)
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

    if(GetPlayerVirtualWorld(playerid) != 0)
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    if(IsABoat(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
        PutPlayerInVehicle(playerid, vehicleid, 0);

	PutPlayerInVehicle(playerid, vehicleid, 0);
    SetVehicleNumberPlate(vehicleid, "ADMIN");
    Servers(playerid, "Anda memunculkan %s (%d, %d).", GetVehicleModelName(model[0]), color1, color2);
   	SendAdminMessage(COLOR_LIGHTRED, "%s Telah menggunakan CMD Spawn kendaraan %s", pData[playerid][pAdminname], GetVehicleModelName(model[0]));
   	new dc[128];
	format(dc, sizeof(dc),  "%s Spawn Veh %s (%d, %d).", pData[playerid][pAdminname], GetVehicleModelName(model[0]), color1, color2);
	SendDiscordMessage(9, dc);
    return 1;
}

CMD:destroyveh(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	new vehicleid = GetPlayerVehicleID(playerid);

    if(pData[playerid][pAdmin] < 7)
	{
	    return PermissionError(playerid);
	}
	if(AdminVehicle{vehicleid})
	{
	    DestroyVehicle(vehicleid);
	    AdminVehicle{vehicleid} = false;
	    return Servers(playerid, "Kendaraan admin dihancurkan.");
	}

	for(new i = 1; i < MAX_VEHICLES; i ++)
	{
	    if(AdminVehicle{i})
	    {
	        DestroyVehicle(i);
	        AdminVehicle{i} = false;
		}
	}

	SendStaffMessage(COLOR_LIGHTRED, "%s menghancurkan semua kendaraan yang dispawn admin.", pData[playerid][pAdminname]);
	return 1;
}

CMD:agl(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/agl [playerid id/name]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SendStaffMessage(COLOR_LIGHTRED, "%s telah memberi sim kepada player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin %s telah memberi sim anda", pData[playerid][pAdminname]);
	return 1;
}
//-----------------------------[ Admin Level 5 ]------------------
CMD:sethelperlevel(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/sethelperlevel <ID/Name> <level 0 - 3>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 3)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pHelper] = alevel;
	Servers(playerid, "You has set helper level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your helper level to %d", pData[otherid][pName], playerid, alevel);
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah menset %s(%d) sebagai staff helper level %s(%d)",  pData[playerid][pAdminname], pData[otherid][pName], otherid, GetStaffRank(playerid), alevel);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level helper %d ke %s!", GetRPName(playerid), alevel, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETHELPERLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:settwittername(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128], string[63];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/settwittername <ID/Name> <Twitter name>");
	    return true;
	}
	
	format(string, sizeof(string), "%s", aname);
	pData[otherid][pRegTwitter] = 1;
	mysql_format(g_SQL, query, sizeof(query), "SELECT twittername FROM players WHERE twittername='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeTwitterName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setadminname(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/setadminname <ID/Name> <admin name>");
	    return true;
	}
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT adminname FROM players WHERE adminname='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeAdminName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/trysetmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	ResetPlayerMoneyEx(otherid);
	GivePlayerMoneyEx(otherid, money);
	
	Servers(playerid, "Kamu telah mengset uang %s(%d) menjadi %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah mengset uang anda menjadi %s!",pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel uang %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMONEY", playerid, otherid, tmp);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah mengset uang %s menjadi %s!",pData[playerid][pAdminname], pData[otherid][pName], FormatMoney(money));
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givemoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	GivePlayerMoneyEx(otherid, money);
	
	Servers(playerid, "Kamu telah memberikan uang %s(%d) dengan jumlah %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah memberikan uang kepada anda dengan jumlah %s!", pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan uang %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEMONEY", playerid, otherid, tmp);
	new dc[128];
	format(dc, sizeof(dc),  "Admin %s telah memberikan uang %s menjadi %s!",pData[playerid][pAdminname], pData[otherid][pName], FormatMoney(money));
	SendDiscordMessage(9, dc);
	return 1;
}

CMD:bansos(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new money;
	if(sscanf(params, "d", money))
	{
	    Usage(playerid, "/bansos <money>");
	    return true;
	}

	foreach(new pid : Player)
	{
		GivePlayerMoneyEx(pid, money);
		Servers(pid, "%s telah memberikan %s kepada semua warga Fountain Daily", pData[playerid][pAdminname], FormatMoney(money));
		new str[150];
		format(str,sizeof(str),"%s memberikan uang kesemua warga Fountain Daily sejumlah %s", GetRPName(playerid), FormatMoney(money));
		LogServer("Admin", str);
	}
    new lstr[1024];
	format(lstr, sizeof(lstr), "%s telah memberikan %s kepada semua warga Fountain Daily", pData[playerid][pAdminname], FormatMoney(money));
	SendClientMessageToAll(COLOR_LIGHTRED, lstr);

	return 1;
}

CMD:setbankmoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 200)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setbankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[playerid][pBankMoney] = money;
	
	Servers(playerid, "Kamu telah mengset uang rekening banki %s(%d) menjadi %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah mengset uang rekening bank anda menjadi %s!",pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel uang bank %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givebankmoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givebankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[playerid][pBankMoney] += money;
	
	Servers(playerid, "Kamu telah memberikan uang rekening bank %s(%d) dengan jumlah %s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin %s telah memberikan uang rekening bank kepada anda dengan jumlah %s!", pData[playerid][pAdminname], FormatMoney(money));
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan uang bank %s ke %s!", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setvw(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setvw [playerid id/name] <virtual world>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerVirtualWorld(otherid, jumlah);
	Servers(otherid, "Admin %s telah men set Virtual World anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setint(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setint [playerid id/name] <interior>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerInterior(otherid, jumlah);
	Servers(otherid, "Admin %s telah men set Interior anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:explode(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
	new Float:POS[3], otherid, giveplayer[24];
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/explode <ID/Name>");
		return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	Servers(playerid, "You have exploded %s(%i).", giveplayer, otherid);
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
	return true;
}

//--------------------------[ Admin Level 6 ]-------------------
CMD:setadminlevelhigh(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/setadminlevel <ID/Name> <level 0 - 200>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 200)
		return Error(playerid, "Level can't be higher than 8!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pAdmin] = alevel;
	Servers(playerid, "You has set admin level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your admin level to %d", pData[otherid][pName], playerid, alevel);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level admin %d ke %s!", GetRPName(playerid), alevel, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}
CMD:setadminlevel(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
		return Error(playerid, "Anda tidak dapat setadmin ke Admin dengan level paling tinggi");
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/setadminlevel <ID/Name> <level 0 - 7>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 4)
		return Error(playerid, "Level can't be higher than 4!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pAdmin] = alevel;
	Servers(playerid, "You has set admin level %s(%d) to level %d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, "%s(%d) has set your admin level to %d", pData[otherid][pName], playerid, alevel);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel level admin %d ke %s!", GetRPName(playerid), alevel, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setcoin(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new coin, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, coin))
	{
	    Usage(playerid, "/setcoin<ID/Name> <coin>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pCoin] = coin;
	
	Servers(playerid, "Kamu telah menset coin %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, coin);
	Servers(otherid, "Admin %s telah menset coin kepada anda dengan jumlah %d!", pData[playerid][pAdminname], coin);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel %d coin ke %s!", GetRPName(playerid), coin, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", coin);
	StaffCommandLog("SETCOIN", playerid, otherid, tmp);
	return 1;
}

CMD:setgold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/setgold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pGold] = gold;
	
	Servers(playerid, "Kamu telah menset gold %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin %s telah menset gold kepada anda dengan jumlah %d!", pData[playerid][pAdminname], gold);
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel %d Gold ke %s!", GetRPName(playerid), gold, GetRPName(otherid));
	LogServer("Admin", str);
	
	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("SETGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:givegold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/givegold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[otherid][pGold] += gold;
	
	Servers(playerid, "Kamu telah memberikan gold %s(%d) dengan jumlah %d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin %s telah memberikan gold kepada anda dengan jumlah %d!", pData[playerid][pAdminname], gold);
	new str[150];
	format(str,sizeof(str),"Admin: %s memberikan %d Gold ke %s!", GetRPName(playerid), gold, GetRPName(otherid));
	LogServer("Admin", str);

	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("GIVEGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:agive(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/agive [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, medicine, snack, sprunk, material, component, marijuana, obat, gps");
			return 1;
		}
			
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			pData[otherid][pBandage] += ammount;
			Info(playerid, "Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan perban kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			pData[otherid][pMedicine] += ammount;
			Info(playerid, "Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan medicine kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			pData[otherid][pSnack] += ammount;
			Info(playerid, "Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan snack kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			pData[otherid][pSprunk] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			
			if(ammount > 1000)
				return Error(playerid, "Invalid ammount 1 - 1000");
			
			new maxmat = pData[otherid][pMaterial] + ammount;
			
			if(maxmat > 1000)
				return Error(playerid, "That player already have maximum material!");
			
			pData[otherid][pMaterial] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Material kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = pData[otherid][pComponent] + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");
			
			pData[otherid][pComponent] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Component kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			pData[otherid][pMarijuana] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Marijuana kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Marijuana kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"obat",true) == 0) 
		{	
			pData[otherid][pObat] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Obat kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Obat kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"gps",true) == 0) 
		{
			pData[otherid][pGPS] += ammount;
			Info(playerid, "Anda telah berhasil memberikan GPS kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan GPS kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:setprice(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setprice [name] [price]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [MaterialPrice], [MetalPrice], [LumberPrice], [ComponentPrice], [MetalPrice], [CoalPrice], [ProductPrice], [AyamFillPrice]");
		SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [FoodPrice], [FishPrice], [GsPrice] [ObatPrice], [alprazolamprice], [seedprice], [potatoprice], [wheatprice], [orangeprice]");
        return 1;
    }
	if (!strcmp(name, "AyamFillPrice", true))
	{
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [AyamFillPrice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        AyamFillPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set material price to %s.", pData[playerid][pAdminname], FormatMoney(price));
	}
	if(!strcmp(name, "materialprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [materialprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MaterialPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set material price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	if(!strcmp(name, "metalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [metalprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MetalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set metal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "lumberprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [lumberprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        LumberPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set lumber price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "componentprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [componentprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ComponentPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set component price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "metalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [metalprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MetalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set metal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "coalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [coalprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        CoalPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set coal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "productprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [productprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ProductPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set product price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medicineprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [medicineprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MedicinePrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set medicine price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medkitprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [medkitprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MedkitPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set medkit price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "foodprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [foodprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FoodPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set food price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "fishprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [fishprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FishPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set fish price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
    else if(!strcmp(name, "obatprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [obatprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ObatPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set obat price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
    else if(!strcmp(name, "alprazolamprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [alprazolamprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        AlprazolamPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set alprazolam price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "seedprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [seedprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        SeedPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set seed  price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "potatoprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [potatoprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        PotatoPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set potato  price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "wheatprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [wheatprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        WheatPrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set wheat  price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "orangeprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [orangeprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        OrangePrice = price;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set orange  price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	return 1;
}


CMD:setstock(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");

	if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setstock [name] [stock]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [metal], [material], [component], [product], [food] [obat] [pedagang] [alprazolam] [allcreate]");
        return 1;
    }
	if(!strcmp(name, "metal", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [metal] [stok]");

        if(stok < 0 || stok > 100000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Metal = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set metal to %d.", pData[playerid][pAdminname], stok);
    }
	if(!strcmp(name, "material", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [material] [stok]");

        if(stok < 0 || stok > 100000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Material = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set material to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "allcrate", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [allcrate] [stok]");

        if(stok < 0 || stok > 1000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 1000.");

		CrateFish = stok;
		CrateComponent = stok;
		CrateMaterial = stok;
		CrateFood = stok;
        //Component = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set allcrate trucker to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "component", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [component] [stok]");

        if(stok < 0 || stok > 100000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Component = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set component to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "product", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [product] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Product = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set product to %d.", pData[playerid][pAdminname], stok);
    }
    else if(!strcmp(name, "pedagang", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [pedagang] [stok]");

        if(stok < 0 || stok > 50000)
            return Error(playerid, "You must specify at least 0 or 5000.");

        Pedagang = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set pedagang stok to %d.", pData[playerid][pAdminname], stok);
	}
	// else if(!strcmp(name, "apotek", true))
    // {
	// 	new stok;
    //     if(sscanf(string, "d", stok))
    //         return Usage(playerid, "/setstok [apotek] [stok]");

    //     if(stok < 0 || stok > 5000)
    //         return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

    //     Apotek = stok;
	// 	Server_Save();
    //     SendAdminMessage(COLOR_LIGHTRED, "%s set apotek stok to %d.", pData[playerid][pAdminname], stok);
    // }
	else if(!strcmp(name, "food", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [food] [stok]");

        if(stok < 0 || stok > 100000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Food = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set food stok to %d.", pData[playerid][pAdminname], stok);
    }
    else if(!strcmp(name, "obat", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [obat] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ObatMyr = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set obat stok to %d.", pData[playerid][pAdminname], stok);
    }
    else if(!strcmp(name, "alprazolam", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [alprazolam] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Alprazolam = stok;
		Server_Save();
        SendAdminMessage(COLOR_LIGHTRED, "%s set obat stok to %d.", pData[playerid][pAdminname], stok);
    }
	new str[150];
	format(str,sizeof(str),"Admin: %s menyetel %s jumlah %d!", GetRPName(playerid), name, string);
	LogServer("Admin", str);
	return 1;
}

/*CMD:gmx(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	foreach(new pid : Player)
	{
		if(pid != playerid)
		{
			UpdateWeapons(playerid);
			UpdatePlayerData(playerid);
			GameTextForAll("Server akan restart 30 detik kedepan", 30000, 3);
			//SetTimer("PlayerKickALL", 30000, false);
			Servers(pid, "Mohon bersabar, server akan melakukan update, data anda sudah otomatis tersimpan");
			// KickEx(pid);
		}
	}
	return 1;
}*/

forward ServerRestart();
public ServerRestart()
{
    // Proses restart server
    GameTextForAll("Server sedang melakukan restart...", 5000, 3);

    // Menyimpan dan memperbarui semua data pemain sebelum restart
    foreach (new pid : Player)
    {
        UpdateWeapons(pid);
        UpdatePlayerData(pid);
        Servers(pid, "Server sedang melakukan restart, silakan tunggu beberapa saat...");
        //KickEx(pid); // Memaksa pemain keluar
    }

    // Logika untuk restart server (bisa melibatkan perintah untuk memuat atau menyimpan data, atau memulai ulang server)
}

CMD:gmx(playerid, params[])
{
    // Pastikan pemain sudah login sebagai admin
    if (pData[playerid][pAlogin] == 0)
        return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    
    // Pastikan pemain memiliki level admin yang cukup
    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    // Parsing parameter menit
    new minutes;
    if(sscanf(params, "i", minutes)) 
        return SendClientMessage(playerid, COLOR_RED, "Format yang benar: /gmx <menit> (misal: /gmx 2)");

    // Validasi waktu, minimal 1 menit
    if (minutes < 1)
        return SendClientMessage(playerid, COLOR_RED, "Anda harus menentukan waktu minimal 1 menit.");

    new message[64];
	format(message, sizeof(message), "Server akan restart dalam %d menit.", minutes);

	// Menginformasikan semua pemain dengan mengirimkan pesan client
	SendClientMessageToAll(COLOR_WHITE, message);

    // Menyampaikan pesan kepada semua pemain bahwa server akan diupdate
    foreach (new pid : Player)
    {
        if (pid != playerid)
        {
            UpdateWeapons(pid);
            UpdatePlayerData(pid);
            Servers(pid, "Mohon bersabar, server akan melakukan update, data anda sudah otomatis tersimpan");
        }
    }

    // Menjadwalkan timer untuk restart server setelah waktu yang ditentukan (dalam detik)
    SetTimerEx("ServerRestart", minutes * 60 * 1000, false, "i", playerid); // Menghitung detik berdasarkan menit dan tidak menggunakan argumen playerid langsung

    return 1;
}

CMD:kickall(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	foreach(new pid : Player)
	{
		if(pid != playerid)
		{
			UpdateWeapons(playerid);
			UpdatePlayerData(playerid);
			Servers(pid, "Mohon Maaf Server Badai, Data Semua Warga Sudah Di Save Di Database.");
			KickEx(pid);
		}
	}
	return 1;
}
new TimerVote;

stock VoteTime()
{
    new pertanyaan[128], unknown, count = Iter_Count(Player);
    unknown = count-(GetGVarInt("Yes")+GetGVarInt("No"));

    GetGVarString("VoteQuest", pertanyaan, 128);

    SendClientMessageToAllEx(X11_LIGHTBLUE, "VOTE: "YELLOW"%s", pertanyaan);
    SendClientMessageToAllEx(X11_LIGHTBLUE, "VOTE: "WHITE"%d "GREEN"yes, "WHITE"%d"RED" no, "WHITE"%d {C0C0C0}unknown", GetGVarInt("Yes"), GetGVarInt("No"), (unknown < 0) ? (unknown*-1) : unknown);

    foreach(new i : Player) {
        SetPVarInt(i, "Vote", 0);
    }
    SetGVarInt("Yes", 0);
    SetGVarInt("No", 0);
    SetGVarInt("Vote", 0);
    return 1;
}
CMD:vote(playerid, params[])
{
    new vote[10], string[64];

    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "s[10]S()[64]", vote, string))
        return SendSyntaxMessage(playerid, "/vote [create/end]");

    if(!strcmp(vote, "create", true))
    {
        new pertanyaan[128];
    
        if(sscanf(string,"s[128]", pertanyaan))
            return SendSyntaxMessage(playerid, "/vote create [vote]");

        SendClientMessageToAllEx(COLOR_LBLUE, "VOTE: {ffff00}%s", pertanyaan);
        SendClientMessageToAllEx(COLOR_LBLUE, "VOTE: {33ee33}/yes {ffffff}to accept, {ff0000}/no{ffffff} to deny");
        SetGVarString("VoteQuest", pertanyaan);
        SetGVarInt("Yes", 0);
        SetGVarInt("No", 0);
        SetGVarInt("Vote", 1);
    
        TimerVote = SetTimer("VoteTime", 45000, false);

        foreach(new i : Player) {
            SetPVarInt(i, "Vote", 0);
        }
    }
    if(!strcmp(vote, "end", true))
    {
        if(!GetGVarInt("Vote"))
            return SendErrorMessage(playerid, "Tidak ada vote yang sedang berlangsung.");

        SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s ended this voting.", pData[playerid][pAdminname]);
        SendClientMessageToAllEx(COLOR_LBLUE, "Vote Result:");
        new resultMsg[128];
        format(resultMsg, sizeof(resultMsg), "{33ee33}YES: {ffffff}%d | {ff0000}NO: {ffffff}%d", GetGVarInt("Yes"), GetGVarInt("No"));
        SendClientMessageToAllEx(COLOR_LBLUE, resultMsg);

        SetGVarString("VoteQuest", "(null)");
        SetGVarInt("Vote", 0);
        SetGVarInt("Yes", 0);
        SetGVarInt("No", 0);

        foreach(new i : Player) {
            SetPVarInt(i, "Vote", 0);
        }

        KillTimer(TimerVote);
    }
    return 1;
}

CMD:no(playerid, params[])
{
    if(!GetGVarInt("Vote"))
        return SendErrorMessage(playerid, "Tidak ada vote yang sedang berlangsung.");

    if(GetPVarInt(playerid, "Vote"))
        return SendErrorMessage(playerid, "Anda sudah melakukan voting sebelumnya.");

    SetGVarInt("No", GetGVarInt("No")+1);
    SetPVarInt(playerid, "Vote", 1);
    SendServerMessage(playerid, "You're vote {ff0000}No");
    return 1;
}

CMD:yes(playerid, params[])
{
    if(!GetGVarInt("Vote"))
        return SendErrorMessage(playerid, "Tidak ada vote yang sedang berlangsung.");

    if(GetPVarInt(playerid, "Vote"))
        return SendErrorMessage(playerid, "Anda sudah melakukan voting sebelumnya.");

    SetGVarInt("Yes", GetGVarInt("Yes")+1);
    SetPVarInt(playerid, "Vote", 1);
    SendServerMessage(playerid, "You're vote {33ee33}Yes");
    return 1;
}


CMD:spw(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new cname[21], query[128], pass[65], tmp[64];
	if(sscanf(params, "s[21]s[20]", cname, pass))
	{
	    Usage(playerid, "/spw <name> <new password>");
	    Info(playerid, "Make sure you enter the players name and not ID!");
	   	return 1;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT password FROM playerucp WHERE ucp='%s'", cname);
	mysql_tquery(g_SQL, query, "ChangePlayerPassword", "iss", playerid, cname, pass);
	
	format(tmp, sizeof(tmp), "%s", pass);
	StaffCommandLog("SETPASSWORD", playerid, INVALID_PLAYER_ID, tmp);
	return 1;
}

// SetPassword Callback
function ChangePlayerPassword(admin, cPlayer[], newpass[])
{
	if(cache_num_rows() > 0)
	{
		new query[512], pass[65], salt[16];
		Servers(admin, "Password for %s has been set to \"%s\"", cPlayer, newpass);
		
		for (new i = 0; i < 16; i++) salt[i] = random(94) + 33;
		SHA256_PassHash(newpass, salt, pass, 65);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE playerucp SET password='%s', salt='%e' WHERE ucp='%s'", pass, salt, cPlayer);
		mysql_tquery(g_SQL, query);
	}
	else
	{
	    // Name Exists
		Error(admin, "The name"DARK_E"'%s' "WHITE_E"doesn't exist in the database!", cPlayer);
	}
    return 1;
}


CMD:playsong(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp);
			Servers(ii, "/stopsong, /togsong");
		}
	}
	return 1;
}

CMD:playnearsong(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playnearsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp, x, y, z, 35.0, 1);
			Servers(ii, "/stopsong, /togsong");
		}
	}
	return 1;
}

CMD:stopsong(playerid)
{
	StopAudioStreamForPlayer(playerid);
	Servers(playerid, "Song stop!");
	return 1;
}

CMD:anticheat(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	new status;

	if(pData[playerid][pAdmin] < 7)
	{
	    return Error(playerid, "Kamu tidak diizinkan untuk menggunakan command ini.");
	}
	if(sscanf(params, "i", status) || !(0 <= status <= 1))
	{
	    return Usage(playerid, "/anticheat [0/1]");
	}

	if(status) {
		SendAdminMessage(COLOR_LIGHTRED, "[ANTICHEAT]:"WHITE_E" %s telah mengaktifkan anticheat server .", ReturnName(playerid));
	} else {
		SendAdminMessage(COLOR_LIGHTRED, "[ANTICHEAT]:"WHITE_E" %s telah menonaktifkan anticheat server .", ReturnName(playerid));
	}

	AntiCheatKontol = status;
	return 1;
}

CMD:setstat(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], query[248], param[32], ammount, otherid;
        if(sscanf(params, "us[24]S()[32]", otherid, name, param))
		{
			Usage(playerid, "/setstat [playerid] [names]");
			Info(playerid, "Names: Level, LevelUp, Gold, Money, Bank, Health, Armour, Hunger, Energy");
			Info(playerid, "Names: PhoneCredit, Job1, Job2, Fish, Worm, Sprunk, Snack, Seed, Food, Potato");
			Info(playerid, "Names: Wheat, Orange, Bandage, Medkit, Medicine, Marijuana, Component, Material");
			return 1;
		}
			
		if(!strcmp(name, "level", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [level] [ammount]");
			}

			pData[otherid][pLevel] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Level {FFFF00}%s {ffffff}ke level %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Level{ffffff} kamu ke %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET level = %i WHERE reg_id = %i", pData[otherid][pLevel], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "levelup", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [levelup] [ammount]");
			}

			pData[otherid][pLevelUp] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Poin Level {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Poin Level{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET levelup = %i WHERE reg_id = %i", pData[otherid][pLevelUp], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "gold", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [gold] [ammount]");
			}

			pData[otherid][pGold] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Gold {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Gold{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET gold = %i WHERE reg_id = %i", pData[otherid][pGold], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "money", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [money] [ammount]");
			}

			pData[otherid][pMoney] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Money {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), FormatMoney(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Money{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET money = %i WHERE reg_id = %i", pData[otherid][pMoney], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "bank", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [bank] [ammount]");
			}

			pData[otherid][pBankMoney] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bank Money {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), FormatMoney(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bank Money{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bmoney = %i WHERE reg_id = %i", pData[otherid][pBankMoney], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "phonecredit", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [phonecredit] [ammount]");
			}

			pData[otherid][pPhoneCredit] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Phone Credit {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Phone Credit{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET phonecredit = %i WHERE reg_id = %i", pData[otherid][pPhoneCredit], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "health", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [health] [ammount]");
			}

			pData[otherid][pHealth] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Health {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Health{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET health = %i WHERE reg_id = %i", pData[otherid][pHealth], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "armour", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [armour] [ammount]");
			}

			pData[otherid][pArmour] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Armour {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Armour{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET armour = %i WHERE reg_id = %i", pData[otherid][pArmour], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "hunger", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [hunger] [ammount]");
			}

			pData[otherid][pHunger] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Hunger {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Hunger{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET hunger = %i WHERE reg_id = %i", pData[otherid][pHunger], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "energy", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [energy] [ammount]");
			}

			pData[otherid][pEnergy] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Energy {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Energy{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET energy = %i WHERE reg_id = %i", pData[otherid][pEnergy], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "job1", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				Usage(playerid, "/setstat [playerid] [job1] [ammount]");
				Info(playerid, "Names: <1> Taxi, <2> Mechanic, <3> LumberJack, <4> Trucker, <5> Miner");
				Info(playerid, "Names: <6> Production, <7> Farmer, <8> Kurir, <9> Smuggler, <10> Baggage, <11> Pemotong Ayam");
				return 1;
			}
			if(!(0 <= ammount <= 11))
			{
				return Error(playerid, "Invalid job.");
			}

			pData[otherid][pJob] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Job {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), GetJobName(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Job{ffffff} kamu menjadi %s.", pData[playerid][pAdminname], GetJobName(ammount));

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET job = %i WHERE reg_id = %i", pData[otherid][pJob], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "job2", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				Usage(playerid, "/setstat [playerid] [job2] [ammount]");
				Info(playerid, "Names: <1> Taxi, <2> Mechanic, <3> LumberJack, <4> Trucker, <5> Miner");
				Info(playerid, "Names: <6> Production, <7> Farmer, <8> Kurir, <9> Smuggler, <10> Baggage, <11> Pemotong Ayam");
				return 1;
			}
			if(!(0 <= ammount <= 11))
			{
				return Error(playerid, "Invalid job.");
			}

			pData[otherid][pJob2] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Second Job {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), GetJobName(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Second Job{ffffff} kamu menjadi %s.", pData[playerid][pAdminname], GetJobName(ammount));

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET job2 = %i WHERE reg_id = %i", pData[otherid][pJob2], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		/*else if(!strcmp(name, "job1", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				Usage(playerid, "/setstat [playerid] [job1] [ammount]");
				Info(playerid, "Names: <1> Taxi, <2> Mechanic, <3> LumberJack, <4> Trucker, <5> Miner");
				Info(playerid, "Names: <6> Production, <7> Farmer, <8> Kurir, <9> Smuggler, <10> Baggage");
				return 1;
			}
			if(!(0 <= ammount <= 10))
			{
				return Error(playerid, "Invalid job.");
			}

			pData[otherid][pJob] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Job {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), GetJobName(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Job{ffffff} kamu menjadi %s.", pData[playerid][pAdminname], GetJobName(ammount));

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET job = %i WHERE reg_id = %i", pData[otherid][pJob], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "job2", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				Usage(playerid, "/setstat [playerid] [job2] [ammount]");
				Info(playerid, "Names: <1> Taxi, <2> Mechanic, <3> LumberJack, <4> Trucker, <5> Miner");
				Info(playerid, "Names: <6> Production, <7> Farmer, <8> Kurir, <9> Smuggler, <10> Baggage");
				return 1;
			}
			if(!(0 <= ammount <= 10))
			{
				return Error(playerid, "Invalid job.");
			}

			pData[otherid][pJob2] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Second Job {FFFF00}%s {ffffff}menjadi %s.", pData[playerid][pAdminname], ReturnName(otherid), GetJobName(ammount));
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Second Job{ffffff} kamu menjadi %s.", pData[playerid][pAdminname], GetJobName(ammount));

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET job2 = %i WHERE reg_id = %i", pData[otherid][pJob2], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}*/
		else if(!strcmp(name, "medicine", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [medicine] [ammount]");
			}

			pData[otherid][pMedicine] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medicine {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medicine{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET medicine = %i WHERE reg_id = %i", pData[otherid][pMedicine], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "medkit", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [medkit] [ammount]");
			}

			pData[otherid][pMedkit] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medkit {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Medicine{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET Medkit = %i WHERE reg_id = %i", pData[otherid][pMedkit], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "snack", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [snack] [ammount]");
			}

			pData[otherid][pSnack] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Snack {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Snack{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET snack = %i WHERE reg_id = %i", pData[otherid][pSnack], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "sprunk", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [sprunk] [ammount]");
			}

			pData[otherid][pSprunk] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Sprunk {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Sprunk{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET sprunk = %i WHERE reg_id = %i", pData[otherid][pSprunk], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "bandage", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [bandage] [ammount]");
			}

			pData[otherid][pBandage] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bandage {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Bandage{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET bandage = %i WHERE reg_id = %i", pData[otherid][pBandage], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "material", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [material] [ammount]");
			}

			pData[otherid][pMaterial] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Material {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Material{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET material = %i WHERE reg_id = %i", pData[otherid][pMaterial], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "component", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [component] [ammount]");
			}

			pData[otherid][pComponent] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Component {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Component{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET component = %i WHERE reg_id = %i", pData[otherid][pComponent], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "food", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [food] [ammount]");
			}

			pData[otherid][pFood] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Food {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Food{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET food = %i WHERE reg_id = %i", pData[otherid][pFood], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "seed", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [seed] [ammount]");
			}

			pData[otherid][pSeed] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Seed {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Seed{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET seed = %i WHERE reg_id = %i", pData[otherid][pSeed], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "potato", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [potato] [ammount]");
			}

			pData[otherid][pPotato] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Potato {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Potato{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET potato = %i WHERE reg_id = %i", pData[otherid][pPotato], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "orange", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [orange] [ammount]");
			}

			pData[otherid][pOrange] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Orange {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Orange{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET orange = %i WHERE reg_id = %i", pData[otherid][pOrange], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "wheat", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [wheat] [ammount]");
			}

			pData[otherid][pWheat] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Wheat {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Wheat{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET wheat = %i WHERE reg_id = %i", pData[otherid][pWheat], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "marijuana", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [marijuana] [ammount]");
			}

			pData[otherid][pMarijuana] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Marijuana {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Marijuana{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET marijuana = %i WHERE reg_id = %i", pData[otherid][pMarijuana], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "fish", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [fish] [ammount]");
			}

			pData[otherid][pFish] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Fish {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Fish{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET fish = %i WHERE reg_id = %i", pData[otherid][pFish], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "worm", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [worm] [ammount]");
			}

			pData[otherid][pWorm] = ammount;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Worm {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Worm{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET worm = %i WHERE reg_id = %i", pData[otherid][pWorm], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else if(!strcmp(name, "fam", true)) 
		{			
			if(sscanf(param, "i", ammount))
			{
				return Usage(playerid, "/setstat [playerid] [fam] [ammount]");
			}

			pData[otherid][pFamily] = ammount;
			pData[otherid][pFamilyRank] = 1;
			AdminCMD(playerid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Family {FFFF00}%s {ffffff}menjadi %d.", pData[playerid][pAdminname], ReturnName(otherid), ammount);
			AdminCMD(otherid, "{FFFF00}%s {ffffff}telah menyetel {15D4ED}Family{ffffff} kamu menjadi %d.", pData[playerid][pAdminname], ammount);

			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET family = %i, familyrank = %i WHERE reg_id = %i", pData[otherid][pFamily], pData[otherid][pFamilyRank], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		else 
		{
			return 1;
		}
	}	
	return 1;
}

CMD:clearallchat(playerid)
{
    if(pData[playerid][pAdmin] < 1)
	    return PermissionError(playerid);

	foreach(new i : Player)
	{
	    ClearAllChat(i);
	}
	SendAdminMessage(COLOR_LIGHTRED, "%s {FFFFFF}telah membersihkan chat box.", pData[playerid][pAdminname]);
	return 1;
}

CMD:checkucp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
			
	new name[24];
	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/checkucp <ucpname>");
 		return 1;
 	}

    new cQuery[600];

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT username FROM players WHERE ucp='%e'", name);
	mysql_tquery(g_SQL, cQuery, "CheckUCP", "is", playerid, name);
	return true;
}

CMD:setadminmoderator(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	new otherid, option[16], status;
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);

	if(sscanf(params, "us[16]i", otherid, option, status) || !(0 <= status <= 1))
	{
	    Usage(playerid, "/setadminmod [playerid] [type] [status (0/1)]");
		Info(playerid, "Type: [1]ServerMod, [2]EventMod, [3]FactionMod, [4]FamilyMod");
		return 1;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	if(pData[otherid][pAdmin] < 1)
		return Error(playerid, "Player tersebut bukan team pengurus, set terlebih dahulu!");

	if(!strcmp(option, "1", true))
	{
	    pData[otherid][pServerModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Server", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Server", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Server!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Server", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Server", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Server!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	else if(!strcmp(option, "2", true))
	{
	    pData[otherid][pEventModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Event", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Event", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Event!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Event", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Event", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Event!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	else if(!strcmp(option, "3", true))
	{
	    pData[otherid][pFactionModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Faction", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Faction", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Faction!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Faction", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Faction", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Faction!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	else if(!strcmp(option, "4", true))
	{
	    pData[otherid][pFamilyModerator] = status;

	    if(status)
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s menjadi Moderator Family", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu menjadi Moderator Family", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s menjadi Moderator Family!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
		else
	    {
	        SendAdminMessage(COLOR_LIGHTRED, "%s menyetel %s keluar dari Moderator Family", GetRPName(playerid), GetRPName(otherid));
		    Servers(otherid, "%s menyetel kamu keluar dari Moderator Family", GetRPName(playerid));
			new str[150];
			format(str,sizeof(str),"Admin: %s menyetel %s keluar dari Moderator Family!", GetRPName(playerid), GetRPName(otherid));
			LogServer("Admin", str);
		}
	}
	return 1;
}		

CMD:moderatorhelp(playerid, params[])
{
    new string[2000];
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	if(pData[playerid][pServerModerator])
	{
	    strcat(string, "{ffffff}==========> {ff0000}Server Moderator.\n\n");
		strcat(string, "{87CEFA}[ACTOR]: {ffffff}/createactor, /editactor, /deleteactor, /gotoactor\n");
		strcat(string, "{87CEFA}[ATM]: {ffffff}/createatm, /editatm, /removeatm, /gotoatm\n");
		strcat(string, "{87CEFA}[BUSINESS]: {ffffff}/createbiz, /editbiz, /gotobiz\n");
		strcat(string, "{87CEFA}[DOOR]: {ffffff}/createdoor, /editdoor, /gotodoor\n");
		strcat(string, "{87CEFA}[FLAT]: {ffffff}/createflat, /editflat, /asellflat, /destroyflat\n");
		strcat(string, "{87CEFA}[GARKOT]: {ffffff}/createpark, /setparkpos, /removepark, /gotopark\n");
		strcat(string, "{87CEFA}[GARAGE]: {ffffff}/creategarage, /editgarage, /gotogarage, /removegarage\n");
		strcat(string, "{87CEFA}[GAS STATION]: {ffffff}/creategs, /editgs, /gotogs\n");
		strcat(string, "{87CEFA}[GATE]: {ffffff}/creategate, /gedit, /gotogate\n");
		strcat(string, "{87CEFA}[HOUSE]: {ffffff}/createhouse, /edithouse, /gotohouse\n");
		strcat(string, "{87CEFA}[SPEEDCAM]: {ffffff}/createsc, deletesc, /gotosc, /editsc - Note: Jangan diset dulu\n");
		strcat(string, "{87CEFA}[WORKSHOP]: {ffffff}/createws, /editws, /gotows\n\n");
	}
	if(pData[playerid][pEventModerator])
	{
	    strcat(string, "{ffffff}==========> {ff0000}Event Moderator.\n\n");
	    strcat(string, "{87CEFA}[EVENT]: {ffffff}/tdmhelp, /createtdm, /settdminfo /tdmpos /endtdm /starttdm /locktdm /announceevent\n\n");
	}
	if(pData[playerid][pFactionModerator])
	{
	    strcat(string, "{ffffff}==========> {ff0000}Faction Moderator.\n\n");
	    strcat(string, "{87CEFA}[LOCKER]: {ffffff}/createlocker, /editlocker, /gotolocker, /setleader\n\n");
	}
	if(pData[playerid][pFamilyModerator])
	{	
		strcat(string, "{ffffff}==========> {ff0000}Family Moderator.\n\n");
	    strcat(string, "{87CEFA}[FAMILY]: {ffffff}/fcreate, /fedit, /fdelete, /flist, /famint\n\n");
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "{FF0000}Moderator Commands | Fountain Daily Roleplay", string, "Close","");
	return 1;
}
// CMD:giveinsu(playerid, params[])
// {
//     if(pData[playerid][pLevel] < 2) 
//         return Error(playerid, "Anda harus level 2 atau lebih tinggi untuk menggunakan command ini.");

//     new vehid, mstr[128];
//     if(sscanf(params, "d", vehid))
//     {
//         SyntaxMsg(playerid, "/giveinsu <vehicleID>");
//         return true;
//     }

//     if(vehid < 1 || vehid > MAX_VEHICLES)  
//     {
//         return Error(playerid, "ID kendaraan tidak valid.");
//     }

//     pvData[vehid][cInsu] += 1;

//     // Kirim pesan konfirmasi kepada pemain
//     format(mstr, sizeof(mstr), "Asuransi kendaraan ID %d telah ditingkatkan menjadi %d.", vehid, pvData[vehid][cInsu]);
//     SendClientMessage(playerid, COLOR_GREY, mstr);

// 	new query[128];
//     format(query, sizeof(query), "UPDATE vehicle SET insu=%d WHERE id=%d", pvData[vehid][cInsu], pvData[vehid][cID]);
//     mysql_tquery(g_SQL, query);

//     return 1;
// }




CMD:aclaimpv(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 3)
		return PermissionError(playerid);
		
	new found = 0, otherid;

	if(sscanf(params, "d", otherid)) 
		return Usage(playerid, "/aclaimpv [playerid]");
	if(otherid == INVALID_PLAYER_ID)
		return Error(playerid, "Invalid id");	

	foreach(new i : PVehicles)
	{
		if(pvData[i][cClaim] > 0 && pvData[i][cClaimTime] > 0)
		{
			if(pvData[i][cOwner] == pData[otherid][pID])
			{
				pvData[i][cClaim] = 0;
				pvData[i][cClaimTime] = 0;
				
				OnPlayerVehicleRespawn(i);
				pvData[i][cPosX] = 1821.5514;
				pvData[i][cPosY] = -1412.8210;
				pvData[i][cPosZ] = 13.6016;
				pvData[i][cPosA] = 269.8788;
				pvData[i][cLockTire] = 0;
				SetValidVehicleHealth(pvData[i][cVeh], 1000);
				SetVehiclePos(pvData[i][cVeh], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ]);
				SetVehicleZAngle(pvData[i][cVeh], pvData[i][cPosA]);
				SetVehicleFuel(pvData[i][cVeh], 1000);
				ValidRepairVehicle(pvData[i][cVeh]);
				found++;
				Info(playerid, "Kamu telah mengclaim kendaraan player %s dengan model %s", ReturnName(otherid), GetVehicleModelName(pvData[i][cModel]));
				Info(otherid, "Kamu telah mengclaim kendaraan dengan model %s di bantu oleh admin %s", GetVehicleModelName(pvData[i][cModel]), pData[playerid][pAdminname]);
			}
			//else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mv untuk mencari ID.");
		}
	}
	if(found == 0)
	{
		Info(playerid, "Sekarang belum saatnya anda mengclaim kendaraan anda!");
	}
	else
	{
		Info(playerid, "Kamu berhasil mengclaim %d kendaraan %s!", found, ReturnName(otherid));
		Info(otherid, "Kamu berhasil mengclaim %d kendaraan anda di bantu oleh admin %s!", found, pData[playerid][pAdminname]);
	}
	return 1;
}

CMD:cleardelays(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if (pData[playerid][pAdmin] < 6)
    {
        return PermissionError(playerid);
    }

    new targetid;
    
    if (sscanf(params, "u", targetid))
    {
        return SyntaxMsg(playerid, "/cleardelays [playerid]");
    }

    if (targetid < 0 || targetid >= MAX_PLAYERS)
    {
        return Error(playerid, "Invalid player ID.");
    }
    
    if (!IsPlayerConnected(targetid))
    {
        return Error(playerid, "Player is not online.");
    }

    pData[targetid][pJobTime] = 0;
    pData[targetid][pSideJobTime] = 0;
	pData[targetid][pDelaySenjata] = 0;
	pData[targetid][pDelayHauling] = 0;

    Info(playerid, "Delays for player %s have been cleared.", pData[targetid][pName]);

    Info(targetid, "Your job and side job delays have been cleared by an admin.");

    return 1;
}


CMD:dewa(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	SetPlayerHealthEx(playerid, 99999999);
	SetPlayerArmourEx(playerid, 99999999);
	SetPlayerAttachedObject( playerid, 0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 2, 18703, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 3, 18703, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	return 1;
}
	
CMD:nonrpname(playerid, params[])
{
	new otherid, string[256];
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/nonrpname <ID/ Name>");
		return true;
	}
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	format(string, sizeof (string), "{ff0000}Nama kamu non rp name!\n{ffffff}Contoh Nama RP: {3BBD44}Cassandra Innesa\n\n{ffff00}Silahkan isi nama kamu baru dibawah ini!");
	ShowPlayerDialog(otherid, DIALOG_NONRPNAME, DIALOG_STYLE_INPUT, "{ffff00}Non Roleplay Name", string, "Change", "Cancel");
	return 1; 
}

CMD:setgirls(playerid, params[])
{
	new otherid;
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/setgirls <ID/ Name>");
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	pData[otherid][pGirls] = 1;
	SendAdminMessage(COLOR_LIGHTRED, "%s mengaktifkan Girls %s", GetRPName(playerid), GetRPName(otherid));
	Servers(otherid, "Admin %s mengaktifkan Girls kamu", GetRPName(otherid), GetRPName(playerid));
	return 1;
}

CMD:ungirls(playerid, params[])
{
	new otherid;
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/setgirls <ID/ Name>");
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	pData[otherid][pGirls] = 0;
	SendAdminMessage(COLOR_LIGHTRED, "%s mengaktifkan Girls %s", GetRPName(playerid), GetRPName(otherid));
	Servers(otherid, "Admin %s mengaktifkan Girls kamu", GetRPName(otherid), GetRPName(playerid));
	return 1;
}

CMD:setcs(playerid, params[])
{
	new otherid;
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/setcs <ID/ Name>");
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	pData[otherid][pCharacterStory] = 1;
	SendAdminMessage(COLOR_LIGHTRED, "%s mengaktifkan CS %s", GetRPName(playerid), GetRPName(otherid));
	Servers(otherid, "Admin %s mengaktifkan CS kamu", GetRPName(otherid), GetRPName(playerid));
	return 1;
}

CMD:delcs(playerid, params[])
{
	new otherid;
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/delcs <ID/ Name>");
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	pData[otherid][pCharacterStory] = 0;
	SendAdminMessage(COLOR_LIGHTRED, "%s menonaktifkan CS %s", GetRPName(playerid), GetRPName(otherid));
	Servers(otherid, "Admin %s menonaktifkan CS kamu", GetRPName(otherid), GetRPName(playerid));
	return 1;
}

CMD:fixtire(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	if(IsPlayerInAnyVehicle(playerid))
	{
		new Panels, Doors, Lights, Tires;
		GetVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors, Lights, Tires);
		UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors, Lights, 15);

		Info(playerid, "Berhasil perbaiki ban mobil ini");
	}
	else Error(playerid, "Kamu tidak berada di dalam kendaraan");
	return 1;
}
CMD:biru(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 2)
        return Error(playerid, "Khusus Helper Keatas");
    
	if(Yanto[playerid] == 0)
	{
		//if(pData[playerid][pGender] == 2) return Error(playerid, "Hanya Laki-laki yang bisa mengguakan CMD ini.");
		SetPlayerSkinEx(playerid, 176);
		SetPlayerHealthEx(playerid, 99999999);
		SetPlayerArmourEx(playerid, 99999999);
		SetPlayerAttachedObject( playerid, 0, 18963, 2, 0.100, 0.029, -0.006, 94.800, 92.000, 0.000, 1.156, 1.359, 1.112);
		SetPlayerAttachedObject( playerid, 1, 11747, 2, 0.119, 0.000, 0.128, 89.200, 0.000, 0.000, 1.000, 1.053, 2.858);
		SetPlayerAttachedObject( playerid, 2, 11747, 2, 0.123, 0.000, -0.148, 93.500, 0.000, 0.000, 1.000, 1.000, 3.287);
		SetPlayerAttachedObject( playerid, 3, 19011, 2, 0.131, 0.074, 0.000, 99.500, 97.800, -7.400, 1.000, 1.437, 1.818);
		Yanto[playerid] = 1;
	}
	else
	{
		SetPlayerSkinEx(playerid, pData[playerid][pSkin]);
		Yanto[playerid] = 0;
		SetPlayerHealthEx(playerid, pData[playerid][pMaxHealth]);
		SetPlayerArmourEx(playerid, 0);
		for ( new i = 0; i < 4; i++ )
		if ( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
		RemovePlayerAttachedObject( playerid, i );
	}
    return 1;
}
forward L3nzxp(playerid);
public L3nzxp(playerid)
{
	new Float:POS[3];
	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
    return 1;
}
CMD:badut(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 2)
        return Error(playerid, "Khusus Helper Keatas");

	if(Yanto[playerid] == 0)
	{
		//if(pData[playerid][pGender] == 2) return Error(playerid, "Hanya Laki-laki yang bisa mengguakan CMD ini.");
		SetPlayerSkinEx(playerid, 264);
		SetPlayerHealthEx(playerid, 99999999);
		SetPlayerArmourEx(playerid, 99999999);
		SetPlayerAttachedObject( playerid, 0, 18963, 2, 0.100, 0.029, -0.006, 94.800, 92.000, 0.000, 1.156, 1.359, 1.112);
		SetPlayerAttachedObject( playerid, 1, 11747, 2, 0.119, 0.000, 0.128, 89.200, 0.000, 0.000, 1.000, 1.053, 2.858);
		SetPlayerAttachedObject( playerid, 2, 11747, 2, 0.123, 0.000, -0.148, 93.500, 0.000, 0.000, 1.000, 1.000, 3.287);
		SetPlayerAttachedObject( playerid, 3, 19011, 2, 0.131, 0.074, 0.000, 99.500, 97.800, -7.400, 1.000, 1.437, 1.818);
		Yanto[playerid] = 1;
	}
	else
	{
		SetPlayerSkinEx(playerid, pData[playerid][pSkin]);
		Yanto[playerid] = 0;
		SetPlayerHealthEx(playerid, pData[playerid][pMaxHealth]);
		SetPlayerArmourEx(playerid, 0);
		for ( new i = 0; i < 4; i++ )
		if ( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
		RemovePlayerAttachedObject( playerid, i );
	}
    return 1;
}
forward Embahxp(playerid);
public Embahxp(playerid)
{
	new Float:POS[3];
	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
    return 1;
}
CMD:lx(playerid)
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdmin] < 6)
		return Error(playerid,"Harus Admin level 6.");
	SetTimerEx("L3nzxp", 1000, false, "ii", playerid);
	return 1;
}
stock FlipVehicle(vehicleid)
{
	new
	    Float:fAngle;

	GetVehicleZAngle(vehicleid, fAngle);

	SetVehicleZAngle(vehicleid, fAngle);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
}
CMD:flipme(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	new vehicleid = GetPlayerVehicleID(playerid);

	if (PlayerData[playerid][pAdmin] < 3)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (vehicleid > 0 && isnull(params))
	{
		FlipVehicle(vehicleid);
		SendServerMessage(playerid, "You have flipped your current vehicle.");
	}
	else
	{
		if (sscanf(params, "d", vehicleid))
	    	return SendSyntaxMessage(playerid, "/flipme [vehicle ID]");

		else if (!IsValidVehicle(vehicleid))
	    	return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

		FlipVehicle(vehicleid);
		SendServerMessage(playerid, "You have flipped vehicle ID: %d.", vehicleid);
	}
	return 1;
}
CMD:anos(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	
	AddVehicleComponent(vehicleid, 1010);
	SavePVComponents(vehicleid, 1010);
	Vehicle_Save(vehicleid);
	SendServerMessage(playerid, "You have added 10x NOS to your vehicle.");
	return 1;
}

// CMD:mypoint(playerid)
// {
//     if (pData[playerid][pAdmin] < 1)
//         return PermissionError(playerid);

//     new pointask = pData[playerid][pointA];
//     new pointreport = pData[playerid][pointR];
// 	new pointunstuck = pData[playerid][pointU];
// 	new totaltol = pointask + pointreport + pointunstuck;

//     new line3[500];
// 	format(line3, sizeof(line3), SBLUE_E "\nPoint ASK: " WHITE_E "%d\n" SBLUE_E "Point REPORT: " WHITE_E "%d\n"SBLUE_E "Point UNSTUCK: " WHITE_E "%d\n"SBLUE_E "Total Point: " WHITE_E "%d\n" PINK_E "\t\nSelamat menjalankan tugas Staff Fountain!\nTerimakasih sudah ikut membantu mengembangkan server Fountain Daily Roleplay", pointask, pointreport, pointunstuck, totaltol);

//     ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, SBLUE_E "Fountain Daily:RP: " WHITE_E "Staff Points", line3, "OK", "");
//     return true;
// }

CMD:checkpoint(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if (pData[playerid][pAdmin] < 201)
        return PermissionError(playerid);

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        SyntaxMsg(playerid, "/checkpoint <ID/Name>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

    new pointask = pData[otherid][pointA];
    new pointreport = pData[otherid][pointR];
	new pointunstuck = pData[otherid][pointU];
	new totaltol = pointask + pointreport + pointunstuck;

    new line3[500];
	format(line3, sizeof(line3), SBLUE_E "\nPoint ASK: " WHITE_E "%d\n" SBLUE_E "Point REPORT: " WHITE_E "%d\n"SBLUE_E "Point UNSTUCK: " WHITE_E "%d\n"SBLUE_E "Total Point: " WHITE_E "%d\n" PINK_E "\t\nSelamat menjalankan tugas Staff Fountain!\nTerimakasih sudah ikut membantu mengembangkan server Fountain Daily Roleplay", pointask, pointreport, pointunstuck, totaltol);

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, SBLUE_E "Fountain Daily:RP: " WHITE_E "Staff Points", line3, "OK", "");
    return true;
}
CMD:resetpointgold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if (pData[playerid][pAdmin] < 200)
        return PermissionError(playerid);

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        SyntaxMsg(playerid, "/resetpointgold <ID/Name>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

    new asktol = pData[otherid][pointA];
    new reptol = pData[otherid][pointR];
	new unstol = pData[otherid][pointU];
    new totalPoints = asktol + reptol + unstol;

    pData[otherid][pointA] = 0;
    pData[otherid][pointR] = 0;
	pData[otherid][pointU] = 0;

	pData[otherid][pGold] += totalPoints;
	// GivePlayerMoneyEx(otherid,totalPoints);

    Info(playerid, "Anda telah mereset semua poin staff milik %s dan telah menerima %d gold.", ReturnName(otherid), totalPoints);
    Info(otherid, "%s telah mereset semua poin Anda dan Anda menerima %d gold.", pData[playerid][pAdminname], totalPoints);

    return 1;
}
CMD:resetpointmoney(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if (pData[playerid][pAdmin] < 200)
        return PermissionError(playerid);

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        SyntaxMsg(playerid, "/resetpointmoney <ID/Name>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

    new asktol = pData[otherid][pointA];
    new reptol = pData[otherid][pointR];
	new unstol = pData[otherid][pointU];
    new totalPoints = asktol + reptol + unstol;

    pData[otherid][pointA] = 0;
    pData[otherid][pointR] = 0;
	pData[otherid][pointU] = 0;

	new totalsemua = totalPoints * 25;
	GivePlayerMoneyEx(otherid,totalsemua);

    Info(playerid, "Anda telah mereset semua poin staff milik %s dan telah menerima %d.", ReturnName(otherid), FormatMoney(totalsemua));
    Info(otherid, "%s telah mereset semua poin Anda dan Anda menerima %d.", pData[playerid][pAdminname], FormatMoney(totalsemua));

    return 1;
}
CMD:bom(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    new Float:POS[3];

    if(sscanf(params, ""))
    {
        Usage(playerid, "/explode");
        return true;
    }
    if(!IsPlayerConnected(playerid))
        return Error(playerid, "You are not connected!");

    GetPlayerPos(playerid, POS[0], POS[1], POS[2]);

    CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
    return true;
}
CMD:bansosgold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new gold;
	if(sscanf(params, "d", gold))
	{
	    Usage(playerid, "/bansosgold <gold>");
	    return true;
	}

	foreach(new pid : Player)
	{
		pData[pid][pGold] += gold;
		Servers(pid, "%s telah memberikan %d gold kepada semua warga Fountain Daily", pData[playerid][pAdminname], gold);
	}
    new lstr[1024];
	format(lstr, sizeof(lstr), "%s telah memberikan %d gold kepada semua warga Fountain Daily", pData[playerid][pAdminname], gold);
	SendClientMessageToAll(COLOR_LIGHTRED, lstr);

	return 1;
}
CMD:bansosred(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);
		
	new redmoneyy;
	if(sscanf(params, "d", redmoneyy))
	{
	    Usage(playerid, "/bansosred <Red Money>");
	    return true;
	}

	foreach(new pid : Player)
	{
		pData[pid][pRedMoney] += redmoneyy;
		Servers(pid, "%s telah memberikan %d red money kepada semua warga Fountain Daily", pData[playerid][pAdminname], redmoneyy);
	}
    new lstr[1024];
	format(lstr, sizeof(lstr), "%s telah memberikan %d red money kepada semua warga Fountain Daily", pData[playerid][pAdminname], redmoneyy);
	SendClientMessageToAll(COLOR_LIGHTRED, lstr);

	return 1;
}
CMD:stafflogin(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1) return 0; 

    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "SELECT alogin FROM players WHERE reg_id='%d'", pData[playerid][pID]);
    mysql_query(g_SQL, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        new storedPassword[128];
        cache_get_value_name(0, "alogin", storedPassword);

        if (strcmp(storedPassword, "None") == 0)
        {
            ShowPlayerDialog(playerid, DIALOG_SETALOGIN, DIALOG_STYLE_INPUT, "Set Password Admin", "Masukkan password baru:", "Set", "Cancel");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_ATEMIN, DIALOG_STYLE_INPUT, "Login Admin", "Masukkan password admin:", "Login", "Cancel");
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ditemukan data admin. Hubungi admin TryDevX.");
    }

    return 1;
}
CMD:hideatemin(playerid, params[])
{
    if (pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    if (pData[playerid][pAtemin] == 1) 
	{
        pData[playerid][pAtemin] = 0;
        SendClientMessage(playerid, COLOR_GREY, "Nama anda sudah di hide dari {ff0000}/admins.");
    } 
	else
	{
        pData[playerid][pAtemin] = 1;
        SendClientMessage(playerid, COLOR_GREY, "Nama anda sudah ditampilkan ke {ff0000}/admins.");
    }

    return 1;
}

CMD:outatemin(playerid, params[])
{
    if (pData[playerid][pAdmin] < 2 )
		return PermissionError(playerid);

	pData[playerid][pAlogin] = 0;
	SendClientMessage(playerid, COLOR_GREY, "Anda berhasil logout dari admin.");
		
    return 1;
}

CMD:mypoint(playerid)
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    if (pData[playerid][pAdmin] < 1 )
		return PermissionError(playerid);

    new pointask = pData[playerid][pointA];
    new pointreport = pData[playerid][pointR];
    new pointunstuck = pData[playerid][pointU];
    new totaltol = pointask + pointreport + pointunstuck;

    new line3[500];
    format(line3, sizeof(line3), SBLUE_E "\nPoint ASK: " WHITE_E "%d\n" SBLUE_E "Point REPORT: " WHITE_E "%d\n"SBLUE_E "Point UNSTUCK: " WHITE_E "%d\n"SBLUE_E "Total Point: " WHITE_E "%d\n" PINK_E "\t\nSelamat menjalankan tugas Staff Fountain!\nTerimakasih sudah ikut membantu mengembangkan server Fountain Daily Roleplay", pointask, pointreport, pointunstuck, totaltol);

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, SBLUE_E "Fountain Daily:RP: " WHITE_E "Staff Points", line3, "OK", "");
    return 1;
}
