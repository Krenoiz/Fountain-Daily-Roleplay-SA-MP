//-----------[ Faction Commands ]------------
CMD:factionhelp(playerid)
{
	if(pData[playerid][pFaction] == 1)
	{
		new str[3500];
		strcat(str, ""BLUE_E"SAPD: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SAPD: /sapdonline /(un)cuff /tazer /tr /trackatm /trackph /detain /arrest /release /flare /destroyflare /checkveh /takedl\n");
		strcat(str, ""BLUE_E"SAPD: /destroypacket /takemarijuana /takeweapon /spike /destroyspike /destroyallspike /getloc\n");
		strcat(str, ""WHITE_E"SAPD: /cuffdrag /sitauang /takeweapon /roadblock /destroyroadblock /destroyallroadblock /impound /unimpound\n");
		strcat(str, ""BLUE_E"SAPD: /locktire /callsign /sapdonline /faconline /fcmd /cdutypd /showbadge /setbadge /takelic /givelic \n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAPD", str, "Close", "");
	}
	else if(pData[playerid][pFaction] == 2)
	{
		new str[3500];
		strcat(str, ""LB_E"SAGS: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SAGS: /sagsonline /(un)cuff /checkcitymoney\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAGS", str, "Close", "");
	}
	else if(pData[playerid][pFaction] == 3)
	{
		new str[3500];
		strcat(str, ""PINK_E"SAMD: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SAMD: /givebpjs /imune /samdonline /loadinjured /dropinjured /ems /findems /healbone /rescue /salve /treatment\n");
		strcat(str, ""PINK_E"SAMD: /showbdage /setrank /cdutymd /fcmd /faconline /cuaca\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAMD", str, "Close", "");
	}
	else if(pData[playerid][pFaction] == 4)
	{
		new str[3500];
		strcat(str, ""ORANGE_E"SANA: /locker /or (/r)adio /od /d(epartement) (/gov)ernment (/m)egaphone /invite /uninvite /setrank\n");
		strcat(str, ""WHITE_E"SANA: /sanaonline /broadcast /bc /live /inviteguest /removeguest\n");
		strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SANEWS", str, "Close", "");
	}
	// else if(pData[playerid][pFaction] == 5)
	// {
	// 	new str[3500];
	// 	strcat(str, ""ORANGE_E"Pedagang/Go Car: /locker /gocarlist /takevehgocar /inputveh /invite /uninvite /setrank\n");
	// 	strcat(str, ""WHITE_E"Pedagang/Go Car: /menumasak /gofare /takefood /od /d /m \n");
	// 	strcat(str, ""WHITE_E"NOTE: Lama waktu duty anda akan menjadi gaji anda pada saat paycheck!\n");
	// 	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"GOCAR", str, "Close", "");
	// }
	else if(pData[playerid][pFamily] != -1)
	{
		new str[3500];
		strcat(str, ""WHITE_E"Family: /fsafe /f(amily) /finvite /funinvite /fsetrank /rampas\n");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Family", str, "Close", "");
	}
	else
	{
		Error(playerid, "Anda tidak bergabung dalam faction/family manapun!");
	}
	return 1;
}

// CMD:dokterlokal(playerid, patams[])
// {
//     if(!pData[playerid][pInjured])
//         return Error(playerid, "Tidak bisa menggunakan karena tidak pingsan.");

//     new Total;
//     foreach(new i : Player)
//     {
//         if(pData[i][pFaction] == 3 && pData[i][pOnDuty] == 1)
//         {
//             Total++;
//         }
//     }
//     if(Total < 3)
//     {
// 		return Error(playerid, "Setidaknya harus Ada Samd Onduty Dikota.");
//     }
// 	ShowPlayerDialog(playerid, DIALOG_DOKTERLOKAL, DIALOG_STYLE_LIST, "Fountain Daily // Dokter Lokal", ""AQUA"Informasi :\n"WHITE_E"Jika kamu menggunnakan dokterlokal maka uang kamu akan berkurang sejumlah\n"RED_E" $5.000\nJika kamu setuju maka klik setuju.", "Setuju", "Batalkan");
// 	return 1;
// }
CMD:tunesapd(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 883.0904, -1800.1721, 13.7988))
		return Error(playerid, "Anda Cuma Bisa Melakukan Ini Di HQ SAPD");

	if(pData[playerid][pFaction] != 1)
			return Error(playerid, "Kamu harus menjadi sapd officer.");
    if(IsPlayerInAnyVehicle(playerid)) 
	{
        SetValidVehicleHealth(GetPlayerVehicleID(playerid), 5000);
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        Servers(playerid, "Vehicle Tuned!");
    }
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}
CMD:or(playerid, params[])
{
    new text[128];
    
    if(pData[playerid][pFaction] == 0)
        return Error(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SyntaxMsg(playerid, "/or(OOC radio) [text]");

    if(strval(text) > 128)
        return Error(playerid,"Text too long.");

    if(pData[playerid][pFaction] == 1) {
        SendFactionMessage(1, COLOR_RADIO, "* (( %s: %s ))", pData[playerid][pName], text);
    }
    else if(pData[playerid][pFaction] == 2) {
        SendFactionMessage(2, COLOR_RADIO, "* (( %s: %s ))", pData[playerid][pName], text);
    }
    else if(pData[playerid][pFaction] == 3) {
        SendFactionMessage(3, COLOR_RADIO, "* (( %s: %s ))", pData[playerid][pName], text);
    }
    else if(pData[playerid][pFaction] == 4) {
        SendFactionMessage(4, COLOR_RADIO, "* (( %s: %s ))", pData[playerid][pName], text);
    }
    else if(pData[playerid][pFaction] == 5) {
        SendFactionMessage(5, COLOR_RADIO, "* (( %s: %s ))", pData[playerid][pName], text);
    }
    else
            return Error(playerid, "You are'nt in any faction");
    return 1;
}
CMD:setbadge(playerid, params[])
{
	if(pData[playerid][pFaction] == 1) {
		if(pData[playerid][pFactionRank] < 12) return Error(playerid, "Anda bukan petinggi Faction");
	} else if(pData[playerid][pFaction] == 2) {
		if(pData[playerid][pFactionRank] < 12) return Error(playerid, "Anda bukan petinggi Faction");
	} else if(pData[playerid][pFaction] == 3) {
		if(pData[playerid][pFactionRank] < 12) return Error(playerid, "Anda bukan petinggi Faction");
	} else if(pData[playerid][pFaction] == 4) {
		if(pData[playerid][pFactionRank] < 12) return Error(playerid, "Anda bukan petinggi Faction");
	} else {
		return Error(playerid, "Anda bukan anggota Faction yang valid!");
	}
	new targetid, option;
    if(sscanf(params,"ui", targetid, option)) return Usage(playerid, "/setbadge [otherid] [number badge]");
	if(!IsPlayerConnected(targetid) || !NearPlayer(playerid, targetid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");
    Servers(playerid, "Kamu telah mengset badge number "BLUE_E"%s "YELLOW_E"menjadi = %d", ReturnName(targetid), option);
    Servers(targetid, "High Command"BLUE_E"%s "YELLOW_E"telah merubah Badge kamu menjadi = %d", ReturnName(playerid), option);
	pData[targetid][pBadge] = 1;
	pData[targetid][pBadgeNumber] = option;
	return 1;
}
CMD:showbadge(playerid, params[])
{
	if(pData[playerid][pBadge] == 0) return Error(playerid, "Anda tidak memiliki id Badge!");
	new otherid;
	if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/showbadge [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

	new sext[40], pext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	if(pData[playerid][pFaction] == 1)
	{
		pext = "San Andreas Police";
	}
	else if(pData[playerid][pFaction] == 2)
	{
		pext = "San Andreas Goverment";
	}
	else if(pData[playerid][pFaction] == 3)
	{
		pext = "San Andreas Medic";
	}
	else if(pData[playerid][pFaction] == 4)
	{
		pext = "San Andreas News";
	}
	SendClientMessageEx(otherid, COLOR_LBLUE, "[Badge Information].");
	SendClientMessageEx(otherid, COLOR_YELLOW, "Name: {ffffff}%s.", pData[playerid][pName]);
	SendClientMessageEx(otherid, COLOR_YELLOW, "Badge: {ffffff}%d.", pData[playerid][pBadgeNumber]);	
	SendClientMessageEx(otherid, COLOR_YELLOW, "Faction: {ffffff}%s.", pext);
	SendClientMessageEx(otherid, COLOR_YELLOW, "Gender: {ffffff}%s.", sext);
	
	Info(playerid, "You show your Badge to {ffff00}%s.", ReturnName(otherid));
	return 1;
}
CMD:r(playerid, params[])
{
    new text[128], mstr[512];

    if(pData[playerid][pFaction] == 0)
        return Error(playerid, "You must be in a faction to use this command");

    if(params[0] == '~')
    {
        new temp[128];
        format(temp, sizeof(temp), "@%s %d %s", GetFactionRank(playerid), pData[playerid][pBadgeNumber], params[0], text); 
        format(text, sizeof(text), "%s", temp); 
    }
    else
    {
        format(text, sizeof(text), "%s", params); 
    }

    if(strlen(text) > 128)
        return Error(playerid, "Text is too long.");

    if(pData[playerid][pFaction] == 1) 
    {
		SendFactionMessage(1, COLOR_RADIO, "** [SAPD Radio]%s: %s", pData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
	else if(pData[playerid][pFaction] == 2) 
    {
		SendFactionMessage(2, COLOR_RADIO, "** [SAGS Radio]%s: %s", pData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(pData[playerid][pFaction] == 3) 
    {
		SendFactionMessage(3, COLOR_RADIO, "** [SAMD Radio] %s: %s", pData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else if(pData[playerid][pFaction] == 4) 
    {
		SendFactionMessage(4, COLOR_RADIO, "** [SANA Radio] %s: %s", pData[playerid][pName], text);
		format(mstr, sizeof(mstr), "[<RADIO>]\n* %s *", text);
		SetPlayerChatBubble(playerid, mstr, COLOR_RADIO, 10.0, 3000);
    }
    else
            return Error(playerid, "You are'nt in any faction");
    return 1;
}
// CMD:takevehgocar(playerid)
// {
// 	if(IsPlayerInRangeOfPoint(playerid, 3.0, 340.9970,-1808.8685,4.5301))
// 	{
// 		if(pData[playerid][pFaction] == 5)
// 		{
// 			ShowPlayerDialog(playerid, DIALOG_LISTVEHGO, DIALOG_STYLE_LIST, "Go Car Vehicles", "Motorcycle\nCar", "Enter", "Close");
// 		}
// 		else
// 		{
// 			Error(playerid, "Anda bukan anggota go car");
// 		}
// 	}
// 	else
// 	{
// 		Error(playerid, "Anda tidak berada di checkpoint");
// 	}
// }
// CMD:inputgocar(playerid, params[])
// {
// 	if(IsPlayerInRangeOfPoint(playerid, 8.0, 340.9970,-1808.8685,4.5301))
// 	{
// 		if(pData[playerid][pFaction] != 5)
// 	        return Error(playerid, "You must be at GoCar officer faction!.");
	        
// 		new vehicleid = GetPlayerVehicleID(playerid);
//         if(!IsEngineVehicle(vehicleid))
// 			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

//     	DestroyVehicle(GOCARVehicles[playerid]);
// 		pData[playerid][pSpawnGo] = 0;
//     	GameTextForPlayer(playerid, "~w~Gocar Vehicles ~r~Despawned", 3500, 3);
//     }
//     return 1;
// }
CMD:od(playerid, params[])
{
    new text[128];
    
    if(pData[playerid][pFaction] == 0)
        return Error(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SyntaxMsg(playerid, "/od(OOC departement) [text]");

    if(strval(text) > 128)
        return Error(playerid,"Text too long.");
	
	for(new fid = 1; fid < 5; fid++)
	{
		if(pData[playerid][pFaction] == 1) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( SAPD: %s: %s ))", pData[playerid][pName], text);
		}
		else if(pData[playerid][pFaction] == 2) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( SAGS: %s: %s ))", pData[playerid][pName], text);
		}
		else if(pData[playerid][pFaction] == 3) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( SAMD: %s: %s ))", pData[playerid][pName], text);
		}
		else if(pData[playerid][pFaction] == 4) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( SANA: %s: %s ))", pData[playerid][pName], text);
		}
		else if(pData[playerid][pFaction] == 5) {
			SendFactionMessage(fid, 0xFFD7004A, "** (( %s: %s ))", pData[playerid][pName], text);
		}
		else
				return Error(playerid, "You are'nt in any faction");
	}
    return 1;
}

CMD:d(playerid, params[])
{
    new text[128], mstr[512];
    
    if(pData[playerid][pFaction] == 0)
        return Error(playerid, "You must in faction member to use this command");
            
    if(sscanf(params,"s[128]",text))
        return SyntaxMsg(playerid, "/d(epartement) [text]");

    if(strval(text) > 128)
        return Error(playerid,"Text too long.");
	
	for(new fid = 1; fid < 5; fid++)
	{
		if(pData[playerid][pFaction] == 1) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SAPD Departement] %s(%d) %s: %s", GetFactionRank(playerid), pData[playerid][pFactionRank], pData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(pData[playerid][pFaction] == 2) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SAGS Departement] %s(%d) %s: %s", GetFactionRank(playerid),  pData[playerid][pFactionRank], pData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(pData[playerid][pFaction] == 3) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SAMD Departement] %s(%d) %s: %s", GetFactionRank(playerid),  pData[playerid][pFactionRank], pData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(pData[playerid][pFaction] == 4) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [SANA Departement] %s(%d) %s: %s", GetFactionRank(playerid),  pData[playerid][pFactionRank], pData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else if(pData[playerid][pFaction] == 4) 
		{
			SendFactionMessage(fid, 0xFFD7004A, "** [GOCAR Departement] %s(%d) %s: %s", GetFactionRank(playerid),  pData[playerid][pFactionRank], pData[playerid][pName], text);
			format(mstr, sizeof(mstr), "[<DEPARTEMENT>]\n* %s *", text);
			SetPlayerChatBubble(playerid, mstr, 0xFFD7004A, 10.0, 3000);
		}
		else
				return Error(playerid, "You are'nt in any faction");
	}
    return 1;
}

CMD:m(playerid, params[])
{
	new facname[16];
	if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");
		
	if(isnull(params)) return SyntaxMsg(playerid, "/m(egaphone) [text]");
	
	if(pData[playerid][pFaction] == 1)
	{
		facname = "SAPD";
	}
	else if(pData[playerid][pFaction] == 2)
	{
		facname = "SAGS";
	}
	else if(pData[playerid][pFaction] == 3)
	{
		facname = "SAMD";
	}
	else if(pData[playerid][pFaction] == 4)
	{
		facname = "SANA";
	}
	else
	{
		facname ="Unknown";
	}
	
	if(strlen(params) > 64) {
        SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "[%s Megaphone] %s says: %.64s", facname, ReturnName(playerid), params);
        SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "...%s", params[64]);
    }
    else {
        SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "[%s Megaphone] %s says: %s", facname, ReturnName(playerid), params);
    }
	return 1;
}

CMD:gov(playerid, params[])
{
	if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");
	
	if(pData[playerid][pFactionRank] < 5)
		return Error(playerid, "Only faction level 5-6");
		
	if(pData[playerid][pFaction] == 1)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAPD: %s(%d) %s: %s **", GetFactionRank(playerid), pData[playerid][pFactionRank], pData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_BLUE, lstr);
	}
	else if(pData[playerid][pFaction] == 2)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAGS: %s(%d) %s: %s **", GetFactionRank(playerid), pData[playerid][pFactionRank], pData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_LBLUE, lstr);
	}
	else if(pData[playerid][pFaction] == 3)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SAMD: %s(%d) %s: %s **", GetFactionRank(playerid), pData[playerid][pFactionRank], pData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_PINK2, lstr);
	}
	else if(pData[playerid][pFaction] == 4)
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "** SANA: %s(%d) %s: %s **", GetFactionRank(playerid), pData[playerid][pFactionRank], pData[playerid][pName], params);
		SendClientMessageToAll(COLOR_WHITE, "|___________ Government News Announcement ___________|");
		SendClientMessageToAll(COLOR_ORANGE2, lstr);
	}
	return 1;
}

CMD:setrank(playerid, params[])
{
	new rank, otherid;
	if(pData[playerid][pFactionLead] < 1)
		return Error(playerid, "You must faction leader!");
		
	if(sscanf(params, "ud", otherid, rank))
        return SyntaxMsg(playerid, "/setrank [playerid/PartOfName] [rank 1-12]");
		
	if(otherid == INVALID_PLAYER_ID)
		return Error(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");
	
	if(pData[otherid][pFaction] != pData[playerid][pFaction])
		return Error(playerid, "This player is not in your devision!");
	
	if(rank < 1 || rank > 13)
		return Error(playerid, "rank must 1 - 12 only");
	
	pData[otherid][pFactionRank] = rank;
	Servers(playerid, "You has set %s faction rank to level %d", pData[otherid][pName], rank);
	Servers(otherid, "%s has set your faction rank to level %d", pData[playerid][pName], rank);
	new str[150];
	format(str,sizeof(str),"[FACTION]: %s menyetel fraksi %s ke rank!", GetRPName(playerid), GetRPName(otherid), rank);
	LogServer("Faction", str);
	return 1;
}

CMD:uninvite(playerid, params[])
{
	if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");
		
	if(pData[playerid][pFactionRank] < 12)
		return Error(playerid, "You must faction level 12 - 13!");
	
	if(!pData[playerid][pOnDuty])
        return Error(playerid, "You must on duty!.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/uninvite [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");
	
	if(pData[otherid][pFactionRank] > pData[playerid][pFactionRank])
		return Error(playerid, "You cant kick him.");
		
	pData[otherid][pFactionRank] = 0;
	pData[otherid][pFaction] = 0;
	Servers(playerid, "Anda telah mengeluarkan %s dari faction.", pData[otherid][pName]);
	Servers(otherid, "%s telah mengkick anda dari faction.", pData[playerid][pName]);
	new str[150];
	format(str,sizeof(str),"[FACTION]: %s mengeluarkan %s dari fraksi!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Faction", str);
	return 1;
}

CMD:invite(playerid, params[])
{
	if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");
		
	if(pData[playerid][pFactionRank] < 12)
		return Error(playerid, "You must faction level 12 - 13!");
	
	if(!pData[playerid][pOnDuty])
        return Error(playerid, "You must on duty!.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/invite [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");
	
	if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");
		
	if(pData[otherid][pFaction] != 0)
		return Error(playerid, "Player tersebut sudah bergabung faction!");
		
	pData[otherid][pFacInvite] = pData[playerid][pFaction];
	pData[otherid][pFacOffer] = playerid;
	Servers(playerid, "Anda telah menginvite %s untuk menjadi faction.", pData[otherid][pName]);
	Servers(otherid, "%s telah menginvite anda untuk menjadi faction. Type: /accept faction or /deny faction!", pData[playerid][pName]);
	new str[150];
	format(str,sizeof(str),"[FACTION]: %s mengundang %s menjadi fraksi!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Faction", str);
	return 1;
}

CMD:locker(playerid, params[])
{
	if(pData[playerid][pFaction] < 1)
		if(pData[playerid][pVip] < 1)
			return Error(playerid, "You cant use this commands!");
		
	foreach(new lid : Lockers)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]))
		{
			if(pData[playerid][pVip] > 0 && lData[lid][lType] == 6)
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERVIP, DIALOG_STYLE_LIST, "VIP Locker", "Health\nWeapons\nClothing\nVip Toys", "Okay", "Cancel");
			}
			else if(pData[playerid][pFaction] == 1 && pData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAPD, DIALOG_STYLE_LIST, "SAPD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing\nClothing War\nVest", "Proceed", "Cancel");
			}
			else if(pData[playerid][pFaction] == 2 && pData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAGS, DIALOG_STYLE_LIST, "SAGS Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
			}
			else if(pData[playerid][pFaction] == 3 && pData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSAMD, DIALOG_STYLE_LIST, "SAMD Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nDrugs\nClothing", "Proceed", "Cancel");
			}
			else if(pData[playerid][pFaction] == 4 && pData[playerid][pFaction] == lData[lid][lType])
			{
				ShowPlayerDialog(playerid, DIALOG_LOCKERSANEW, DIALOG_STYLE_LIST, "SANA Lockers", "Toggle Duty\nHealth\nArmour\nWeapons\nClothing", "Proceed", "Cancel");
			}
			else return Error(playerid, "You are not in this faction type!");
		}
	}
	return 1;
}

//SAPD Commands
CMD:siren(playerid, params[])
{
	if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");
		
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "You must faction to access");
	
	if(!pData[playerid][pOnDuty])
        return Error(playerid, "You must on duty!.");


	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsPlayerInAnyVehicle(playerid))
	    return Error(playerid, "You must be inside a vehicle.");

	switch (pvData[vehicleid][vehSirenOn])
	{
	    case 0:
	    {
			static
        		Float:fSize[3],
        		Float:fSeat[3];

		    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]); // need height (z)
    		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]); // need pos (x, y)

            pvData[vehicleid][vehSirenOn] = 1;
			pvData[vehicleid][vehSirenObject] = CreateDynamicObject(18646, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);

		    AttachDynamicObjectToVehicle(pvData[vehicleid][vehSirenObject], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s attaches a portable siren to the vehicle.", ReturnName(playerid));
		}
		case 1:
		{
		    pvData[vehicleid][vehSirenOn] = 0;

			DestroyDynamicObject(pvData[vehicleid][vehSirenObject]);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s detaches a portable siren from the vehicle.", ReturnName(playerid));
		}
	}
	return 1;
}

CMD:takeweapon(playerid, params[])
{
    if (pData[playerid][pFaction] != 1) 
    {
        return Error(playerid, "Kamu harus menjadi police officer.");
    }

    new otherid;

    if (sscanf(params, "u", otherid)) 
    {
        return SyntaxMsg(playerid, "USAGE: /takeweapon [playerid/partofname]");
    }

    if (!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0)) 
    {
        return Error(playerid, "Player disconnect atau tidak berada di dekat anda.");
    }

    ResetPlayerWeaponsEx(otherid); 

    Info(playerid, "Anda telah mengambil senjata dari %s", pData[otherid][pName]);
    Info(otherid, "Petugas %s telah mengambil senjata Anda.", pData[playerid][pName]);

    return 1;
}

CMD:trackatm(playerid, params[])
{
    if(pData[playerid][pFaction] <= 0)
		return Error(playerid, "You are not faction!");

	new atmid;
	if(sscanf(params, "d", atmid)) return SyntaxMsg(playerid, "/trackatm [Id]");
	if(!Iter_Contains(ATMS, atmid)) return Error(playerid, "Maaf ATM dengan id {FFFF00}%d{FFFFFF} Tidak dapat ditemukan.", atmid);

	SetPlayerCheckpoint(playerid, AtmData[atmid][atmX]-3, AtmData[atmid][atmY], AtmData[atmid][atmZ], 3.0);
	Info(playerid, "Berhasil mendapatkan lokasi atm dengan id {FFFF00}%d", atmid);
    return 1;
}

CMD:sapdonline(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi police officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");
		
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 1)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty, pData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAPD Online", lstr, "Close", "");
	return 1;
}



CMD:flare(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
   		 return Error(playerid, "Kamu harus menjadi police officer.");

	if(IsValidDynamicObject(pData[playerid][pFlare]))
		DestroyDynamicObject(pData[playerid][pFlare]);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	pData[playerid][pFlare] = CreateDynamicObject(18728, x, y, z-2.8, 0, 0, 90);	

	if(pData[playerid][pJail] > 0)
		return Error(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");

	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

    SendFactionMessage(1, COLOR_RADIO, "[FLARE ALERT] Officer %s has requesting a backup near {fc0303}%s{fc0303}", ReturnName(playerid), GetLocation(x, y, z));
	foreach(new ii : Player)
	{
		if(pData[ii][pFaction] == 1)
		{
			SetPlayerRaceCheckpoint(ii, 2, x, y, z, 0.0, 0.0, 0.0, 3.5);
		}
	}

	return 1;
}


CMD:destroyflare(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi police officer.");
		
	if(IsValidDynamicObject(pData[playerid][pFlare]))
		DestroyDynamicObject(pData[playerid][pFlare]);
	Info(playerid, "Your flare is deleted.");
	return 1;
}

alias:detain("undetain")
CMD:detain(playerid, params[])
{
    new vehicleid = GetNearestVehicleToPlayer(playerid, 3.0, false), otherid;

    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi police officer.");
	
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/detain [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "That player is disconnected.");

    if(otherid == playerid)
        return Error(playerid, "You cannot detained yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(!pData[otherid][pCuffed])
        return Error(playerid, "The player is not cuffed at the moment.");

    if(vehicleid == INVALID_VEHICLE_ID)
        return Error(playerid, "You are not near any vehicle.");

    if(GetVehicleMaxSeats(vehicleid) < 2)
        return Error(playerid, "You can't detain that player in this vehicle.");

    if(IsPlayerInVehicle(otherid, vehicleid))
    {
        TogglePlayerControllable(otherid, 1);

        RemoveFromVehicle(otherid);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens the door and pulls %s out the vehicle.", ReturnName(playerid), ReturnName(otherid));
    }
    else
    {
        new seatid = GetAvailableSeat(vehicleid, 2);

        if(seatid == -1)
            return Error(playerid, "There are no more seats remaining.");

        new
            string[64];

        format(string, sizeof(string), "You've been ~r~detained~w~ by %s.", ReturnName(playerid));
        TogglePlayerControllable(otherid, 0);

        //StopDragging(otherid);
        PutPlayerInVehicle(otherid, vehicleid, seatid);

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens the door and places %s into the vehicle.", ReturnName(playerid), ReturnName(otherid));
        InfoTD_MSG(otherid, 3500, string);
    }
    return 1;
}

CMD:cuff(playerid, params[])
{
	if(pData[playerid][pFaction] == 1 || pData[playerid][pFaction] == 2)
	{
		if(!pData[playerid][pOnDuty])
			return Error(playerid, "You must on duty to use cuff.");
		
		new otherid;
		if(sscanf(params, "u", otherid))
			return SyntaxMsg(playerid, "/cuff [playerid/PartOfName]");

		if(otherid == INVALID_PLAYER_ID)
			return Error(playerid, "That player is disconnected.");

		if(otherid == playerid)
			return Error(playerid, "You cannot handcuff yourself.");

		if(!NearPlayer(playerid, otherid, 5.0))
			return Error(playerid, "You must be near this player.");

		if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
			return Error(playerid, "The player must be onfoot before you can cuff them.");

		if(pData[otherid][pCuffed])
			return Error(playerid, "The player is already cuffed at the moment.");

		pData[otherid][pCuffed] = 1;
		SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);
		
		new mstr[128];
		format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", ReturnName(playerid));
		InfoTD_MSG(otherid, 3500, mstr);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s tightens a pair of handcuffs on %s's wrists.", ReturnName(playerid), ReturnName(otherid));
	}
	else
	{
		return Error(playerid, "You not police/gov.");
	}
    return 1;
}

CMD:uncuff(playerid, params[])
{
	if(pData[playerid][pFaction] == 1 || pData[playerid][pFaction] == 2)
	{
	
		if(!pData[playerid][pOnDuty])
			return Error(playerid, "You must on duty to use cuff.");
		
		new otherid;
		if(sscanf(params, "u", otherid))
			return SyntaxMsg(playerid, "/uncuff [playerid/PartOfName]");

		if(otherid == INVALID_PLAYER_ID)
			return Error(playerid, "That player is disconnected.");

		if(otherid == playerid)
			return Error(playerid, "You cannot uncuff yourself.");

		if(!NearPlayer(playerid, otherid, 5.0))
			return Error(playerid, "You must be near this player.");

		if(!pData[otherid][pCuffed])
			return Error(playerid, "The player is not cuffed at the moment.");

		static
			string[64];

		pData[otherid][pCuffed] = 0;
		SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

		format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", ReturnName(playerid));
		InfoTD_MSG(otherid, 3500, string);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s loosens the pair of handcuffs on %s's wrists.", ReturnName(playerid), ReturnName(otherid));
	}
	else
	{
		return Error(playerid, "You not police/gov.");
	}
    return 1;
}

CMD:release(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi police officer.");
	
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1550.0549,-1692.4110,-10.8487))
		return Error(playerid, "You must be near an arrest point.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SyntaxMsg(playerid, "/release <ID/Name>");
	    return true;
	}

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");
	
	if(otherid == playerid)
		return Error(playerid, "You cant release yourself!");

	if(pData[otherid][pArrest] == 0)
	    return Error(playerid, "The player isn't in arrest!");

	pData[otherid][pArrest] = 0;
	pData[otherid][pArrestTime] = 0;
	pData[otherid][pHunger] = 100;
	pData[otherid][pEnergy] = 100;
	pData[otherid][pBladder] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPositionEx(otherid, 1541.0924,-1675.4509,13.5519,90.7043, 2000);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAllEx(COLOR_BLUE, "[PRISON]"WHITE_E"Officer %s telah membebaskan %s dari penjara.", ReturnName(playerid), ReturnName(otherid));
	new str[150];
	format(str,sizeof(str),"[FACTION]: %s membebaskan %s dari penjara!", GetRPName(playerid), GetRPName(otherid));
	LogServer("Faction", str);
	return true;
}


CMD:arrest(playerid, params[])
{
    static
        denda,
		cellid,
        times,
		otherid;

    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi police officer.");
		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1550.0549,-1692.4110,-10.8487))
		return Error(playerid, "You must be near an arrest point.");

    if(sscanf(params, "uddd", otherid, cellid, times, denda))
        return SyntaxMsg(playerid, "/arrest [playerid/PartOfName] [cell id] [minutes] [denda]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "The player is disconnected or not near you.");
		
	/*if(otherid == playerid)
		return Error(playerid, "You cant arrest yourself!");*/

    if(times < 1 || times > 600)
        return Error(playerid, "The specified time can't be below 1 or above 600.");
		
	if(cellid < 1 || cellid > 4)
        return Error(playerid, "The specified cell id can't be below 1 or above 4.");
		
	if(denda < 100 || denda > 20000)
        return Error(playerid, "The specified denda can't be below 100 or above 20,000.");

    /*if(!IsPlayerNearArrest(playerid))
        return Error(playerid, "You must be near an arrest point.");*/

	GivePlayerMoneyEx(otherid, -denda);
    pData[otherid][pArrest] = cellid;
    pData[otherid][pArrestTime] = times * 60;
	pData[otherid][pHunger] = 1000;
	pData[otherid][pEnergy] = 1000;
	pData[otherid][pBladder] = 0;
	Server_AddBankPd(denda);
	
	SetPlayerArrest(otherid, cellid);

 	SendFactionMessage(1, COLOR_RADIO, "[PRISON]"WHITE_E" %s telah ditangkap dan dipenjarakan oleh polisi selama %d hari dengan denda "GREEN_E"%s.", ReturnName(otherid), times, FormatMoney(denda)); 
    // SendClientMessageToAllEx(COLOR_BLUE, "[PRISON]"WHITE_E" %s telah ditangkap dan dipenjarakan oleh polisi selama %d hari dengan denda "GREEN_E"%s.", ReturnName(otherid), times, FormatMoney(denda));
    new str[150];
	format(str,sizeof(str),"[FACTION]: %s mempenjarakan %s selama %d hari dan denda %s!", GetRPName(playerid), GetRPName(otherid), times, FormatMoney(denda));
	LogServer("Faction", str);
	return 1;
}

CMD:getloc(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
		return Error(playerid, "Kamu harus menjadi police officer.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SyntaxMsg(playerid, "/getloc <ID/Name>");
	    return true;
	}

	if(pData[playerid][pSuspectTimer] > 1)
		return Error(playerid, "Anda harus menunggu %d detik untuk melanjutkan GetLoc",pData[playerid][pSuspectTimer]);

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");
	
	if(otherid == playerid)
		return Error(playerid, "You cant getloc yourself!");

	if(pData[otherid][pPhone] == 0) return Error(playerid, "Player tersebut belum memiliki Ponsel");
	if(pData[otherid][pPhoneStatus] == 0) return Error(playerid, "Tidak dapat mendeteksi lokasi, Ponsel tersebut yang dituju sedang Offline");

    new zone[MAX_ZONE_NAME];
	GetPlayer3DZone(otherid, zone, sizeof(zone));
	new Float:sX, Float:sY, Float:sZ;
	GetPlayerPos(otherid, sX, sY, sZ);
	SetPlayerCheckpoint(playerid, sX, sY, sZ, 5.0);
	pData[playerid][pSuspectTimer] = 5;
	Info(playerid, "Target Nama : %s", pData[otherid][pName]);
	Info(playerid, "Target Akun Twitter : %s", pData[otherid][pTwittername]);
	Info(playerid, "Lokasi : %s", zone);
	Info(playerid, "Nomer Telepon : %d", pData[otherid][pPhone]);
	return 1;
}

/*CMD:trackph1(playerid, params[])
{
    if(pData[playerid][pPhone] == 0) return Error(playerid, "You dont have phone!");
	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "You cant do that in this time.");

	new ph;
	if(sscanf(params, "d", ph))
	{
		SyntaxMsg(playerid, "/shareloc [phone number]");
		return 1;
	}
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii) || pData[playerid][pPhoneOff] == 1) return Error(playerid, "This number is not actived!");

			Servers(playerid, "Send Your location to phone number  %d", ph);
			SendClientMessage(ii, COLOR_WHITE, "Anda Dikirimi Lokasi Oleh Seseorang");

			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s mengirimkan lokasinya kepada seseorang", ReturnName(playerid));

			
			return 1;
		}
	}
	return 1;
}

CMD:trackph(playerid, params[])
{
    new number;  // Variabel untuk nomor telepon yang dimasukkan (tipe int)
    
    // Mengambil parameter nomor telepon dari pemain (mengubah string ke int)
    if (sscanf(params, "d", number) != 1) {
        SendClientMessage(playerid, COLOR_RED, "Please provide a valid phone number.");
        return 1;
    }

    // Validasi apakah nomor telepon dimasukkan dengan benar
    if (number <= 0) {
        SendClientMessage(playerid, COLOR_RED, "Please provide a valid phone number.");
        return 1;
    }

    // Debugging: Cek nomor yang dimasukkan oleh pemain
    printf("Player %d is searching for phone number: %d", playerid, number);

    // Menelusuri semua pemain yang terhubung
    foreach (new ii : Player) {
        // Debugging: Cek nomor telepon setiap pemain
        printf("Checking player %d, Phone: %d", ii, pData[ii][pPhone]);

        // Memeriksa apakah nomor telepon pemain yang dicari sesuai dengan nomor yang dimasukkan
        if (pData[ii][pPhone] == number) {
            // Jika pemain ditemukan, periksa apakah dia terhubung dan login
            if (pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) {
                SendClientMessage(playerid, COLOR_RED, "This number is not active!");
                return 1;
            }

            // Jika pemain valid, beri informasi kepada pemain yang mencari
            SendClientMessage(playerid, COLOR_GREEN, "Tracking phone number %d, please wait...", number);

            // Set timer untuk memulai proses tracking
            SetTimerEx("trackph", random(100) + 1, false, "iid", playerid, ii, number);

            return 1;
        }
    }

    // Jika nomor tidak ditemukan
    SendClientMessage(playerid, COLOR_RED, "Phone number not found.");
    return 1;
}*/

/*CMD:su(playerid, params[])
{
	new crime[64];
	if(sscanf(params, "us[64]", otherid, crime)) return SyntaxMsg(playerid, "(/su)spect [playerid] [crime discription]");

	if (pData[playerid][pFaction] == 1 || pData[playerid][pFaction] == 2)
	{
		if(IsPlayerConnected(otherid))
		{
			if(otherid != INVALID_PLAYER_ID)
			{
				if(otherid == playerid)
				{
					Error(playerid, COLOR_GREY, "Kamu tidak dapat mensuspek dirimu!");
					return 1;
				}
				if(pData[playerid][pFaction] > 0)
				{
					Error(playerid, COLOR_GREY, "Tidak dapat mensuspek fraksi!");
					return 1;
				}
				WantedPoints[otherid] += 1;
				pData[playerid][pSuspect] = 1;
				SetPlayerCriminal(otherid,playerid, crime);
				return 1;
			}
		}
		else
		{
			Error(playerid, "Invalid player specified.");
			return 1;
		}
	}
	else
	{
		Error(playerid, "   You are not a Cop/Gov!");
	}
	return 1;
}*/

CMD:ticket(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
			return Error(playerid, "Kamu harus menjadi sapd officer.");
	
	new vehid, ticket;
	if(sscanf(params, "dd", vehid, ticket))
		return SyntaxMsg(playerid, "/ticket [vehid] [ammount] | /checkveh - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
	
	if(ticket < 0 || ticket > 500)
		return Error(playerid, "Ammount max of ticket is $1 - $500!");
	
	new nearid = GetNearestVehicleToPlayer(playerid, 5.0, false);
	
	foreach(new ii : PVehicles)
	{
		if(vehid == pvData[ii][cVeh])
		{
			if(vehid == nearid)
			{
				if(pvData[ii][cTicket] >= 2000)
					return Error(playerid, "Kendaraan ini sudah mempunyai terlalu banyak ticket!");
					
				pvData[ii][cTicket] += ticket;
				Info(playerid, "Anda telah menilang kendaraan %s(id: %d) dengan denda sejumlah "RED_E"%s", GetVehicleName(vehid), vehid, FormatMoney(ticket));
				new str[150];
				format(str,sizeof(str),"[FACTION]: %s menilang kendaraan %s(id: %d) dengan denda %s!", GetRPName(playerid), GetVehicleName(vehid), vehid, FormatMoney(ticket));
				LogServer("Faction", str);
				return 1;
			}
			else return Error(playerid, "Anda harus berada dekat dengan kendaraan tersebut!");
		}
	}
	return 1;
}

CMD:checkveh(playerid, params[])
{
	if(pData[playerid][pFaction] == 1 || pData[playerid][pAdmin] > 0)
	{
		static carid = -1;
		new vehicleid = GetNearestVehicleToPlayer(playerid, 3.0, false);

		if(vehicleid == INVALID_VEHICLE_ID || !IsValidVehicle(vehicleid))
			return Error(playerid, "You not in near any vehicles.");
		
		if((carid = Vehicle_Nearest(playerid)) != -1)
		{
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE reg_id='%d'", pvData[carid][cOwner]);
			mysql_query(g_SQL, query);
			new rows = cache_num_rows();
			if(rows) 
			{
				new owner[32];
				cache_get_value_index(0, 0, owner);
				
				if(strcmp(pvData[carid][cPlate], "NoHave"))
				{
					Info(playerid, "ID: %d | Model: %s | Owner: %s | Plate: %s | Plate Time: %s", vehicleid, GetVehicleName(vehicleid), owner, pvData[carid][cPlate], ReturnTimelapse(gettime(), pvData[carid][cPlateTime]));
				}
				else
				{
					Info(playerid, "ID: %d | Model: %s | Owner: %s | Plate: None | Plate Time: None", vehicleid, GetVehicleName(vehicleid), owner);
				}
			}
			else
			{
				Error(playerid, "This vehicle no owned found!");
				return 1;
			}
		}
		else
		{
			Error(playerid, "You are not in near owned private vehicle.");
			return 1;
		}	
	}
	else Error(playerid, "You don't have an access for that command.");
		
	return 1;
}
CMD:sitauang(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi sapd officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "You must be 1 rank level!");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SyntaxMsg(playerid, "/sitauang <ID/Name> | Melenyapkan uang merah");
	    return true;
	}

	if(!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

 	if(!NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
		
	pData[otherid][pRedMoney] = 0;
	UpdatePlayerData(otherid);

	Info(playerid, "Anda telah mengambil semua uang merah milik %s.", ReturnName(otherid));
	Info(otherid, "Officer %s telah mengambil semua uang merah milik anda", ReturnName(playerid));
	return 1;
}
CMD:takeschematic(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi sapd officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "You must be 1 rank level!");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SyntaxMsg(playerid, "/takeschematic <ID/Name> | Melenyapkan schematic");
	    return true;
	}

	if(!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

 	if(!NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
		
	pData[otherid][pScheSLC] = 0;
	pData[otherid][pScheColt] = 0;
	pData[otherid][pScheSg] = 0;
	pData[otherid][pScheDe] = 0;
	pData[otherid][pScheRiffle] = 0;
	pData[otherid][pScheUzi] = 0;
	pData[otherid][pScheAk] = 0;
	Info(playerid, "Anda telah mengambil semua schematic milik %s.", ReturnName(otherid));
	Info(otherid, "Officer %s telah mengambil semua schematic milik anda", ReturnName(playerid));
	return 1;
}
CMD:takedrugs(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi sapd officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "You must be 1 rank level!");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    SyntaxMsg(playerid, "/takedrugs <ID/Name> | Melenyapkan narkoba");
	    return true;
	}

	if(!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

 	if(!NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
		
	pData[otherid][pMarijuana] = 0;
	pData[otherid][pHeroin] = 0;
	pData[otherid][pPeyote] = 0;
	pData[otherid][pShrooms] = 0;
	pData[otherid][pXanax] = 0;
	pData[otherid][pSabuReady] = 0;
	pData[otherid][pSabuType] = 0;
	Info(playerid, "Anda telah mengambil semua narkoba milik %s.", ReturnName(otherid));
	Info(otherid, "Officer %s telah mengambil semua narkoba milik anda", ReturnName(playerid));
	return 1;
}
CMD:takelic(playerid, params[])
{
    new otherid, type;

    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "You must be part of the licensing authority.");

    if(sscanf(params, "ud", otherid, type))
        return SyntaxMsg(playerid, "/takelic <ID/ Name> <type>");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player is not online or name not found!");

	if(!NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");	

    if(type < 1 || type > 4)
        return Error(playerid, "Invalid license type. Available types: 1 (truckerLow), 2 (truckerHeavy), 3 (weapon), 4 (flying).");
	new query[256];
    switch(type)
    {
        case 1:
		{
            pData[otherid][pTruckerLowLicense] = 0;
			pData[otherid][pTlowTime] = 0;
			Info(playerid, "Anda telah menilang Driving Low Truck License milik %s.", ReturnName(otherid));
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} Officer %s telah menilang Driving Low Truck License  milik anda", pData[otherid][pName]);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET ltruck = %d WHERE reg_id = %d", pData[otherid][pTruckerLowLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		case 2:
		{
            pData[otherid][pTruckerHeavyLicense] = 0;
			pData[otherid][pTheavTime] = 0;
            // SetTimerEx("RevokeLicense", duration * 24 * 60 * 60, false, "ddi", playerid, otherid, 2);
			Info(playerid, "Anda telah menilang Driving Heavy Truck License milik %s.", ReturnName(otherid));
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} Officer %s telah menilang Heavy Truck Driving License milik anda", pData[otherid][pName]);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET htruck = %d WHERE reg_id = %d", pData[otherid][pTruckerHeavyLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
	    case 3:
		{
            pData[otherid][pWeaponLicense] = 0;
			pData[otherid][pWeapLic] = 0;
            // SetTimerEx("RevokeLicense", duration * 24 * 60 * 60, false, "ddi", playerid, otherid, 3);
			Info(playerid, "Anda telah menilang Weapon License milik %s.", ReturnName(otherid));
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} Officer %s telah menilang Weapon Licenses milik anda", pData[otherid][pName]);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET weaplic = %d WHERE reg_id = %d", pData[otherid][pWeaponLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
	    case 4:
		{
            pData[otherid][pFlyingLicense] = 0;
			pData[otherid][pFlyLic] = 0;
            // SetTimerEx("RevokeLicense", duration * 24 * 60 * 60, false, "ddi", playerid, otherid, 4);
			Info(playerid, "Anda telah menilang Flying License milik %s.", ReturnName(otherid));
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} Officer %s telah menilang Flying License milik anda.", pData[otherid][pName]);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET flylic = %d WHERE reg_id = %d", pData[otherid][pFlyingLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);		
		}
		default:
            return Error(playerid, "Invalid license type.");
    }

    return 1;
}
// CMD:takedl(playerid, params[])
// {
// 	if(pData[playerid][pFaction] != 1)
//         return Error(playerid, "Kamu harus menjadi sapd officer.");
// 	if(pData[playerid][pFactionRank] < 2)
// 		return Error(playerid, "You must be 2 rank level!");

// 	new otherid;
// 	if(sscanf(params, "u", otherid))
// 	{
// 	    SyntaxMsg(playerid, "/takedl <ID/Name> | Tilang Driving License(SIM)");
// 	    return true;
// 	}

// 	if(!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
//         return Error(playerid, "Player tersebut belum masuk!");

//  	if(!NearPlayer(playerid, otherid, 4.0))
//         return Error(playerid, "The specified player is disconnected or not near you.");
		
// 	pData[otherid][pDriveLic] = 0;
// 	pData[otherid][pDriveLicTime] = 0;
// 	Info(playerid, "Anda telah menilang Driving License milik %s.", ReturnName(otherid));
// 	Info(otherid, "Officer %s telah menilang Driving License milik anda", ReturnName(playerid));
// 	return 1;
// }

//SAGS Commands
CMD:sagsonline(playerid, params[])
{
	if(pData[playerid][pFaction] != 2)
        return Error(playerid, "Kamu harus menjadi sags officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");
		
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 2)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty, pData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAGS Online", lstr, "Close", "");
	return 1;
}

CMD:checkcitymoney(playerid, params)
{
	if(pData[playerid][pFaction] != 2)
        return Error(playerid, "Kamu harus menjadi sags officer.");
	if(pData[playerid][pFactionRank] < 12)
		return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");

	new lstr[300];
	format(lstr, sizeof(lstr), "City Money: {3BBD44}%s", FormatMoney(ServerMoney));
	ShowPlayerDialog(playerid, DIALOG_SERVERMONEY, DIALOG_STYLE_MSGBOX, "Fountain Daily City Money", lstr, "Manage", "Close");
	return 1;
}

CMD:fcpd(playerid, params)
{
	if(!IsPlayerInRangeOfPoint(playerid,3.0,1580.0330,-1667.2471,20061.9746)) return Error(playerid, "Kamu tidak berada di bank SAPD");
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi SAPD officer.");
	// if(pData[playerid][pFactionRank] < 12)
	// 	return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");

	new lstr[300];
	format(lstr, sizeof(lstr), "Bank of SAPD: {3BBD44}%s", FormatMoney(BankPd));
	ShowPlayerDialog(playerid, DIALOG_BANKPD, DIALOG_STYLE_MSGBOX, "Fountain Daily SAPD Bank", lstr, "Manage", "Close");
	return 1;
}
CMD:fcsan(playerid, params)
{
	if(!IsPlayerInRangeOfPoint(playerid,3.0,1958.4419,1361.8083,8001.0859)) return Error(playerid, "Kamu tidak berada di bank SANA");
	if(pData[playerid][pFaction] != 4)
        return Error(playerid, "Kamu harus menjadi SAN officer.");
	// if(pData[playerid][pFactionRank] < 12)
	// 	return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");

	new lstr[300];
	format(lstr, sizeof(lstr), "Bank of SAN: {3BBD44}%s", FormatMoney(BankSan));
	ShowPlayerDialog(playerid, DIALOG_BANKSAN, DIALOG_STYLE_MSGBOX, "Fountain Daily SAN Bank", lstr, "Manage", "Close");
	return 1;
}
CMD:fcmd(playerid, params)
{
	if(!IsPlayerInRangeOfPoint(playerid,3.0,1135.9987,-1296.0098,1028.2650)) return Error(playerid, "Kamu tidak berada di bank SAMD");
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi SAMD.");
	// if(pData[playerid][pFactionRank] < 12)
	// 	return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");

	new lstr[300];
	format(lstr, sizeof(lstr), "Bank of SAMD: {3BBD44}%s", FormatMoney(BankMd));
	ShowPlayerDialog(playerid, DIALOG_BANKMD, DIALOG_STYLE_MSGBOX, "Fountain Daily SAMD Bank", lstr, "Manage", "Close");
	return 1;
}

CMD:givelic(playerid, params[])
{
    new otherid, type, duration;

    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "You must be part of the licensing authority.");

    if(sscanf(params, "udi", otherid, type, duration))
        return SyntaxMsg(playerid, "/givelic <ID/ Name> <type> <duration>");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player is not online or name not found!");

	if(!NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");

    if(duration < 1 || duration > 90)
        return Error(playerid, "Duration must be between 1 and 90 days.");

    if(type < 1 || type > 4)
        return Error(playerid, "Invalid license type. Available types: 1 (truckerLow), 2 (truckerHeavy), 3 (weapon), 4 (flying).");
	new query[256];
    switch(type)
    {
        case 1:
		{
            pData[otherid][pTruckerLowLicense] = 1;
			pData[otherid][pTlowTime] = gettime() + (duration * 86400);
			SendClientMessageEx(playerid, COLOR_BLUE, "[LICENSE]{ffffff}You gives a Low Truck Driver's License to %s for %d days.", pData[otherid][pName], duration);
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} officer %s gives you a Low Truck Driver's License for %d days.", pData[playerid][pName], duration);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET ltruck = %d WHERE reg_id = %d", pData[otherid][pTruckerLowLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
		case 2:
		{
            pData[otherid][pTruckerHeavyLicense] = 1;
			pData[otherid][pTheavTime] = gettime() + (duration * 86400);
			SendClientMessageEx(playerid, COLOR_BLUE, "[LICENSE]{ffffff}You gives a Heavy Truck Driver's License to %s for %d days.", pData[otherid][pName], duration);
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff}officer %s gives you a Heavy Truck Driver's License for %d days.", pData[playerid][pName], duration);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET htruck = %d WHERE reg_id = %d", pData[otherid][pTruckerHeavyLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
	    case 3:
		{
            pData[otherid][pWeaponLicense] = 1;
			pData[otherid][pWeapLic] = gettime() + (duration * 86400);
			SendClientMessageEx(playerid, COLOR_BLUE, "[LICENSE]{ffffff}You gives a Weapon's License License to %s for %d days.", pData[otherid][pName], duration);
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} officer %s gives you a Weapon's License for %d days.", pData[playerid][pName], duration);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET weaplic = %d WHERE reg_id = %d", pData[otherid][pWeaponLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);
		}
	    case 4:
		{
            pData[otherid][pFlyingLicense] = 1;
			pData[otherid][pFlyLic] = gettime() + (duration * 86400);
			SendClientMessageEx(playerid, COLOR_BLUE, "[LICENSE]{ffffff}You gives a Flying Driver's License to %s for %d days.", pData[otherid][pName], duration);
            SendClientMessageEx(otherid, COLOR_BLUE, "[LICENSE]{ffffff} officer %s gives you a Flying Driver's License for %d days.", pData[playerid][pName], duration);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET flylic = %d WHERE reg_id = %d", pData[otherid][pFlyingLicense], pData[otherid][pID]);
	    	mysql_tquery(g_SQL, query);		
		}
		default:
            return Error(playerid, "Invalid license type.");
    }

    return 1;
}

// function RevokeLicense(playerid, otherid, type)
// {
//     switch(type)
//     {
//         case 1:
// 		{
//             pData[otherid][pTruckerLowLicense] = 0;
//             SendClientMessageEx(otherid, COLOR_YELLOW, "Your Trucker Low License has expired.");
// 		}
//         case 2:
// 		{
//             pData[otherid][pTruckerHeavyLicense] = 0;
//             SendClientMessageEx(otherid, COLOR_YELLOW, "Your Trucker Heavy License has expired.");
// 		}
//         case 3:
// 		{
//             pData[otherid][pWeaponLicense] = 0;
//             SendClientMessageEx(otherid, COLOR_YELLOW, "Your Weapon License has expired.");
// 		}
// 		case 4:
//         {
// 		    pData[otherid][pFlyingLicense] = 0;
//             SendClientMessageEx(otherid, COLOR_YELLOW, "Your Flying License has expired.");
// 		}
// 		default:
//             return 0;
//     }
    
//     return 1;
// }



//SAMD Commands
CMD:givebpjs(playerid, params[])
{
	new otherid;
    if(pData[playerid][pFaction] != 3)
        return Error(playerid, "You must be part of a medical faction.");
	if(sscanf(params, "u", otherid))
		return SyntaxMsg(playerid, "/givebpjs <ID/ Name>");
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	new sext[40], mstr[128];
	new married[20];
	strmid(married, pData[otherid][pMarriedTo], 0, strlen(pData[otherid][pMarriedTo]), 255);
	if(pData[otherid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nKota: Fountain Daily City\nTgl Lahir: %s\nJenis Kelamin: %s\nStatus: %s\nExpired 20days", pData[otherid][pName], pData[otherid][pAge], sext, married);
	ShowPlayerDialog(otherid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "BPJS", mstr, "Tutup", "");
	pData[otherid][pBpjs] = 1;
	pData[otherid][pBpjsTime] = gettime() + (20 * 86400);
	SendFactionMessage(3, COLOR_PINK2, "[BPJS LOGS] "WHITE_E"* %s Telah Memberikan BPJS Kepada %s Expire 20 Hari.", ReturnName(playerid), ReturnName(otherid));
	return 1;
}
// CMD:showbpjs(playerid, params[])
// {
// 	if(pData[playerid][pBpjs] == 0) return Error(playerid, "Anda tidak memiliki BPJS.");
// 	new sext[40];
// 	new married[20];
// 	strmid(married, pData[playerid][pMarriedTo], 0, strlen(pData[playerid][pMarriedTo]), 255);
// 	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
// 	SendNearbyMessage(playerid, 20.0, COLOR_PINK2, "Nama: %s\nKota: Fountain Daily City\nTgl Lahir: %s\nJenis Kelamin: %s\nStatus: %s\nExpire: %s.", pData[playerid][pName], pData[playerid][pAge], sext, married, ReturnTimelapse(gettime(), pData[playerid][pBpjsTime]));
// 	return 1;
// }
CMD:showbpjs(playerid, params[])
{
	if(pData[playerid][pBpjs] == 0) return Error(playerid, "Anda tidak memiliki BPJS.");
	new otherid;
	if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/showbpjs [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");
	new sext[40];
	new married[20];
	strmid(married, pData[playerid][pMarriedTo], 0, strlen(pData[playerid][pMarriedTo]), 255);
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendClientMessageEx(otherid, COLOR_PINK2, "[Health Insurance Information].");
	SendClientMessageEx(otherid, COLOR_PINK2, "Name: {ffffff}%s.", pData[playerid][pName]);
	SendClientMessageEx(otherid, COLOR_PINK2, "Brithday: {ffffff}%s.",pData[playerid][pAge]);	
	SendClientMessageEx(otherid, COLOR_PINK2, "Status: {ffffff}%s.",married);
	SendClientMessageEx(otherid, COLOR_PINK2, "Expire: {ffffff}%s.", ReturnTimelapse(gettime(), pData[playerid][pBpjsTime]));
	SendClientMessageEx(otherid, COLOR_PINK2, "Gender: {ffffff}%s.", sext);
	Info(playerid, "You show your Health Insurance to {ffff00}%s.", ReturnName(otherid));
	return 1;
}
CMD:loadinjured(playerid, params[])
{
    static
        seatid,
		otherid;

    if(pData[playerid][pFaction] != 3)
        return Error(playerid, "You must be part of a medical faction.");

    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/loadinjured [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 10.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "You can't load yourself into an ambulance.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "That player is not injured.");
	
	if(!IsPlayerInAnyVehicle(playerid))
	{
	    Error(playerid, "You must be in a Ambulance to load patient!");
	    return true;
	}
		
	new i = GetPlayerVehicleID(playerid);
    if(GetVehicleModel(i) == 416)
    {
        seatid = GetAvailableSeat(i, 2);

        if(seatid == -1)
            return Error(playerid, "There is no room for the patient.");

        ClearAnimations(otherid);
        pData[otherid][pInjured] = 2;

        PutPlayerInVehicle(otherid, i, seatid);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens up the ambulance and loads %s on the stretcher.", ReturnName(playerid), ReturnName(otherid));

        TogglePlayerControllable(otherid, 0);
        // SetPlayerHealth(otherid, 0.0);
        Info(otherid, "You're injured ~r~now you're on ambulance.");
        return 1;
    }
    else Error(playerid, "You must be in an ambulance.");
    return 1;
}

CMD:dropinjured(playerid, params[])
{

    if(pData[playerid][pFaction] != 3)
        return Error(playerid, "You must be part of a medical faction.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/dropinjured [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid)))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "You can't deliver yourself to the hospital.");

    if(pData[otherid][pInjured] == 1)
        return Error(playerid, "That player is not injured.");

    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1142.38, -1330.74, 13.62))
    {
		RemovePlayerFromVehicle(otherid);
		// pData[otherid][pHospital] = 1;
		// pData[otherid][pHospitalTime] = 0;
		pData[otherid][pInjured] = 2;
		// ResetPlayerWeaponsEx(otherid);
		SetPlayerPos(otherid, 1142.38, -1330.74, 13.62);
        Info(playerid, "You have delivered %s to the hospital.", ReturnName(otherid));
        Info(otherid, "You have recovered at the nearest hospital by officer %s.", ReturnName(playerid));
    }
    else Error(playerid, "You must be near a hospital deliver location.");
    return 1;
}

CMD:samdonline(playerid, params[])
{
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");
		
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 3)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty, pData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SAMD Online", lstr, "Close", "");
	return 1;
}

CMD:ems(playerid, params[])
{
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	
	foreach(new ii : Player)
	{
		if(pData[ii][pInjured])
		{
			SendClientMessageEx(playerid, COLOR_PINK2, "EMS Player: "WHITE_E"%s(id: %d)", ReturnName(ii), ii);
		}
	}
	Info(playerid, "/findems [id] to search injured player!");
	return 1;
}

CMD:findems(playerid, params[])
{
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
		
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/findems [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player is not connected");
	
	if(otherid == playerid)
        return Error(playerid, "You can't find yourself.");
	
	if(!pData[otherid][pInjured]) return Error(playerid, "You can't find a player that's not injured.");
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(otherid, x, y, z);
	SetPlayerCheckpoint(playerid, x, y, x, 4.0);
	pData[playerid][pFindEms] = otherid;
	Info(otherid, "SAMD Officer %s sedang menuju ke lokasi anda. harap tunggu!", ReturnName(playerid));
	return 1;
}

CMD:rescue(playerid, params[])
{
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	
	if(pData[playerid][pMedkit] < 1) return Error(playerid, "You need medkit.");
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/rescue [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "You can't rescue yourself.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "That player is not injured.");
	
	pData[playerid][pMedkit]--;
	
	SetPlayerHealthEx(otherid, 50.0);
    pData[otherid][pInjured] = 0;
	pData[otherid][pHospital] = 0;
	pData[playerid][pBladder] = 0;
	pData[otherid][pSick] = 0;
	HideTdDeath(otherid);
	UpdateDynamic3DTextLabelText(pData[otherid][pInjuredLabel], COLOR_ORANGE, "");
    ClearAnimations(otherid);
	ApplyAnimation(otherid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
	
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has rescuered %s with medkit tools.", ReturnName(playerid), ReturnName(otherid));
    Info(otherid, "Officer %s has rescue your character.", ReturnName(playerid));
	return 1;
}

CMD:sellobat(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1430.44, 2.16,1000.92)) return Error(playerid, "You're not near in sell places.");

	if(pData[playerid][pObat] < 1)
		return Error(playerid, "Anda tidak memiliki Obat");

	ObatMyr += 1;
	pData[playerid][pObat] -= 1;
	Servers(playerid, "Anda berhasil menjual 1 Obat anda!");
	Server_Save();
	return 1;
}

// CMD:mix(playerid, params[])
// {
// 	if(pData[playerid][pFaction] != 3)
//         return Error(playerid, "Kamu harus menjadi samd officer.");

//     if(IsPlayerInRangeOfPoint(playerid, 2.0, 1352.7783, 1546.4692, 23223.0859))
//     {
//     	if(pData[playerid][pMedicine] < 4)
//     		return Error(playerid, "Anda harus memiliki 4 Medicine & 1 Marijuana");

//     	if(pData[playerid][pMarijuana] < 1)
//     		return Error(playerid, "Anda harus memiliki 4 Medicine & 1 Marijuana");

//     	TogglePlayerControllable(playerid, 0);
//     	Info(playerid, "Anda sedang memproduksi bahan makanan dengan 40 food!");
//     	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
// 		pData[playerid][pProductingStatus] = 1;
//     	pData[playerid][pProducting] = SetTimerEx("CreateObat", 1000, true, "id", playerid, 1);
//     	PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meracik...");
//     	PlayerTextDrawShow(playerid, ActiveTD[playerid]);
//     	ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
// 	}
// 	return 1;
// }

CMD:salve(playerid, params[])
{
	new Float:health;
	health = GetPlayerHealth(playerid, health);
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	
	if(pData[playerid][pMedicine] < 1) return Error(playerid, "Kamu butuh Medicine.");
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/salve [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa mensalve dirimu sendiri.");

    if(pData[otherid][pSick] == 0)
        return Error(playerid, "Player itu tidak sakit.");
	
	pData[playerid][pMedicine]--;
	
	//SetPlayerHealthEx(otherid, 50.0);
    //pData[otherid][pInjured] = 0;
	//pData[otherid][pHospital] = 0;
	SetPlayerHealth(playerid, health+50);
	pData[otherid][pHunger] += 20;
	pData[otherid][pEnergy] += 20;
	pData[otherid][pSick] = 0;
	pData[otherid][pSickTime] = 0;
    ClearAnimations(otherid);
	ApplyAnimation(otherid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
	SetPlayerDrunkLevel(otherid, 0);
	
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has given medicine to %s with the right hand.", ReturnName(playerid), ReturnName(otherid));
    Info(otherid, "Officer %s has resalve your sick character.", ReturnName(playerid));
	return 1;
}

CMD:healbone(playerid, params[])
{
	new Float:health;
	health = GetPlayerHealth(playerid, health);
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	
	if(pData[playerid][pMedicine] < 1) return Error(playerid, "Kamu butuh Medicine.");
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/healbone [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memperbaiki kesehatan tulang dirimu sendiri.");
	
	pData[playerid][pMedicine]--;
	
	//SetPlayerHealthEx(otherid, 50.0);
    //pData[otherid][pInjured] = 0;
	//pData[otherid][pHospital] = 0;
	SetPlayerHealth(playerid, health+50);
	pData[otherid][pHead] = 100;
	pData[otherid][pPerut] = 100;
	pData[otherid][pRHand] = 100;
	pData[otherid][pLHand] = 100;
	pData[otherid][pRFoot] = 100;
	pData[otherid][pLFoot] = 100;
	pData[otherid][pSickTime] = 0;
    ClearAnimations(otherid);
	SetPlayerDrunkLevel(otherid, 0);
	
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has given medicine to %s with the right hand.", ReturnName(playerid), ReturnName(otherid));
    Info(otherid, "Officer %s has resalve your sick character.", ReturnName(playerid));
	return 1;
}



CMD:revive(playerid, params[])
{
			
	new otherid;
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
		
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/revive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(!pData[otherid][pInjured])
        return Error(playerid, "Tidak bisa revive karena tidak injured.");

	if(otherid == playerid)
        return Error(playerid, "Tidak bisa revive kedirimu sendiri.");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

    if(pData[playerid][pObat] < 1)
    	return Error(playerid, "Tidak dapat Revive karena anda tidak memiliki Obat");

    SetTimerEx("Reviving", 5000, 0, "i", playerid);
    TogglePlayerControllable(playerid, 0);
    GameTextForPlayer(playerid, "~w~REVIVING...", 5000, 3);
    pData[playerid][pObat] -= 1;
    pData[otherid][pInjured] = 0;
    pData[otherid][pHospital] = 0;
    pData[otherid][pSick] = 0;
    pData[otherid][pHead] = 100;
    pData[otherid][pPerut] = 100;
    pData[otherid][pRHand] = 100;
    pData[otherid][pLHand] = 100;
    pData[otherid][pRFoot] = 100;
    pData[otherid][pLFoot] = 100;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);
    ClearAnimations(otherid);
	ApplyAnimation(otherid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
    TogglePlayerControllable(otherid, 1);
    SetPVarInt(playerid, "gcPlayer", otherid);
    ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 1, 1, 1);
    SetPlayerHealthEx(otherid, pData[otherid][pMaxHealth]);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s menyembuhkan segala luka %s.", ReturnName(playerid), ReturnName(otherid));
    Info(otherid, "%s has revived you.", pData[playerid][pAdminname]);

	HideTdDeath(otherid);
	UpdateDynamic3DTextLabelText(pData[otherid][pInjuredLabel], COLOR_ORANGE, "");
    return 1;
}

//SANEW Commands
CMD:sanaonline(playerid, params[])
{
	if(pData[playerid][pFaction] != 4)
        return Error(playerid, "Kamu harus menjadi sanew officer.");
	if(pData[playerid][pFactionRank] < 1)
		return Error(playerid, "Kamu harus memiliki peringkat tertinggi!");
		
	new duty[16], lstr[1024];
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 4)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = ""BLUE_E"On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty, pData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SANA Online", lstr, "Close", "");
	return 1;
}

CMD:broadcast(playerid, params[])
{
    if(pData[playerid][pFaction] != 4)
        return Error(playerid, "You must be part of a news faction.");

    //if(!IsSANEWCar(GetPlayerVehicleID(playerid)) || !IsPlayerInRangeOfPoint(playerid, 5, 255.63, 1757.39, 701.09))
    //    return Error(playerid, "You must be inside a news van or chopper or in sanew studio.");

    if(!pData[playerid][pBroadcast])
    {
        pData[playerid][pBroadcast] = true;

        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has started a news broadcast.", ReturnName(playerid));
        Servers(playerid, "You have started a news broadcast (use \"/bc [broadcast text]\" to broadcast).");
    }
    else
    {
        pData[playerid][pBroadcast] = false;

        foreach (new i : Player) if(pData[i][pNewsGuest] == playerid) 
		{
            pData[i][pNewsGuest] = INVALID_PLAYER_ID;
        }
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has stopped a news broadcast.", ReturnName(playerid));
        Servers(playerid, "You have stopped the news broadcast.");
    }
    return 1;
}


CMD:bc(playerid, params[])
{
    if(pData[playerid][pFaction] != 4)
        return Error(playerid, "You must be part of a news faction.");

    if(isnull(params))
        return SyntaxMsg(playerid, "/bc [broadcast text]");

    //if(!IsSANEWCar(GetPlayerVehicleID(playerid)) || !IsPlayerInRangeOfPoint(playerid, 5, 255.63, 1757.39, 701.09))
    //    return Error(playerid, "You must be inside a news van or chopper or in sanew studio.");

    if(!pData[playerid][pBroadcast])
        return Error(playerid, "You must be broadcasting to use this command.");

    if(strlen(params) > 64) {
        foreach (new i : Player) /*if(!pData[i][pDisableBC])*/ {
            SendClientMessageEx(i, COLOR_ORANGE, "[SANA] Reporter %s: %.64s", ReturnName(playerid), params);
            SendClientMessageEx(i, COLOR_ORANGE, "...%s", params[64]);
        }
    }
    else {
        foreach (new i : Player) /*if(!pData[i][pDisableBC])*/ {
            SendClientMessageEx(i, COLOR_ORANGE, "[SANA] Reporter %s: %s", ReturnName(playerid), params);
        }
    }
    return 1;
}

CMD:live(playerid, params[])
{
    static livechat[128];

    if (sscanf(params, "s[128]", livechat))
        return SyntaxMsg(playerid, "/live [live chat]");

    if (pData[playerid][pNewsGuest] == INVALID_PLAYER_ID && pData[playerid][pFaction] != 4)
        return Error(playerid, "You're not authorized to go live!");

    if (pData[playerid][pFaction] == 4)
    {
        foreach (new i : Player)
        {
            SendClientMessageEx(i, COLOR_LBLUE, "[LIVE] Host %s: %s", ReturnName(playerid), livechat);
        }
    }
    else if (pData[playerid][pNewsGuest] != INVALID_PLAYER_ID)
    {
        foreach (new i : Player)
        {
            SendClientMessageEx(i, COLOR_LBLUE, "[LIVE] Guest %s: %s", ReturnName(playerid), livechat);
        }
    }
    
    return 1;
}

CMD:inviteguest(playerid, params[])
{
    if(pData[playerid][pFaction] != 4)
        return Error(playerid, "You must be part of a news faction.");
		
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/inviteguest [playerid/PartOfName]");

    if(!pData[playerid][pBroadcast])
        return Error(playerid, "You must be broadcasting to use this command.");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "You can't add yourself as a guest.");

    if(pData[otherid][pNewsGuest] == playerid)
        return Error(playerid, "That player is already a guest of your broadcast.");

    if(pData[otherid][pNewsGuest] != INVALID_PLAYER_ID)
        return Error(playerid, "That player is already a guest of another broadcast.");

    pData[otherid][pNewsGuest] = playerid;

    Info(playerid, "You have added %s as a broadcast guest.", ReturnName(otherid));
    Info(otherid, "%s has added you as a broadcast guest ((/live to start broadcast)).", ReturnName(otherid));
    return 1;
}

CMD:removeguest(playerid, params[])
{

    if(pData[playerid][pFaction] != 4)
        return Error(playerid, "You must be part of a news faction.");
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/removeguest [playerid/PartOfName]");

    if(!pData[playerid][pBroadcast])
        return Error(playerid, "You must be broadcasting to use this command.");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "You can't remove yourself as a guest.");

    if(pData[otherid][pNewsGuest] != playerid)
        return Error(playerid, "That player is not a guest of your broadcast.");

    pData[otherid][pNewsGuest] = INVALID_PLAYER_ID;

    Info(playerid, "You have removed %s from your broadcast.", ReturnName(otherid));
    Info(otherid, "%s has removed you from their broadcast.", ReturnName(otherid));
    return 1;
}

// forward CreateObat(playerid);
// public CreateObat(playerid)
// {
// 	if(!IsPlayerConnected(playerid)) return 0;
// 	if(pData[playerid][pProductingStatus] != 1) return 0;

// 	if(pData[playerid][pActivityTime] >= 100)
// 	{
// 		new bonus = RandomEx(80,100);
// 		GivePlayerMoneyEx(playerid, bonus);
// 		TogglePlayerControllable(playerid, 1);
// 		SuccesMsg(playerid, "Myricious Berhasil Dibuat");
// 		//InfoTD_MSG(playerid, 8000, "Myricous Created!");
// 		KillTimer(pData[playerid][pProducting]);
// 		pData[playerid][pProductingStatus] = 0;
// 		pData[playerid][pActivityTime] = 0;
// 		pData[playerid][pObat] += 1;
// 		pData[playerid][pMedicine] -= 4;
// 		pData[playerid][pMarijuana] -= 1;
// 		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
// 		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
// 		pData[playerid][pEnergy] -= 3;
// 		ClearAnimations(playerid);
// 	}
// 	else if(pData[playerid][pActivityTime] < 100)
// 	{
// 		pData[playerid][pActivityTime] += 5;
// 		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
// 		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
// 	}
// 	return 1;
// }

// forward DutyHour(playerid);
// public DutyHour(playerid)
// {
// 	if(pData[playerid][pOnDuty] < 1)
// 		return KillTimer(DutyTimer);

// 	pData[playerid][pDutyHour] += 1;
// 	if(pData[playerid][pDutyHour] == 3600)
// 	{
// 		if(pData[playerid][pFaction] == 1)
// 		{
// 			AddPlayerSalary(playerid, "Duty(SAPD)", 1500);
// 			pData[playerid][pDutyHour] = 0;
// 			Servers(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
// 		}
// 		else if(pData[playerid][pFaction] == 2)
// 		{
// 			AddPlayerSalary(playerid, "Duty(SAGS)", 1500);
// 			pData[playerid][pDutyHour] = 0;
// 			Servers(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
// 		}
// 		else if(pData[playerid][pFaction] == 3)
// 		{
// 			AddPlayerSalary(playerid, "Duty(SAMD)", 1500);
// 			pData[playerid][pDutyHour] = 0;
// 			Servers(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
// 		}
// 		else if(pData[playerid][pFaction] == 4)
// 		{
// 			AddPlayerSalary(playerid, "Duty(SANEWS)", 1500);
// 			pData[playerid][pDutyHour] = 0;
// 			Servers(playerid, "Anda telah Duty selama 1 Jam dan Anda mendapatkan Pending Salary anda");
// 		}
// 	}
// 	return 1;
// }

forward TreatmentPlayer(playerid, otherid);
public TreatmentPlayer(playerid, otherid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pProductingStatus] != 1) return 0;

	if(pData[playerid][pActivityTime] >= 100)
	{
		TogglePlayerControllable(playerid, 1);
		TogglePlayerControllable(otherid, 1);
		SetPlayerHealthEx(otherid, pData[otherid][pMaxHealth]);
		SuccesMsg(playerid, "Treathment Berhasil");
		SuccesMsg(otherid, "Treathment Berhasil");
		SetPlayerHealth(otherid, pData[otherid][pMaxHealth]);
		//InfoTD_MSG(playerid, 8000, "Treatment Sucess!");
		//InfoTD_MSG(otherid, 8000, "Treatment Sucess!");
		KillTimer(pData[playerid][pProducting]);
		pData[playerid][pProductingStatus] = 0;
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		pData[playerid][pEnergy] -= 3;
		ClearAnimations(playerid);
	}
	else if(pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		//ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}
CMD:treatment(playerid, params[])
{
	new otherid;
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/treatment [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa treatment dirimu sendiri.");

   	TogglePlayerControllable(playerid, 0);
	TogglePlayerControllable(otherid, 0);   
   	Info(playerid, "Kamu sedang mentreatment %s!", ReturnName(otherid));
	Info(otherid, "Kamu sedang ditreatment oleh medis, Mohon tenang!");
   	//ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	pData[playerid][pProductingStatus] = 1;
   	pData[playerid][pProducting] = SetTimerEx("TreatmentPlayer", 1000, true, "iid", playerid, otherid, 1);
   	PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Treatment...");
   	PlayerTextDrawShow(playerid, ActiveTD[playerid]);
   	ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
	return 1;
}

forward ImunePlayer(playerid, otherid);
public ImunePlayer(playerid, otherid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pProductingStatus] != 1) return 0;

	if(pData[playerid][pActivityTime] >= 100)
	{
		TogglePlayerControllable(playerid, 1);
		TogglePlayerControllable(otherid, 1);
		//SetPlayerHealthEx(otherid, 100);
		pData[otherid][pBladder] = 0;
		SuccesMsg(playerid, "Imune Success");
		SuccesMsg(otherid, "Imune Success");
		//InfoTD_MSG(playerid, 8000, "Imune Sucess!");
		//InfoTD_MSG(otherid, 8000, "Imune Sucess!");
		KillTimer(pData[playerid][pProducting]);
		pData[playerid][pProductingStatus] = 0;
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		pData[playerid][pEnergy] -= 3;
		ClearAnimations(playerid);
	}
	else if(pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		//ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}
CMD:imune(playerid, params[])
{
	new otherid;
	if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
	
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/Imune [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player tersebut tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa mengimune dirimu sendiri.");

   	TogglePlayerControllable(playerid, 0);
	TogglePlayerControllable(otherid, 0);   
   	Info(playerid, "Kamu sedang mengimune %s!", ReturnName(otherid));
	Info(otherid, "Kamu sedang diberi imune oleh medis, Mohon tenang!");
   	//ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	pData[playerid][pProductingStatus] = 1;
   	pData[playerid][pProducting] = SetTimerEx("ImunePlayer", 1000, true, "iid", playerid, otherid, 1);
   	PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Imune...");
   	PlayerTextDrawShow(playerid, ActiveTD[playerid]);
   	ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
	return 1;
}

CMD:cdutypd(playerid, params[])
{
    if (pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi SAPD.");

    if (pData[playerid][pFactionRank] < 11)
        return Error(playerid, "Kamu harus memiliki rank tertinggi!");

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        SyntaxMsg(playerid, "/cdutypd <ID/Name>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

    if (pData[otherid][pFaction] != 1)
        return Error(playerid, "Player tersebut bukan anggota faction SAPD!");

    new sapdduty = pData[otherid][pOnDutyTime];
    new totalPoints = sapdduty;

    new salary = (totalPoints / 1500) * 500;

    if (salary > 25200)
        salary = 10000;

    pData[otherid][pOnDutyTime] = 0; 

    AddPlayerSalary(otherid, "Faction (SAPD)", salary);
	Server_MinBankPd(salary);

    Info(otherid, "%s telah mereset semua waktu duty anda silahkan cek /salary.", pData[playerid][pName], FormatMoney(salary));

    return 1;
}
CMD:cdutymd(playerid, params[])
{
    if (pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi SAMD.");

    if (pData[playerid][pFactionRank] < 11)
        return Error(playerid, "Kamu harus memiliki rank tertinggi!");

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        SyntaxMsg(playerid, "/cdutymd <ID/Name>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

    if (pData[otherid][pFaction] != 3)
        return Error(playerid, "Player tersebut bukan anggota faction SAMD!");

    new samduty = pData[otherid][pOnDutyTime];
    new totalPoints = samduty;

    new salary = (totalPoints / 1500) * 500;

    if (salary > 25200)
        salary = 10000;

    pData[otherid][pOnDutyTime] = 0; 

    AddPlayerSalary(otherid, "Faction (SAMD)", salary);
	Server_MinBankMd(salary);

    Info(otherid, "%s telah mereset semua waktu duty anda silahkan cek /salary.", pData[playerid][pName], FormatMoney(salary));

    return 1;
}

CMD:cdutysan(playerid, params[])
{
    if (pData[playerid][pFaction] != 4)
        return Error(playerid, "Kamu harus menjadi SANA .");

    if (pData[playerid][pFactionRank] < 11)
        return Error(playerid, "Kamu harus memiliki rank tertinggi!");

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        SyntaxMsg(playerid, "/cdutysan <ID/Name>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

    if (pData[otherid][pFaction] != 4)
        return Error(playerid, "Player tersebut bukan anggota faction SANA!");

    new sanaduty = pData[otherid][pOnDutyTime];
    new totalPoints = sanaduty;

    new salary = (totalPoints / 1500) * 500;

    if (salary > 25200)
        salary = 10000;

    pData[otherid][pOnDutyTime] = 0; 

    AddPlayerSalary(otherid, "Faction (SANA)", salary);
	Server_MinBankSan(salary);

    Info(otherid, "%s telah mereset semua waktu duty anda silahkan cek /salary.", pData[playerid][pName], FormatMoney(salary));

    return 1;
}

/*CMD:spawnvsapd(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1584.875854, -1678.226074, 5.890625))
	{
		if(pData[playerid][pFaction] == 1)
		{
			ShowPlayerDialog(playerid, DIALOG_SPAWNCARSAPD, DIALOG_STYLE_LIST, "Vehicle SAPD", "Cop Car LS\nRanger\nSwat Tank\nFBI Truck\nHPV-1000\nNRG-500\nSultan\nBullet\nTow Truck", "Spawn", "Close");
		}
		else
		{
			Error(playerid, "Anda bukan anggota SAPD");
		}
	}
	else
	{
		Error(playerid, "Anda tidak berada di checkpoint");
	}
}

CMD:desvsapd(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50.0, 1584.875854, -1678.226074, 5.890625))
	{
		if(pData[playerid][pFaction] == 1)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsSAPDCar(vehicleid))	// if(!IsPlayerInVehicle(playerid, SAPDVehicles[10]))
			{
		        DestroyVehicle(vehicleid);
			}
			else
			{
				SendClientMessage(playerid, -1, "Kamu sedang tidak didalam Mobil PD");
			}
		}
		else
		{
			SendClientMessage(playerid, -1, "Anda bukan bagian dari SAPD! ");
		}
	}
	else
	{
		SendClientMessage(playerid, -1, "Anda tidak berada Sapd Vehicles");
	}
}*/

