
enum
{
	TYPE_WARN = 1,
	TYPE_JAIL,
	TYPE_BAN
}


stock JailUser(playerid, otherid, minutes, reason[])
{
	pData[otherid][pJail] = 1;
	pData[otherid][pHunger] = 1000;
	pData[otherid][pEnergy] = 1000;
	pData[otherid][pBladder] = 1000;
	pData[otherid][pJailTime] = minutes * 60;
	format(pData[otherid][pJailReason], 32, reason);
	format(pData[otherid][pJailBy], MAX_PLAYER_NAME, pData[playerid][pUCP]);

	SetPlayerPositionEx(otherid, -310.64, 1894.41, 34.05, 178.17, 2000);
	SetPlayerInterior(otherid, 3);
	SetPlayerVirtualWorld(otherid, (otherid + 100));
	SetCameraBehindPlayer(otherid);

	UpdatePlayerData(otherid);

	new string[192];
	mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", pData[otherid][pID], TYPE_JAIL, reason, pData[playerid][pUCP]);
	mysql_query(g_SQL, string, false);
	return 1;
}



function OnWarnUser(playerid, otherid, reason[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been warned by %s.", GetName(otherid), pData[playerid][pAdminname]);
    SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: [Reason: %s] [%d/20]", reason,  pData[otherid][pWarn]);
}
stock WarnUser(playerid, otherid, reason[])
{
	new string [192];
	mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", pData[otherid][pID], TYPE_WARN, reason, pData[playerid][pUCP]);
	mysql_tquery(g_SQL, string, "OnWarnUser", "dds", playerid, otherid, reason);
	return 1;
}

function OWarnPlayer(adminid, NameToWarn[], warnReason[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account '%s' does not exist.", NameToWarn);
	}
	else
	{
		new RegID, warn;
		cache_get_value_index_int(0, 0, RegID);
		cache_get_value_index_int(0, 1, warn);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s memberikan warning kepada player %s.", pData[adminid][pAdminname], NameToWarn);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: [Reason: %s]", warnReason);

		new str[150];
		format(str, sizeof(str), "Admin: %s memberi %s warn (offline). Alasan: %s!", GetRPName(adminid), NameToWarn, warnReason);
		LogServer("Admin", str);

		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET warn=%d WHERE reg_id=%d", warn + 1, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}


function ShowPlayerInfo(playerid, otherid)
{

	new const warntype[][] = {
		"None",
		"{FF0000}WARN",
		"{FF0000}JAIL",
		"{FF0000}BANNED"
	};
	new query[128], str[1012];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `warnings` WHERE `Owner` = '%d'", pData[otherid][pID]);
	mysql_query(g_SQL, query, true);
	new rows = cache_num_rows();
	if(rows)
	{
		format(str, sizeof(str), "Type\tAdmin\tReason\tDate\n");
		for(new i; i < rows; i++)
		{
			new type, admin[24], reason[32], date[40];
			cache_get_value_name_int(i, "Type", type);
			cache_get_value_name(i, "Admin", admin, 24);
			cache_get_value_name(i, "Reason", reason, 32);
			cache_get_value_name(i, "Date", date, 40);
			format(str, sizeof(str), "%s%s {FF0000}\t%s\t%s\t%s\n", str, warntype[type], admin, reason, date);
		}
		new title[64];
		format(title, sizeof(title), "Warning List: %s", GetName(otherid));
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, str, "Close", "");
	}
	else
	{
		SendErrorMessage(playerid, "That player has no warnings.");
	}
	return 1;
}
CMD:mywarn(playerid, params[])
{
	ShowPlayerInfo(playerid, playerid);
	return 1;
}
CMD:checkwarn(playerid, params[])
{
    new targetid;
    
    if(sscanf(params, "u", targetid))
    {
        return SendClientMessage(playerid, -1, "Usage: /checkwarn [playerid]");
    }

    if(!IsPlayerConnected(targetid))
    {
        return SendClientMessage(playerid, -1, "Player ID not connected.");
    }

    ShowPlayerInfo(playerid, targetid);
    
    return 1;
}

CMD:owarn(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");

	if(pData[playerid][pAdminDuty] != 1)
		return Error(playerid, "Kamu harus on duty sebagai admin!");
    
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new playerName[24], warnReason[50];

	if(sscanf(params, "s[24]s[50]", playerName, warnReason))
		return Usage(playerid, "/owarn <name> <reason>");

	if(strlen(warnReason) > 50)
		return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new i : Player)
	{
		new playerOnlineName[MAX_PLAYER_NAME];
		GetPlayerName(i, playerOnlineName, MAX_PLAYER_NAME);

		if(strfind(playerOnlineName, playerName, true) != -1)
		{
			Error(playerid, "Player is online, you can use /warn on him.");
			return 1;
		}
	}

	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id, warn FROM players WHERE username='%s'", playerName);
	mysql_tquery(g_SQL, query, "OWarnPlayer", "iss", playerid, playerName, warnReason);
	return 1;
}


CMD:warn(playerid, params[])
{

	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    
	if(pData[playerid][pAdminDuty] != 1)
		return Error(playerid, "Kamu harus on duty sebagai admin!");
    
    if(pData[playerid][pAdmin] < 2 && pData[playerid][pHelper] < 3)
		return PermissionError(playerid);

	new otherid, reason[32];
    
    if(sscanf(params, "us[32]", otherid, reason))
        return Usage(playerid, "/warn [playerid/PartOfName] [reason]");
    

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

    pData[otherid][pWarn]++;
    
    WarnUser(playerid, otherid, reason);

    return 1;
}

CMD:jail(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1)
		return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new reason[60], timeSec, otherid;
	if(sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
	{
	    Usage(playerid, "/jail <ID/Name> <time in minutes> <reason>)");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Player belum masuk!");

	if(pData[otherid][pJail] > 0)
	{
	    Servers(playerid, "%s(%i) is already jailed (gets out in %d minutes)", pData[otherid][pName], otherid, pData[otherid][pJailTime]);
	    Info(playerid, "/unjail <ID/Name> to unjail.");
	    return true;
	}
	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}
    if (pData[otherid][pAdmin] > pData[playerid][pAdmin])
	    return SendErrorMessage(playerid, "The specified player has higher authority.");
	if(reason[0] != '*' && strlen(reason) > 60)
	{
	 	Error(playerid, "Reason too long! Must be smaller than 60 characters!");
	   	return true;
	}
	if(timeSec < 1 || timeSec > 60)
	{
	    if(pData[playerid][pAdmin] < 5)
	 	{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
	    	return 1;
	  	}
	}
	SendClientMessageToAllEx(COLOR_LRED, "AdmCmd: %s has been Jailed by %s for %d minute(s).", GetName(otherid), pData[playerid][pUCP], timeSec);
	SendClientMessageToAllEx(COLOR_LRED, "Reason: %s", reason);
	// Panggil JailUser untuk melanjutkan proses jail
	JailUser(playerid, otherid, timeSec, reason);
	return 1;
}



function OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
{
    // Mengecek apakah player ditemukan di database
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account '%s' does not exist.", NameToJail);
	}
	else
	{
	    new RegID, JailMinutes = jailTime * 60;
		new jail = 1;
		cache_get_value_index_int(0, 0, RegID);

        // Mengirim pesan ke semua player bahwa player tersebut telah dijail secara offline
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Admin %s telah menjail player %s selama %d menit", pData[adminid][pAdminname], NameToJail, jailTime);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Reason: %s", jailReason);

        // Update database untuk memasukkan waktu jail dan alasan
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail_time=%d WHERE reg_id=%d", JailMinutes, RegID);
		mysql_tquery(g_SQL, query);

		new tquery[512];
		mysql_format(g_SQL, tquery, sizeof(tquery), "UPDATE players SET jail=%d WHERE reg_id=%d", jail, RegID);
		mysql_tquery(g_SQL, tquery);

		new string [192];
		mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", RegID, TYPE_JAIL, jailReason, pData[adminid][pAdminname]);
		mysql_query(g_SQL, string, false);
	}
	return 1;
}

CMD:ojail(playerid, params[])
{
    // Validasi apakah admin sudah login
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
    
    // Validasi apakah admin sedang dalam tugas (on duty)
	if(pData[playerid][pAdminDuty] != 1)
		return Error(playerid, "Kamu harus on duty sebagai admin!");
    
    // Membatasi akses hanya untuk admin level 2 ke atas
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new playerName[24], jailTime, reason[50];

    // Memeriksa parameter yang diberikan oleh admin
	if(sscanf(params, "s[24]ds[50]", playerName, jailTime, reason))
		return Usage(playerid, "/ojail <name> <time in minutes> <reason>");

    // Memastikan panjang alasan tidak melebihi batas yang diizinkan
	if(strlen(reason) > 50) 
	    return Error(playerid, "Reason must be shorter than 50 characters.");

    // Memeriksa batas waktu jail
	if(jailTime < 1 || jailTime > 60)
	{
 		if(pData[playerid][pAdmin] < 5)
   		{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
  			return 1;
   		}
	}

    // Memastikan player yang dijail tidak sedang online
	foreach(new i : Player)
	{
		new playerOnlineName[MAX_PLAYER_NAME];
		GetPlayerName(i, playerOnlineName, MAX_PLAYER_NAME);

	    if(strfind(playerOnlineName, playerName, true) != -1)
		{
			Error(playerid, "Player is online, you can use /jail on him.");
	  		return 1;
	  	}
	}

    // Query untuk mengambil data player dari database berdasarkan nama
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%s'", playerName);
	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, playerName, reason, jailTime);
	return 1;
}
