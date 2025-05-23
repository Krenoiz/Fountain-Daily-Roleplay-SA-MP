

//-------------[ Player Commands ]-------------//
CMD:savepos(playerid, params[])
{
	if(!strlen(params))
		return SendClientMessage(playerid, 0xCECECEFF, "Gunakan: /savepos [judul]");

    extract params -> new string:message[1000]; else return SendClientMessage(playerid, 0xCECECEFF, "Gunakan: /savepos [judul]");

   	GetPlayerVehicleID(playerid);
	new msg[500];
	new Float:PPos[5];

	GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
	GetPlayerFacingAngle(playerid, PPos[3]);
	format(msg, sizeof(msg), "\nSetPlayerPos(playerid, %f,%f,%f);\nSetPlayerFacingAngle(playerid, %f);\nJudul : %s", PPos[0], PPos[1], PPos[2], PPos[3], message);
	//DCC_SendChannelMessage(g_discord_savepos, msg);
    new File:fhandle;
    fhandle = fopen("coordinates.txt",io_append);
    fwrite(fhandle, msg);
    fclose(fhandle);
	SuccesMsg(playerid, "Coordinat Posisi Kamu Berhasil Di Save!");

    return 1;
}
CMD:livestream(playerid, params[])
{
    new line1[1200], line3[500];
    new count = 0;

    line1[0] = '\0';

    foreach(new i : Player)
    {
        if (strlen(pData[i][pLiveChannel]) > 0) 
        {
            count++;
            format(line3, sizeof(line3), "{C6E2FF}[ID:%d] {FFFFFF}%s : {FFFF00}%s\n", i, SGetName(i), pData[i][pLiveChannel]);
            strcat(line1, line3);  
        }
    }

    if (count == 0)
    {
        return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "No Live Streams", "{FF0000}No live streams currently active.", "OK", "");
    }


    format(line1, sizeof(line1), "%s%s", line1); 

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Live Streams", line1, "Close", "");
    return 1;
}


CMD:livemode(playerid, params[])
{
    new livechannel[256];

    if (sscanf(params, "s[255]", livechannel))
        return SendClientMessage(playerid, -1, "{C6E2FF}SYNTAX:{FFFFFF} /livemode [channel]"), Info(playerid, "Your live channel will be visible at {FFFF00}'/livestream'{FFFFFF} command");

    if (strfind(livechannel, "", true) != -1)
        return Error(playerid, "Please enter a valid live channel!");

    format(pData[playerid][pLiveChannel], 256, livechannel);
    Info(playerid, "You have set your live channel to "YELLOW_E"%s", livechannel);
    return 1;
}

CMD:ambilbox(playerid, params[])
{   
    ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,1,1,1,1,1);
    SetPlayerAttachedObject(playerid, 9, 19900, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

    SetPlayerChatBubble(playerid,"Sedang Mengambil toolkit",COLOR_PURPLE,30.0,10000);
    SendClientMessage(playerid, COLOR_WHITE, "mengambil toolkit.");
}

CMD:ambilkoin(playerid, params[])
{   
    ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,1,1,1,1,1);
    SetPlayerAttachedObject(playerid, 9, 1931, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

    SetPlayerChatBubble(playerid,"Sedang Mengambil koin dari saku",COLOR_PURPLE,30.0,10000);
    SendClientMessage(playerid, COLOR_WHITE, "mengambil koin dari saku.");
}

CMD:turunkan(playerid, params[])
{
    RemovePlayerAttachedObject(playerid, 9);
    ClearAnimations(playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    SetPlayerChatBubble(playerid,"Sedang Menaruh Barang",COLOR_PURPLE,30.0,10000);
    SendClientMessage(playerid, COLOR_WHITE, "Anda menaruh barang");
    
}


CMD:coins(playerid, params[])
{
    RemovePlayerAttachedObject(playerid, 9);
    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s flip a coin and earn %s", GetRPName(playerid), (random(2)) ? "{ff0000}Heads" : "{ff0000}Tails");
    return 1;
}
CMD:dadu(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 45.0, 485.8546, -13.2079, 1000.6797)) return Error(playerid, "Kamu harus di Alhambra!");
    if(pData[playerid][pDice] == 0) return Error(playerid, "Anda Tidak Memiliki Dadu!");
    new dice_type = 1; 

    if(params[0] != EOS)
        dice_type = strval(params);

    new random_number1, random_number2, random_number3;

    switch(dice_type)
    {
        case 1: // genap
        {
            random_number1 = (random(3) * 2) + 2; // 2, 4, 6
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d", GetRPName(playerid), random_number1);
        }
        case 2: // ganjil
        {
            random_number1 = (random(3) * 2) + 1; // 1, 3, 5
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d", GetRPName(playerid), random_number1);
        }
        case 3: // big (total < 10)
        {
            do {
                random_number1 = random(6) + 1; // 1 - 6
                random_number2 = random(6) + 1; // 1 - 6
                random_number3 = random(6) + 1; // 1 - 6
            } while (random_number1 + random_number2 + random_number3 <= 10); // pastikan jumlah > 10
            
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d - %d - %d", GetRPName(playerid), random_number1, random_number2, random_number3);
        }
		case 4: // small (total < 10)
        {
            do {
                random_number1 = random(6) + 1; // 1 - 6
                random_number2 = random(6) + 1; // 1 - 6
                random_number3 = random(6) + 1; // 1 - 6
            } while (random_number1 + random_number2 + random_number3 >= 10); // pastikan jumlah < 10
            
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d - %d - %d", GetRPName(playerid), random_number1, random_number2, random_number3);
        }
        default:
            return Usage(playerid,"Pilihan dadu tidak valid. Gunakan /dadu [1-4]");
    }
    return 1;
}
CMD:dice(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 45.0, 485.8546, -13.2079, 1000.6797)) return Error(playerid, "Kamu harus di Alhambra!");
	if(pData[playerid][pDice] == 0) return Error(playerid, "Anda Tidak Memiliki Dadu!");
	if(pData[playerid][pAdmin] < 6)
        return Error(playerid, "You don't have use permission");
    new dice_type = 1; 

    if(params[0] != EOS)
        dice_type = strval(params);

    new random_number1, random_number2, random_number3;
    switch(dice_type)
    {
        case 1:
		{
            random_number1 = random(6) + 1;
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d", GetRPName(playerid), random_number1);
		}
        case 2:
		{
            random_number1 = random(6) + 1;
            random_number2 = random(6) + 1;
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d - %d", GetRPName(playerid), random_number1, random_number2);
		}
        case 3:
		{
            random_number1 = random(6) + 1;
            random_number2 = random(6) + 1;
            random_number3 = random(6) + 1;
            SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "** %s roll the dice and get a number {ff0000}%d - %d - %d", GetRPName(playerid), random_number1, random_number2, random_number3);
		}
        default: return Usage(playerid,"Pilihan dadu tidak valid. Gunakan /dice [1-3]");
    }
    return 1;
}
CMD:help(playerid, params[])
{
	new str[512], info[512];
	format(str, sizeof(str), "Account Commands\nGeneral Commands\nVehicle Commands\nJob Commands\nFaction Commands\nBusiness Commands\nHouse Commands\nFlat Commands\nWorkshop Commands\nVending Commands\nAuto RP\nVoice Command\nServer Credits\n");
	strcat(info, str);
	if(pData[playerid][pRobLeader] > 1 || pData[playerid][pMemberRob] > 1)
	{
		format(str, sizeof(str), "Robbery Help");
		strcat(info, str);	
	}
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Fountain Daily Help Menu", info, "Select", "Close");
	return 1;
}
CMD:enims(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_ANIM, DIALOG_STYLE_TABLIST_HEADERS, "Fountain Daily List Anim V2 // Create By Lenz", "No\tNama Anim\n1\tJoget\n2\tJoget2\n3\tJoget3\n4\tJoget4\n5\tAngkat tangan\n6\tangkat hp\n7\tduduk\n8\tTutup Telepon\n9\tbebek\n10\tmasuk mobil\n11\tkeluar mobil\n12\tminum beer\n13\tngerokok\n14\tminum sprunk\n15\tsurrender\n16\tthrowbarl\n17\tstepsitin\n18\tstepsitloop\n19\tstepsitout\n20\tbar1\n21\tbar2\n22\tbar3\n23\tbar4\n24\tbar5\n25\tbar6\n26\tbar7\n27\tbar8\n28\tbar9\n29\tbar10\n30\tbaseball\n31\tbaseball2\n32\tbaseball3\n33\tbaseball4\n34\tbat\n35\tbat2\n36\tbathit2\n37\tbathit\n38\tbatidle\n39\tbatm\n40\tbatpart\n41\tfire\n42\tfire2\n43\tfire3\n44\twave\n45\tpanic\n46\tpanic2\n47\tpanic3\n48\tpanic4\n49\tpanicloop\n50\tgirlkiss\n51\tboykiss\n52\tbather\n53\tlayloop\n54\tparksit\n55\tparksit2\n56\tsitwait\n57\tcelebrate\n58\tdown\n59\tgeton\n60\tup\n61\tup2\n62\tsmooth\n63\trhs\n64\tlhs\n65\trhs2\n66\tbikedback\n67\tdriveby\n68\tdriveby2\n69\tdriveby3\n70\tfwd\n71\tgetoffback\n72\tgetofflhs\n73\tgetoffrhs\n74\tbikehit\n75\tbikejump\n76\tbikejump2\n77\tbikekick\n78\tbikeleft\n79\tbjcouch\n80\tbjcouch2\n81\tbjstart\n82\tbjloop\n83\tbjloop2\n84\tbjend\n85\tbjs1\n86\tbjs2\n87\tbjs3\n88\tbjs4\n89\tbjs5\n90\tbbalbat", "Lakukan", "Tutup");
    return 1;
}
CMD:tukarhepeng(playerid, params[])
{
	if (!IsPlayerInRangeOfPoint(playerid, 5.0, 287.2036,-109.7823,1001.5156))
	{
		return Error(playerid, "Kamu harus berada di penukaran coin.");
	}
    ShowPlayerDialog(playerid, DIALOG_TUKARR, DIALOG_STYLE_LIST, "Fountain Daily Roleplay", "Exchange Red Money\n Exchange Coin", "Exchange", "Cancel");
    return 1;
}
CMD:destroyschematic(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_DESTROYSCHE, DIALOG_STYLE_LIST, "Fountain Daily Roleplay", "Schematic SLC\nSchematic Colt-45\nSchematic Shotgun\nSchematic DE\nSchematic Riffle\nSchematicUzi\nAK-47", "Destroy", "Cancel");
    return 1;
}

CMD:enterdweb(playerid, params[])
{
	if (pData[playerid][pDarkWeb] == 0)
	{
		pData[playerid][pDarkWeb] = 1;
		SendClientMessageEx(playerid, 0xFF0000FF, "You've entered the darkweb, be carefull with everyone.");
	}
	else if (pData[playerid][pDarkWeb] == 1)
	{
		pData[playerid][pDarkWeb] = 0;
		SendClientMessageEx(playerid, 0xFF0000FF, "You've leave from the darkweb.");
	}

	return 1;
}

CMD:dweb(playerid, params[])
{
	new teks[120];
    if(pData[playerid][pDarkWeb] == 1) 
    {
		if(DWebDelay[playerid] > gettime())
			return Error(playerid, "You must wait %d seconds.", DWebDelay[playerid]-gettime());

    	if(sscanf(params, "s[120]", teks))
			return SyntaxMsg(playerid, "/dweb [pesan]");	

		new lstr[1024];
		format(lstr, sizeof(lstr), "DARKWEB | MASKMAN :{FFFFFF} %s", params);

		foreach(new i : Player)
		{
			if (pData[i][pDarkWeb] == 1)
			{
				SendClientMessageEx(i, 0xFF0000FF, "%s", lstr);
			}
		}

		DWebDelay[playerid] = gettime()+10;

		// SendClientMessageToAll(COLOR_GOLD, lstr);
		SendStaffMessage(COLOR_GOLD, "[LOGS PLAYER DWEB] {FFFFFF}%s.", pData[playerid][pName]);
    }
	else
	{
		Error(playerid, "Kamu harus masuk ke dalam darkweb terlebih dahulu.");
	}
	return 1;
}
GetFactionCount(FACTION_ID)
{
    new count;
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
        if (pData[i][pFaction] == FACTION_ID && pData[i][pOnDuty] == 1) count++;
    }
    return count;
}

// GetMechanicCount()
// {
//     new count;
//     for (new i; i < MAX_PLAYERS; i++)
//     {
//         if (!IsPlayerConnected(i)) continue;
//         if (pData[i][pMechDuty] == 1) count++;
//     }
//     return count;
// }
CMD:cuaca(playerid, params[])
{
    new string[658] = "Status Cuaca\n";
    new sapdCount = GetFactionCount(1);
    new samdCount = GetFactionCount(3);
    new weather;

    if (sapdCount >= 3 && samdCount >= 1) 
	{
        weather = 1; 
    } 
	else 
	{
        weather = 2; 
    }

    if (weather == 1) 
	{
        strcat(string, "{00FF00}Cerah (Boleh Kriminal)\n");
    } 
	else 
	{
        strcat(string, "{FF0000}Mendung (Tidak Boleh Kriminal)\n");
    }
    SendClientMessage(playerid, -1, string);
    return 1;
}

CMD:faconline(playerid, params[])
{
    new string[658] = "No. Fraksi\tCheck F.Online\n", tmp_string[128];
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}1. "BLUE_E"SAPD\t(%d online)\n", GetFactionCount(1));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}2. "LB_E"SAGS\t(%d online)\n", GetFactionCount(2));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}3. "PINK_E"SAMD\t(%d online)\n", GetFactionCount(3));
    strcat(string, tmp_string);
    format(tmp_string, sizeof(tmp_string), "{FFFFFF}4. "ORANGE_E"SANEWS\t(%d online)\n", GetFactionCount(4));
    strcat(string, tmp_string);
    // format(tmp_string, sizeof(tmp_string), "{FFFFFF}5. "YELLOW_E"PEDAGANG\t(%d online)\n", GetFactionCount(5));
    // strcat(string, tmp_string);
    // format(tmp_string, sizeof(tmp_string), "{FFFFFF}6. "GREEN_E"MECHANIC\t(%d online)", GetMechanicCount());
    // strcat(string, tmp_string);
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Fountain Daily Fraksi Online List", string, "Close", "");
}
CMD:carwash(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 5, 1911.1886,-1784.2952,13.0801))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				for(new x = 0; x < sizeof(unwashable); x++)
				{
					if(GetVehicleModel(GetPlayerVehicleID(playerid)) == unwashable[x][0])
					{
						SendClientMessage(playerid, 0xAA3333AA, "Kendaraan ini tidak boleh dicuci.");
						return 1;
					}
				}
				if(usingcarwash == -1)
				{
					GivePlayerMoneyEx(playerid, -5000);
					usingcarwash = playerid;
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s menggunakan tempat pencucian mobil sekarang.", pData[playerid][pName]);
					//Update3DTextLabelText(entrancetext, 0xB0171FFF, "Seseorang sedang menggunakan tempat pencucian mobil sekarang.");
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
						{
							TogglePlayerControllable(i, 0);
							SetPlayerCameraPos(i,1907.8804,-1790.0590,15);
							SetPlayerCameraLookAt(i,1911.0471,-1781.6868,13.3828);
						}
						if(GetPlayerSurfingVehicleID(i) == GetPlayerVehicleID(playerid))
						{
							SetPlayerPos(i,1906.9204,-1786.0435,13.5469);
							SetPlayerFacingAngle(i, 270);
						}
					}
					SetVehiclePos(GetPlayerVehicleID(playerid), 1911.1886, -1784.2952, 13.0801);
					SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
					MoveDynamicObject(entrancegate, 1911.21130371, -1780.68151855, 10.50000000, 1);
					SetTimerEx("Autocruise",3500,0,"ii",playerid, 1);
				}
				else
				{
					SendClientMessage(playerid, 0xAA3333AA, "Orang lain sedang menggunakan pencucian mobil sekarang.");
				}
			}
			else
			{
				SendClientMessage(playerid, 0xAA3333AA, "Anda bukan pengemudi kendaraan ini.");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xAA3333AA, "Anda tidak berada di dalam mobil.");
		}
	}
	else
	{
		SendClientMessage(playerid, 0xAA3333AA, "Anda tidak berada di pintu masuk tempat cuci mobil.");
	}
	return 1;
}



CMD:phoneold(playerid, params[])
{
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");

	for(new i = 0; i < 92; i++) {
		TextDrawShowForPlayer(playerid, Text_Global[i]);
	}
	TextDrawShowForPlayer(playerid, klikhome);
	TextDrawShowForPlayer(playerid, klikgps);
	TextDrawShowForPlayer(playerid, klikcall);
	TextDrawShowForPlayer(playerid, klikkontak);
	TextDrawShowForPlayer(playerid, klikmusik);
	TextDrawShowForPlayer(playerid, klikbank);
	TextDrawShowForPlayer(playerid, kliksms);
	TextDrawShowForPlayer(playerid, kliksetting);
	TextDrawShowForPlayer(playerid, klikjob);
	TextDrawShowForPlayer(playerid, klikgocar);
	TextDrawShowForPlayer(playerid, klikads);
	TextDrawShowForPlayer(playerid, kliktwitter);
	TextDrawShowForPlayer(playerid, klikairdrop);
	TextDrawShowForPlayer(playerid, klikgojek);
	TextDrawShowForPlayer(playerid, jamphonenew);
	SelectTextDraw(playerid, COLOR_LBLUE);
	return 1;
}
CMD:phone(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 25, 1555.6453,-1682.4194,-10.8488))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada penjara");
    if(IsPlayerInRangeOfPoint(playerid, 25, 1955.7324, 1526.8608, 5003.4956))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
    
	if(pData[playerid][pCuffed] == 1)
        return Error(playerid, "You can't do that in this time.");
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
    if(pData[playerid][pInjured] == 1) return Error(playerid, "Anda sedang pingsan!");
    if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki ponsel");
    if(pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
    SetPlayerChatBubble(playerid,"> Membuka hpnya..",COLOR_PURPLE,30.0,10000);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s Telah membuka HPMiliknya", pData[playerid][pName]);

    PlayerPlaySound(playerid, 3600, 0,0,0);
    SetPlayerAttachedObject(playerid, 9, 18871, 5, 0.056, 0.039, -0.015, -18.100, -108.600, 93.000, 1,1,1);
	if(!IsPlayerInAnyVehicle(playerid) && !PlayerData[playerid][pInjured] && !PlayerData[playerid][pLoopAnim])
	{
		ApplyAnimation(playerid,"ped","Jetpack_Idle",4.0, 1, 0, 0, 0, 0, 1); // anim jancok
	}    
	if(ToggleCall[playerid] == 1)
	{
	    return SelectTextDraw(playerid, 0xFFFF00FF);
	}
	HideRadialMenu(playerid);
    if(TogglePhone[playerid] == 0)
	{
		/* for(new i = 0; i < 25; i++) {
			PlayerTextDrawShow(playerid, fingerhp[playerid][i]);
		} */
		ShowPhoneLockscreen(playerid);
		// SelectTextDraw(playerid, COLOR_LBLUE);
		TogglePhone[playerid] = 1;
	}
 	else if(TogglePhone[playerid] == 1)
	{
		/* for(new i = 0; i < 25; i++) {
			PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
		}
		HideHpLenz(playerid); */
		HidePhone(playerid);
		TogglePhone[playerid] = 0;
		// CancelSelectTextDraw(playerid);
	}
	return 1;
}
CMD:call(playerid, const params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	if(pData[playerid][pCuffed] == 1)
        return Error(playerid, "You can't do that in this time.");
	new ph;
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Handphone anda sedang dimatikan");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "Anda tidak memiliki Ponsel credits!");
	
	if(sscanf(params, "d", ph))
	{
		Usage(playerid, "/call [phone number] 911 - SAPD Crime Call | 922 - SAMD Medic Call | 123 - SANA");
		foreach(new ii : Player)
		{	
			if(pData[ii][pMechDuty] == 1)
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "Mech Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
			}
			/* if(pData[ii][pTaxiDuty] == 1)
			{
				SendClientMessageEx(playerid, COLOR_YELLOW, "Taxi Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
			} */
		}
		return 1;
	}
	if(ph == 911)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

		Info(playerid, "Warning: This number for emergency crime only! Please wait for SAPD respon!");
		Info(playerid, "911: "WHITE_E"You have reached the emergency crime.");
		Info(playerid, "911: "WHITE_E"How can I help you?");
		SetPVarInt(playerid, "911", 1); 

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		pData[playerid][pCallTime] = gettime() + 60;

		Info(playerid, "Please leave your message after the beep:");
		
		// SetTimerEx("CallSAPDsep", 60000, false, "i", playerid); 
	}
	if(ph == 922)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

		Info(playerid, "Warning: This number for emergency  medical only! Please wait for SAMD respon!");
		Info(playerid, "922: "WHITE_E"You have reached the emergency medical .");
		Info(playerid, "922: "WHITE_E"How can I help you?");
		SetPVarInt(playerid, "922", 1); 

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		pData[playerid][pCallTime] = gettime() + 60;

		Info(playerid, "Please leave your message after the beep:");
		
		// SetTimerEx("CallSAMDsep", 60000, false, "i", playerid); 
	}
	if(ph == 123)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

		Info(playerid, "Warning: This number for SANews! Please wait for SANA respon!");
		Info(playerid, "123: "WHITE_E"You have reached the SANews .");
		Info(playerid, "123: "WHITE_E"How can I help you?");
		SetPVarInt(playerid, "123", 1); 

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		pData[playerid][pCallTime] = gettime() + 60;

		Info(playerid, "Please leave your message after the beep:");
		
		// SetTimerEx("CallSANsep", 60000, false, "i", playerid); 
	}
	if(ph == 999)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

        Info(playerid, "999: "WHITE_E"You have reached the SAGS.");
		Info(playerid, "999: "WHITE_E"How can I help you?");
		SetPVarInt(playerid, "999", 1);

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for government! please wait for SAGS respon!");
		//SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"Telp Umum"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		SendFactionMessage(2, COLOR_LBLUE, "[SAGS CALL] "WHITE_E"%s calling the government! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		pData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == pData[playerid][pPhone])
	{
		/* for(new i = 0; i < 25; i++) {
			PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
		}
		HideHpLenz(playerid); */

		HidePhoneLockscreen(playerid);
		HidePhoneMainscreen(playerid);
		
		ShowPhoneIncomingCallscreen(playerid);
     	/* for(new i = 0; i < 21; i++)
		{
			PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
		}
		SelectTextDraw(playerid, COLOR_LBLUE); */
	}
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii))
			{/* 
				for(new i = 0; i < 25; i++) {
					PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
				}
				HideHpLenz(playerid);
				for(new i = 0; i < 21; i++)
				{
					PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
				}
				SelectTextDraw(playerid, COLOR_LBLUE); */

				HidePhoneLockscreen(playerid);
				HidePhoneMainscreen(playerid);
				
				ShowPhoneIncomingCallscreen(playerid);
				
				new tstr[256];
				// format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				// PlayerTextDrawSetString(playerid, CallHpLenz[playerid][16], tstr);

				format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				PlayerTextDrawSetString(playerid, PhoneTD_CallName[playerid], tstr);
				return 1;
			}
			if(pData[ii][pPhoneStatus] == 0)
			{
				/* for(new i = 0; i < 25; i++) {
					PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
				}
				HideHpLenz(playerid);
				for(new i = 0; i < 21; i++)
				{
					PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
				}
				SelectTextDraw(playerid, COLOR_LBLUE); */

				HidePhoneLockscreen(playerid);
				HidePhoneMainscreen(playerid);
				
				ShowPhoneIncomingCallscreen(playerid);
				
				new tstr[256];
				// format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				// PlayerTextDrawSetString(playerid, CallHpLenz[playerid][16], tstr);

				format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				PlayerTextDrawSetString(playerid, PhoneTD_CallName[playerid], tstr);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(ii, 20, 1955.7324, 1526.8608, 5003.4956))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(pData[ii][pCall] == INVALID_PLAYER_ID)
			{
				pData[playerid][pCall] = ii;
				
				//njajal
				//SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
				/* for(new i = 0; i < 25; i++) {
					PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
				}
				HideHpLenz(playerid);
				for(new i = 0; i < 21; i++)
				{
					PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
				}
				SelectTextDraw(playerid, COLOR_LBLUE); */

				HidePhoneLockscreen(playerid);
				HidePhoneMainscreen(playerid);
				ShowPhoneCallingscreen(playerid);
				
				/* new tstr[256];
				format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				PlayerTextDrawSetString(playerid, CallHpLenz[playerid][16], tstr);
				new stro[256];
				format(stro, sizeof(stro), "Berdering..");
				PlayerTextDrawSetString(playerid, CallHpLenz[playerid][17], stro);
				SelectTextDraw(playerid, COLOR_LBLUE); */

				new tstr[256];
				format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				PlayerTextDrawSetString(playerid, PhoneTD_CallName[playerid], tstr);
				new stro[256];
				format(stro, sizeof(stro), "Berdering..");
				PlayerTextDrawSetString(playerid, PhoneTD_CallStatus[playerid], stro);
				format(stro, sizeof(stro), "Panggilan masuk...");
				PlayerTextDrawSetString(ii, PhoneTD_CallStatus[ii], stro);
				
				//SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE form %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
			
				HidePhoneLockscreen(ii);
				HidePhoneMainscreen(ii);
				ShowPhoneIncomingCallscreen(ii);

				/* for(new i = 0; i < 25; i++) {
					PlayerTextDrawHide(ii, fingerhp[playerid][i]);
				}				
				for(new i = 0; i < 56; i++) {
					PlayerTextDrawHide(ii, hplenzbaru[playerid][i]);
				}
				PlayerTextDrawHide(ii, adshplenz[playerid]);
				PlayerTextDrawHide(ii, airdrophplenz[playerid]);
				PlayerTextDrawHide(ii, contacthplenz[playerid]);
				PlayerTextDrawHide(ii, camerahplenz[playerid]);
				PlayerTextDrawHide(ii, callhplenz[playerid]);
				PlayerTextDrawHide(ii, jobhplenz[playerid]);
				PlayerTextDrawHide(ii, musichplenz[playerid]);
				PlayerTextDrawHide(ii, gojekhplenz[playerid]);
				PlayerTextDrawHide(ii, bankhplenz[playerid]);
				PlayerTextDrawHide(ii, mapshplenz[playerid]);
				PlayerTextDrawHide(ii, twhplenz[playerid]);
				PlayerTextDrawHide(ii, settinghplenz[playerid]); */
				
				/* for(new i = 0; i < 21; i++)
				{
					PlayerTextDrawShow(ii, CallHpLenz[playerid][i]);
				} */
				ToggleCall[ii] = 1;
				PlayerPlaySound(playerid, 3600, 0,0,0);
				PlayerPlaySound(ii, 6003, 0,0,0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				/* format(tstr, sizeof(tstr), "%s", pData[playerid][pName]);
				PlayerTextDrawSetString(ii, CallHpLenz[playerid][16], tstr); */
				format(tstr, sizeof(tstr), "%s", pData[playerid][pName]);
				PlayerTextDrawSetString(ii, PhoneTD_CallName[playerid], tstr);
				//SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
				return 1;
			}
			else
			{
				HidePhoneLockscreen(playerid);
				HidePhoneMainscreen(playerid);
				ShowPhoneIncomingCallscreen(playerid);

				new tstr[256];
				format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				PlayerTextDrawSetString(playerid, PhoneTD_CallName[playerid], tstr);
				new stro[256];
				format(stro, sizeof(stro), "Sibuk..");
				PlayerTextDrawSetString(playerid, PhoneTD_CallStatus[playerid], stro);

				/* for(new i = 0; i < 25; i++) {
					PlayerTextDrawHide(playerid, fingerhp[playerid][i]);
				}
				HideHpLenz(playerid);
				for(new i = 0; i < 21; i++)
				{
					PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
				}
				SelectTextDraw(playerid, COLOR_LBLUE); */

				/* new tstr[256];
				format(tstr, sizeof(tstr), "%s", pData[ii][pName]);
				PlayerTextDrawSetString(playerid, CallHpLenz[playerid][16], tstr);
				new stro[256];
				format(stro, sizeof(stro), "Sibuk..");
				PlayerTextDrawSetString(playerid, CallHpLenz[playerid][17], stro); */
				return 1;
			}
		}
	}
	return 1;
}
CMD:p(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(pData[playerid][pCall] != INVALID_PLAYER_ID)
        return Error(playerid, "Anda sudah sedang menelpon seseorang!");
        
    if(pData[playerid][pInjured] != 0)
        return Error(playerid, "You cant do that in this time.");
        
    foreach(new ii : Player)
    {
        if(playerid == pData[ii][pCall])
        {
            pData[ii][pPhoneCredit]--;
            
            pData[playerid][pCall] = ii;
            pData[playerid][pCallStatus] = 1; // Set status panggilan sebagai diangkat
            pData[ii][pCallStatus] = 1; // Set status panggilan sebagai diangkat

            SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");

            /* for(new i = 0; i < 21; i++)
            {
                PlayerTextDrawShow(ii, CallHpLenz[playerid][i]);
            } */
			HidePhoneIncomingCallscreen(ii);
			ShowPhoneCallingscreen(ii);
            CancelSelectTextDraw(ii);
            SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");

            /* for(new i = 0; i < 21; i++)
            {
                PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
            } */
			HidePhoneIncomingCallscreen(playerid);
			ShowPhoneCallingscreen(playerid);
            CancelSelectTextDraw(playerid);
            ToggleCall[playerid] = 1;
            ToggleCall[ii] = 1;
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
            
            DetikCall[playerid] = 0;
            MenitCall[playerid] = 0;
            JamCall[playerid] = 0;
            
            DetikCall[ii] = 0;
            MenitCall[ii] = 0;
            JamCall[ii] = 0;
            
            KillTimer(CallTimer[playerid]);
            KillTimer(CallTimer[ii]);
            
            CallTimer[playerid] = SetTimerEx("TambahDetikCall", 1000, true, "i", playerid);
            CallTimer[ii] = SetTimerEx("TambahDetikCall", 1000, true, "i", ii);
            
            // new targetid = pData[playerid][pCall];

            /* OnPhone[targetid] = SvCreateGStream(0xFFA200FF, "Telepon");

            if (OnPhone[targetid])
            {
                SvAttachListenerToStream(OnPhone[targetid], targetid);
                SvAttachListenerToStream(OnPhone[targetid], playerid);
            }
            if (OnPhone[targetid] && pData[playerid][pCall] != INVALID_PLAYER_ID)
            {
                SvAttachSpeakerToStream(OnPhone[targetid], playerid);
            }

            if(OnPhone[targetid] && pData[targetid][pCall] != INVALID_PLAYER_ID)
            {
                SvAttachSpeakerToStream(OnPhone[targetid], targetid);
            } */
        }
    }
    return 1;
}

// CMD:p(playerid, params[])
// {
// 	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
// 		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

// 	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
// 		return Error(playerid, "Anda sudah sedang menelpon seseorang!");
		
// 	if(pData[playerid][pInjured] != 0)
// 		return Error(playerid, "You cant do that in this time.");
		
// 	foreach(new ii : Player)
// 	{
// 		if(playerid == pData[ii][pCall])
// 		{
// 			pData[ii][pPhoneCredit]--;
			
// 			pData[playerid][pCall] = ii;
// 			SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");

// 			for(new i = 0; i < 21; i++)
// 			{
// 				PlayerTextDrawShow(ii, CallHpLenz[playerid][i]);
// 			}
// 			CancelSelectTextDraw(ii);
// 			SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");

			
// 			for(new i = 0; i < 21; i++)
// 			{
// 				PlayerTextDrawShow(playerid, CallHpLenz[playerid][i]);
// 			}
// 			CancelSelectTextDraw(playerid);
// 			ToggleCall[playerid] = 1;
// 			ToggleCall[ii] = 1;
// 			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
// 			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
			
// 			DetikCall[playerid] = 0;
// 			MenitCall[playerid] = 0;
// 			JamCall[playerid] = 0;
			
// 			DetikCall[ii] = 0;
// 			MenitCall[ii] = 0;
// 			JamCall[ii] = 0;
			
// 			KillTimer(CallTimer[playerid]);
// 			KillTimer(CallTimer[ii]);
			
// 			CallTimer[playerid] = SetTimerEx("TambahDetikCall", 1000, true, "i", playerid);
// 			CallTimer[ii] = SetTimerEx("TambahDetikCall", 1000, true, "i", ii);
// 			////////////////////////////////////////
//    			new targetid = pData[playerid][pCall];

// 			OnPhone[targetid] = SvCreateGStream(0xFFA200FF, "Telepon");

// 		    if (OnPhone[targetid])
// 			{
// 		        SvAttachListenerToStream(OnPhone[targetid], targetid);
// 		        SvAttachListenerToStream(OnPhone[targetid], playerid);
// 		    }
// 		    if (OnPhone[targetid] && pData[playerid][pCall] != INVALID_PLAYER_ID)
// 			{
// 		        SvAttachSpeakerToStream(OnPhone[targetid], playerid);
// 		    }

// 		    if(OnPhone[targetid] && pData[targetid][pCall] != INVALID_PLAYER_ID)
// 			{
// 		        SvAttachSpeakerToStream(OnPhone[targetid], targetid);
// 		    }
// 		}
// 	}
// 	return 1;
// }
// CMD:hu(playerid, params[])
// {
// 	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
// 		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

// 	new caller = pData[playerid][pCall];

// 	if(IsPlayerConnected(caller) && caller != INVALID_PLAYER_ID)
// 	{
// 		pData[caller][pCall] = INVALID_PLAYER_ID;
// 		SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
// 		SendNearbyMessage(caller, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(caller));
// 		for(new i = 0; i < 21; i++)
// 		{
// 			PlayerTextDrawHide(caller, CallHpLenz[playerid][i]);
// 		}
// 		CancelSelectTextDraw(caller);
// 		ToggleCall[caller] = 0;
// 		TogglePhone[caller] = 0;
// 		DetikCall[caller] = 0;
// 		MenitCall[caller] = 0;
// 		JamCall[caller] = 0;
		
// 		//SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
// 		for(new i = 0; i < 21; i++)
// 		{
// 			PlayerTextDrawHide(playerid, CallHpLenz[playerid][i]);
// 		}
// 		CancelSelectTextDraw(playerid);
// 		ToggleCall[playerid] = 0;
// 		TogglePhone[playerid] = 0;
// 		DetikCall[playerid] = 0;
// 		MenitCall[playerid] = 0;
// 		JamCall[playerid] = 0;
// 		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
// 		pData[playerid][pCall] = INVALID_PLAYER_ID;
// 		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);

//   		if (OnPhone[caller] && pData[caller][pCall] != INVALID_PLAYER_ID)
// 	 	{
//             SvDetachSpeakerFromStream(OnPhone[caller], caller);
//         }

//         if(OnPhone[caller] && pData[playerid][pCall] != INVALID_PLAYER_ID)
// 		{
//             SvDetachSpeakerFromStream(OnPhone[caller], playerid);
//         }

//         if(OnPhone[caller])
// 		{
//             SvDetachListenerFromStream(OnPhone[caller], caller);
//             SvDetachListenerFromStream(OnPhone[caller], playerid);
//             SvDeleteStream(OnPhone[caller]);
//             OnPhone[caller] = SV_NULL;
//         }

// 		if (OnPhone[playerid] && pData[caller][pCall] != INVALID_PLAYER_ID)
// 		{
//             SvDetachSpeakerFromStream(OnPhone[playerid], caller);
//         }

//         if(OnPhone[playerid] && pData[playerid][pCall] != INVALID_PLAYER_ID)
// 		{
//             SvDetachSpeakerFromStream(OnPhone[playerid], playerid);
//         }

//         if(OnPhone[playerid])
// 		{
//             SvDetachListenerFromStream(OnPhone[playerid], caller);
//             SvDetachListenerFromStream(OnPhone[playerid], playerid);
//             SvDeleteStream(OnPhone[playerid]);
//             OnPhone[playerid] = SV_NULL;
//         }
// 	}
// 	return 1;
// }
CMD:hu(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    foreach (new ii : Player)
    {
        if (playerid == pData[ii][pCall] || ii == pData[playerid][pCall])
        {
            if (playerid == pData[ii][pCall]) 
            {
                pData[playerid][pCall] = ii;
            }
            else 
            {
                pData[ii][pCall] = INVALID_PLAYER_ID;
            }

            /* for (new i = 0; i < 21; i++)
            {
                PlayerTextDrawHide(ii, CallHpLenz[playerid][i]);
                PlayerTextDrawHide(playerid, CallHpLenz[playerid][i]);
            } */

			
			HidePhoneCallingscreen(ii);
			HidePhoneCallingscreen(playerid);
			HidePhoneIncomingCallscreen(ii);
			HidePhoneIncomingCallscreen(playerid);

            SetPlayerSpecialAction(ii, SPECIAL_ACTION_STOPUSECELLPHONE);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);

            SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE] " WHITE_E "The number is rejected your call.");
            SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] " WHITE_E "You just rejected the caller number.");

            CancelSelectTextDraw(playerid);
            CancelSelectTextDraw(ii);

            ToggleCall[ii] = 0;
            ToggleCall[playerid] = 0;
            TogglePhone[ii] = 0;
            TogglePhone[playerid] = 0;

            DetikCall[playerid] = 0;
            MenitCall[playerid] = 0;
            JamCall[playerid] = 0;
            DetikCall[ii] = 0;
            MenitCall[ii] = 0;
            JamCall[ii] = 0;


            pData[playerid][pCall] = INVALID_PLAYER_ID;
            pData[ii][pCall] = INVALID_PLAYER_ID;
            pData[playerid][pCallStatus] = 0; 
            pData[ii][pCallStatus] = 0;      
        }
    }

    return 1;
}

// stock GetPlayerText(playerid, message[], len)
// {
//     format(message, len, "%s", PlayerMessage[playerid]); 
//     return strlen(message); 
// }
// function CallSAPDsep(playerid)
// {
//     if(!IsPlayerConnected(playerid)) return;

//     new message[128];
//     GetPlayerText(playerid, message, sizeof(message));

//     if(strlen(message) > 0)
//     {
//         new Float:x, Float:y, Float:z;
//         GetPlayerPos(playerid, x, y, z);

// 		SendFactionMessage(1, COLOR_BLUE, "[HOTLINE] {ffffff}%s", PlayerMessage[playerid]);
// 		SendFactionMessage(1, COLOR_BLUE, "[{ffffff}%s{0000ff}] PH: [{ffffff}%d{0000ff}] Loc: [{ffffff}%s{0000ff}]", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		
//         Info(playerid, "Your message has been sent to SAPD. The call has ended.");
//     }
//     else
//     {
//         Info(playerid, "No message recorded. The call has ended.");
//     }

//     SetPVarInt(playerid, "911", 0);
// }
// function CallSAMDsep(playerid)
// {
//     if(!IsPlayerConnected(playerid)) return;

//     new message[128]; 
//     GetPlayerText(playerid, message, sizeof(message)); 

//     if(strlen(message) > 0)
//     {
//         new Float:x, Float:y, Float:z;
//         GetPlayerPos(playerid, x, y, z);

// 		SendFactionMessage(3, COLOR_PINK, "[HOTLINE] {ffffff}%s", PlayerMessage[playerid]);
// 		SendFactionMessage(3, COLOR_PINK, "[{ffffff}%s{82EEFF}] PH: [{ffffff}%d{82EEFF}] Loc: [{ffffff}%s{82EEFF}]", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		
//         Info(playerid, "Your message has been sent to SAMD. The call has ended.");
//     }
//     else
//     {
//         Info(playerid, "No message recorded. The call has ended.");
//     }

//     SetPVarInt(playerid, "922", 0);
// }
// function CallSANsep(playerid)
// {
//     if(!IsPlayerConnected(playerid)) return;

//     new message[128]; 
//     GetPlayerText(playerid, message, sizeof(message)); 

//     if(strlen(message) > 0)
//     {
//         // Kirim pesan ke SAPD
//         new Float:x, Float:y, Float:z;
//         GetPlayerPos(playerid, x, y, z);

// 		SendFactionMessage(4, COLOR_ORANGE2, "[HOTLINE] {ffffff}%s", PlayerMessage[playerid]);
// 		SendFactionMessage(4, COLOR_ORANGE2, "[{ffffff}%s{000FFF}] PH: [{ffffff}%d{000FFF}] Loc: [{ffffff}%s{000FFF}]", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		
//         Info(playerid, "Your message has been sent to SANA. The call has ended.");
//     }
//     else
//     {
//         Info(playerid, "No message recorded. The call has ended.");
//     }

//     SetPVarInt(playerid, "123", 0);
// }
// CMD:call(playerid, params[])
// {
// 	new ph;
// 	if(pData[playerid][pPhone] == 0) return Error(playerid, "You dont have phone!");
// 	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Handphone anda sedang dimatikan");
// 	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "You dont have phone credits!");
// 	if(pData[playerid][pCuffed] == 1)
//         return Error(playerid, "You can't do that in this time.");
// 	if(sscanf(params, "d", ph))
// 	{
// 		SyntaxMsg(playerid, "/call [phone number] 911 - SAPD Crime Call | 922 - SAMD Medic Call | 123 - SANA");
// 		foreach(new ii : Player)
// 		{
// 			if(pData[ii][pMechDuty] == 1)
// 			{
// 				SendClientMessageEx(playerid, COLOR_GREEN, "Mech Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
// 			}
// 			/* if(pData[ii][pTaxiDuty] == 1)
// 			{
// 				SendClientMessageEx(playerid, COLOR_YELLOW, "Taxi Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
// 			} */
// 		}
// 		return 1;
// 	}
// 	if(ph == 911)
// 	{
// 		if(pData[playerid][pCallTime] >= gettime())
// 			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

// 		Info(playerid, "Warning: This number for emergency crime only! Please wait for SAPD respon!");
// 		Info(playerid, "911: "WHITE_E"You have reached the emergency crime.");
// 		Info(playerid, "911: "WHITE_E"How can I help you?");
// 		SetPVarInt(playerid, "911", 1); 

// 		new Float:x, Float:y, Float:z;
// 		GetPlayerPos(playerid, x, y, z);

// 		pData[playerid][pCallTime] = gettime() + 60;

// 		Info(playerid, "Please leave your message after the beep:");
		
// 		// SetTimerEx("CallSAPDsep", 60000, false, "i", playerid); 
// 	}
// 	if(ph == 922)
// 	{
// 		if(pData[playerid][pCallTime] >= gettime())
// 			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

// 		Info(playerid, "Warning: This number for emergency  medical only! Please wait for SAMD respon!");
// 		Info(playerid, "922: "WHITE_E"You have reached the emergency medical .");
// 		Info(playerid, "922: "WHITE_E"How can I help you?");
// 		SetPVarInt(playerid, "922", 1); 

// 		new Float:x, Float:y, Float:z;
// 		GetPlayerPos(playerid, x, y, z);

// 		pData[playerid][pCallTime] = gettime() + 60;

// 		Info(playerid, "Please leave your message after the beep:");
		
// 		// SetTimerEx("CallSAMDsep", 60000, false, "i", playerid); 
// 	}
// 	if(ph == 123)
// 	{
// 		if(pData[playerid][pCallTime] >= gettime())
// 			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

// 		Info(playerid, "Warning: This number for SANews! Please wait for SANA respon!");
// 		Info(playerid, "123: "WHITE_E"You have reached the SANews .");
// 		Info(playerid, "123: "WHITE_E"How can I help you?");
// 		SetPVarInt(playerid, "123", 1); 

// 		new Float:x, Float:y, Float:z;
// 		GetPlayerPos(playerid, x, y, z);

// 		pData[playerid][pCallTime] = gettime() + 60;

// 		Info(playerid, "Please leave your message after the beep:");
		
// 		// SetTimerEx("CallSANsep", 60000, false, "i", playerid); 
// 	}
// 	if(ph == 999)
// 	{
// 		if(pData[playerid][pCallTime] >= gettime())
// 			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

//         Info(playerid, "999: "WHITE_E"You have reached the SAGS.");
// 		Info(playerid, "999: "WHITE_E"How can I help you?");
// 		SetPVarInt(playerid, "999", 1);

// 		new Float:x, Float:y, Float:z;
// 		GetPlayerPos(playerid, x, y, z);
// 		Info(playerid, "Warning: This number for government! please wait for SAGS respon!");
// 		//SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"Telp Umum"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
// 		SendFactionMessage(2, COLOR_LBLUE, "[SAGS CALL] "WHITE_E"%s calling the government! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
// 		pData[playerid][pCallTime] = gettime() + 60;
// 	}
// 	foreach(new ii : Player)
// 	{
// 		if(pData[ii][pPhone] == ph)
// 		{
// 			if(pData[ii][pPhoneStatus] == 0)
// 			{
// 				Error(playerid, "This number is not active!");
// 				return 1;
// 			}

// 			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii))
// 			{
// 				Error(playerid, "This number is not active!");
// 				return 1;
// 			}

// 			if(pData[ii][pCall] == INVALID_PLAYER_ID)
// 			{
// 				pData[playerid][pCall] = ii;

// 				SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
// 				SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE from %d] "WHITE_E"Your phone is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
// 				PlayerPlaySound(playerid, 3600, 0,0,0);
// 				PlayerPlaySound(ii, 6003, 0,0,0);
// 				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
// 				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and is calling someone.", ReturnName(playerid));
// 				return 1;
// 			}
// 			else
// 			{
// 				Error(playerid, "This number is currently busy.");
// 				return 1;
// 			}
// 		}
// 	}
// 	return 1;
// }


CMD:shakehand(playerid, params[])
{
	new String[10000], giveplayerid, style;
	if(sscanf(params, "ud", giveplayerid, style)) return SendClientMessageEx(playerid, COLOR_WHITE, "USE: /shakehand [playerid] [style (1-8)]");

	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid == playerid)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "You can't shake your own hand.");
			return 1;
		}
		if(style >= 1 && style < 9)
		{
			new Float: ppFloats[3];

			GetPlayerPos(giveplayerid, ppFloats[0], ppFloats[1], ppFloats[2]);

			if(!IsPlayerInRangeOfPoint(playerid, 5, ppFloats[0], ppFloats[1], ppFloats[2]))
			{
				SendClientMessageEx(playerid, COLOR_GREY, "You're too far away. You can't shake hands right now.");
				return 1;
			}

			SetPVarInt(playerid, "shrequest", giveplayerid);
			SetPVarInt(playerid, "shstyle", style);

			format(String, sizeof(String), "You have requested to shake %s's hand, please wait for them to respond.", pData[giveplayerid][pName]);
			SendClientMessageEx(playerid, COLOR_WHITE, String);

			format(String, sizeof(String), "%s has requested to shake your hand, please use {FFFF00}'/accept handshake'{FFFFFF} to approve the hand shake.", pData[playerid][pName]);
			SendClientMessageEx(giveplayerid, COLOR_WHITE, String);
		}
		else
		{
			Usage(playerid,"/shakehand [1-9]");
		}
	}
	else
	{
		 Error(playerid, "Invalid player specified.");
	}
	return 1;
}
CMD:adolbotol(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid,2.0, 1690.4587,-1222.3273,15.7241))
	{
		new total = pData[playerid][pBotol];
		if( pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
		if( pData[playerid][pBotol] < 1) return Error(playerid, "Anda Tidak Memiliki Botol Bekas");
		ShowProgressbar(playerid, "Menjual Botol..", 10);
		ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.0, 1, 0, 0, 0, 0,1);
		new pay = pData[playerid][pBotol] * 10;
		GivePlayerMoneyEx(playerid, pay);
		pData[playerid][pBotol] -= total;
		new str[500];
		format(str, sizeof(str), "Received_%dx", pay);
		ShowItemBox(playerid, "Uang", str, 1212, 4);
		format(str, sizeof(str), "Removed_%dx", total);
		ShowItemBox(playerid, "Botol", str, 1666, 4);
		Inventory_Update(playerid);
	}
	return 1;
}
CMD:bin(playerid, params[])
{
	if(GetNearbyTrash(playerid) >= 0)
	{
		for(new i = 0; i < MAX_Trash; i++)
		{
	    	if(IsPlayerInRangeOfPoint(playerid, 2.3, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
			{
				if(TrashData[i][Sampah] < 1) return Error(playerid, "Sampah Kosong!!");
				StartPlayerLoadingBar(playerid, 3, "Memulung...");
				pData[playerid][pBotol]++;
				ShowItemBox(playerid, "Botol", "ADD_1x", 1666, 2);
				Inventory_Update(playerid);
				TrashData[i][Sampah] -= 1;
				new query[128], str[512];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE trash SET sampah='%d' WHERE ID='%d'", TrashData[i][Sampah], i);
				mysql_tquery(g_SQL, query);
				Trash_Save(i);
				if(IsValidDynamic3DTextLabel(TrashData[i][TrashLabel]))
				DestroyDynamic3DTextLabel(TrashData[i][TrashLabel]);
				format(str, sizeof(str), "Trash Capacity {FFFF00}%d/100\n{ffffff}Tekan {00FF00}[ Y ] {ffffff}Untuk Membuang Sampah\nGunakan /bin untuk memungut sampah", TrashData[i][Sampah]);
				TrashData[i][TrashLabel] = CreateDynamic3DTextLabel(str, ARWIN, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]+1.0, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, TrashData[i][TrashWorld], TrashData[i][TrashInt], -1, 10.0);
			}
		}
	}
	return 1;
}


CMD:setrobwarung(playerid, params[])
{
    Warung = false;
    SuccesMsg(playerid, "Mereset Coldown Rob warung");
    return 1;
}
CMD:i(playerid, params[])
{
    if(pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
	//if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s sedang membuka tas", pData[playerid][pName]);
	HideRadialMenu(playerid);
	Inventory_Show(playerid);
	return 1;
}
CMD:togphone(playerid)
{
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	ShowPlayerDialog(playerid, DIALOG_TOGGLEPHONE, DIALOG_STYLE_LIST, "Setting", "Phone On\nPhone Off", "Select", "Back");
	return 1;
}
CMD:cursor(playerid, params[])
{
	SelectTextDraw(playerid, COLOR_YELLOW);
	SuccesMsg(playerid, "Menggunakan Fitur Cursor");
	return 1;
}
CMD:tenthelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_YELLOW,"_______________________________________");
	SendClientMessage(playerid, COLOR_WHITE,"*** Tent Help ***");
	SendClientMessage(playerid, COLOR_WHITE,"For place tent {AA3333}/createtent");
	SendClientMessage(playerid, COLOR_WHITE,"For Take tent {AA3333}/untent");
	return 1;
}
CMD:sleep(playerid,params[])
{
	if(PlayerTent[playerid] == 1)
	{
		if(GetPVarInt(playerid, "Sleeping") == 0)
		{
			    SendClientMessage(playerid, COLOR_WHITE, "Sleeping");
			    ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
				SetPVarInt(playerid, "Sleeping", 1);
		}
		else if(GetPVarInt(playerid, "Sleeping") == 1)
		{
			    SendClientMessage(playerid, COLOR_WHITE, "Wakeup.");
				SetPVarInt(playerid, "Sleeping", 0);
				ClearAnimations(playerid);
		}
	}
	else
	{
		 SendClientMessage(playerid, COLOR_WHITE, "You are not near / place your tent.");
	}
	return 1;
}
CMD:createtent(playerid)
{
	if(PlayerTent[playerid] == 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, " Anda Sudah Menempatkan Tenda");
	}
	else
	{
  		new string[128];
		format(string, sizeof(string), "%s telah meletakkan tendanya di tempatnya!", GetPlayerNameEx(playerid));
	    ProxDetector(30.0, playerid, string, COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);

	    new Float:x, Float:y, Float:z, Float:a;
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
	    ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_In", 4.0, 0, 0, 0, 0, 0, 1);
	    PlayerTent[playerid] = 1;
	    x += (5 * floatsin(-a, degrees));
    	y += (5 * floatcos(-a, degrees));
    	z -= 1.0;

	    SetPVarInt(playerid, "pTenda", CreateDynamicObject(3243, x, y, z, 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
	    SetPVarFloat(playerid, "pTentX", x); SetPVarFloat(playerid, "pTentY", y); SetPVarFloat(playerid, "pTentZ", z);
		format(string, sizeof(string), "{FF0000}Tent Owner {FFFF00}%s\n{FF0000}/untent", GetPlayerNameEx(playerid));
	    SetPVarInt(playerid, "pTentLabel", _:CreateDynamic3DTextLabel(string, COLOR_YELLOW, x, y, z+0.6, 5.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
		SetPVarInt(playerid, "pTentArea", CreateDynamicSphere(x, y, z, 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
		SetPVarInt(playerid, "pTentInt", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "pTentVW", GetPlayerVirtualWorld(playerid));
	}
	return 1;
}
CMD:untent(playerid, params[])
{
	if(GetPVarType(playerid, "pTenda"))
	{
	    DestroyDynamicObject(GetPVarInt(playerid, "pTenda"));
	    DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "pTentLabel"));
	    DeletePVar(playerid, "pTenda");  DeletePVar(playerid, "pTentLabel");
	    DeletePVar(playerid, "pTentX"); DeletePVar(playerid, "pTentY"); DeletePVar(playerid, "pTentZ");
	    PlayerTent[playerid] = 0;
	    if(GetPVarType(playerid, "pTentArea"))
	    {
			new string[128];
			format(string, sizeof(string), "* %s Has take the tent.", GetPlayerNameEx(playerid));
	        foreach(new i : Player)
	        {
	            if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "pTentArea")))
	            {
	                SendClientMessage(i, COLOR_PURPLE, string);
				}
			}
	        DeletePVar(playerid, "pTentArea");
		}
		SendClientMessage(playerid, COLOR_WHITE, "You has take your tent!");
	}
	else
	{
		foreach(new i : Player)
	    {
	        if(GetPVarType(i, "pTenda"))
	        {
				if(GetPVarInt(i, "pTentVW") == GetPlayerVirtualWorld(playerid) && GetPVarInt(i, "pTentInt") == GetPlayerInterior(playerid) && IsPlayerInRangeOfPoint(playerid, 5.0, GetPVarFloat(i, "pTentX"), GetPVarFloat(i, "pTentY"), GetPVarFloat(i, "pTentZ")))
				{
				    DestroyDynamicObject(GetPVarInt(i, "pTenda"));
				    DestroyDynamic3DTextLabel(Text3D:GetPVarInt(i, "pTentLabel"));

				    DeletePVar(i, "pTenda");
					DeletePVar(i, "pTentLabel");
				    DeletePVar(i, "pTentX");
				    PlayerTent[playerid] = 0;
					DeletePVar(i, "pTentY");
					DeletePVar(i, "pTentZ");
					DeletePVar(i, "pTentInt");
					DeletePVar(i, "pTentVW");

        			new string[128];
				    if(GetPVarType(i, "pTentArea"))
				    {
				        format(string, sizeof(string), "* %s Has take the tent.", GetPlayerNameEx(playerid));
				        foreach(new x : Player)
				        {
				            if(IsPlayerInDynamicArea(playerid, GetPVarInt(x, "pTentArea")))
				            {
				                SendClientMessage(playerid, COLOR_PURPLE, string);
							}
						}
				        DeletePVar(i, "pTentArea");
					}
				    format(string, sizeof(string), "%s Has destroy your tent!", GetPlayerNameEx(playerid));
				    SendClientMessage(i, COLOR_WHITE, string);
					return 1;
				}
			}
	    }
    	SendClientMessage(playerid, COLOR_WHITE, "You dont have any tent");
  	}
  	return 1;
}

CMD:race(playerid, params[])
{
	new type[24], string[128], Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(sscanf(params, "s[24]S()[128]", type, string))
	{
	    SendSyntaxMessage(playerid, "/race [names]");
	    SendClientMessage(playerid, COLOR_SERVER, "NAMES: {FFFFFF}savecp(1-5), finishcp, invite, start, kick");
	    return 1;
	}
	if(!strcmp(type, "savecp1", true))
	{
	    RaceData[playerid][racePos1][0] = pos[0];
	    RaceData[playerid][racePos1][1] = pos[1];
	    RaceData[playerid][racePos1][2] = pos[2];

	    SendServerMessage(playerid, "Checkpoint recorded!");
	}
	else if(!strcmp(type, "savecp2", true))
	{
	    RaceData[playerid][racePos2][0] = pos[0];
	    RaceData[playerid][racePos2][1] = pos[1];
	    RaceData[playerid][racePos2][2] = pos[2];

	    SendServerMessage(playerid, "Checkpoint recorded!");
	}
	else if(!strcmp(type, "savecp3", true))
	{
	    RaceData[playerid][racePos3][0] = pos[0];
	    RaceData[playerid][racePos3][1] = pos[1];
	    RaceData[playerid][racePos3][2] = pos[2];

	    SendServerMessage(playerid, "Checkpoint recorded!");
	}
	else if(!strcmp(type, "savecp4", true))
	{
	    RaceData[playerid][racePos4][0] = pos[0];
	    RaceData[playerid][racePos4][1] = pos[1];
	    RaceData[playerid][racePos4][2] = pos[2];

	    SendServerMessage(playerid, "Checkpoint recorded!");
	}
	else if(!strcmp(type, "savecp5", true))
	{
	    RaceData[playerid][racePos5][0] = pos[0];
	    RaceData[playerid][racePos5][1] = pos[1];
	    RaceData[playerid][racePos5][2] = pos[2];

	    SendServerMessage(playerid, "Checkpoint recorded!");
	}
	else if(!strcmp(type, "finishcp", true))
	{
	    RaceData[playerid][raceFinish][0] = pos[0];
	    RaceData[playerid][raceFinish][1] = pos[1];
	    RaceData[playerid][raceFinish][2] = pos[2];

	    SendServerMessage(playerid, "Finish checkpoint recorded!");
	}
	else if(!strcmp(type, "kick", true))
	{
	    new targetid;
	    if(sscanf(string, "u", targetid))
			return SendSyntaxMessage(playerid, "/race [kick] [playerid/name]");

		if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 5.0))
		    return SendErrorMessage(playerid, "That player is disconnected or not near you.");

		if(pData[targetid][pRaceWith] != playerid)
		    return SendErrorMessage(playerid, "That player is not on your race!");


		pData[targetid][pRaceWith] = INVALID_PLAYER_ID;
		pData[targetid][pRaceIndex] = 0;
		DisablePlayerRaceCheckpoint(targetid);
		SendServerMessage(playerid, "You've kick %s from your race!", ReturnName(targetid));
		SendServerMessage(targetid, "You've been kicked by %s from their race!", ReturnName(playerid));
	}
	else if(!strcmp(type, "invite", true))
	{
	    new targetid;
	    if(sscanf(string, "u", targetid))
			return SendSyntaxMessage(playerid, "/race [invite] [playerid/name]");

		if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 5.0))
		    return SendErrorMessage(playerid, "That player is disconnected or not near you.");

		if(pData[targetid][pRaceWith] != INVALID_PLAYER_ID)
		    return SendErrorMessage(playerid, "That player is already in any Race's!");

		if(pData[targetid][pRaceWith] == playerid)
		    return SendErrorMessage(playerid, "That player is already in your race!");

		pData[targetid][pRaceWith] = playerid;
		SendServerMessage(playerid, "You've invite %s to join your race!", ReturnName(targetid));
		SendServerMessage(targetid, "You've been invited by %s to join their race!", ReturnName(playerid));
	}
	else if(!strcmp(type, "start", true))
	{
	    if(RaceData[playerid][racePos1][0] == 0.0)
	        return SendErrorMessage(playerid, "You must record your CP's first!");

	    if(RaceData[playerid][racePos2][0] == 0.0)
	        return SendErrorMessage(playerid, "You must record your CP's first!");

	    if(RaceData[playerid][racePos3][0] == 0.0)
	        return SendErrorMessage(playerid, "You must record your CP's first!");

	    if(RaceData[playerid][racePos4][0] == 0.0)
	        return SendErrorMessage(playerid, "You must record your CP's first!");

	    if(RaceData[playerid][racePos5][0] == 0.0)
	        return SendErrorMessage(playerid, "You must record your CP's first!");

	    if(RaceData[playerid][raceFinish][0] == 0.0)
	        return SendErrorMessage(playerid, "You must record your Finish CP's first!");

		foreach(new i : Player) if(pData[i][pRaceWith] == playerid)
		{
		    SetRaceCP(i, 2, RaceData[pData[i][pRaceWith]][racePos1][0], RaceData[pData[i][pRaceWith]][racePos1][1], RaceData[pData[i][pRaceWith]][racePos1][2], 5.0);
			pData[i][pRaceIndex] = 1;
			GameTextForPlayer(i, "Race Started!", 3000, 5);
		}
	}
	return 1;
}
CMD:drone(playerid, params[])
{
	if(pData[playerid][pVip] < 3)
	    return SendErrorMessage(playerid, "You're not a VIP Player.");

	new str[128];
 	if( sscanf( params, "s", str ) ) return SendClientMessage( playerid, COLOR_RED, "USAGE: /drone [spawn/end]" );

  	if( strcmp( str, "spawn" ) == 0 ) {
  	    if( GetPVarInt( playerid, "DroneSpawned" ) == 0 ) {
  	        new Float:Health;
  	        GetPlayerHealth( playerid, Health );

  	        if(Health != 0) {
	  	        new Float:PosX, Float:PosY, Float:PosZ;
	  	        GetPlayerPos( playerid, PosX, PosY, PosZ );
	            SetPVarFloat( playerid, "OldPosX", PosX );
				SetPVarFloat( playerid, "OldPosY", PosY );
				SetPVarFloat( playerid, "OldPosZ", PosZ );
		 	    SetPVarInt( playerid, "DroneSpawned", 1 );
		 	    SendClientMessage( playerid, COLOR_GREEN, "You have successfully spawned a drone." );
		 	    Drones[playerid] = CreateVehicle( 465, PosX, PosY, PosZ + 20, 0, 0, 0, 0, -1 );
		 	    PutPlayerInVehicle( playerid, Drones[playerid], 0 );
			}
	  	} else {
	  	    SendClientMessage( playerid, COLOR_RED, "You already have a drone spawned in!" );
	  	}
 	} else {
 	    if( strcmp( str, "ex" ) == 0 ) {
	  	    if( GetPVarInt( playerid, "DroneSpawned" ) == 1 ) {
	  	        new Float:PosX, Float:PosY, Float:PosZ;
	  	        GetVehiclePos( Drones[playerid], PosX, PosY, PosZ );

		 	    SetPVarInt( playerid, "DroneSpawned", 0 );
		 	    SendClientMessage( playerid, COLOR_GREEN, "Drone successfully detonated." );
				DestroyVehicle( Drones[playerid] );

				CreateExplosion( PosX, PosY, PosZ, 7, 25 );

				SetPlayerPos(playerid, GetPVarFloat( playerid, "OldPosX" ), GetPVarFloat( playerid, "OldPosY" ), GetPVarFloat( playerid, "OldPosZ" ));
		  	} else {
		  	    SendClientMessage( playerid, COLOR_RED, "You need to have a drone spawned in!" );
		  	}
	 	} else {
	 	    if( strcmp( str, "end" ) == 0 ) {
		  	    if( GetPVarInt( playerid, "DroneSpawned" ) == 1 ) {
			 	    SetPVarInt( playerid, "DroneSpawned", 0 );
			 	    SendClientMessage( playerid, COLOR_GREEN, "You have shut your drone down." );
			 	    DestroyVehicle( Drones[playerid] );

			 	    SetPlayerPos(playerid, GetPVarFloat( playerid, "OldPosX" ), GetPVarFloat( playerid, "OldPosY" ), GetPVarFloat( playerid, "OldPosZ" ));
			  	} else {
			  	    SendClientMessage( playerid, COLOR_RED, "You need to have a drone spawned in!" );
			  	}
		 	}
	 	}
 	}
 	return 1;
}
CMD:eradio(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_LIST, "Amplifier Car", "Matikan Amplifier\nRasah Bali Rimek\nAnother love\nRight Now One Direction\nLast Child Duka\nMX Sengkuni\nKalih Welasku Rimek\nLatino Rimek\nReckless\nNext Request Saya Di Website", "Putar", "Close");
	//ShowPlayerDialog(playerid, 	DIALOG_RADIO,, DIALOG_STYLE_LIST, "Car Menu", "Mesin\nBuka/Kunci Kendaraan\nBuka/Tutup Trunk\nBuka/Tutup Hood\nCek Bagasi[Maintennace]\nLampu\nPark\nCek insu\nCek kendaraan\nNeon", "Pilih", "Tidak");
    return 1;
}
CMD:car(playerid, params[])
{
	ShowPlayerDialog(playerid, CAR_MENU, DIALOG_STYLE_LIST, "Car Menu", "Mesin\nBuka/Kunci Kendaraan\nBuka/Tutup Trunk\nBuka/Tutup Hood\nCek Bagasi[Maintennace]\nLampu\nPark\nCek insu\nCek kendaraan\nNeon", "Pilih", "Tidak");
    return 1;
}
CMD:propose(playerid, params[])
{
	if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1464.7244,751.3544,12.6962))
    {
        return Error(playerid, "Kamu harus berada di penukaran uang.");
    }
	if(GetPlayerMoney(playerid) < 100000)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "The Marriage & Reception costs $100000!");
		return 1;
	}
	if(pData[playerid][pMarried] > 0)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "You are already Married!");
		return 1;
	}

	new String[512], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_WHITE, "KEGUNAAN: /propose [playerid]");

	if(IsPlayerConnected(giveplayerid))
	{
		if(pData[giveplayerid][pMarried] > 0)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player is already married!");
			return 1;
		}
		if (ProxDetectorS(8.0, playerid, giveplayerid))
		{
			if(giveplayerid == playerid) { SendClientMessageEx(playerid, COLOR_GREY, "You cannot Propose to yourself!"); return 1; }
			format(String, sizeof(String), "* You proposed to %s.", ReturnName(giveplayerid));
			SendClientMessageEx(playerid, COLOR_GREEN, String);
			format(String, sizeof(String), "* %s just proposed to you (type /accept marriage) to accept.", ReturnName(playerid));
			SendClientMessageEx(giveplayerid, COLOR_GREEN, String);
			pData[giveplayerid][pMarriedAccept] = playerid;
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player isn't near you.");
			return 1;
		}

	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		return 1;
	}
	return 1;
}
CMD:cerai(playerid, params[])
{
	if(pData[playerid][pMarried] < 0)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "You are already Married!");
		return 1;
	}

	new String[500], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_WHITE, "KEGUNAAN: /cerai [playerid]");

	if(IsPlayerConnected(giveplayerid))
	{
		if(pData[giveplayerid][pMarried] < 0)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player is already married!");
			return 1;
		}
		if (ProxDetectorS(8.0, playerid, giveplayerid))
		{
			if(giveplayerid == playerid) { SendClientMessageEx(playerid, COLOR_GREY, "You cannot Propose to yourself!"); return 1; }
			format(String, sizeof(String), "* Kamu mengajak cerai/pisah %s.", ReturnName(giveplayerid));
			SendClientMessageEx(playerid, COLOR_BLUE, String);
			format(String, sizeof(String), "* %s Mengajak cerai/pisah kamu (type /accept cerai) to accept.", ReturnName(playerid));
			SendClientMessageEx(giveplayerid, COLOR_BLUE, String);
			pData[giveplayerid][pMarriedCancel] = playerid;
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That player isn't near you.");
			return 1;
		}

	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		return 1;
	}
	return 1;
}
CMD:accent(playerid, params[])
{
	if(pData[playerid][pLevel] < 4) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 4 ke atas");

	new length = strlen(params), idx, String[256];
	while ((idx < length) && (params[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[16];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = params[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	if(!strlen(result))
	{
		SyntaxMsg(playerid, "/accent [name]");
		return 1;
	}
	format(pData[playerid][pAccent], 80, "%s", result);
	format(String, sizeof(String), "ACCENT: {ffffff}Your character's accent has been set to '{ffff00}%s{ffffff}'", pData[playerid][pAccent]);
	SendClientMessageEx(playerid,ARWIN,String);
	SendClientMessageEx(playerid,ARWIN,"NOTE: Jika ingin menghapus accent gunakan command "YELLOW_E"'/offaccent'");
	return 1;
}

CMD:offaccent(playerid, params[])
{
	if(pData[playerid][pLevel] ==  1) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pLevel] ==  2) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pLevel] ==  3) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pLevel] ==  4) 
		return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");
	if(pData[playerid][pTogAccent] == 1)
	{
		SendClientMessageEx(playerid, ARWIN, "ACCENT: "WHITE_E"Accent OFF!");
		pData[playerid][pTogAccent] = 0;
	}	
	return 1;
}
CMD:userokok(playerid, params[])
{
	if(pData[playerid][pHealth] == 100)
		return Error(playerid, "Anda Bisa Melakukannya Lagi Nanti");

	if(IsPlayerConnected(playerid)) 
	{

		if(pData[playerid][pRokok] < 1)
			return Error(playerid, "Anda tidak memiliki rokok.");

		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
		pData[playerid][pRokok]--;
		pData[playerid][pHealth] += 1;
	}
	return 1;
}
CMD:ngamen(playerid)
{
	SetPlayerAttachedObject(playerid, 4, 19317, 6, -0.007, 0.079, -0.346, 6.300, 11.300, -173.699);
	ApplyAnimation(playerid, "DILDO", "DILDO_IDLE", 4.1, 1, 1, 1, 1, 1, 1);
	Servers(playerid, "Gunakan /offngamen Untuk selesai mengamen.");
	return 1;
}
CMD:offngamen(playerid)
{
	Servers(playerid, "Anda selesai mengamen.");
    RemovePlayerAttachedObject(playerid, 4);
    return 1;
}


CMD:buyclip(playerid, params[])
{
	if(pData[playerid][pFamily] == -1)  return Error(playerid, "Cuman family yang bisa beli.");
	if(IsPlayerInRangeOfPoint(playerid,2.0, 2371.1223,-646.4237,128.1688))
	{
	    ShowPlayerDialog(playerid, DIALOG_BELICLIP, DIALOG_STYLE_LIST, "Jenis Clip","Clip DE\nClip SG\nClip AK47","Pilih","Batal");
	}
	return 1;
}

CMD:clip(playerid,params[])
{
	ShowPlayerDialog(playerid, DIALOG_CLIP, DIALOG_STYLE_LIST, "Jenis CLIP", "Clip DE\nClip SG\nClip AK47", "Reload", "Tutup");
	return 1;
}

// CMD:damages(playerid, params[])
// {
// 	if(pData[playerid][IsLoggedIn] == false)
// 		return Error(playerid, "Kamu harus login!");

// 	ShowPlayerDamages(playerid, playerid);
// 	return 1;
// }

CMD:putplayer(playerid, params[])
{
	new giveplayerid, seat;
	if(sscanf(params, "ud", giveplayerid, seat)) return SyntaxMsg(playerid, "/putplayer [playerid] [seatid 1-3]");

	if(!IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You can't do this while you're in a vehicle.");

	if(seat < 1 || seat > 3)
		return Error(playerid, "The seat ID cannot be above 3 or below 1.");

	if(IsPlayerInAnyVehicle(giveplayerid))
		return Error(playerid, "That person is in a car - get them out first.");

	if(giveplayerid == INVALID_PLAYER_ID)
    	return Error(playerid, "That player is disconnected.");

    if(giveplayerid == playerid)
        return Error(playerid, "You cannot put yourself.");

    if(!NearPlayer(playerid, giveplayerid, 5.0))
        return Error(playerid, "You must be near this player.");

    //if(!pData[giveplayerid][pInjured])
        //return Error(playerid, "That person is not injured!.");

	new carid = GetPlayerVehicleID(playerid);
	new Float:pos[6];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerPos(giveplayerid, pos[3], pos[4], pos[5]);
	GetVehiclePos( carid, pos[0], pos[1], pos[2]);
	if (floatcmp(floatabs(floatsub(pos[0], pos[3])), 10.0) != -1 &&
	floatcmp(floatabs(floatsub(pos[1], pos[4])), 10.0) != -1 &&
	floatcmp(floatabs(floatsub(pos[2], pos[5])), 10.0) != -1) return false;
	Info(giveplayerid, "You were put in vehicle by %s .", ReturnName(playerid));
	Info(playerid, "Put %s To Vehicle.", ReturnName(giveplayerid));

	ClearAnimations(giveplayerid);
	PutPlayerInVehicle(giveplayerid, carid, seat);

	return 1;
}

CMD:checksalary(playerid, parms[])
{
	new tax = RandomEx(30, 55);
	pData[playerid][pBankMoney] -= tax;
    SendClientMessage(playerid, -1, "{00ffff}========[{ffff00} Paycheck {00ffff}]========");
    SendClientMessageEx(playerid, -1, "Bank Money: {00ff00}%s", FormatMoney(pData[playerid][pBankMoney]));
    SendClientMessageEx(playerid, -1, "Money: {00ff00}%s", FormatMoney(pData[playerid][pMoney]));
    SendClientMessageEx(playerid, -1, "Tax Money: {ff0000}%s", FormatMoney(tax));
    SendClientMessage(playerid, -1, "{00ffff}============================");
	PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
	return 1;
}

CMD:twlist(playerid)
{
	new mstr[4000];
	mstr = "Player Name\tTweet Name\n";
	foreach (new i : Player)
	{
		if(pData[i][pTwitter] == 1)
		{
			format(mstr, sizeof(mstr), "%s%s[%d]\t"YELLOW_E"%s\n", mstr, pData[i][pName], i, pData[i][pTwittername]);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "List Tweet Account", mstr, "Close","");
		}
	}
}


CMD:destroycp(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pSideJob] < 1 || pData[playerid][pCP] > 1)
		return Error(playerid, "Harap selesaikan Pekerjaan mu terlebih dahulu");

	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SuccesMsg(playerid, "Menghapus Checkpoint Sukses");
	return 1;
}
CMD:id(playerid, params[])
{	
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/checkid [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");
	
	new string[128];
	GetPlayerVersion(otherid, string, sizeof string);	
	
	Servers(playerid, "(ID: %d) - Name: %s - (Level:%d) - (Ping:%d) - (Packetloss:%.2f) - Version: %s", otherid, GetPlayerNameEx(otherid), pData[otherid][pLevel], GetPlayerPing(otherid), NetStats_PacketLossPercent(otherid), string);
	return 1;
}
CMD:changelog(playerid, params[])
{
	new line3[3500];
    strcat(line3, "_________[{00FFFC}Changed Logs Fountain Daily 31 Juli 2024{ffffff}]_________\n");
    strcat(line3, "- Add mysql broken cstolen\n");
    strcat(line3, "- Add mapping workshop conference\n");
    strcat(line3, "- Add dialog /gps > dealer restock\n");
    strcat(line3, "- Add streamer tag 3d text label in gas fuel\n");
    strcat(line3, "- Add edit price vehicle in cmd /dealermanage\n");
    strcat(line3, "- Fix cmd /missions\n");
    strcat(line3, "- Fix cmd /takeweapon\n");
    strcat(line3, "- Renew price restock dealer\n");
    strcat(line3, "- Renew cmd /buycrack only be purchased with redmoney\n");
    strcat(line3, "- Renew system dealership\n");
    strcat(line3, "- Delete fitur garkot (pakai /mv > despawn)\n");
    strcat(line3, "- Delete textdraw notifikasi\n");
    strcat(line3, "- Delete mapping workshop rodeo & smb\n");
    strcat(line3, "- Reset all trunk vehicle weapon\n");
	strcat(line3, "- Delete paytax vehicle\n");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Changelogs", line3, "OK", "");

	return 1;
}
CMD:faq(playerid)
{
    new String[10280];
	format(String, sizeof String, "Q: Apa Saja Yang Kami Tambahkan(1)\nA: Warga bisa membuat senjata SLC & Colt\nQ:Apakah Ada Bug?\nA:Kami Memastikan Bahwa Tidak ada bug\nQ: Apakah Fitur Ini Menarik\nA: Kami Jamin Menarik Untuk Anda\nQ: Apa Yang Di Ubah\nA: System Pekerjaan Dan Fitures Langka\nQ: Mappingan Apa Saja Yang Di Tambahkan\nA: Allfaction,Job,DLL\n\n"LB_E"For more information: {FFF000}https://discord.gg/Fountain Dailyrp");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "F.A.Q", String, "OK", "");
}
CMD:credits(playerid)
{
    new line1[1200], line2[300], line3[500];
    strcat(line3, ""LB_E"Server Owner: "YELLOW_E"Krenoiz\n");
    strcat(line3, ""LB_E"Developer: "YELLOW_E"Hash\n");
    strcat(line3, ""LB_E"Mappers: "YELLOW_E"Krenoiz\n");
    format(line2, sizeof(line2), ""LB_E"Server Support: "YELLOW_E"%s & All Crews FD:RP\n\n\
    "LB_E"Terima kasih telah bergabung dengan kami! Copyright © 2024 | Fountain Daily Roleplay.", pData[playerid][pName]);
    format(line1, sizeof(line1), "%s%s", line3, line2);
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""LB_E"Fountain Daily:RP: "WHITE_E"Server Credits", line1, "OK", "");
    return 1;
}

// CMD:vip(playerid)
// {
// 	new longstr2[3500];
// 	strcat(longstr2, ""YELLOW_E"Looking for bonus features and commands? Get premium status today!\n\n"RED_E"Premium features:\n\
// 	"dot""GREEN_E"Regular(1) "PINK_E"Rp.50.000/month"RED_E"|| "PINK_E"Features:\n\
// 	"YELLOW_E"1) "WHITE_E"Slot Rumah Bertambah  "LB_E"1 "WHITE_E".\n");
// 	strcat(longstr2, ""YELLOW_E"2) "WHITE_E"Slot Kendaraan Bertambah "LB_E"1 "WHITE_E".\n");

// 	strcat(longstr2, ""YELLOW_E"3) "WHITE_E"Slot Bisnis Bertambah "LB_E"1 "WHITE_E".\n\
// 	"YELLOW_E"4) "WHITE_E"Include Akses Iklan VIP Di  "LB_E"HP\n\
// 	"YELLOW_E"5) "WHITE_E"Paychek Lebih Cepat "LB_E"10%\n");
// 	strcat(longstr2, ""YELLOW_E"6) "WHITE_E"Include Roleplay Booster  "LB_E"30 Hari\n\
// 	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips & /vchat"WHITE_E".\n");
// 	strcat(longstr2, ""YELLOW_E"8) "WHITE_E"Role Server Donatur.\n");


// 	strcat(longstr2, "\n\n"dot""YELLOW_E"Premium(2) "PINK_E"Rp.70,000/month "RED_E"|| "PINK_E"Features:\n\
// 	"YELLOW_E"1) "WHITE_E"Slot Rumah Bertambah  "LB_E"2 "WHITE_E".\n");
// 	strcat(longstr2, ""YELLOW_E"2) "WHITE_E"Slot Kendaraan Bertambah "LB_E"2 "WHITE_E".\n");

// 	strcat(longstr2, ""YELLOW_E"3) "WHITE_E"Slot Bisnis Bertambah "LB_E"2 "WHITE_E".\n\
// 	"YELLOW_E"4) "WHITE_E"Include Akses Iklan VIP Di  "LB_E"HP\n\
// 	"YELLOW_E"5) "WHITE_E"Paychek Lebih Cepat "LB_E"10%\n");
// 	strcat(longstr2, ""YELLOW_E"6) "WHITE_E"Include Roleplay Booster  "LB_E"30 Hari\n\
// 	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips & /vchat"WHITE_E".\n");
// 	strcat(longstr2, ""YELLOW_E"8) "WHITE_E"Role Server Donatur.\n");

// 	strcat(longstr2, "\n\n"dot""PURPLE_E"VIP Diamond(3) "PINK_E"Rp.90,000/month "RED_E"|| "PINK_E"Features:\n\
// 	"YELLOW_E"1) "WHITE_E"Slot Rumah Bertambah  "LB_E"3 "WHITE_E".\n");
// 	strcat(longstr2, ""YELLOW_E"2) "WHITE_E"Slot Kendaraan Bertambah "LB_E"3 "WHITE_E".\n");

// 	strcat(longstr2, ""YELLOW_E"3) "WHITE_E"Slot Bisnis Bertambah "LB_E"3 "WHITE_E".\n\
// 	"YELLOW_E"4) "WHITE_E"Include Akses Iklan VIP Di  "LB_E"HP\n\
// 	"YELLOW_E"5) "WHITE_E"Paychek Lebih Cepat "LB_E"10%\n");
// 	strcat(longstr2, ""YELLOW_E"6) "WHITE_E"Include Roleplay Booster  "LB_E"30 Hari\n\
// 	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips & /vchat"WHITE_E".\n");
// 	strcat(longstr2, ""YELLOW_E"8) "WHITE_E"Role Server Donatur.\n");

// 	strcat(longstr2, "\n\n"dot""GREEN_E"VIP Bronze(1) "PINK_E"Rp.100,000/Permanent");
// 	strcat(longstr2, "\n\n"dot""YELLOW_E"VIP Premium(3) "PINK_E"Rp.125,000/Permanent");
// 	strcat(longstr2, "\n\n"dot""PURPLE_E"VIP Diamond(3) "PINK_E"Rp.150,000/Permanent");

// 	strcat(longstr2, "\n\n"LB_E"Pembayaran Via QR All payment / BRI. "LB2_E"Harga VIP Gold "LB_E"70 Gold/Rp.15.000\n\
// 	"YELLOW_E"Untuk informasi selengkapnya hubungi (Server Owner di Discord)!");
// 	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Fountain Daily:RP "PINK_E"VIP SYSTEM", longstr2, "Close", "");
// 	return 1;
// }


CMD:shareloc(playerid, params[])
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

			new
				Float: X,
				Float: Y,
				Float: Z;

			GetPlayerPos(playerid, X, Y, Z);
			SetPlayerCheckpoint(ii, X, Y, Z, 5.0);
			return 1;
		}
	}
	return 1;
}

CMD:tagaads(playerid, params[])
{
    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        SyntaxMsg(playerid, "/tag [text]");
		Info(playerid, "Use /tag off to disable or delete the tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pAdoActive])
            return Error(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pCatTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pCatTag]);

        Servers(playerid, "You're removed your ado text.");
        pData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n[ %s ]", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64)
	{
        SendNearbyMessage(playerid, 20.0, COLOR_BLUE, "* [TAG]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_BLUE, ".. %s", params[64]);
    }
    else
	{
        SendNearbyMessage(playerid, 20.0, COLOR_BLUE, "* [TAG]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pCatTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pAdoTag], COLOR_BLUE, flyingtext);
        else
            pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_BLUE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pAdoActive] = true;
        pData[playerid][pCatTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_BLUE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[TAG] %s(%d) : %s", ReturnName(playerid), playerid, params);
    return 1;
}
// CMD:donate(playerid, params[])
// {
//     new line3[3500];
//     strcat(line3, ""RED_E"...:::... "DOOM_"Donate List Fountain Daily Roleplay "RED_E"...:::...\n");
//     strcat(line3, ""RED_E"..:.. "DOOM_"GOLD(OOC) "RED_E"..:..\n\n");

//     strcat(line3, ""DOOM_"1. 250 Gold >> "RED_E"Rp 15.000\n");
//     strcat(line3, ""DOOM_"2. 525 Gold >> "RED_E"Rp 25.000\n");
// 	strcat(line3, ""DOOM_"3. 1125 Gold >> "RED_E"Rp 50.000\n");
//     strcat(line3, ""DOOM_"4. 2150 Gold >> "RED_E"Rp 100.000\n");
// 	strcat(line3, ""DOOM_"5. 3125 Gold >> "RED_E"Rp 150.000\n");
//     strcat(line3, ""DOOM_"6. 4200 Gold >> "RED_E"Rp 200.000\n\n");

// 	strcat(line3, ""RED_E"..::.. "DOOM_"VIP PLAYER "RED_E"..::..\n\n");
	
//     strcat(line3, ""DOOM_"1. VIP Regular(1 Month) >> "RED_E"500 Gold\n");
//     strcat(line3, ""DOOM_"2. VIP Premium(1 Month) >> "RED_E"900 Gold\n");
//     strcat(line3, ""DOOM_"3. VIP Platinum(1 Month) >> "RED_E"1200 Gold\n\n");

// 	strcat(line3, ""RED_E"..:::.. "DOOM_"SERVER FEATURE "RED_E"..:::..\n\n");
//     strcat(line3, ""DOOM_"1. Mapping(per object) >> "RED_E"60 Gold\n");
// 	strcat(line3, ""DOOM_"2. Private Door >> "RED_E"100 Gold\n");
// 	strcat(line3, ""DOOM_"3. Private Gate >> "RED_E"200 Gold\n");
// 	strcat(line3, ""DOOM_"4. Bisnis >> "RED_E"(Tergantung Lokasi)\n");
// 	strcat(line3, ""DOOM_"5. House >> "RED_E"(Tergantung Lokasi dan Type)\n");
// 	strcat(line3, ""DOOM_"6. Custom House Interior >> "RED_E"(Tergantung Interior)\n\n");
	
// 	strcat(line3, ""RED_E"..::::.. "DOOM_"SERVER VEHICLE "RED_E"..:::::..\n\n");
//     strcat(line3, ""DOOM_"1. VEHICLE IN DEALER >> "RED_E"1200 Gold\n");
// 	strcat(line3, ""DOOM_"2. VEHICLE NON DEALER >> "RED_E"1800 Gold\n");
// 	strcat(line3, ""DOOM_"3. BOAT / HELI >> "RED_E"2300 Gold\n\n");

//     strcat(line3, ""RED_E"..::.. "WHITE_E"CONTACT INFO "RED_E"..::..\n");
//     strcat(line3, ""WHITE_E"1. NAMA : "RED_E"lenz Owner Server\n");
//     strcat(line3, ""WHITE_E"-  WHATSAPP: "RED_E"+6283134513162\n\n");

//     strcat(line3, ""RED_E"..::.. "WHITE_E"NOTE "RED_E"..::..\n");
//     strcat(line3, ""WHITE_E"Note: "RED_E"Pembayaran Via Rekening BRi, Gopay, Dana, OVO, Saweria!\n\n");

// 	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Fountain Daily: "WHITE_E"DONATE LIST", line3, "Okay", "");
// 	return 1;
// }

CMD:email(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login!");

	ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, ""WHITE_E"Set Email", ""WHITE_E"Masukkan Email.\nIni akan digunakan sebagai ganti kata sandi.\n\n"RED_E"* "WHITE_E"Email mu tidak akan termunculkan untuk Publik\n"RED_E"* "WHITE_E"Email hanya berguna untuk verifikasi Password yang terlupakan dan berita lainnya\n\
	"RED_E"* "WHITE_E"Be sure to double-check and enter a valid email address!", "Enter", "Exit");
	return 1;
}

CMD:changepass(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login sebelum menggantinya!");

	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_INPUT, ""WHITE_E"Change your password", "Masukkan Password untuk menggantinya!", "Change", "Exit");
	InfoTD_MSG(playerid, 3000, "~g~~h~Masukkan password yang sebelum nya anda pakai!");
	return 1;
}

CMD:savestats(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu belum login!");
		
	UpdateWeapons(playerid);
	UpdatePlayerData(playerid);
	SuccesMsg(playerid, "Statistik Anda sukses disimpan kedalam Database!");
	return 1;
}

CMD:gshop(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new Dstring[712];
	format(Dstring, sizeof(Dstring), "Gold Shop\tPrice\n\
	%sClear Warning\t100 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 1(7 Days)\t1600 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 2(7 Days)\t2600 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 3(7 Days)\t3400 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sMengganti No HP (Vip silver)\t 150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sMengganti No Mask (Vip silver)\t 150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sMengganti No Rek (Vip silver)\t 150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sCustom Rank (Vip silver)\t 300 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sCustom Mapping House\t 4500 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sCustom Mapping Bussines\t 5000 Gold\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_GOLDSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Gold Shop", Dstring, "Buy", "Cancel");
	return 1;
}


CMD:mypos(playerid, params[])
{
	new int, Float:px,Float:py,Float:pz, Float:a;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, a);
	int = GetPlayerInterior(playerid);
	new zone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, zone, sizeof(zone));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lokasi Anda Saat Ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) Int = %d", zone, px, py, pz, a, int);
	return 1;
}

CMD:gps(playerid, params[])
{
	if(pData[playerid][pGPS] < 1) return Error(playerid, "Anda tidak memiliki GPS.");
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission\nPublic Garage", "Select", "Close");
	return 1;
}

CMD:tolong(playerid, params[])
{
	if(CallRescueDelay[playerid] > gettime())
		return Error(playerid, "You must wait %d seconds.", CallRescueDelay[playerid]-gettime());

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

    if(pData[playerid][pInjured] == 0)
        return Error(playerid, "Kamu belum injured.");
		
	if(pData[playerid][pJail] > 0)
		return Error(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");
		
	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

	CallRescueDelay[playerid] = gettime()+180;
	SendFactionMessage(3, COLOR_PINK, "Requesting rescue: [{ffffff}%s{ff69ff}] Loc: [{ffffff}%s{ff69ff}]", ReturnName(playerid), GetLocation(x, y, z));
    foreach(new ii : Player)
	{
		if(pData[ii][pFaction] == 3)
		{
			SetPlayerRaceCheckpoint(ii, 2, x, y, z, 0.0, 0.0, 0.0, 3.5);
		}
	}

	return 1;
}

CMD:death(playerid, params[])
{
    if(pData[playerid][pInjured] == 0)
        return Error(playerid, "Kamu belum injured.");
		
	if(pData[playerid][pJail] > 0)
		return Error(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");
		
	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

    if((gettime()-GetPVarInt(playerid, "GiveUptime")) < 300)
        return Error(playerid, "Kamu harus menunggu 5 menit untuk kembali kerumah sakit");
        
	/*if(pMatiPukul[playerid] == 1)
	{
	    SetPlayerHealthEx(playerid, 50.0);
	    ClearAnimations(playerid);
	    pData[playerid][pInjured] = 0;
	    pMatiPukul[playerid] = 0;
    	Servers(playerid, "You have wake up and accepted death in your position.");
    	return 1;
	}*/
    SuccesMsg(playerid, "Kamu telah terbangun dari pingsan.");
	pData[playerid][pHospitalTime] = 0;
	pData[playerid][pHospital] = 1;
	HideTdDeath(playerid);
    return 1;
}

CMD:piss(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");

	new time = (100 - pData[playerid][pBladder]) * (300);
    SetTimerEx("UnfreezePee", time, 0, "i", playerid);
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}

stock GetCondition(rating, output[], outputSize) {
    if (rating < 30) {
        format(output, outputSize, ""RED_E"Bleeding"WHITE_E"");
    } else {
        format(output, outputSize, ""GREEN_E"Normal"WHITE_E"");
    }
}

CMD:health(playerid, params[]) {
    if (IsAtEvent[playerid] == 1) {
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
    }

    new hstring[512];
    new info[1024];
    new hh = pData[playerid][pHead];
    new hp = pData[playerid][pPerut];
    new htk = pData[playerid][pRHand];
    new htka = pData[playerid][pLHand];
    new hkk = pData[playerid][pRFoot];
    new hkka = pData[playerid][pLFoot];
    new playerName[24]; 
    new dialogTitle[50];

	GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
    info[0] = '\0';
	format(dialogTitle, sizeof(dialogTitle), "Health Condition\n%s", playerName);
	format(info, sizeof(info), "===[Body part status]==="WHITE_E"\n\n");
    new condition[500];

   
	GetCondition(hh, condition, sizeof(condition));
    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Head"WHITE_E" | Condition: %s\n", condition);
    strcat(info, hstring);

    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Torso"WHITE_E" | Fitness Rating: %.2f\n", pData[playerid][pFitnessRating][0]);
    strcat(info, hstring);

    GetCondition(hp, condition, sizeof(condition));
    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Groin"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", pData[playerid][pFitnessRating][1], condition);
    strcat(info, hstring);

    GetCondition(htk, condition, sizeof(condition));
    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Right Arm"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", pData[playerid][pFitnessRating][2], condition);
    strcat(info, hstring);

    GetCondition(htka, condition, sizeof(condition));
    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Left Arm"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", pData[playerid][pFitnessRating][3], condition);
    strcat(info, hstring);

    GetCondition(hkk, condition, sizeof(condition));
    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Right Leg"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", pData[playerid][pFitnessRating][4], condition);
    strcat(info, hstring);

    GetCondition(hkka, condition, sizeof(condition));
    format(hstring, sizeof(hstring), "Part: "YELLOW_E"Left Leg"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", pData[playerid][pFitnessRating][5], condition);
    strcat(info, hstring);

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, dialogTitle, info, "Oke", "");

    return 1;
}

CMD:sleeps(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
	
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "Kamu tidak berada didalam rumah.");
	
	InfoTD_MSG(playerid, 10000, "Sleeping... Harap Tunggu");
	TogglePlayerControllable(playerid, 0);
	pData[playerid][pBladder] -= 90;
	new time = (100 - pData[playerid][pBladder]) * (400);
    SetTimerEx("UnfreezeSleep", time, 0, "i", playerid);
	switch(random(6))
	{
		case 0: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L",4.1,0,0,0,1,1);
		case 1: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R",4.1,0,0,0,1,1);
		case 2: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L",4.1,1,0,0,1,1);
		case 3: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R",4.1,1,0,0,1,1);
		case 4: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_L",4.1,0,1,1,0,0);
		case 5: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_R",4.1,0,1,1,0,0);
	}
	return 1;
}

CMD:time(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login!");
		
	new line2[1200];
	new paycheck = 3600 - pData[playerid][pPaycheck];
	if(paycheck < 1)
	{
		paycheck = 0;
	}
	
	format(line2, sizeof(line2), ""WHITE_E"Paycheck Time: "YELLOW_E"%d remaining\n"WHITE_E"Delay Job: "RED_E"%d Detik\n"WHITE_E"Delay Side Job: "RED_E"%d Detik\n"WHITE_E"Plant Time(Farmer): "RED_E"%d Detik\n"WHITE_E"Arrest Time: "RED_E"%d Detik\n"WHITE_E"Jail Time: "RED_E"%d Detik\n"WHITE_E"Truck Time: "RED_E"%d Detik\n"WHITE_E"Weapon Created: "RED_E"%d Detik\n", paycheck, pData[playerid][pJobTime], pData[playerid][pSideJobTime], pData[playerid][pPlantTime], pData[playerid][pArrestTime], pData[playerid][pJailTime], pData[playerid][pTruckerTime], pData[playerid][pDelaySenjata]);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Fountain Daily RP: "WHITE_E"Time", line2, "Oke", "");
	return 1;
}
CMD:idcard(playerid, params[])
{
	if(pData[playerid][pIDCard] == 0) return Error(playerid, "Anda tidak memiliki id card!");
	
    if(!IsPlayerConnected(playerid))
        return Error(playerid, "Anda tidak terhubung.");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendClientMessageEx(playerid, COLOR_LBLUE, "[ID-Card Information].");
	SendClientMessageEx(playerid, COLOR_YELLOW, "Name: {ffffff}%s.", pData[playerid][pName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, "Brithday: {ffffff}%s.",pData[playerid][pAge]);	
	SendClientMessageEx(playerid, COLOR_YELLOW, "Expire: {ffffff}%s.", ReturnTimelapse(gettime(), pData[playerid][pIDCardTime]));
	SendClientMessageEx(playerid, COLOR_YELLOW, "Gender: {ffffff}%s.", sext);
	SendClientMessageEx(playerid, COLOR_YELLOW, "VIP: {ffffff}%s.", GetVipRank(playerid));
	Info(playerid, "You show your ID card to {ffff00}%s.", ReturnName(playerid));
	return 1;
}
CMD:showidcard(playerid, params[])
{
	if(pData[playerid][pIDCard] == 0) return Error(playerid, "Anda tidak memiliki id card!");
	new otherid;
	if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/showidcard [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendClientMessageEx(otherid, COLOR_LBLUE, "[ID-Card Information].");
	SendClientMessageEx(otherid, COLOR_YELLOW, "Name: {ffffff}%s.", pData[playerid][pName]);
	SendClientMessageEx(otherid, COLOR_YELLOW, "Brithday: {ffffff}%s.",pData[playerid][pAge]);	
	SendClientMessageEx(otherid, COLOR_YELLOW, "Expire: {ffffff}%s.", ReturnTimelapse(gettime(), pData[playerid][pIDCardTime]));
	SendClientMessageEx(otherid, COLOR_YELLOW, "Gender: {ffffff}%s.", sext);
	SendClientMessageEx(otherid, COLOR_YELLOW, "VIP: {ffffff}%s.", GetVipRank(playerid));
	// SendClientMessageEx(otherid, COLOR_GREEN, "[ID-Card] "GREY3_E"Name: %s | Gender: %s | Brithday: %s | Expire: %s.", pData[playerid][pName], sext, pData[playerid][pAge], ReturnTimelapse(gettime(), pData[playerid][pIDCardTime]));
	Info(playerid, "You show your ID card to {ffff00}%s.", ReturnName(otherid));
	return 1;
}

CMD:licenses(playerid, params[])
{
    if(!IsPlayerConnected(playerid))
        return Error(playerid, "Anda tidak terhubung.");

    new sext[40];
    if(pData[playerid][pGender] == 1)
    {
        sext = "Male";
    }
    else
    {
        sext = "Female";
    }

    SendClientMessageEx(playerid, COLOR_LBLUE, "[Licenses Information]");
    SendClientMessageEx(playerid, COLOR_YELLOW, "Name: {ffffff}%s", pData[playerid][pName]);
    SendClientMessageEx(playerid, COLOR_YELLOW, "Gender: {ffffff}%s", sext);
    
    // Drive License
    if(pData[playerid][pDriveLicTime] != 0)
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Drive License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pDriveLicTime]));
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Drive License: {ff0000}Expired");
    }
    
    // Low Truck License
    if(pData[playerid][pTlowTime] != 0)
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Low Truck License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pTlowTime]));
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Low Truck License: {ff0000}Expired");
    }
    
    // Heavy Truck License
    if(pData[playerid][pTheavTime] != 0)
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Heavy Truck License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pTheavTime]));
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Heavy Truck License: {ff0000}Expired");
    }
    
    // Flying License
    if(pData[playerid][pFlyLic] != 0)
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Flying License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pFlyLic]));
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Flying License: {ff0000}Expired");
    }
    
    // Weapon License
    if(pData[playerid][pWeapLic] != 0)
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Weapon License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pWeapLic]));
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Weapon License: {ff0000}Expired");
    }

    Info(playerid, "You show your Licenses to yourself.");
    return 1;
}



CMD:showlicenses(playerid, params[])
{
    new otherid;
    if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/showlicenses [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player tidak terhubung atau tidak berada dekat Anda.");

    new sext[40];
    if(pData[playerid][pGender] == 1)
    {
        sext = "Male";
    }
    else
    {
        sext = "Female";
    }

    SendClientMessageEx(otherid, COLOR_LBLUE, "[Licenses Information]");
    SendClientMessageEx(otherid, COLOR_YELLOW, "Name: {ffffff}%s", pData[playerid][pName]);
    SendClientMessageEx(otherid, COLOR_YELLOW, "Gender: {ffffff}%s", sext);
    
    // Drive License
    if(pData[playerid][pDriveLicTime] != 0)
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Drive License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pDriveLicTime]));
    }
    else
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Drive License: {ff0000}Expired");
    }
    
    // Low Truck License
    if(pData[playerid][pTlowTime] != 0)
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Low Truck License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pTlowTime]));
    }
    else
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Low Truck License: {ff0000}Expired");
    }
    
    // Heavy Truck License
    if(pData[playerid][pTheavTime] != 0)
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Heavy Truck License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pTheavTime]));
    }
    else
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Heavy Truck License: {ff0000}Expired");
    }
    
    // Flying License
    if(pData[playerid][pWeapLic] != 0)
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Flying License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pWeapLic]));
    }
    else
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Flying License: {ff0000}Expired");
    }
    
    // Weapon License
    if(pData[playerid][pFlyLic] != 0)
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Weapon License: {ffffff}%s", ReturnTimelapse(gettime(), pData[playerid][pFlyLic]));
    }
    else
    {
        SendClientMessageEx(otherid, COLOR_YELLOW, "Weapon License: {ff0000}Expired");
    }

    Info(playerid, "You show your Licenses to {ffff00}%s", ReturnName(otherid));
    return 1;
}

CMD:newidcard(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1392.5812, -12.6790, 1000.9166)) return Error(playerid, "Anda harus berada di City Hall!");
	if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 200) return Error(playerid, "Anda butuh $200 untuk membuat ID Card");
	new sext[40], mstr[128];
	if(pData[playerid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nNegara: San Andreas\nTgl Lahir: %s\nJenis Kelamin: %s\nBerlaku hingga 1 Tahun!", pData[playerid][pName], pData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ID-Card", mstr, "Tutup", "");
	pData[playerid][pIDCard] = 1;
	pData[playerid][pIDCardTime] = gettime() + (365 * 86400);
	GivePlayerMoneyEx(playerid, -200);
	ShowItemBox(playerid, "IDCARD", "Received_1x", 1581, 4);
	ShowItemBox(playerid, "Uang", "Removed_200$", 1212, 4);
	SuccesMsg(playerid, "Anda Berhasil Membuat Id Card");
	Server_AddMoney(25);
	return 1;
}


CMD:newage(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1392.5812, -12.6790, 1000.9166)) return Error(playerid, "Anda harus berada di City Hall!");
	if(GetPlayerMoney(playerid) < 300) return Error(playerid, "Anda butuh $300 untuk mengganti tgl lahir anda!");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Anda harus login terlebih dahulu!");
	ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Change", "Cancel");
	return 1;
}

CMD:taketest(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2032.8335,-116.8391,1035.1719)) return Error(playerid, "Anda harus berada di DMV!");
	if(pData[playerid][pDriveLic] != 0) return Error(playerid, "Anda sudah memiliki Driving License!");
	if(GetPlayerMoney(playerid) < 200) return Error(playerid, "Anda butuh $200 untuk membuat Driving License.");
	Info(playerid, "Silahkan masuki salah satu mobil untuk mengikuti tes mengemudi");
	pData[playerid][pDriveLicApp] = 1;
	pData[playerid][pCheckPoint] = CHECKPOINT_DRIVELIC;
	pData[playerid][pRegistLic] = 1;
	return 1;
}
CMD:renewlic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2032.8335,-116.8391,1035.1719)) return Error(playerid, "Anda harus berada di DMV!");
	if(pData[playerid][pRegistLic] == 0) return Error(playerid, "Anda belum pernah belajar mengemudi!");
	if(GetPlayerMoney(playerid) < 500) return Error(playerid, "Anda butuh $200 untuk membuat Driving License.");
	Info(playerid, "Selamat License anda telah diperpanjang");
	pData[playerid][pDriveLic] = 1;
	pData[playerid][pDriveLicTime] = gettime() + (30 * 86400);
	return 1;
}


CMD:payticket(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1554.9960,-1670.1924,20061.9648) && !IsPlayerInRangeOfPoint(playerid, 3.0, 1554.9960,-1670.1924,20061.9648)) return Error(playerid, "Anda harus berada di kantor SAPD!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return SyntaxMsg(playerid, "/payticket [vehid] | /mv - for find vehid");
		
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
		
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new ticket = pvData[i][cTicket];
				
				if(ticket > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money! check your ticket in /v insu.");
					
				if(ticket > 0)
				{
					GivePlayerMoneyEx(playerid, -ticket);
					pvData[i][cTicket] = 0;
					Server_AddBankPd(ticket);
					Info(playerid, "Anda telah berhasil membayar ticket tilang kendaraan %s(id: %d) sebesar "RED_E"%s", GetVehicleName(vehid), vehid, FormatMoney(ticket));
					return 1;
				}
			}
			else return Error(playerid, "Kendaraan ini bukan milik anda! /mv - for find vehid");
		}
	}
	return 1;
}

CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1554.9821,-1672.2106,20061.9551)) return Error(playerid, "Anda harus berada di SAPD!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/buyplate [vehid] | /mv - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				if(GetPlayerMoney(playerid) < 100) return Error(playerid, "Anda butuh $500 untuk membeli Plate baru.");
				GivePlayerMoneyEx(playerid, -100);
				new rand = RandomEx(1111, 9999);
				Server_AddBankPd(100);
				format(pvData[i][cPlate], 32, "MRP-%d", rand);
				SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
				pvData[i][cPlateTime] = gettime() + (15 * 86400);
				Info(playerid, "Model: %s || New plate: %s || Plate Time: %s || Plate Price: $100", GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mv untuk mencari ID.");
		}
	}
	return 1;
}

CMD:buyinsu(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1828.8109,-1412.6986,13.6016)) return Error(playerid, "Kamu harus berada di Kantor Insurance!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/buyinsu [vehid] | /mv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cClaim] == 0)
			{
				if(GetPlayerMoney(playerid) < 2500) return Error(playerid, "Anda butuh $2500 untuk membeli Insurance.");
				GivePlayerMoneyEx(playerid, -2500);
				pvData[i][cInsu]++;
				Info(playerid, "Model: %s || Total Insurance: %d || Insurance Price: $2500", GetVehicleModelName(pvData[i][cModel]), pvData[i][cInsu]);
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mv untuk mencari ID.");
		}
	}
	return 1;
}

CMD:claimpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1833.0356,-1412.7167,13.6016)) 
	{
		return Error(playerid, "Kamu harus berada di Kantor Insurance!");
	}

	new found = 0;
	foreach(new i : PVehicles)
	{
		if(pvData[i][cClaim] == 1 && pvData[i][cClaimTime] == 0)
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
	
				pvData[i][cClaim] = 0;
				
				OnPlayerVehicleRespawn(i);
				pvData[i][cPosX] = 1821.7982;
				pvData[i][cPosY] = -1444.3495;
				pvData[i][cPosZ] = 13.5946;
				pvData[i][cPosA] = 0.2481;
				pvData[i][cLockTire] = 0;
				SetValidVehicleHealth(pvData[i][cVeh], 1000);
				SetVehiclePos(pvData[i][cVeh], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ]);
				SetVehicleZAngle(pvData[i][cVeh], pvData[i][cPosA]);
				SetVehicleFuel(pvData[i][cVeh], 1000);
				ValidRepairVehicle(pvData[i][cVeh]);


				if (pvData[i][cInsu] == 0)
				{
					new query[128], xuery[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
					mysql_tquery(g_SQL, query);

					mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[i][cOwner]);
					mysql_tquery(g_SQL, xuery);
					pvData[pvData[i][cVeh]][LoadedStorage] = false;
					if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
					pvData[i][cVeh] = INVALID_VEHICLE_ID;
					Iter_SafeRemove(PVehicles, i, i);
					new line3[500];
					format(line3, sizeof(line3), "Kendaraan anda telah dihapus dikarenakan memiliki 0 insu");
					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, SBLUE_E "Fountain Daily:RP: " WHITE_E "Claim Insurance", line3, "OK", "");
					SendClientMessage(playerid, COLOR_GREY, "Kendaraan anda telah dihapus dikarenakan memiliki 0 insu");
				}	
				found++;
				Info(playerid, "Anda telah mengclaim kendaraan %s anda.", GetVehicleModelName(pvData[i][cModel]));
			}
		}
	}
	if(found == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "Sekarang belum saatnya anda mengclaim kendaraan anda!");
	}
	else
	{
		Info(playerid, "Anda berhasil mengclaim %d kendaraan anda!", found);
	}

	return 1;
}

CMD:sellpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1833.2275,-1432.0680,17.2285)) return Error(playerid, "Kamu harus berada di Kantor Insurance!");
	
	new vehid;
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/sellpv [vehid] | /mv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				if(!IsValidVehicle(pvData[i][cVeh])) return Error(playerid, "Your vehicle is not spanwed!");
				if(pvData[i][cRent] != 0) return Error(playerid, "You can't sell rental vehicle!");
				// new pay = pvData[i][cPrice] / 2;
				// GivePlayerMoneyEx(playerid, pay);
				new pay = 150; 
				GivePlayerMoneyEx(playerid, pay);

				
				Info(playerid, "Anda menjual kendaraan model %s(%d) dengan seharga "LG_E"%s", GetVehicleName(vehid), GetVehicleModel(vehid), FormatMoney(pay));
				new str[150];
				format(str,sizeof(str),"[VEH]: %s menjual kendaraan %s seharga %s!", GetRPName(playerid), GetVehicleName(vehid), FormatMoney(pay));
				LogServer("Property", str);
				SuccesMsg(playerid, "Anda berhasil Menjual Kendaraan Anda.");
				new query[128], xuery[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
				mysql_tquery(g_SQL, query);

				mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[i][cID]);
				mysql_tquery(g_SQL, xuery);
				pvData[pvData[i][cVeh]][LoadedStorage] = false;
				if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
				pvData[i][cVeh] = INVALID_VEHICLE_ID;
				Iter_SafeRemove(PVehicles, i, i);
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /mv untuk mencari ID.");
		}
	}
	return 1;
}
CMD:newrek(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1448.8788,-984.3636,20057.1875)) return Error(playerid, "Anda harus berada di Bank!");
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
	return 1;
}


CMD:oldbank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2679.9041, 806.8085, 1500.9688)) return Error(playerid, "Anda harus berada di bank point!");
	new tstr[128];
	format(tstr, sizeof(tstr), ""ORANGE_E"No Rek: "LB_E"%d", pData[playerid][pBankRek]);
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, tstr, "Deposit Money\nWithdraw Money\nCheck Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	return 1;
}

CMD:bank(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1445.7396,-984.7730,20057.1875))
    {
		new name[32];
		format(name, sizeof(name), "%s", GetRPName(playerid));
		PlayerTextDrawSetString(playerid, NAMABANKABONLOGIN[playerid], name);
		new rek[32];
		format(rek, sizeof(rek), "%d",  pData[playerid][pBankRek]);
		PlayerTextDrawSetString(playerid, REKENINGBANKABONLOGIN[playerid], rek);
		ShowBankAbonLogin(playerid);
	}
	return 1;
}

CMD:skills(playerid)
{
	SkillStatus(playerid);
}

CMD:calc(playerid, params[])
{
    new arg1[32], arg2[32], op[2]; 
    new num1, num2, result[64];

    // Memisahkan argumen
    if (sscanf(params, "s s s", arg1, op, arg2))
    {
        return SendClientMessage(playerid, COLOR_RED, "Format salah. Gunakan: /calc num1 operator num2");
    }
    num1 = strval(arg1);
    num2 = strval(arg2);

    switch (op[0])
    {
        case '+':
            format(result, sizeof(result), "Hasil: %d + %d = %d", num1, num2, num1 + num2);
        case '-':
            format(result, sizeof(result), "Hasil: %d - %d = %d", num1, num2, num1 - num2);
        case '*':
            format(result, sizeof(result), "Hasil: %d * %d = %d", num1, num2, num1 * num2);
        case '/':
            if (num2 != 0)
                format(result, sizeof(result), "Hasil: %d / %d = %d", num1, num2, num1 / num2);
            else
                return SendClientMessage(playerid, COLOR_GREY, "Error: Pembagian dengan nol.");
        default:
            return SendClientMessage(playerid, COLOR_GREY, "Operator tidak dikenali. Gunakan: +, -, *, /");
    }

    SendClientMessage(playerid, COLOR_GREY, result);
    return 1;
}

CMD:pay(playerid, params[])
{
    if(pData[playerid][pLevel] < 2) 
        return Error(playerid, "Untuk menggunakan command ini anda harus level 2 ke atas");

    if(IsAtEvent[playerid] == 1)
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    new money, otherid, mstr[128];
    if(sscanf(params, "ud", otherid, money))
    {
        SyntaxMsg(playerid, "/pay <ID/Name> <amount>");
        return true;
    }
    
    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

    if(otherid == playerid)
        return Error(playerid, "You can't send yourself money!");

    if(pData[playerid][pMoney] < money)
        return Error(playerid, "You don't have enough money to send!");


    new maxPay;
    switch (pData[playerid][pLevel])
    {
        case 2:
            maxPay = 1000;
        case 5:
            maxPay = 5000;
        case 10:
            maxPay = 50000;
        default:
            maxPay = 50000;
    }

    if(money > maxPay)
        return Error(playerid, "Anda tidak dapat mengirim lebih dari $%d pada level Anda.", maxPay);
    
    if(money < 1)
        return Error(playerid, "Anda tidak bisa mengirim kurang dari $1!");

    GivePlayerMoneyEx(otherid, money);
    GivePlayerMoneyEx(playerid, -money);

    format(mstr, sizeof(mstr), "Pays: "LB_E"Kamu memberikan uang ke %s(%i) "GREEN_E"%s", pData[otherid][pName], otherid, FormatMoney(money));
    SendClientMessage(playerid, COLOR_GREY, mstr);
    format(mstr, sizeof(mstr), "Pays: "LB_E"%s(%i) Telah memberikan kamu uang sebesar "GREEN_E"%s", pData[playerid][pName], playerid, FormatMoney(money));
    SendClientMessage(otherid, COLOR_GREY, mstr);
    InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
    InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
    ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

    SendStaffMessage(COLOR_LBLUE, ""YELLOW_E"{7fffd4}[PAY INFO] %s telah memberikan uang %s kepada %s", GetRPName(playerid), FormatMoney(money), GetRPName(otherid));
    SetPVarInt(playerid, "gcAmount", money);
    SetPVarInt(playerid, "gcPlayer", otherid);
    new dc[128];
    format(dc, sizeof(dc),  "```%s memberikan uang kepada %s sebesar %s```", ReturnName(playerid), ReturnName(otherid), FormatMoney(money));
    SendDiscordMessage(10, dc);
    return 1;
}

CMD:payrm(playerid, params[])
{
    if(pData[playerid][pLevel] < 5) 
        return Error(playerid, "Untuk menggunakan command ini anda harus level 5 ke atas");

    if(IsAtEvent[playerid] == 1)
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    new rmmoney, otherid, mstr[128];
    if(sscanf(params, "ud", otherid, rmmoney))
    {
        SyntaxMsg(playerid, "/payrm <ID/Name> <amount>");
        return true;
    }
    
    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 6.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

    if(otherid == playerid)
        return Error(playerid, "You can't send yourself money!");

    if(pData[playerid][pRedMoney] < rmmoney)
        return Error(playerid, "You don't have enough money to send!");


    new maxPay;
    switch (pData[playerid][pLevel])
    {
        case 2:
            maxPay = 1000;
        case 5:
            maxPay = 5000;
        case 10:
            maxPay = 10000;
        default:
            maxPay = 10000;
    }

    if(rmmoney > maxPay)
        return Error(playerid, "Anda tidak dapat mengirim lebih dari $%d pada level Anda.", maxPay);
    
    if(rmmoney < 1)
        return Error(playerid, "Anda tidak bisa mengirim kurang dari $1!");

	pData[otherid][pRedMoney] += rmmoney;
	pData[playerid][pRedMoney] -= rmmoney;

    format(mstr, sizeof(mstr), "Pays: "LB_E"Kamu memberikan uang merah ke %s(%i) "RED_E"%s", pData[otherid][pName], otherid, FormatMoney(rmmoney));
    SendClientMessage(playerid, COLOR_GREY, mstr);
    format(mstr, sizeof(mstr), "Pays: "LB_E"%s(%i) Telah memberikan kamu uang merah sebesar "RED_E"%s", pData[playerid][pName], playerid, FormatMoney(rmmoney));
    SendClientMessage(otherid, COLOR_GREY, mstr);
    InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
    InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
    ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);

    SendStaffMessage(COLOR_LBLUE, ""YELLOW_E"{7fffd4}[PAY INFO] %s telah memberikan uang merah %s kepada %s", GetRPName(playerid), FormatMoney(rmmoney), GetRPName(otherid));
    SetPVarInt(playerid, "gcAmount", rmmoney);
    SetPVarInt(playerid, "gcPlayer", otherid);
    new dc[128];
    format(dc, sizeof(dc),  "```%s memberikan uang merah kepada %s sebesar %s```", ReturnName(playerid), ReturnName(otherid), FormatMoney(rmmoney));
    SendDiscordMessage(10, dc);
    return 1;
}
CMD:stats(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	DisplayStats(playerid, playerid);
	return 1;
}

CMD:settings(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	new str[1024], hbemode[128], togpm[64], toglog[64], togads[64], togwt[64], togvip[64], tognotif[64], togcapss[64], togo[64];
	if(pData[playerid][pHBEMode] == 1)
	{
		hbemode = ""LG_E"Modern";
	}
	else if(pData[playerid][pHBEMode] == 2)
	{
		hbemode = ""LG_E"Minimalist";
	}
	else
	{
		hbemode = ""RED_E"Disable";
	}
	if(pData[playerid][pTogPM] == 0)
	{
		togpm = ""RED_E"Disable";
	}
	else
	{
		togpm = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogLog] == 0)
	{
		toglog = ""RED_E"Disable";
	}
	else
	{
		toglog = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogAds] == 0)
	{
		togads = ""RED_E"Disable";
	}
	else
	{
		togads = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogWT] == 0)
	{
		togwt = ""RED_E"Disable";
	}
	else
	{
		togwt = ""LG_E"Enable";
	}

	if(pData[playerid][pTogVip] == 0)
	{
		togvip = ""RED_E"Disable";
	}
	else
	{
		togvip = ""LG_E"Enable";
	}

	if(pData[playerid][pTogNotif] == 0)
	{
		tognotif = ""RED_E"Disable";
	}
	else
	{
		tognotif = ""LG_E"Enable";
	}
	if(pData[playerid][pcapitalizeFirstLetter] == 0)
	{
		togcapss = ""RED_E"Disable";
	}
	else
	{
		togcapss = ""LG_E"Enable";
	}
	if(pData[playerid][pTogO] == 0)
	{
		togo = ""RED_E"Disable";
	}
	else
	{
		togo = ""LG_E"Enable";
	}	
	format(str, sizeof(str), "Settings\tStatus\n"WHITEP_E"Email:\t"GREY3_E"%s\n"WHITEP_E"Change Password\n"WHITEP_E"HUD HBE Mode:\t%s\n"WHITEP_E"Toggle PM:\t%s\n"WHITEP_E"Toggle Log Server:\t%s\n"WHITEP_E"Toggle Ads:\t%s\n"WHITEP_E"Toggle Wt:\t%s\n"WHITEP_E"Toggle Vip:\t%s\n"WHITEP_E"Toggle Bot:\t%s\n"WHITEP_E"Upper Case:\t%s\n"WHITEP_E"Toggle OOC:\t%s",
	pData[playerid][pEmail], 
	hbemode, 
	togpm,
	toglog,
	togads,
	togwt,
	togvip,
	tognotif,
	togcapss,
	togo
	);
	
	ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "Settings", str, "Set", "Close");
	return 1;
}

CMD:items(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check items!");
	    return true;
	}
	DisplayItems(playerid, playerid);
	return 1;
}


CMD:frisk(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/frisk [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pFriskOffer] = playerid;

    Info(otherid, "%s has offered to frisk you {ffff00}\"/accept frisk\").", ReturnName(playerid));
    Info(playerid, "You have offered to frisk %s.", ReturnName(otherid));
	return 1;
}
CMD:ainspect(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1) 
	{
        return PermissionError(playerid);
    }
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/ainspect [playerid/PartOfName]");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");
	
	if(otherid < 0 || otherid >= MAX_PLAYERS) 
	{
        Error(playerid, "Invalid player ID.");
        return true;
    }
	new info[1024];
	new hstring[500];
	new condition[500];
	new targetPlayerId = otherid;
	new hh = pData[targetPlayerId][pHead];
	new hp = pData[targetPlayerId][pPerut];
	new htk = pData[targetPlayerId][pRHand];
	new htka = pData[targetPlayerId][pLHand];
	new hkk = pData[targetPlayerId][pRFoot];
	new hkka = pData[targetPlayerId][pLFoot];
	new playerName[24];
	new dialogTitle[50];

	GetPlayerName(targetPlayerId, playerName, MAX_PLAYER_NAME);


	info[0] = '\0';
	format(dialogTitle, sizeof(dialogTitle), "Health Condition\n%s", playerName);

	GetCondition(hh, condition, sizeof(condition));
	format(hstring, sizeof(hstring), "Part: "YELLOW_E"Head"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hh, condition);
	strcat(info, hstring);

	GetCondition(hp, condition, sizeof(condition));
	format(hstring, sizeof(hstring), "Part: "YELLOW_E"Groin"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hp, condition);
	strcat(info, hstring);

	GetCondition(htk, condition, sizeof(condition));
	format(hstring, sizeof(hstring), "Part: "YELLOW_E"Right Arm"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", htk, condition);
	strcat(info, hstring);

	GetCondition(htka, condition, sizeof(condition));
	format(hstring, sizeof(hstring), "Part: "YELLOW_E"Left Arm"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", htka, condition);
	strcat(info, hstring);

	GetCondition(hkk, condition, sizeof(condition));
	format(hstring, sizeof(hstring), "Part: "YELLOW_E"Right Leg"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hkk, condition);
	strcat(info, hstring);

	GetCondition(hkka, condition, sizeof(condition));
	format(hstring, sizeof(hstring), "Part: "YELLOW_E"Left Leg"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hkka, condition);
	strcat(info, hstring);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, dialogTitle, info, "Oke", "");

	Servers(playerid, "Anda sedang memeriksa kondisi health %s.", ReturnName(targetPlayerId));
	return 1;
}

CMD:inspect(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/inspect [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pInsOffer] = playerid;

    Info(otherid, "%s has offered to inspect you {ffff00}\"/accept inspect\").", ReturnName(playerid));
    Info(playerid, "You have offered to inspect %s.", ReturnName(otherid));
	return 1;
}

CMD:reqloc(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/reqloc [playerid/PartOfName]");
	if (otherid < 0 || otherid >= MAX_PLAYERS)
		return Error(playerid, "Invalid player ID.");

    if(pData[playerid][pPhone] == 0)
    	return Error(playerid, "Anda tidak memiliki Handphone");

    if(pData[playerid][pPhoneStatus] == 0)
    	return Error(playerid, "Ponsel anda masih offline");

    if(pData[otherid][pPhone] == 0)
    	return Error(playerid, "Tujuan tidak memiliki Handphone");

    if(pData[otherid][pPhoneStatus] == 0)
    	return Error(playerid, "Ponsel yang anda tuju masih offline");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa meminta lokasi kepada anda sendiri.");

    pData[otherid][pLocOffer] = playerid;

    Info(otherid, "%s has offered to request share his location (type \"/accept reqloc or /deny reqloc\").", ReturnName(playerid));
    Info(playerid, "You have offered to share your location %s.", ReturnName(otherid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            SyntaxMsg(playerid, "USAGE: /accept [name]");
            Info(playerid, "Names: handshake, marriage, cerai, faction, family, drag, cuffdrag, menikah, frisk, inspect, job, reqloc, rob, tradepv");
            Info(playerid, "buypv");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFacOffer])) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
                    pData[playerid][pFaction] = pData[playerid][pFacInvite];
					pData[playerid][pFactionRank] = 1;
					Info(playerid, "Anda telah menerima invite faction dari %s", pData[pData[playerid][pFacOffer]][pName]);
					Info(pData[playerid][pFacOffer], "%s telah menerima invite faction yang anda tawari", pData[playerid][pName]);
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"family",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFamOffer])) 
			{
                if(pData[playerid][pFamInvite] > -1) 
				{
                    pData[playerid][pFamily] = pData[playerid][pFamInvite];
					pData[playerid][pFamilyRank] = 1;
					Info(playerid, "Anda telah menerima invite family dari %s", pData[pData[playerid][pFamOffer]][pName]);
					Info(pData[playerid][pFamOffer], "%s telah menerima invite family yang anda tawari", pData[playerid][pName]);
					pData[playerid][pFamInvite] = 0;
					pData[playerid][pFamOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"verified",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pVerOffer])) 
			{
                if(pData[playerid][pVerInvite] > -1) 
				{
                    pData[playerid][pVerified] = pData[playerid][pVerInvite];
					pData[playerid][pVerifiedRank] = 1;
					Info(playerid, "Anda telah menerima invite family dari %s", pData[pData[playerid][pVerOffer]][pName]);
					Info(pData[playerid][pVerOffer], "%s telah menerima invite family yang anda tawari", pData[playerid][pName]);
					pData[playerid][pVerInvite] = 0;
					pData[playerid][pVerOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
        
			pData[playerid][pDragged] = 1;
			pData[playerid][pDraggedBy] = dragby;

			pData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/undrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"marriage",true) == 0)
		{
			new String[500];
			if(pData[playerid][pMarriedAccept] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMarriedAccept]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pMarriedAccept], 5.0))
				return Error(playerid, "You must be near this player.");

			if(pData[playerid][pGender] == 1 && pData[pData[playerid][pMarriedAccept]][pGender] == 2)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Wife, you may kiss the bride.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Wife, you may kiss the groom.", ReturnName(pData[playerid][pMarriedAccept]), ReturnName(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new lovely couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				//SendClientMessageEx(COLOR_WHITE, String);
			}
			else if(pData[playerid][pGender] == 1 && pData[pData[playerid][pMarriedAccept]][pGender] == 1)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Husband, you may kiss the bride.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Husband & Husband, you may kiss the groom.", ReturnName(pData[playerid][pMarriedAccept]), ReturnName(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new gay couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				//SendClientMessageEx(COLOR_WHITE, String);
			}
			else if(pData[playerid][pGender] == 2 && pData[pData[playerid][pMarriedAccept]][pGender] == 2)
			{
				format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Wife & Wife, you may kiss the Bride.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				SendClientMessageEx(playerid, COLOR_WHITE, String);
		   		format(String, sizeof(String), "Priest: %s and %s i pronounce you now... Wife & Wife, you may kiss the Groom.", ReturnName(pData[playerid][pMarriedAccept]), ReturnName(playerid));
				SendClientMessageEx(pData[playerid][pMarriedAccept], COLOR_WHITE, String);
				format(String, sizeof(String), "Marriage News: We have a new lesbian couple! {FFFF00}%s {FFFFFF}& {FFFF00}%s have been married.", ReturnName(playerid), ReturnName(pData[playerid][pMarriedAccept]));
				//SendClientMessageEx(COLOR_WHITE, String);
			}
			format(pData[pData[playerid][pMarriedAccept]][pMarriedTo], MAX_PLAYER_NAME, "%s", pData[playerid][pName]);
			format(pData[playerid][pMarriedTo], MAX_PLAYER_NAME, "%s", pData[pData[playerid][pMarriedAccept]][pName]);
			GivePlayerMoney(pData[playerid][pMarriedAccept], -10000);
			pData[playerid][pMarried] = 1;
			pData[pData[playerid][pMarriedAccept]][pMarried] = 1;
			pData[playerid][pMarriedAccept] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"cerai",true) == 0)
		{
			if(pData[playerid][pMarriedCancel] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMarriedCancel]))
				return Error(playerid, "That player not connected!");
			
			if(!NearPlayer(playerid, pData[playerid][pMarriedCancel], 5.0))
				return Error(playerid, "You must be near this player.");

			if(pData[playerid][pGender] == 1)
			{
				format(pData[playerid][pMarriedTo], 50, "Duda");
			}
			else if(pData[playerid][pGender] == 2)
			{
				format(pData[playerid][pMarriedTo], 50, "Janda");
			}
			if(pData[pData[playerid][pMarriedCancel]][pGender] == 1)
			{
				format(pData[pData[playerid][pMarriedCancel]][pMarriedTo], 50, "Duda");
			}
			else if(pData[pData[playerid][pMarriedCancel]][pGender] == 2)
			{
				format(pData[pData[playerid][pMarriedCancel]][pMarriedTo], 50, "Janda");
			}
			pData[playerid][pMarried] = 0;
			pData[pData[playerid][pMarriedCancel]][pMarried] = 0;
			pData[playerid][pMarriedCancel] = INVALID_PLAYER_ID;
			SendClientMessageEx(playerid, ARWIN, "ACCEPT: "WHITE_E"Anda telah pisah/cerai dengan %s", ReturnName(pData[playerid][pMarriedCancel]));
			SendClientMessageEx(pData[pData[playerid][pMarriedCancel]][pMarried], ARWIN, "ACCEPT: "WHITE_E"Anda telah pisah/cerai dengan %s", ReturnName(playerid));
		}
		else if(strcmp(params,"cuffdrag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
        
			pData[playerid][pDragged] = 1;
			pData[playerid][pDraggedBy] = dragby;

			pData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/uncuffdrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"menikah",true) == 0) //MENIKAH
		{
			if(pData[playerid][pMelamar] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMelamar]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, pData[playerid][pMelamar], 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
				
			Servers(playerid, "Anda menerima lamaran Menikah dengan %s.", ReturnName(pData[playerid][pMelamar]));
			Servers(pData[playerid][pMelamar], "Selamatt!! Kini %s sudah menjadi istrimu.", ReturnName(pData[playerid][pMelamar]));
			new query[512];
			format(query, sizeof(query), "UPDATE players SET menikah='%e' WHERE reg_id=%d", ReturnName(pData[playerid][pMelamar]), pData[playerid][pID]);
			mysql_tquery(g_SQL, query);
			format(pData[playerid][pMenikah], MAX_PLAYER_NAME, "%s", ReturnName(pData[playerid][pMelamar]));
			//cowo
			format(query, sizeof(query), "UPDATE players SET menikah='%e' WHERE reg_id=%d", ReturnName(playerid), pData[pData[playerid][pMelamar]][pID]);
			mysql_tquery(g_SQL, query);
			format(pData[pData[playerid][pMelamar]][pMenikah], MAX_PLAYER_NAME, "%s", ReturnName(playerid));
			
			pData[playerid][pMelamar] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, pData[playerid][pFriskOffer], 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
				
			DisplayItems(pData[playerid][pFriskOffer], playerid);
			Servers(playerid, "Anda telah berhasil menaccept tawaran frisk kepada %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
		}
		else if (strcmp(params, "inspect", true) == 0)
		{
			if (pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pInsOffer]))
			{
				return Error(playerid, "Player tersebut belum masuk!");
			}

			if (!NearPlayer(playerid, pData[playerid][pInsOffer], 5.0))
			{
				return Error(playerid, "Kamu harus didekat Player.");
			}

			new info[1024];
			new hstring[500];
			new condition[500];
			new targetPlayerId = pData[playerid][pInsOffer];
			new hh = pData[playerid][pHead];
			new hp = pData[playerid][pPerut];
			new htk = pData[playerid][pRHand];
			new htka = pData[playerid][pLHand];
			new hkk = pData[playerid][pRFoot];
			new hkka = pData[playerid][pLFoot];
			new playerName[24];
			new dialogTitle[50];

			GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

			info[0] = '\0';
			format(dialogTitle, sizeof(dialogTitle), "Health Condition\n%s", playerName);

			GetCondition(hh, condition, sizeof(condition));
			format(hstring, sizeof(hstring), "Part: "YELLOW_E"Head"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hh, condition);
			strcat(info, hstring);

			GetCondition(hp, condition, sizeof(condition));
			format(hstring, sizeof(hstring), "Part: "YELLOW_E"Groin"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hp, condition);
			strcat(info, hstring);

			GetCondition(htk, condition, sizeof(condition));
			format(hstring, sizeof(hstring), "Part: "YELLOW_E"Right Arm"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", htk, condition);
			strcat(info, hstring);

			GetCondition(htka, condition, sizeof(condition));
			format(hstring, sizeof(hstring), "Part: "YELLOW_E"Left Arm"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", htka, condition);
			strcat(info, hstring);

			GetCondition(hkk, condition, sizeof(condition));
			format(hstring, sizeof(hstring), "Part: "YELLOW_E"Right Leg"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hkk, condition);
			strcat(info, hstring);

			GetCondition(hkka, condition, sizeof(condition));
			format(hstring, sizeof(hstring), "Part: "YELLOW_E"Left Leg"WHITE_E" | Fitness Rating: %.2f\nCondition: %s\n", hkka, condition);
			strcat(info, hstring);

			ShowPlayerDialog(targetPlayerId, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, dialogTitle, info, "Oke", "");

			Servers(playerid, "Anda telah berhasil menaccept tawaran Inspect kepada %s.", ReturnName(targetPlayerId));

			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
		}

		else if(strcmp(params,"job",true) == 0) 
		{
			if(pData[playerid][pGetJob] > 0)
			{
				pData[playerid][pJob] = pData[playerid][pGetJob];
				Info(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan /help untuk informasi.");
				pData[playerid][pGetJob] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 21600);
			}
			else if(pData[playerid][pGetJob2] > 0)
			{
				pData[playerid][pJob2] = pData[playerid][pGetJob2];
				Info(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan /help untuk informasi.");
				pData[playerid][pGetJob2] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 21600);
			}
		}
		else if(strcmp(params,"reqloc",true) == 0)
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
				
			new Float:sX, Float:sY, Float:sZ;
			GetPlayerPos(playerid, sX, sY, sZ);
			SetPlayerCheckpoint(pData[playerid][pLocOffer], sX, sY, sZ, 5.0);
			Servers(playerid, "Anda telah berhasil menaccept tawaran Share Lokasi kepada %s.", ReturnName(pData[playerid][pLocOffer]));
			Servers(pData[playerid][pLocOffer], "Lokasi %s telah tertandai.", ReturnName(playerid));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params, "handshake",true) == 0) {

            foreach(new i : Player)
	 			{
                if(GetPVarInt(i, "shrequest") == playerid) {
                    new
                        Float: ppFloats[3];

                    GetPlayerPos(i, ppFloats[0], ppFloats[1], ppFloats[2]);

                    if(!IsPlayerInRangeOfPoint(playerid, 5, ppFloats[0], ppFloats[1], ppFloats[2])) {
                        Count++;
                        SendClientMessageEx(playerid, COLOR_WHITE, "You're too far away. You can't accept the handshake right now.");
                    }
                    else {
                        switch(GetPVarInt(i, "shstyle")) {
                            case 1:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "hndshkaa", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "hndshkaa", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 2:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "hndshkba", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "hndshkba", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 3:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "hndshkca", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "hndshkca", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 4:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "hndshkcb", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "hndshkca", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 5:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "hndshkda", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "hndshkca", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 6:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS","hndshkfa_swt", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS","hndshkfa_swt", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 7:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "prtial_hndshk_01", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "prtial_hndshk_01", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                            case 8:
                            {
                                Count++;
                                PlayerFacePlayer( playerid, i );
                                ApplyAnimation( playerid, "GANGS", "prtial_hndshk_biz_01", 4.1, 0, 1, 1, 0, 0, 1);
                                ApplyAnimation( i, "GANGS", "prtial_hndshk_biz_01", 4.1, 0, 1, 1, 0, 0, 1);
                                SetPVarInt(i, "shrequest", INVALID_PLAYER_ID);
                                DeletePVar(i, "shstyle");
                            }
                        }
                    }
                }
            }
            if(Count == 0) return SendClientMessageEx(playerid, COLOR_WHITE, "You don't have any pending handshake requests.");
            return 1;
        }
		else if(strcmp(params,"rob",true) == 0)
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Servers(playerid, "Anda telah berhasil menaccept tawaran bergabung kedalam Robbery %s.", ReturnName(pData[playerid][pRobOffer]));
			Servers(pData[playerid][pRobOffer], "%s Menerima ajakan Robbing anda.", ReturnName(playerid));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
			pData[playerid][pMemberRob] = 1;
			pData[pData[playerid][pRobOffer]][pRobMember] += 1;
			RobMember += 1;
		}
		else if(strcmp(params, "tradepv", true) == 0)
		{
			if (GetPVarInt(playerid, "OfferedTradePV") == 1)
			{
				new Target = GetPVarInt(playerid, "TradePVWith");

				if (pData[Target][IsLoggedIn] == false)
					return Error(playerid, "The player who is offering you a trade has disconnected.");

				new index = GetPVarInt(Target, "TradePVIndex");

				if (Vehicle_Nearest(Target) != index)
					return Error(playerid, "Kendaraan yang ditawarkan tidak berada di sekitar pemiliknya.");

				if (!IsValidVehicle(pvData[index][cVeh]))
					return Error(playerid, "Invalid vehicle ID.");

				new String[512];
				format(String, sizeof String, "{FFFFFF}Silahkan pilih kendaraanmu yang ingin kamu tukarkan:\n");

				new bool: found = false;

				foreach(new vid : PVehicles)
				{
					if(pvData[vid][cOwner] == pData[playerid][pID])
					{
						found = true;
						format(String, sizeof(String), "%s%s\n", String, GetVehicleModelName(pvData[vid][cModel]));
					}
				}

				if (!found)
					return Error(playerid, "Kamu tidak memiliki kendaraan sama sekali.");

				ShowPlayerDialog(playerid, DIALOG_TRADEVEH2, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Select Vehicle to Trade", String, "Trade", "Cancel");

				/* if (!IsValidVehicle(pvData[targetindex][cVeh]))
					return Error(playerid, "Invalid vehicle ID.");

				pvData[targetindex][cOwner] = pData[playerid][pID];
				pvData[index][cOwner] = pData[Target][pID];

				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[playerid][pID], pvData[targetindex][cID]);
				mysql_tquery(g_SQL, query);

				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[Target][pID], pvData[index][cID]);
				mysql_tquery(g_SQL, query);

				new str[150];
				format(str,sizeof(str),"[VEH]: %s bertukar kendaraan model %s(%d) dengan %s(%d) milik %s!", GetRPName(playerid), GetVehicleName(pvData[index][cVeh]), GetVehicleModel(pvData[index][cVeh]), GetVehicleName(pvData[targetindex][cVeh]), GetVehicleModel(pvData[targetindex][cVeh]), GetRPName(Target));
				LogServer("Property", str);

				format(str, sizeof str, "* Kamu telah menerima tawaran trade dari %s.", GetRPName(Target));
				SCM(playerid, COLOR_YELLOW, str);
				format(str, sizeof str, "* %s telah menerima tawaran trademu.", GetRPName(playerid));
				SCM(Target, COLOR_YELLOW, str); */
			}
			else Error(playerid, "Nobody offering you a trade.");
		}
		else if(strcmp(params, "buypv", true) == 0)
		{
			if (GetPVarInt(playerid, "OfferedSellPV") == 1)
			{
				new Target = GetPVarInt(playerid, "SellPVWith");

				if (pData[Target][IsLoggedIn] == false)
					return Error(playerid, "The player who is offering you has disconnected.");

				new targetindex = GetPVarInt(Target, "SellPVIndex");
				new Price = GetPVarInt(Target, "SellPVPrice");

				if (Vehicle_Nearest(Target) != targetindex)
					return Error(playerid, "Kendaraan yang ditawarkan tidak berada di sekitarmu/pemiliknya.");

				if (!IsValidVehicle(pvData[targetindex][cVeh]))
					return Error(playerid, "Invalid vehicle ID.");

				if (GetPlayerMoney(playerid) < Price)
					return Error(playerid, "You don't have enough money.");

				pvData[targetindex][cOwner] = pData[playerid][pID];
				GivePlayerMoneyEx(playerid, -Price);
				GivePlayerMoneyEx(Target, Price);

				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[playerid][pID], pvData[targetindex][cID]);
				mysql_tquery(g_SQL, query);

				new str[150];
				format(str,sizeof(str),"[VEH]: %s membeli kendaraan model %s(%d) dengan harga %s milik %s!", GetRPName(playerid), GetVehicleName(pvData[targetindex][cVeh]), GetVehicleModel(pvData[targetindex][cVeh]), FormatMoney(Price), GetRPName(Target));
				LogServer("Property", str);

				format(str, sizeof str, "* Kamu telah menerima tawaran jual kendaraan dari %s dengan harga {00FF00}%s{FFFFFF}.", GetRPName(Target), FormatMoney(Price));
				SCM(playerid, COLOR_YELLOW, str);
				format(str, sizeof str, "* %s telah menerima tawaranmu dengan harga {00FF00}%s{FFFFFF}.", GetRPName(playerid), FormatMoney(Price));
				SCM(Target, COLOR_YELLOW, str);
			}
			else Error(playerid, "Nobody offering you a vehicle sell.");
		}
	}
	return 1;
}

CMD:deny(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            SyntaxMsg(playerid, "USAGE: /deny [name]");
            Info(playerid, "Names: faction, drag, cuffdrag, menikah, frisk, inspect, job1, job2, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(pData[playerid][pFacOffer] > -1) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
					Info(playerid, "Anda telah menolak faction dari %s", ReturnName(pData[playerid][pFacOffer]));
					Info(pData[playerid][pFacOffer], "%s telah menolak invite faction yang anda tawari", ReturnName(playerid));
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");

			Info(playerid, "Anda telah menolak drag.");
			Info(dragby, "Player telah menolak drag yang anda tawari.");
			
			DeletePVar(playerid, "DragBy");
			pData[playerid][pDragged] = 0;
			pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"cuffdrag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");

			Info(playerid, "Anda telah menolak drag.");
			Info(dragby, "Player telah menolak drag yang anda tawari.");
			
			DeletePVar(playerid, "DragBy");
			pData[playerid][pDragged] = 0;
			pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran frisk kepada %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"menikah",true) == 0)
		{
			if(pData[playerid][pMelamar] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pMelamar]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Kamu telah monolak lamaran %s.", ReturnName(pData[playerid][pMelamar]));
			Info(pData[playerid][pMelamar], "Kasiannn... Kamu ditolak oleh %s.", ReturnName(playerid));
			pData[playerid][pMelamar] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pInsOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Inspect kepada %s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"job1",true) == 0) 
		{
			if(pData[playerid][pJob] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			if(pData[playerid][pJob] != 0)
			{
				pData[playerid][pJob] = 0;
				Info(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"job2",true) == 0) 
		{
			if(pData[playerid][pJob2] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			if(pData[playerid][pJob2] != 0)
			{
				pData[playerid][pJob2] = 0;
				Info(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"reqloc",true) == 0) 
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Share Lokasi kepada %s.", ReturnName(pData[playerid][pLocOffer]));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0) 
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Rob kepada %s.", ReturnName(pData[playerid][pRobOffer]));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}


CMD:rampas(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
	if(pData[playerid][pFamily] == -1)  return Error(playerid, "Kamu gak punya akses buat rampas.");
	if(IsPlayerConnected(playerid))
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			SyntaxMsg(playerid, "/rampas [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, material, component, marijuana");
			Info(playerid, "Names: redmoney, nasbung, ultramilk, clipde, clipsg, clipak");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");

		if(strcmp(name,"bandage",true) == 0)
		{
			if(pData[otherid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 5");

			new maxbandage = pData[playerid][pBandage] + ammount;

			if(maxbandage > 10)
				return Error(playerid, "Bandage lu penuh!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pBandage] -= ammount;
			pData[playerid][pBandage] += ammount;
			Info(otherid, "%s telah  merampas perban anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas perban %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas bandage %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		//	ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0)
		{
			if(pData[otherid][pMaterial] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 1000)
				return Error(playerid, "Invalid ammount 1 - 1000");

			new maxmat = pData[playerid][pMaterial] + ammount;

			if(maxmat > 1000)
				return Error(playerid, "Material lu penuh!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pMaterial] -= ammount;
			pData[playerid][pMaterial] += ammount;
			Info(otherid, "%s telah  merampas material anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas material %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas material %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"nasbung",true) == 0)
		{
			if(pData[otherid][pNasi] < ammount)
				return Error(playerid, "Nasi Kucing anda tidak cukup.");

			if(ammount > 25)
				return Error(playerid, "lu cuman bisa ngasih 25 Nasi Kucing");

			new maxnaskuc = pData[playerid][pNasi] + ammount;

			if(maxnaskuc > 25)
				return Error(playerid, "tuh orang dah ada 25 Nasi Kucing Beb!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pNasi] -= ammount;
			pData[playerid][pNasi] += ammount;
			Info(otherid, "%s telah  merampas Nasi Kucing anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Nasi Kucing %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas nasbung %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"ultramilk",true) == 0)
		{
			if(pData[otherid][pSusu] < ammount)
				return Error(playerid, "Ultramilk anda tidak cukup.");

			if(ammount > 25)
				return Error(playerid, "lu cuman bisa ngasih 25 Ultramilk");

			new maxjusjer = pData[playerid][pSusu] + ammount;

			if(maxjusjer > 25)
				return Error(playerid, "tuh orang dah ada 25 ultramilk!");
			
			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pSusu] -= ammount;
			pData[playerid][pSusu] += ammount;
			Info(otherid, "%s telah  merampas ultramilk anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas ultramilk %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas ultramilk %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"redmoney",true) == 0)
		{
			if(pData[otherid][pRedMoney] < ammount)
				return Error(playerid, "UangKotor anda tidak cukup.");

			if(ammount > 10000)
				return Error(playerid, "lu cuman bisa ngasih 10k uang kotor");

			new maxkot = pData[playerid][pRedMoney] + ammount;

			if(maxkot > 10000)
				return Error(playerid, "tuh orang dah ada 10k Uang Kotor!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pRedMoney] -= ammount;
			pData[playerid][pRedMoney] += ammount;
			Info(otherid, "%s telah  merampas Uang Merah anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Uang Merah %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Uang Kotor %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0)
		{
			if(pData[otherid][pComponent] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 300)
				return Error(playerid, "Invalid ammount 1 - 300");

			new maxcomp = pData[playerid][pComponent] + ammount;

			if(maxcomp > 300)
				return Error(playerid, "That player already have maximum component!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pComponent] -= ammount;
			pData[playerid][pComponent] += ammount;
			Info(otherid, "%s telah  merampas Component anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Component %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas component %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0)
		{
			if(pData[otherid][pMarijuana] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 100)
				return Error(playerid, "Invalid ammount 1 - 100");

			new maxmarijuana = pData[playerid][pMarijuana] + ammount;

			if(maxmarijuana > 100)
				return Error(playerid, "That player already have maximum marjun!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pMarijuana] -= ammount;
			pData[playerid][pMarijuana] += ammount;
			Info(otherid, "%s telah  merampas Marijuan anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Marijuana %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas marijuana %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipde",true) == 0)
		{
			if(pData[otherid][pClipA] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxclipa = pData[playerid][pClipA] + ammount;

			if(maxclipa > 10)
				return Error(playerid, "That player already have maximum clip!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pClipA] -= ammount;
			pData[playerid][pClipA] += ammount;
			Info(otherid, "%s telah  merampas Clip DE anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Clip DE %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Clip DE %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipsg",true) == 0)
		{
			if(pData[otherid][pClipB] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxclipb = pData[playerid][pClipB] + ammount;

			if(maxclipb > 10)
				return Error(playerid, "That player already have maximum clip!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pClipB] -= ammount;
			pData[playerid][pClipB] += ammount;
			Info(otherid, "%s telah  merampas Clip SG anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Clip SG %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Clip SG %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipak",true) == 0)
		{
			if(pData[otherid][pClipC] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxclipc = pData[playerid][pClipC] + ammount;

			if(maxclipc > 10)
				return Error(playerid, "That player already have maximum clip!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pClipC] -= ammount;
			pData[playerid][pClipC] += ammount;
			Info(otherid, "%s telah  merampas Clip AK47 anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Clip AK47 %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Clip AK47 %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:sapdtake(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
    if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
	if(pData[playerid][pFaction] != 1)  return Error(playerid, "Kamu gak punya akses buat sita.");
	if(IsPlayerConnected(playerid))
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			SyntaxMsg(playerid, "/sita [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, marijuana");
			Info(playerid, "Names: redmoney,clipde, clipsg, clipak, senjata");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");

		if(strcmp(name,"bandage",true) == 0)
		{
			if(pData[otherid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxbandage = pData[playerid][pBandage] + ammount;

			if(maxbandage > 10)
				return Error(playerid, "Bandage lu penuh!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pBandage] -= ammount;
			pData[playerid][pBandage] += ammount;
			Info(otherid, "%s telah  merampas perban anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas perban %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas bandage %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		//	ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0)
		{
			if(pData[otherid][pMaterial] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 1000)
				return Error(playerid, "Invalid ammount 1 - 1000");

			new maxmat = pData[playerid][pMaterial] + ammount;

			if(maxmat > 1000)
				return Error(playerid, "Material lu penuh!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pMaterial] -= ammount;
			pData[playerid][pMaterial] += ammount;
			Info(otherid, "%s telah  merampas material anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas material %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas material %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"metal",true) == 0)
		{
			if(pData[otherid][pMetal] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 2000)
				return Error(playerid, "Invalid ammount 1 - 2000");

			new maxmat = pData[playerid][pMetal] + ammount;

			if(maxmat > 2000)
				return Error(playerid, "Metal lu penuh!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pMetal] -= ammount;
			pData[playerid][pMetal] += ammount;
			Info(otherid, "%s telah  merampas Metal anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Metal %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Metal %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"redmoney",true) == 0)
		{
			if(pData[otherid][pRedMoney] < ammount)
				return Error(playerid, "UangKotor anda tidak cukup.");

			if(ammount > 10000)
				return Error(playerid, "lu cuman bisa ngasih 10k uang kotor");

			new maxkot = pData[playerid][pRedMoney] + ammount;

			if(maxkot > 10000)
				return Error(playerid, "tuh orang dah ada 10k Uang Kotor!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pRedMoney] -= ammount;
			pData[playerid][pRedMoney] += ammount;
			Info(otherid, "%s telah  merampas Uang Kotor anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Uang Kotor %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Uang kotor %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipde",true) == 0)
		{
			if(pData[otherid][pClipA] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxclipa = pData[playerid][pClipA] + ammount;

			if(maxclipa > 10)
				return Error(playerid, "clip lu penuh!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pClipA] -= ammount;
			pData[playerid][pClipA] += ammount;
			Info(otherid, "%s telah  merampas Clip DE anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Clip DE %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Clip AK47 %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipsg",true) == 0)
		{
			if(pData[otherid][pClipB] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxclipb = pData[playerid][pClipB] + ammount;

			if(maxclipb > 10)
				return Error(playerid, "clip lu penuh!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pClipB] -= ammount;
			pData[playerid][pClipB] += ammount;
			Info(otherid, "%s telah  merampas Clip SG anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Clip SG %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Clip SG %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipak",true) == 0)
		{
			if(pData[otherid][pClipC] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount > 10)
				return Error(playerid, "Invalid ammount 1 - 10");

			new maxclipc = pData[playerid][pClipC] + ammount;

			if(maxclipc > 10)
				return Error(playerid, "clip lu penuh!");


			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[otherid][pClipC] -= ammount;
			pData[playerid][pClipC] += ammount;
			Info(otherid, "%s telah  merampas Clip AK47 anda sejumlah %d.", ReturnName(playerid), ammount);
			Info(playerid, "Anda telah berhasil merampas Clip AK47 %s sejumlah %d.", ReturnName(otherid), ammount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas Clip AK47 %s sejumlah %d.", ReturnName(playerid), ReturnName(otherid), ammount);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"senjata",true) == 0)
		{
            //if(pData[otherid][pAmmo] < ammount)
				//return Error(playerid, "Item anda tidak cukup.")
        		
            ResetPlayerWeaponsEx(otherid);
			//pData[otherid][pWeapon] -= ammount;
			//pData[playerid][pWeapon] += ammount;
			Info(otherid, "%s telah merampas Senjata anda.", ReturnName(playerid));
			Info(playerid, "Anda telah berhasil merampas senjata %s.", ReturnName(otherid));
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Telah merampas semua senjata %s", ReturnName(playerid), ReturnName(otherid));
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:give(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			SyntaxMsg(playerid, "/give [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, ikangoreng, kebab, ultramilk, nasbung, burger, medicine, snack");
			Info(playerid, "Names: sprunk, berry, material, metal, component, marijuana, obat, gps, rokok");
			Info(playerid, "Names: clipde, clipsg, clipak, crack, alprazolam");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");
			
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
				
			pData[playerid][pBandage] -= ammount;
			pData[otherid][pBandage] += ammount;
			Info(playerid, "Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan perban kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipde",true) == 0)
		{
			if(pData[playerid][pClipA] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[playerid][pClipA] -= ammount;
			pData[otherid][pClipA] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Clip DE kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Clip DE kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipsg",true) == 0)
		{
			if(pData[playerid][pClipB] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[playerid][pClipB] -= ammount;
			pData[otherid][pClipB] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Clip SG kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Clip SG kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"clipak",true) == 0)
		{
			if(pData[playerid][pClipC] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[playerid][pClipC] -= ammount;
			pData[otherid][pClipC] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Clip AK47 kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Clip AK47 kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMedicine] -= ammount;
			pData[otherid][pMedicine] += ammount;
			Info(playerid, "Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan medicine kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSnack] -= ammount;
			pData[otherid][pSnack] += ammount;
			Info(playerid, "Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan snack kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"rokok",true) == 0)
		{
			if(ammount < 1) return SendClientMessage(playerid, 0xCECECEFF, "tidak bisa kurang dari 1");

			if(pData[playerid][pRokok] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			pData[playerid][pRokok] -= ammount;
			pData[otherid][pRokok] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Rokok kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Rokok kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"nasbung",true) == 0)
		{
			if(pData[playerid][pNasi] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			//if(ammount > -0) return Error(playerid, "Can't Give below -0");

			pData[playerid][pNasi] -= ammount;
			pData[otherid][pNasi] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Nasi Bungku kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Nasi Bungkus kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"burger",true) == 0)
		{
			if(pData[playerid][pBurger] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			//if(ammount > -0) return Error(playerid, "Can't Give below -0");

			pData[playerid][pBurger] -= ammount;
			pData[otherid][pBurger] += ammount;
			Info(playerid, "Anda telah berhasil memberikan burger kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan burger kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"ultramilk",true) == 0)
		{
			if(pData[playerid][pSusu] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			//if(ammount > -0) return Error(playerid, "Can't Give below -0");

			pData[playerid][pSusu] -= ammount;
			pData[otherid][pSusu] += ammount;
			Info(playerid, "Anda telah berhasil memberikan ultra milk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan ultra milk kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSprunk] -= ammount;
			pData[otherid][pSprunk] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"berry",true) == 0)
		{
			if(pData[playerid][pBerry] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");

			pData[playerid][pBerry] -= ammount;
			pData[otherid][pBerry] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Berry kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Berry kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"metal",true) == 0) 
		{
			if(pData[playerid][pMetal] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 2000)
				return Error(playerid, "Invalid ammount 1 - 2000");
			
			new maxmat = pData[otherid][pMetal] + ammount;
			
			if(maxmat > 2000)
				return Error(playerid, "That player already have maximum Metal!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMetal] -= ammount;
			pData[otherid][pMetal] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Metal kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Metal kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			if(pData[playerid][pMaterial] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 1000)
				return Error(playerid, "Invalid ammount 1 - 1000");
			
			new maxmat = pData[otherid][pMaterial] + ammount;
			
			if(maxmat > 1000)
				return Error(playerid, "That player already have maximum material!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMaterial] -= ammount;
			pData[otherid][pMaterial] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Material kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			if(pData[playerid][pComponent] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = pData[otherid][pComponent] + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pComponent] -= ammount;
			pData[otherid][pComponent] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Component kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			if(pData[playerid][pMarijuana] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMarijuana] -= ammount;
			pData[otherid][pMarijuana] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Marijuana kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Marijuana kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pObat] -= ammount;
			pData[otherid][pObat] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Obat kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Obat kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"gps",true) == 0) 
		{
			if(pData[playerid][pGPS] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pGPS] -= ammount;
			pData[otherid][pGPS] += ammount;
			Info(playerid, "Anda telah berhasil memberikan GPS kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan GPS kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"heroin",true) == 0) 
		{
			if(pData[playerid][pHeroin] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pHeroin] -= ammount;
			pData[otherid][pHeroin] += ammount;
			Info(playerid, "Anda telah berhasil memberikan heroin kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan heroin kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"xanax",true) == 0) 
		{
			if(pData[playerid][pXanax] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pXanax] -= ammount;
			pData[otherid][pXanax] += ammount;
			Info(playerid, "Anda telah berhasil memberikan xanax kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan xanax kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"peyote",true) == 0) 
		{
			if(pData[playerid][pPeyote] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pPeyote] -= ammount;
			pData[otherid][pPeyote] += ammount;
			Info(playerid, "Anda telah berhasil memberikan peyote kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan peyote kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"shrooms",true) == 0) 
		{
			if(pData[playerid][pShrooms] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pShrooms] -= ammount;
			pData[otherid][pShrooms] += ammount;
			Info(playerid, "Anda telah berhasil memberikan shrooms kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan shrooms kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"alprazolam",true) == 0) 
		{
			if(pData[playerid][pAlprazolam] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pAlprazolam] -= ammount;
			pData[otherid][pAlprazolam] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Alprazolam kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Alprazolam kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:burgertd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"burger",true) == 0)
		{
    		if(GetPVarInt(playerid, "mangan") > gettime())
        		return Error(playerid, "Mohon Tunggu 5 Detik Untuk Memakan kembali (Don't Spam).");
			if(pData[playerid][sampahsaya] == 10)
				return Error(playerid, "Buang sampah anda terlebih dahulu");
			if(pData[playerid][pBurger] < 1)
				return Error(playerid, "Anda tidak memiliki Burger.");

			//StartPlayerLoadingBar(playerid, 3, "Memakan...");
			ShowProgressbar(playerid, "Memakan..", 3);
			pData[playerid][pBurger]--;
			pData[playerid][pHunger] += 30;
			pData[playerid][sampahsaya]++;
		    Inventory_Update(playerid);
        	Inventory_Close(playerid);
        	ShowItemBox(playerid, "Roti", "Removed_1x", 19883, 2);
			ShowItemBox(playerid, "Sampah", "Received_1x", 2840, 2);
	    	SetPlayerChatBubble(playerid,"Makan Burger",COLOR_PURPLE,30.0,10000);
			//notification.Show(playerid, "Info", "Anda berhasil memakan burger.", "ld_chat:thumbup");
			SuccesMsg(playerid, "Anda berhasil memakan burger.");
			//Info(playerid, "Anda telah berhasil memakan burger.");
			//InfoTD_MSG(playerid, 3000, "Restore +30 Hunger");
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
			SetPVarInt(playerid, "mangan", gettime() + 6);
		}
	}
	return 1;
}

CMD:nasbungtd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"nasbung",true) == 0)
		{
    		if(GetPVarInt(playerid, "mangan") > gettime())
        		return Error(playerid, "Mohon Tunggu 5 Detik Untuk Memakan kembali (Don't Spam).");
			if(pData[playerid][sampahsaya] == 10)
				return Error(playerid, "Buang sampah anda terlebih dahulu");
			if(pData[playerid][pNasi] < 1)
				return Error(playerid, "Anda tidak memiliki Nasi Bungkus.");

			//StartPlayerLoadingBar(playerid, 3, "Memakan...");
			ShowProgressbar(playerid, "Memakan..", 3);
			pData[playerid][pNasi]--;
			pData[playerid][pHunger] += 20;
	    	pData[playerid][sampahsaya]++;
		    Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
        	ShowItemBox(playerid, "Nasbung", "Removed_1x", 2663, 2);
			ShowItemBox(playerid, "Sampah", "Received_1x", 2840, 2);
	    	SetPlayerChatBubble(playerid,"Makan Nasbung",COLOR_PURPLE,30.0,10000);
			//pData[playerid][pTrash] += 1;
			//notification.Show(playerid, "Info", "Anda berhasil memakan nasbung.", "ld_chat:thumbup");
			//Info(playerid, "Anda telah berhasil menggunakan nasbung.");
			//SuccesMsg(playerid, "Anda berhasil memakan nasbung.");
			//InfoTD_MSG(playerid, 3000, "Restore +20 Hunger");
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
			SetPVarInt(playerid, "mangan", gettime() + 6);
		}
	}
	return 1;
}
CMD:susutd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"ultramilk",true) == 0)
		{
    		if(GetPVarInt(playerid, "ngudud") > gettime())
        		return Error(playerid, "Mohon Tunggu 5 Detik Untuk Meminum kembali (Don't Spam).");
			if(pData[playerid][sampahsaya] == 10)
				return Error(playerid, "Buang sampah anda terlebih dahulu");
			if(pData[playerid][pSusu] < 1)
				return Error(playerid, "Anda tidak memiliki ultramilk.");

			//StartPlayerLoadingBar(playerid, 3, "Memakan...");
			ShowProgressbar(playerid, "Meminum..", 3);
			pData[playerid][pSusu]--;
			pData[playerid][pEnergy] += 25;
			pData[playerid][pBladder] -= 15;
	    	pData[playerid][sampahsaya]++;
        	Inventory_Close(playerid);
        	ShowItemBox(playerid, "Milk_Max", "Removed_1x", 19570, 2);
			ShowItemBox(playerid, "Sampah", "Received_1x", 2840, 2);
			Inventory_Update(playerid);
	    	SetPlayerChatBubble(playerid,"Minum Susu",COLOR_PURPLE,30.0,10000);

			//pData[playerid][pBladder] += 10;
			//notification.Show(playerid, "Info", "Anda berhasil meminum susu.", "ld_chat:thumbup");
			//SuccesMsg(playerid, "Anda berhasil meminum susu ultramilk.");
			//Info(playerid, "Anda telah berhasil meminum ultra milk.");
			//InfoTD_MSG(playerid, 3000, "Restore +25 Energy");
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
			SetPVarInt(playerid, "ngudud", gettime() + 6);
		}
	}
	return 1;
}
CMD:bandagetd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"bandage",true) == 0) 
		{
    		if(GetPVarInt(playerid, "ngebandage") > gettime())
        		return Error(playerid, "Mohon Tunggu 5 Detik Untuk Menggunakan kembali (Don't Spam).");

			if(pData[playerid][pBandage] < 1)
				return Error(playerid, "Anda tidak memiliki perban.");

			//if(pData[playerid][pBandage] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memperban lagi", pData[playerid][pBandage] - gettime());

		
			//StartPlayerLoadingBar(playerid, 3, "Memperban...");
			ShowProgressbar(playerid, "Memperban..", 3);
			//pData[playerid][pBandage] = gettime() + 10;
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			pData[playerid][pBandage]--;
			
			if(pData[playerid][pHealth] > 100)
				return Error(playerid, "Max 100 Hp!");

			SetPlayerHealthEx(playerid, darah+15);
			//notification.Show(playerid, "Info", "Anda Berhasil Memperban", "ld_chat:thumbup");
			//SuccesMsg(playerid, "Anda berhasil menggunakan perban.");
			//Info(playerid, "Anda telah berhasil menggunakan perban.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Health");
			SetPVarInt(playerid, "ngebandage", gettime() + 6);
		}
	}
	return 1;
}
CMD:snacktd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < 1)
				return Error(playerid, "Anda tidak memiliki snack.");

			//if(pData[playerid][pSnack] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memakan lagi", pData[playerid][pSnack] - gettime());

		
			// ShowProgressbar(playerid, 3, "Memakan...");
			//pData[playerid][pSnack] = gettime() + 10;
			pData[playerid][pSnack]--;
			pData[playerid][pHunger] += 15;
			//Info(playerid, "Anda telah berhasil menggunakan snack.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}
CMD:sprunktd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"sprunk",true) == 0) 
		{
			
			if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "Anda tidak memiliki sprunk.");
			
			//if(pData[playerid][pSprunk] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk meminum lagi", pData[playerid][pSprunk] - gettime());

		
			// ShowProgressbar(playerid, 3, "Meminum...");
			//pData[playerid][pSprunk] = gettime() + 10;
			pData[playerid][pSprunk]--;
			pData[playerid][pEnergy] += 15;
			//Info(playerid, "Anda telah berhasil meminum sprunk.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}
CMD:boomboxtd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"boombox",true) == 0)
		{
			if(pData[playerid][pBoombox] < 1)
				return Error(playerid, "You dont have boombox");

			new string[128], Float:BBCoord[4], pNames[MAX_PLAYER_NAME];
		    GetPlayerPos(playerid, BBCoord[0], BBCoord[1], BBCoord[2]);
		    GetPlayerFacingAngle(playerid, BBCoord[3]);
		    SetPVarFloat(playerid, "BBX", BBCoord[0]);
		    SetPVarFloat(playerid, "BBY", BBCoord[1]);
		    SetPVarFloat(playerid, "BBZ", BBCoord[2]);
		    GetPlayerName(playerid, pNames, sizeof(pNames));
		    BBCoord[0] += (2 * floatsin(-BBCoord[3], degrees));
		   	BBCoord[1] += (2 * floatcos(-BBCoord[3], degrees));
		   	BBCoord[2] -= 1.0;
			if(GetPVarInt(playerid, "PlacedBB")) return SendClientMessage(playerid, -1, "Kamu Sudah Memasang Boombox");
			foreach(new i : Player)
			{
		 		if(GetPVarType(i, "PlacedBB"))
		   		{
		  			if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ")))
					{
		   				SendClientMessage(playerid, COLOR_WHITE, "Kamu Tidak Dapat Memasang Boombox Disini, Karena Orang Sudah Lain Sudah Memasang Boombox Disini");
					    return 1;
					}
				}
			}
			new string2[128];

			StartPlayerLoadingBar(playerid, 3, "Memasang...");

			format(string2, sizeof(string2), "%s Telah Memasang Boombox!", pNames);
			//notification.Show(playerid, "Info", "Anda berhasil menggunakan boombox.", "ld_chat:thumbup");
			SuccesMsg(playerid, "Anda berhasil menggunakan boombox.");
			SendNearbyMessage(playerid, 15, COLOR_PURPLE, string2);
			Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
			SetPVarInt(playerid, "PlacedBB", CreateDynamicObject(2102, BBCoord[0], BBCoord[1], BBCoord[2], 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
			format(string, sizeof(string), "Creator [%s]\n{FFFFFF}Use {FFFF00}'/bbhelp'{FFFFFF} for info.", GetName(playerid));	
			//format(string, sizeof(string), "Creator "COLOR_GREEN"%s\n[" COLOR_BLUE "/bbhelp for info" WHITE_E "]", pName);
			SetPVarInt(playerid, "BBLabel", _:CreateDynamic3DTextLabel(string, COLOR_YELLOW, BBCoord[0], BBCoord[1], BBCoord[2]+0.6, 5, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
			SetPVarInt(playerid, "BBArea", CreateDynamicSphere(BBCoord[0], BBCoord[1], BBCoord[2], 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
			SetPVarInt(playerid, "BBInt", GetPlayerInterior(playerid));
			SetPVarInt(playerid, "BBVW", GetPlayerVirtualWorld(playerid));
			ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
		    ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
		}
	}
	return 1;
}
CMD:berrytd(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
        if(strcmp(params,"berry",true) == 0)
		{
			if(pData[playerid][pBerry] < 0)
				return Error(playerid, "You dont have berry.");

			//if(pData[playerid][pBerry] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memakan lagi", pData[playerid][pBerry] - gettime());

		
			//StartPlayerLoadingBar(playerid, 3, "Memakan...");
			ShowProgressbar(playerid, "Memakan..", 3);
			//notification.Show(playerid, "Info", "Anda berhasil memakan berry.", "ld_chat:thumbup");
			SuccesMsg(playerid, "Anda berhasil memakan berry.");
			//pData[playerid][pBerry] = gettime() + 5;
			pData[playerid][pHunger] += 10;
			pData[playerid][pBerry]--;
			Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
		}
	}
	return 1;
}
CMD:gas(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(pData[playerid][pGas] < 1)
			return Error(playerid, "Anda tidak memiliki gas.");
			
		if(IsPlayerInAnyVehicle(playerid))
			return Error(playerid, "Anda harus berada diluar kendaraan!");
		
		if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
		
		new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
		if(IsValidVehicle(vehicleid))
		{
			new fuel = GetVehicleFuel(vehicleid);
		
			if(GetEngineStatus(vehicleid))
				return Error(playerid, "Turn off vehicle engine.");
		
			if(fuel >= 1999.0)
				return Error(playerid, "This vehicle gas is full.");
		
			if(!IsEngineVehicle(vehicleid))
				return Error(playerid, "This vehicle can't be refull.");

			//if(!GetHoodStatus(vehicleid))
				//return Error(playerid, "The hood must be opened before refull the vehicle.");

			pData[playerid][pGas]--;
			Inventory_Update(playerid);
			Inventory_Close(playerid);
			Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			pData[playerid][pActivityStatus] = 1;
			pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			//notification.Show(playerid, "Info", "Anda berhasil menggunakan gasfuel.", "ld_chat:thumbup");
			SuccesMsg(playerid, "Anda berhasil menggunakan gasfuel.");
			//InfoTD_MSG(playerid, 10000, "Refulling...");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s starts to refulling the vehicle.", ReturnName(playerid));
			return 1;
		}
		else Error(playerid, "Kamu tidak berada didekat Kendaraan");
	}
	return 1;
}
CMD:usevest(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"vest",true) == 0) 
		{
    		if(GetPVarInt(playerid, "vest") > gettime())
        		return Error(playerid, "Mohon Tunggu 5 Detik Untuk Menggunakan kembali (Don't Spam).");

			if(pData[playerid][pVest] < 1)
				return Error(playerid, "You dont have vest.");
	
			pData[playerid][pVest]--;
			SetPlayerArmourEx(playerid, 97);
			Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
			SuccesMsg(playerid, "Anda berhasil menggunakan vest.");
			SetPVarInt(playerid, "vest", gettime() + 6);
		}
	}
	return 1;
}
CMD:use(playerid, params[])
{
    if (IsPlayerConnected(playerid)) 
    {
		if(isnull(params)) 
		{
			SyntaxMsg(playerid, "USAGE: /use [name]");
			Info(playerid, "Names: heroin, marijuana, xanax, shrooms, peyote, snack, sprunk, bandage, rokok");
			return 1;
		}

        new Float:armor;
        GetPlayerArmour(playerid, armor);
		if(strcmp(params,"heroin",true) == 0) 
        {
            if (GetPVarInt(playerid, "heroin") > gettime())
                return Error(playerid, "Please wait 5 seconds before using this again.");

            if (pData[playerid][pHeroin] < 1)
                return Error(playerid, "You don't have heroin.");

            if (armor + 3 > 97) 
                return Error(playerid, "Overdose risk! Armor limit is 97.");

            ShowProgressbar(playerid, "Using Heroin...", 3);
            pData[playerid][pHeroin]--;
            SetPlayerArmourEx(playerid, armor + 3);
            SetPlayerDrunkLevel(playerid, 4000);
            SuccesMsg(playerid, "Successfully used heroin.");
            ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 2.1, 0, 0, 0, 0, 0);
            SetPVarInt(playerid, "heroin", gettime() + 6);
        }
        else if(strcmp(params,"marijuana",true) == 0) 
        {
            if (GetPVarInt(playerid, "marjun") > gettime())
                return Error(playerid, "Please wait 5 seconds before using this again.");

            if (pData[playerid][pMarijuana] < 1)
                return Error(playerid, "You don't have marijuana.");

            if (armor + 5 > 50) 
                return Error(playerid, "Overdose risk! Armor limit is 50.");

            ShowProgressbar(playerid, "Using Marijuana...", 3);
            pData[playerid][pMarijuana]--;
            SetPlayerArmourEx(playerid, armor + 5);
            SetPlayerDrunkLevel(playerid, 4000);
            SuccesMsg(playerid, "Successfully used marijuana.");
            ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 2.1, 0, 0, 0, 0, 0);
            SetPVarInt(playerid, "marjun", gettime() + 6);
        }
        else if(strcmp(params,"xanax",true) == 0) 
        {
            if (GetPVarInt(playerid, "xanax") > gettime())
                return Error(playerid, "Please wait 5 seconds before using this again.");

            if (pData[playerid][pXanax] < 1)
                return Error(playerid, "You don't have Xanax.");

            if (armor + 6 > 97) 
                return Error(playerid, "Overdose risk! Armor limit is 97.");

            ShowProgressbar(playerid, "Using Xanax...", 3);
            pData[playerid][pXanax]--;
            SetPlayerArmourEx(playerid, armor + 6);
            SetPlayerDrunkLevel(playerid, 5000);
            SuccesMsg(playerid, "Successfully used Xanax.");
            ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 2.1, 0, 0, 0, 0, 0);
            SetPVarInt(playerid, "xanax", gettime() + 6);
        }
        else if(strcmp(params,"peyote",true) == 0) 
        {
            if (GetPVarInt(playerid, "peyote") > gettime())
                return Error(playerid, "Please wait 5 seconds before using this again.");

            if (pData[playerid][pPeyote] < 1)
                return Error(playerid, "You don't have Peyote.");

            if (armor + 4 > 97) 
                return Error(playerid, "Overdose risk! Armor limit is 97.");

            ShowProgressbar(playerid, "Using Peyote...", 3);
            pData[playerid][pPeyote]--;
            SetPlayerArmourEx(playerid,  armor + 4);
            SetPlayerDrunkLevel(playerid, 6000);
            SuccesMsg(playerid, "Successfully used Peyote.");
            ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 2.1, 0, 0, 0, 0, 0);
            SetPVarInt(playerid, "peyote", gettime() + 6);
        }
        else if(strcmp(params,"shrooms",true) == 0) 
        {
            if (GetPVarInt(playerid, "shrooms") > gettime())
                return Error(playerid, "Please wait 5 seconds before using this again.");

            if (pData[playerid][pShrooms] < 1)
                return Error(playerid, "You don't have Shrooms.");

            if (armor + 5 > 97) 
                return Error(playerid, "Overdose risk! Armor limit is 100.");

            ShowProgressbar(playerid, "Using Shrooms...", 3);
            pData[playerid][pShrooms]--;
            SetPlayerArmourEx(playerid,  armor + 5);
            SetPlayerDrunkLevel(playerid, 7000);
            SuccesMsg(playerid, "Successfully used Shrooms.");
            ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 2.1, 0, 0, 0, 0, 0);
            SetPVarInt(playerid, "shrooms", gettime() + 6);
        }
		else if(strcmp(params,"sprunk",true) == 0) 
        {
            if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "Anda tidak memiliki sprunk.");
			
			//if(pData[playerid][pSprunk] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk meminum lagi", pData[playerid][pSprunk] - gettime());

		
			// ShowProgressbar(playerid, 3, "Meminum...");
			//pData[playerid][pSprunk] = gettime() + 10;
			pData[playerid][pSprunk]--;
			pData[playerid][pEnergy] += 15;
			//Info(playerid, "Anda telah berhasil meminum sprunk.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        }
		else if(strcmp(params,"snack",true) == 0) 
        {
            if(pData[playerid][pSnack] < 1)
				return Error(playerid, "Anda tidak memiliki snack.");

			//if(pData[playerid][pSnack] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memakan lagi", pData[playerid][pSnack] - gettime());

		
			// ShowProgressbar(playerid, 3, "Memakan...");
			//pData[playerid][pSnack] = gettime() + 10;
			pData[playerid][pSnack]--;
			pData[playerid][pHunger] += 15;
			//Info(playerid, "Anda telah berhasil menggunakan snack.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        }
		else if(strcmp(params,"bandage",true) == 0) 
        {
            if(GetPVarInt(playerid, "ngebandage") > gettime())
        		return Error(playerid, "Mohon Tunggu 5 Detik Untuk Menggunakan kembali (Don't Spam).");

			if(pData[playerid][pBandage] < 1)
				return Error(playerid, "Anda tidak memiliki perban.");

			//if(pData[playerid][pBandage] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memperban lagi", pData[playerid][pBandage] - gettime());

		
			//StartPlayerLoadingBar(playerid, 3, "Memperban...");
			ShowProgressbar(playerid, "Memperban..", 3);
			//pData[playerid][pBandage] = gettime() + 10;
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			pData[playerid][pBandage]--;
			
			if(pData[playerid][pHealth] > 100)
				return Error(playerid, "Max 100 Hp!");

			SetPlayerHealthEx(playerid, darah+15);
			//notification.Show(playerid, "Info", "Anda Berhasil Memperban", "ld_chat:thumbup");
			//SuccesMsg(playerid, "Anda berhasil menggunakan perban.");
			//Info(playerid, "Anda telah berhasil menggunakan perban.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Health");
			SetPVarInt(playerid, "ngebandage", gettime() + 6);
        }
		else if(strcmp(params,"rokok",true) == 0) 
        {
            if(pData[playerid][pRokok] < 1)
			return Error(playerid, "Anda tidak memiliki rokok.");
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
			new Float:darah;
			GetPlayerHealth(playerid, darah);

			
			pData[playerid][pRokok]--;
			SetPlayerHealthEx(playerid, darah+15);
			pData[playerid][pBladder] -= 10;
        }
        else 
        {
            return Error(playerid, "Invalid item. Use 'heroin', 'marijuana', 'xanax', 'peyote', or 'shrooms'.");
        }
    }
    return 1;
}



CMD:usealpra(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"alprazolam",true) == 0) 
		{
			if(pData[playerid][pAlprazolam] < 1)
				return Error(playerid, "Anda tidak memiliki alprazolam.");
			
			ShowProgressbar(playerid, "Meminum Alprazolam..", 3);
			Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
			pData[playerid][pAlprazolam]--;
			pData[playerid][pBladder] -= 25;
			pData[playerid][pSick] = 0;	
			// pData[playerid][pSick] = 0;
			// pData[playerid][pSickTime] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "Alprazolam telah terminum.");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}
CMD:medicine(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < 1)
				return Error(playerid, "Anda tidak memiliki medicine.");
			
			//if(pData[playerid][pMedicine] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memakan lagi", pData[playerid][pMedicine] - gettime());

		
			//StartPlayerLoadingBar(playerid, 3, "Memakan...");
			ShowProgressbar(playerid, "Memakan Obat..", 3);
			//pData[playerid][pMedicine] = gettime() + 10;
			Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
			pData[playerid][pMedicine]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "Anda menggunakan medicine.");
			//notification.Show(playerid, "Info", "Anda berhasil menggunakan medicine.", "ld_chat:thumbup");
			//SuccesMsg(playerid, "Anda berhasil menggunakan medicine.");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}
CMD:obat(playerid, params[])
{
	if(IsPlayerConnected(playerid)) 
	{
		if(strcmp(params,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < 1)
				return Error(playerid, "Anda tidak memiliki Obat Myricous.");
			
			//if(pData[playerid][pObat] >= gettime())
				//return Error(playerid, "kamu harus menunggu %d lagi untuk memakan lagi", pData[playerid][pObat] - gettime());

		
			//StartPlayerLoadingBar(playerid, 3, "Memakan...");
			ShowProgressbar(playerid, "Memakan Obat..", 3);
			//pData[playerid][pObat] = gettime() + 10;
			Inventory_Update(playerid);
 	       	Inventory_Close(playerid);
			pData[playerid][pObat]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			pData[playerid][pHead] = 100;
			pData[playerid][pPerut] = 100;
			pData[playerid][pRHand] = 100;
			pData[playerid][pLHand] = 100;
			pData[playerid][pRFoot] = 100;
			pData[playerid][pLFoot] = 100;
			SetPlayerDrunkLevel(playerid, 0);
			//Info(playerid, "Anda menggunakan Obat Myricous.");
			//SuccesMsg(playerid, "Anda berhasil menggunakan obat myricious.");
			//notification.Show(playerid, "Info", "Anda berhasil menggunakan obat.", "ld_chat:thumbup");
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}
CMD:lbaju(playerid, params[])
{
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "You are not allowed to take off your clothes except at your home");
		
	if(BajuLaki[playerid] == 0)

	{
		if(pData[playerid][pGender] == 2) return Error(playerid, "Hanya Laki-laki yang bisa mengguakan CMD ini.");
		SetPlayerSkinEx(playerid, 154);
		BajuLaki[playerid] = 1;
		SendClientMessage(playerid, -1, "Anda berhasil membuka baju");
	}
	else
	{
		SetPlayerSkinEx(playerid, pData[playerid][pSkin]);
		BajuLaki[playerid] = 0;
		SendClientMessage(playerid, -1, "Anda berhasil memakai baju");
	}
    return 1;
}
CMD:pbaju(playerid, params[])
{
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "You are not allowed to take off your clothes except at your home");

	if(BajuPerempuan[playerid] == 0)
	{
		if(pData[playerid][pGender] == 1) return Error(playerid, "Hanya Perempuan yang bisa mengguakan CMD ini.");
		SetPlayerSkinEx(playerid, 140);
		BajuPerempuan[playerid] = 1;
		SendClientMessage(playerid, -1, "Anda berhasil membuka baju");
	}
	else
	{
		SetPlayerSkinEx(playerid, pData[playerid][pSkin]);
		BajuPerempuan[playerid]  = 0;
		SendClientMessage(playerid, -1, "Anda berhasil memakai baju");
	}
    return 1;
}

CMD:bbhelp(playerid, params[])
{
	SyntaxMsg(playerid, "/use boombox /setbb /pickupbb");
	return 1;
}

CMD:setbb(playerid, params[])
{
    if(pData[playerid][pBoombox] == 0)
	    return SendClientMessage(playerid, 0xCECECEFF, "you dont have boombox");

	if(GetPVarType(playerid, "PlacedBB"))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")))
		{
			ShowPlayerDialog(playerid,DIALOG_BOOMBOX,DIALOG_STYLE_LIST,"Boombox","Turn Off Boombox\nInput URL","Select", "Cancel");
		}
		else
		{
   			return SendClientMessage(playerid, -1, "You're not near from your boombox");
		}
    }
    else
    {
        SendClientMessage(playerid, -1, "you didnt place boombox before");
	}
	return 1;
}

CMD:pickupbb(playerid, params [])
{
    if(pData[playerid][pBoombox] == 0)
	    return SendClientMessage(playerid, 0xCECECEFF, "you dont have boombox");

	if(!GetPVarInt(playerid, "PlacedBB"))
    {
        SendClientMessage(playerid, -1, "you dont have placedboombox to take");
    }
	if(IsPlayerInRangeOfPoint(playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")))
    {
        PickUpBoombox(playerid);
        SendClientMessage(playerid, -1, "boombox pickup");
    }
    return 1;
}
stock StopStream(playerid)
{
	DeletePVar(playerid, "pAudioStream");
    StopAudioStreamForPlayer(playerid);
}

stock PlayStream(playerid, url[], Float:posX = 0.0, Float:posY = 0.0, Float:posZ = 0.0, Float:distance = 50.0, usepos = 0)
{
	if(GetPVarType(playerid, "pAudioStream")) StopAudioStreamForPlayer(playerid);
	else SetPVarInt(playerid, "pAudioStream", 1);
    PlayAudioStreamForPlayer(playerid, url, posX, posY, posZ, distance, usepos);
}

stock PickUpBoombox(playerid)
{
    foreach(new i : Player)
	{
 		if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
   		{
     		StopStream(i);
		}
	}
	DeletePVar(playerid, "BBArea");
	DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
	DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
	DeletePVar(playerid, "PlacedBB"); DeletePVar(playerid, "BBLabel");
 	DeletePVar(playerid, "BBX"); DeletePVar(playerid, "BBY"); DeletePVar(playerid, "BBZ");
	DeletePVar(playerid, "BBInt");
	DeletePVar(playerid, "BBVW");
	DeletePVar(playerid, "BBStation");
	return 1;
}

CMD:enter(playerid, params[])
{
	if(pData[playerid][pInjured] == 0)
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "Bangunan ini di Kunci untuk sementara.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk fraksi.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "Pintu ini hanya untuk Family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "VIP Level mu tidak cukup.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Admin level mu tidak cukup.");
						
					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return SyntaxMsg(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Password Salah.");
						
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
				else
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "Pintu ini ditutup sementara");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "Pintu ini hanya untuk family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level not enough to enter this door.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this door.");

					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return SyntaxMsg(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");

						if (SpaceDebug[playerid] >= gettime()-2)
							return 0;
						
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if (SpaceDebug[playerid] >= gettime()-2)
							return 0;

						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
				
					if(dData[did][dCustom])
					{
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					else
					{
						SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
				else
				{
					if (SpaceDebug[playerid] >= gettime()-2)
						return 0;
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
					
					if(dData[did][dCustom])
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);

					else
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
			}
        }
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "Rumah ini terkunci!");

				if (SpaceDebug[playerid] >= gettime()-2)
					return 0;
					
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			if (SpaceDebug[playerid] >= gettime()-2)
				return 0;
				
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			pData[playerid][pInHouse] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "Bisnis ini Terkunci!");

				if (SpaceDebug[playerid] >= gettime()-2)
					return 0;
					
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			if (SpaceDebug[playerid] >= gettime()-2)
				return 0;
				
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			pData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if (SpaceDebug[playerid] >= gettime()-2)
					return 0;
					
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "Anda bukan termasuk family ini!");
					
				pData[playerid][pInFamily] = fid;		
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			new difamily = pData[playerid][pInFamily];
			if(pData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, fData[difamily][fIntposX], fData[difamily][fIntposY], fData[difamily][fIntposZ]))
			{
				if (SpaceDebug[playerid] >= gettime()-2)
					return 0;
					
				pData[playerid][pInFamily] = -1;	
				SetPlayerPositionEx(playerid, fData[difamily][fExtposX], fData[difamily][fExtposY], fData[difamily][fExtposZ], fData[difamily][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
	}
	return 1;
}
CMD:cuffdrag(playerid, params[])
{
	if(pData[playerid][pFaction] != 1)
        return Error(playerid, "Kamu harus menjadi police officer.");

	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/cuffdrag [playerid/PartOfName] || /uncuffdrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player itu Disconnect.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa menarik diri mu sendiri.");

    if(!NearPlayer(playerid, otherid, 8.0))
        return Error(playerid, "Kamu harus didekat Player.");

    //if(!pData[otherid][pInjured])
        //return Error(playerid, "kamu tidak bisa drag orang yang tidak mati.");

    SetPVarInt(otherid, "DragBy", playerid);
    Info(otherid, "%s Telah menawari drag kepada anda, /accept cuffdrag untuk menerimanya /deny cuffdrag untuk membatalkannya.", ReturnName(playerid));
	Info(playerid, "Anda berhasil menawari drag kepada player %s", ReturnName(otherid));
    return 1;
}

CMD:uncuffdrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/uncuffdrag [playerid]");
	if(pData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        pData[otherid][pDragged] = 0;
        pData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(pData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}
CMD:drag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/drag [playerid/PartOfName] || /undrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player itu Disconnect.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa menarik diri mu sendiri.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Kamu harus didekat Player.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "kamu tidak bisa drag orang yang tidak mati.");

    SetPVarInt(otherid, "DragBy", playerid);
    Info(otherid, "%s Telah menawari drag kepada anda, /accept drag untuk menerimanya /deny drag untuk membatalkannya.", ReturnName(playerid));
	Info(playerid, "Anda berhasil menawari drag kepada player %s", ReturnName(otherid));
    return 1;
}

CMD:undrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/undrag [playerid]");
	if(pData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        pData[otherid][pDragged] = 0;
        pData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(pData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}
CMD:togmask(playerid, params[])
{
	if(pData[playerid][pLevel] < 3)
	    return ErrorMsg(playerid, "You must level 3 first for using mask.");

	if(pData[playerid][pMask] < 1)
		return ErrorMsg(playerid, "You don't have a mask");

	if(pData[playerid][pLevel] < 5) return Error(playerid, "Level kamu kurang dari 5.");
		
	switch (pData[playerid][pMaskOn])
    {
        case 0:
        {
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a mask and puts it on.", ReturnName(playerid));
            pData[playerid][pMaskOn] = 1;
			CreatePlayerMask(playerid);
            /* new string[35];
            GetPlayerName(playerid, string, sizeof(string));
            format(string,sizeof(string), "Mask_%d", pData[playerid][pMaskID]);
      	 	SetPlayerName(playerid, string); */
			for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(i, playerid, false);
			ApplyAnimation(playerid, "goggles", "goggles_put_on", 4.1, 0, 0, 0, 0, 0, 1);
        }
        case 1:
        {
			RemovePlayerMask(playerid);
            pData[playerid][pMaskOn] = 0;
            // SetPlayerName(playerid, pData[playerid][pName]);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));
			for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(i, playerid, true);
        }
    }
	return 1;
}
// CMD:maskbro(playerid, params[])
// {
//     if (pData[playerid][pMask] <= 0)
//         return Error(playerid, "You don't have a mask.");

//     switch (pData[playerid][pMaskOn])
//     {
//         case 0: 
//         {
//             SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* Mask_#%d takes out a mask and puts it on.", pData[playerid][pMaskID]);
//             pData[playerid][pMaskOn] = 1;
// 			for (new i = GetPlayerPoolSize(); i != -1; --i)
// 				{
// 					ShowPlayerNameTagForPlayer(i, playerid, 0); 
// 				}
//             UpdateMaskTextLabel(playerid); 
//             UpdateNametagMaskForPlayer(playerid); 
//         }
//         case 1: 
//         {
//             DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);
//             pData[playerid][pMaskOn] = 0;
//             SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));

//             for (new i = GetPlayerPoolSize(); i != -1; --i)
// 			{
// 				ShowPlayerNameTagForPlayer(i, playerid, 1); 
// 			}

//             UpdateNametagMaskForPlayer(playerid); 
//         }
//     }
//     return 1;
// }
CMD:fixme(playerid, params[])
{
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
    SendClientMessage(playerid, COLOR_LIGHTRED, "Bug Visual Anda telah diperbaiki.");
	// SendStaffMessage(COLOR_LIGHTRED, "[ISSUE] %s telah menggunakan cmd fixme",pData[playerid][pName]);
    return 1;
}


CMD:stuck(playerid, params[])
{
	if(pData[playerid][pAdmin] > 0)
		return PermissionError(playerid);
    if((gettime() - PlayerData[playerid][pStuck]) < 60) return SendErrorMessage(playerid, "Tunggu 1 menit untuk stuck kembali.");
    ShowPlayerDialog(playerid, DIALOG_STUCK, DIALOG_STYLE_LIST, "Stuck", "BUG VW.\n\
	BUG INT.\n\
	BUG DALAM INT\n\
	Stuck at BB\n\
	AKU MATI GAJELAS\n\
	GA BISA GERAK\n\
	BUG TERJUN\n\
	TIDAK TAHU DIMANA\n\
	KENDARAAN NYEBUR KELAUT", "Report", "Close");
    return 1;
}

//Text and Chat Commands
CMD:try(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/try [action]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s, %s", params[64], (random(2) == 0) ? ("and success") : ("but fail"));
    }
    else {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s, %s", ReturnName(playerid), params, (random(2) == 0) ? ("and success") : ("but fail"));
    }
	printf("[TRY] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ado(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        SyntaxMsg(playerid, "/ado [text]");
		Info(playerid, "Use /ado off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pAdoActive])
            return Error(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

        Servers(playerid, "You're removed your ado text.");
        pData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pAdoTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pAdoActive] = true;
        pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[ADO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ab(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        SyntaxMsg(playerid, "/ab [text]");
		Info(playerid, "Use /ab off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pBActive])
            return Error(playerid, "You're not actived your 'ab' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);

        Servers(playerid, "You're removed your ab text.");
        pData[playerid][pBActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( OOC : %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pBActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pBTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pBActive] = true;
        pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[AB] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ame(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164];

    if(isnull(params))
        return SyntaxMsg(playerid, "/ame [action]");

    if(strlen(params) > 128)
        return Error(playerid, "Max action can only maximmum 128 characters.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    format(flyingtext, sizeof(flyingtext), "* %s %s*", ReturnName(playerid), params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_PURPLE, 10.0, 10000);
	printf("[AME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:l(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64)
				{
					SendClientMessageEx(i, COLOR_GREY, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessageEx(i, COLOR_GREY, "...%s", params[64]);
				}
				else
				{
					SendClientMessageEx(i, COLOR_GREY, "[car] %s says: %s", ReturnName(playerid), params);
				}
				printf("[CAR] %s(%d) : %s", pData[playerid][pName], playerid, params);
			}
		}
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 5.0, COLOR_GREY, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_GREY, "...%s", params[64]);
		}
		else
		{
			SendNearbyMessage(playerid, 5.0, COLOR_GREY, "[low] %s says: %s", ReturnName(playerid), params);
		}
		printf("[LOW] %s(%d) : %s", pData[playerid][pName], playerid, params);
	}
    return 1;
}

CMD:me(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/me [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
    }
	printf("[ME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}


CMD:do(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/do [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
    }
	printf("[DO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}
CMD:lme(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/lme [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 5.0, COLOR_PURPLE3, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 5.0, COLOR_PURPLE3, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 5.0, COLOR_PURPLE3, "* %s %s", ReturnName(playerid), params);
    }
	printf("[LME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ldo(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/ldo [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 5.0, COLOR_PURPLE3, "* %.64s ..", params);
        SendNearbyMessage(playerid, 5.0, COLOR_PURPLE3, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 5.0, COLOR_PURPLE3, "* %s (( %s ))", params, ReturnName(playerid));
    }
	printf("[LDO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}


CMD:toglog(playerid)
{
	if(!pData[playerid][pTogLog])
	{
		pData[playerid][pTogLog] = 1;
		Info(playerid, "Anda telah menonaktifkan log server.");
	}
	else
	{
		pData[playerid][pTogLog] = 0;
		Info(playerid, "Anda telah mengaktifkan log server.");
	}
	return 1;
}

CMD:togpm(playerid)
{
	if(!pData[playerid][pTogPM])
	{
		pData[playerid][pTogPM] = 1;
		Info(playerid, "Anda telah mengaktifkan PM");
	}
	else
	{
		pData[playerid][pTogPM] = 0;
		Info(playerid, "Anda telah menonaktifkan PM");
	}
	return 1;
}

CMD:togads(playerid)
{
	if(!pData[playerid][pTogAds])
	{
		pData[playerid][pTogAds] = 1;
		Info(playerid, "Anda telah menonaktifkan Ads/Iklan.");
	}
	else
	{
		pData[playerid][pTogAds] = 0;
		Info(playerid, "Anda telah mengaktifkan Ads/Iklan.");
	}
	return 1;
}

CMD:togwt(playerid)
{
	if(!pData[playerid][pTogWT])
	{
		pData[playerid][pTogWT] = 1;
		Info(playerid, "Anda telah menonaktifkan Walkie Talkie.");
	}
	else
	{
		pData[playerid][pTogWT] = 0;
		Info(playerid, "Anda telah mengaktifkan Walkie Talkie.");
	}
	return 1;
}

CMD:tognotif(playerid)
{
	if(!pData[playerid][pTogNotif])
	{
		pData[playerid][pTogNotif] = 1;
		Info(playerid, "Anda telah menonaktifkan notif Bot.");
	}
	else
	{
		pData[playerid][pTogNotif] = 0;
		Info(playerid, "Anda telah mengaktifkan notif Bot.");
	}
	return 1;
}
CMD:toggletextformat(playerid)
{
    if (pData[playerid][pcapitalizeFirstLetter])
    {
        pData[playerid][pcapitalizeFirstLetter] = 0;
        pData[playerid][pupperToLower] = 1;
        Info(playerid, "Upper case dinonaktifkan");
    }
    else
    {
        pData[playerid][pcapitalizeFirstLetter] = 1;
        pData[playerid][pupperToLower] = 0;
        Info(playerid, "Upper case diaktifkan");
    }
    return 1;
}


CMD:pm(playerid, params[])
{
    static text[128];
    new otherid;
    
    if(sscanf(params, "us[128]", otherid, text))
        return SyntaxMsg(playerid, "/pm [playerid/PartOfName] [message]");
    
    if (playerid < 0 || playerid >= MAX_PLAYERS || otherid < 0 || otherid >= MAX_PLAYERS)
        return Error(playerid, "Invalid player ID.");
    
    if(pData[playerid][pInjured] != 0)
        return Error(playerid, "Kamu sedang Down tidak boleh menggunakan PM.");
    
    if(pData[playerid][pTogPM] == 0)
        return Error(playerid, "You must enable private messaging first.");
    
    if(pData[otherid][pTogPM] == 0)
        return Error(playerid, "Player yang anda tuju tidak mengaktifkan private messaging.");

    if(pData[otherid][pAdminDuty])
        return Error(playerid, "You can't pm'ing admin duty now!");
    
    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player yang anda tuju tidak valid.");
    
    if(otherid == playerid)
        return Error(playerid, "Tidak dapan PM diri sendiri.");
    
    PlayerPlaySound(otherid, 1085, 0.0, 0.0, 0.0);
    
    SendClientMessageEx(otherid, COLOR_YELLOW, "(( PM from %s (%d): %s ))", pData[playerid][pName], playerid, text);
    
    SendClientMessageEx(playerid, COLOR_YELLOW, "(( PM to %s (%d): %s ))", pData[otherid][pName], otherid, text);
    
    foreach(new i : Player)
    {
        if((pData[i][pAdmin]) && pData[playerid][pSPY] > 0)
        {
            SendClientMessageEx(i, COLOR_LIGHTGREEN, "[SPY PM] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
        }
    }
    
    return 1;
}

CMD:w(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return SyntaxMsg(playerid, "/(w)hisper [playerid/PartOfName] [text]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player itu Disconnect or not near you.");

    if(otherid == playerid)
        return Error(playerid, "You can't whisper yourself.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(text) > 64) 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
        SendClientMessageEx(otherid, COLOR_YELLOW, "...%s **", text[64]);

        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %.64s", ReturnName(otherid), otherid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
    }
    else 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %s **", ReturnName(otherid), otherid, text);
    }
    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(otherid));
	
	foreach(new i : Player) if((pData[i][pAdmin]) && pData[i][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_YELLOW2, "[SPY Whisper] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:lasd(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64) 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessageEx(i, COLOR_WHITE, "...%s", params[64]);
				}
				else 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %s", ReturnName(playerid), params);
				}
				printf("[CAR] %s(%d) : %s", pData[playerid][pName], playerid, params);
			}
		}
	}
	else
	{
		if(strlen(params) > 64) 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
		}
		printf("[LOW] %s(%d) : %s", pData[playerid][pName], playerid, params);
	}
    return 1;
}

CMD:s(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return SyntaxMsg(playerid, "/(s)hout [shout text] /ds for in the door");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "%s shouts: %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "...%s!", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
    }
	// new flyingtext[128];
	// format(flyingtext, sizeof(flyingtext), "%s!", params);
    // SetPlayerChatBubble(playerid, flyingtext, COLOR_WHITE, 10.0, 10000);
	printf("[SHOUTS] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:b(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "OOC Zone, Ketik biasa saja");

    if(isnull(params))
        return SyntaxMsg(playerid, "/b [local OOC]");

    new jembut[40];
	if(pData[playerid][pLevel] > 50)
	{
		jembut = "Supreme";
	}
	if(pData[playerid][pAdminDuty] == 1)
    {
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", GetRPName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" "WHITE_E"((" WHITE_E"%s"WHITE_E "))", GetRPName(playerid), params);
            return 1;
        }
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", GetRPName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "[OOC] %s {ffffff}%s [%d]: "WHITE_E"((" WHITE_E" %s "WHITE_E "))", jembut, pData[playerid][pName], playerid, params);
            return 1;
        }
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
	new str[150];
	format(str,sizeof(str),"[OOC] %s: %s", GetRPName(playerid), params);
	LogServer("Chat", str);
	SendDiscordMessage(2, str);
    return 1;
}

CMD:t(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(isnull(params))
		return SyntaxMsg(playerid, "/t [typo text]");

	if(strlen(params) < 10)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s : %.10s*", ReturnName(playerid), params);
	}

    return 1;
}


CMD:sms(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	if(pData[playerid][pCuffed] == 1)
        return Error(playerid, "You can't do that in this time.");
	// if(GetSignalNearest(playerid) == 0)
	// 	return Error(playerid, "Perangkat anda tidak mendapatkan sinyal di wilayah ini.");
	

	new ph, text[50];
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "Anda tidak memiliki Ponsel credits!");
	if(pData[playerid][pInjured] != 0) return Error(playerid, "You cant do at this time.");
	
	if(sscanf(params, "ds[50]", ph, text))
        return SyntaxMsg(playerid, "/sms [phone number] [message max 50 text]");
	
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][pPhoneStatus] == 0) return Error(playerid, "Tidak dapat SMS, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 1955.7324, 1526.8608, 5003.4956))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", ph, text);
			SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], text);
			Info(ii, "Gunakan "LB_E"'@<text>' "WHITE_E"untuk membalas SMS!");
			PlayerPlaySound(ii, 6003, 0,0,0);
			pData[ii][pSMS] = pData[playerid][pPhone];
			
			pData[playerid][pPhoneCredit] -= 1;
			return 1;
		}
	}
	return 1;
}

/*CMD:trackph(playerid, params[])
{
    new number;
    if(sscanf(params, "u", number)) {
        return Usage(playerid, "/trackph [number]");
    }

    if(pData[playerid][pFaction] != 1) {
        return Error(playerid, "You are not part of SAPD.");
    }

    // Check if the player exists and has a phone
    if(pData[number][pPhone] == 0) {
        return Error(playerid, "The player does not have a phone.");
    }

    // Check if the phone is online
    if(pData[number][pPhoneStatus] == 0) {
        return Error(playerid, "The phone is currently offline.");
    }

    // Ensure the player is not inside an interior or virtual world
    if(GetPlayerInterior(playerid) >= 1 || GetPlayerVirtualWorld(playerid) >= 1) {
        return SendClientMessage(playerid, COLOR_GREY, "You are in an interior or a virtual world, cannot track this phone.");
    }

    // Check if the player is on admin duty and prevent them from tracking
    if(pData[playerid][pAdminDuty] >= 1) {
        return SendClientMessage(playerid, COLOR_GREY, "You cannot track players while on admin duty.");
    }

    // Loop through all players and match the phone number
    new otherid = -1;
    foreach(new ii : Player) {
        if(pData[ii][pPhone] == number) {
            otherid = ii;
            break;
        }
    }

    if(otherid == -1) {
        return Error(playerid, "This phone number is not assigned to any player or is inactive.");
    }

    // Ensure the target player is logged in and connected
    if(pData[otherid][IsLoggedIn] == false || !IsPlayerConnected(otherid)) {
        return Error(playerid, "This number is not active or the player is not connected.");
    }

    // Proceed to track the phone location
    new zone[MAX_ZONE_NAME];
    GetPlayer3DZone(otherid, zone, sizeof(zone));
    new Float:sX, Float:sY, Float:sZ;
    GetPlayerPos(otherid, sX, sY, sZ);
    SetPlayerCheckpoint(playerid, sX, sY, sZ, 5.0);

    Info(playerid, "Tracking player with phone number: %d", pData[otherid][pPhone]);
    Info(playerid, "Player Name: %s", pData[otherid][pName]);
    Info(playerid, "Player Twitter: %s", pData[otherid][pTwittername]);
    Info(playerid, "Location: %s", zone);

    return 1;
}*/

CMD:setfreq(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
	
	new channel;
	if(sscanf(params, "d", channel))
		return SyntaxMsg(playerid, "/setfreq [channel 1 - 1000]");
	
	if(pData[playerid][pTogWT] == 1) return Error(playerid, "Your walkie talkie is turned off.");
	if(channel == pData[playerid][pWTFreq]) return Error(playerid, "You are already in this channel.");
	
	if(channel >= 0 && channel <= 1000)
	{
		foreach(new i : Player)
		{
		    if(pData[i][pWTFreq] == channel)
		    {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s has joined in to this channel!", ReturnName(playerid));
		    }
		}
		Info(playerid, "You have set your walkie talkie channel to "LIME_E"%d", channel);
		pData[playerid][pWTFreq] = channel;
	}
	else
	{
		Error(playerid, "Invalid channel id! 0 - 1000");
	}
	return 1;
}



CMD:wt(playerid, params[])
{
	if(WTDelay[playerid] > gettime())
		return Error(playerid, "You must wait %d seconds.", WTDelay[playerid]-gettime());

    if(IsPlayerInRangeOfPoint(playerid, 25, 1955.7324, 1526.8608, 5003.4956))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
    
	if(IsPlayerInRangeOfPoint(playerid, 25, 1555.6453,-1682.4194,-10.8488))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di penjara");

    if(pData[playerid][pInjured] != 0)
        return Error(playerid, "You can't do that in this time.");

	if(pData[playerid][pCuffed] == 1)
        return Error(playerid, "You can't do that in this time.");

    if(pData[playerid][pWT] == 0)
        return Error(playerid, "You don't have a walkie talkie!");

    if(pData[playerid][pTogWT] == 1)
        return Error(playerid, "Your walkie talkie is turned off!");


    new msg[128];
    if(sscanf(params, "s[128]", msg)) return SyntaxMsg(playerid, "/wt [message]");

    new currentChannel = pData[playerid][pWTFreq];

    new flyingtext[128];
    format(flyingtext, sizeof(flyingtext), "*[WT]: %s*", params); 
    SetPlayerChatBubble(playerid, flyingtext, COLOR_YELLOW, 10.0, 2000);
    printf("[WT: %d] %s", currentChannel, params); 

	WTDelay[playerid] = gettime()+10;

    foreach(new i : Player)
    {
        if(pData[i][pTogWT] == 0 && pData[i][pWT] && pData[i][pWTFreq] == currentChannel)
        {
            SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s: %s", ReturnName(playerid), msg); 
            
            SetPlayerChatBubble(i, flyingtext, COLOR_YELLOW, 10.0, 2000);
        }
    }
    SendNearbyMessage(playerid, 2.0, COLOR_GREY, "[WT] %s says: %s.", ReturnName(playerid), msg);
    return 1;
}
CMD:eprop(playerid, params[]) {
	new eprop[512];
    format(eprop, 512, "X( Hapus Animasi )\nBox\nTv\nBasket\nKursi\nPayung\nBendera\nBunga");
    ShowPlayerDialog(playerid, DIALOG_EMOTEPROPERTY, DIALOG_STYLE_LIST, "{8A2BE2}FDRP Roleplay{FFFFFF}- Emote Property", eprop, "Select", "Close");
}

CMD:ad(playerid, params[])
{
    if (pData[playerid][pVip] <= 0)
    {
        if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1960.3293, 1364.7899, 8001.0859))
            return Error(playerid, "You only can perform this inside San News!");

        if (Advert_CountPlayer(playerid) > 0)
            return Error(playerid, "You already have a pending advertisement, you must wait first.");

        if (isnull(params))
            return SyntaxMsg(playerid, "/ad [advertisement]");

        new strLen = strlen(params);
        if (strLen == 0 || strLen > 64)
            return Error(playerid, "Text cannot be more than 64 characters.");

        new cost = strLen * 3; 
        if (pData[playerid][pMoney] < cost)
            return Error(playerid, "You need at least %s", FormatMoney(cost));

        if (Advert_Count() >= 100)
            return Error(playerid, "The server has reached limit of ads list, come back later.");

        GivePlayerMoneyEx(playerid, -cost);
        Server_AddBankSan(cost);
        Advert_Create(playerid, params);
        SendClientMessage(playerid, COLOR_SERVER, "ADS: {FFFFFF}Your advertisement will appear in 1 minute.");
    }
    else
    {
        if (isnull(params))
            return SyntaxMsg(playerid, "/ad [advertisement]");

        new strLen = strlen(params);
        if (strLen == 0 || strLen > 82)
            return Error(playerid, "Text cannot be more than 82 characters.");

        new cost = strLen * 3; 
		if (pData[playerid][pMoney] < cost)
            return Error(playerid, "You need at least $%s", FormatMoney(cost));
        if (Advert_Count() >= 100)
            return Error(playerid, "The server has reached limit of ads list, come back later.");

        GivePlayerMoneyEx(playerid, -cost);
        Server_AddBankSan(cost);
        Advert_Create(playerid, params);
        SendClientMessage(playerid, COLOR_SERVER, "VIP: {FFFFFF}Because you're a VIP Player, you can create ads everywhere.");
    }
    return 1;
}


// CMD:ad(playerid, params[])
// {
// 	if(pData[playerid][pVip] <= 0)
// 	{
// 		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1960.3293, 1364.7899, 8001.0859))
// 		    return Error(playerid, "You only can perform this inside San News!");

// 		if(Advert_CountPlayer(playerid) > 0)
// 		    return Error(playerid, "You already have a pending advertisement, you must wait first.");

// 		if(pData[playerid][pMoney] < 15)
// 		    return Error(playerid, "You need at least $15!");

// 		if(Advert_Count() >= 100)
// 			return Error(playerid, "The server has reached limit of ads list, comeback later.");

// 		if(isnull(params))
// 		    return SyntaxMsg(playerid, "/ad [advertisement]");

// 		if(strlen(params) > 64)
// 		    return Error(playerid, "Text cannot more than 64 characters.");

// 		GivePlayerMoneyEx(playerid, -15);
// 		Server_AddBankSan(15);
// 		Advert_Create(playerid, params);
// 		SendClientMessage(playerid, COLOR_SERVER, "ADS: {FFFFFF}Your advertisement will be appear 1 minutes from now.");
// 	}
// 	else
// 	{
// 		if(isnull(params))
// 		    return SyntaxMsg(playerid, "/ad [advertisement]");

// 		if(strlen(params) > 82)
// 		    return Error(playerid, "Text cannot more than 82 characters.");

// 		if(Advert_Count() >= 100)
// 			return Error(playerid, "The server has reached limit of ads list, comeback later.");

// 		GivePlayerMoneyEx(playerid, -15);
// 		Server_AddBankSan(15);
// 		Advert_Create(playerid, params);

// 	    SendClientMessage(playerid, COLOR_SERVER, "VIP: {FFFFFF}Because you're a VIP Player, you able to create ads everywhere.");
// 	}
// 	return 1;
// }


//------------------[ Bisnis and Buy Commands ]-------
CMD:buy(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 1955.7324, 1526.8608, 5003.4956))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	// //trucker product
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 1637.6825,-1256.7981,14.8255))
	{
		if(pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah product:\nProduct Stock: "GREEN_E"%d\n"WHITE_E"Product Price"GREEN_E"%s / item", Product, FormatMoney(ProductPrice));
				ShowPlayerDialog(playerid, DIALOG_PRODUCT, DIALOG_STYLE_INPUT, "Buy Product", mstr, "Buy", "Cancel");
			}
			else return Error(playerid, "You are not in vehicle trucker.");
		}
		else return Error(playerid, "You are not trucker job.");
	}
	//Material
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -266.0215, -2213.7021, 29.0420))
	{
		if(pData[playerid][pMaterial] >= 1000) return Error(playerid, "Anda sudah membawa 1000 Material!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah material:\nMaterial Stock: "GREEN_E"%d\n"WHITE_E"Material Price"GREEN_E"%s / item", Material, FormatMoney(MaterialPrice));
		ShowPlayerDialog(playerid, DIALOG_MATERIAL, DIALOG_STYLE_INPUT, "Buy Material", mstr, "Buy", "Cancel");
	}
	//Metal
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 321.6840,1121.0055,1083.8828))
	{
		if(pData[playerid][pMetal] >= 2000) return Error(playerid, "Anda sudah membawa 2000 Metal!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah Metal:\nMetal Stock: "GREEN_E"%d\n"WHITE_E"Metal Price"GREEN_E"%s / item", Metal, FormatMoney(MetalPrice));
		ShowPlayerDialog(playerid, DIALOG_METAL, DIALOG_STYLE_INPUT, "Buy Metal", mstr, "Buy", "Cancel");
	}
	//Component
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 854.5555, -605.2056, 18.4219))
	{
		if(pData[playerid][pComponent] >= 500) return Error(playerid, "Anda sudah membawa 500 Component!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah component:\nComponent Stock: "GREEN_E"%d\n"WHITE_E"Component Price"GREEN_E"%s / item", Component, FormatMoney(ComponentPrice));
		ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
	}
	//Buy gas
	foreach(new bid : GStation)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, gsData[bid][gsPosX], gsData[bid][gsPosY], gsData[bid][gsPosZ]))
		{
			if(gsData[bid][gPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this gas.");
			if(strcmp(gsData[bid][gOwner], "-")) return Error(playerid, "Someone already owns this gas.");
			/*if(pData[playerid][pVip] == 1)	
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_GasCount(playerid) + 1 > 2) return Error(playerid, "You can't buy any more gas.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_GasCount(playerid) + 1 > 3) return Error(playerid, "You can't buy any more gas.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_GasCount(playerid) + 1 > 4) return Error(playerid, "You can't buy any more gas.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_GasCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more gas.");
				#endif
			}*/
			GivePlayerMoneyEx(playerid, -gsData[bid][gPrice]);
			Server_AddMoney(gsData[bid][gPrice]);
			gsData[bid][gsStock] = 1500;
			gsData[bid][gMoney] = 0;
			//bData[bid][bTax] = 0;
            //bData[bid][bTaxTime] = gettime() + (8 * 86400);
			GetPlayerName(playerid, gsData[bid][gOwner], MAX_PLAYER_NAME);

			GStation_Refresh(bid);
			GStation_Save(bid);
		}
	}
	//spray
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 387.4682,-1897.1913,7.8359))
	{
		if(pData[playerid][pLevel] < 5)
			return Error(playerid, "You must level 5 to use this!");

		new String[900];
		format(String, sizeof(String), "Size\tPrice\n\
		"ORANGE_E"Small\t$1000\n");
		format(String, sizeof(String), "%s"GREEN_E"Normal\t$1500\n", String);
		format(String, sizeof(String), "%s"RED_E"Big\t$2000\n", String);
		SendNearbyMessage(playerid, 30.0, COLOR_GREEN, "Try says: %s apakah kamu ingin membeli spraycan?Silahkan dipilih.", ReturnName(playerid));
		ShowPlayerDialog(playerid, BUY_SPRAYCAN, DIALOG_STYLE_TABLIST_HEADERS, "Buy spray can", String, "Buy", "Close");
	}
	//Food and Seed
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -381.44, -1426.13, 25.93))
	{
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Food\t"GREEN_E"%s\n\
		Seed\t"GREEN_E"%s\n\
		", FormatMoney(FoodPrice), FormatMoney(SeedPrice));
		ShowPlayerDialog(playerid, DIALOG_FOOD, DIALOG_STYLE_TABLIST_HEADERS, "Food", mstr, "Buy", "Cancel");
	}
	//Gym
	for(new a = 1; a < sizeof(GymPoint); a++)
	if(IsPlayerInRangeOfPoint(playerid, 5.0, GymPoint[a][bbPos][0], GymPoint[a][bbPos][1], GymPoint[a][bbPos][2]))
	{
		ShowPlayerDialog(playerid, DIALOG_GMENU, DIALOG_STYLE_LIST, "Gym Menu", "Gym Membership[16 Days]\nLearning Fight Style[$500,00]", "Select", "Back");
	}
	//Ayamfill
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 694.9672,-500.1339,16.3359))
	{
		if(pData[playerid][AyamFillet] >= 100) return Error(playerid, "Anda sudah membawa 100 kg AyamFillet!");

		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah ayam:\nAyam Stock: "GREEN_E"%d\n"WHITE_E"Ayam Price"GREEN_E"%s / item", AyamFill, FormatMoney(AyamFillPrice));
		ShowPlayerDialog(playerid, DIALOG_AYAMFILL, DIALOG_STYLE_INPUT, "Buy Ayam", mstr, "Buy", "Cancel");
	}
	// Alprazolam
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 1165.7499,-1327.4109,1028.1956))
	{
		if(pData[playerid][pAlprazolam] >= 5) return Error(playerid, "Anda sudah membawa 5 Alprazolam!");
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah Obat:\nAlprazolam Stock: "GREEN_E"%d\n"WHITE_E"Alprazolam Price"GREEN_E"%s / item", Alprazolam, FormatMoney(AlprazolamPrice));
		ShowPlayerDialog(playerid, DIALOG_ALPRAZOLAM, DIALOG_STYLE_INPUT, "Buy", mstr, "Buy", "Cancel");
	}
	//Buy House
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(pData[playerid][pMaskOn] == 1) return Error(playerid, "Tidak boleh menggunakan mask saat membeli rumah.");
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return Error(playerid, "Someone already owns this house.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 4)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 10) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			Server_AddMoney(hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			hData[hid][hVisit] = gettime() + (86400 * 30);
			House_Save(hid);
			//hData[hid][hOwnerID] = pData[playerid][pID];
			//hData[hid][hVisit] = gettime();
			new str[150];
			format(str,sizeof(str),"[HOUSE]: %s membeli rumah id %d seharga %s!", GetRPName(playerid), hid, FormatMoney(hData[hid][hPrice]));
			LogServer("Property", str);

			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", hData[hid][hOwner], hData[hid][hOwnerID], hData[hid][hVisit], hid);
			mysql_tquery(g_SQL, query);
			
			House_Refresh(hid);
		}
	}
	//Buy Bisnis
	foreach(new bid : Bisnis)
	{
		if(pData[playerid][pMaskOn] == 1) return Error(playerid, "Tidak boleh menggunakan mask saat membeli bisnis.");
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(bData[bid][bPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this bisnis.");
			if(strcmp(bData[bid][bOwner], "-") || bData[bid][bOwnerID] != 0) return Error(playerid, "Someone already owns this bisnis.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 4)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 10) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
			Server_AddMoney(-bData[bid][bPrice]);
			GetPlayerName(playerid, bData[bid][bOwner], MAX_PLAYER_NAME);
			bData[bid][bVisit] = gettime() + (86400 * 30);
			Bisnis_Save(bid);
			//bData[bid][bOwnerID] = pData[playerid][pID];
			//bData[bid][bVisit] = gettime();
			new str[150];
			format(str,sizeof(str),"[BIZ]: %s membeli bisnis id %d seharga %s!", GetRPName(playerid), bid, FormatMoney(bData[bid][bPrice]));
			LogServer("Property", str);
			
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", bData[bid][bOwner], bData[bid][bOwnerID], bData[bid][bVisit], bid);
			mysql_tquery(g_SQL, query);

			Bisnis_Refresh(bid);
		}
	}
	//Mods
	for(new aaa = 1; aaa < sizeof(ModsPoint); aaa++)
	if(IsPlayerInRangeOfPoint(playerid, 5.0, ModsPoint[aaa][ModsPos][0], ModsPoint[aaa][ModsPos][1], ModsPoint[aaa][ModsPos][2]))
	{
		ShowPlayerDialog(playerid, DIALOG_MMENU, DIALOG_STYLE_LIST, "Vehicle Modshop", "Purchase Vehicle Toys", "Select", "Back");
	}
	//Buy Bisnis menu
	if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
	{
		Bisnis_BuyMenu(playerid, pData[playerid][pInBiz]);
	}
	//Buy Vending Machine
	if(pData[playerid][pInVending] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, VendingData[pData[playerid][pInVending]][vendingX], VendingData[pData[playerid][pInVending]][vendingY], VendingData[pData[playerid][pInVending]][vendingZ]))
	{
		VendingBuyMenu(playerid, pData[playerid][pInVending]);
	}
	foreach(new vid : Vendings)
	{
		if(pData[playerid][pMaskOn] == 1) return Error(playerid, "Tidak boleh menggunakan mask saat membeli vending.");
		if(IsPlayerInRangeOfPoint(playerid, 2.5, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]))
		{
			if(VendingData[vid][vendingPrice] > GetPlayerMoney(playerid)) 
				return Error(playerid, "Not enough money, you can't afford this Vending.");

			if(strcmp(VendingData[vid][vendingOwner], "-") || VendingData[vid][vendingOwnerID] != 0) 
				return Error(playerid, "Someone already owns this Vending.");

			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 4)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 10) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}

			SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to vending id %d", vid);
			GivePlayerMoneyEx(playerid, -VendingData[vid][vendingPrice]);
			Server_AddMoney(VendingData[vid][vendingPrice]);
			GetPlayerName(playerid, VendingData[vid][vendingOwner], MAX_PLAYER_NAME);
			VendingData[vid][vendingOwnerID] = pData[playerid][pID];
			new str[150];
			format(str,sizeof(str),"[VEND]: %s membeli vending id %d seharga %s!", GetRPName(playerid), vid, FormatMoney(VendingData[vid][vendingPrice]));
			LogServer("Property", str);
			
			Vending_RefreshText(vid);
			Vending_Save(vid);
		}
		//Ladang
		// foreach(new oid : Ladang)
		// {
		// 	if(IsPlayerInRangeOfPoint(playerid, 2.5, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
		// 	{
		// 		if(opData[oid][oPrice] > GetPlayerMoney(playerid))
		// 			return Error(playerid, "Not enough money, you can't afford this Ladang.");
		// 		if(opData[oid][oOwnerID] != 0 || strcmp(opData[oid][oOwner], "-")) 
		// 			return Error(playerid, "Someone already owns this Ladang.");

		// 		#if LIMIT_PER_PLAYER > 0
		// 		if(Player_LadangCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Ladang.");
		// 		#endif

		// 		GivePlayerMoneyEx(playerid, -opData[oid][oPrice]);
		// 		Server_AddMoney(opData[oid][oPrice]);
		// 		GetPlayerName(playerid, opData[oid][wOwner], MAX_PLAYER_NAME);
		// 		opData[oid][oOwnerID] = pData[playerid][pID];
		// 		new str[150];
		// 		format(str,sizeof(str),"[LADANG]: %s membeli Ladang id %d seharga %s!", GetRPName(playerid), oid, FormatMoney(opData[oid][oPrice]));
		// 		LogServer("Property", str);

		// 		Ladang_Refresh(oid);
		// 		Ladang_Save(oid);
		// 	}
		// }
		//Buy Workshop
		foreach(new wid : Workshop)
		{
			if(pData[playerid][pMaskOn] == 1) return Error(playerid, "Tidak boleh menggunakan mask saat membeli ws.");
			if(IsPlayerInRangeOfPoint(playerid, 2.5, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]))
			{
				if(wsData[wid][wPrice] > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money, you can't afford this workshop.");
				if(wsData[wid][wOwnerID] != 0 || strcmp(wsData[wid][wOwner], "-")) 
					return Error(playerid, "Someone already owns this workshop.");

				#if LIMIT_PER_PLAYER > 0
				if(Player_WorkshopCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more workshop.");
				#endif

				GivePlayerMoneyEx(playerid, -wsData[wid][wPrice]);
				Server_AddMoney(wsData[wid][wPrice]);
				GetPlayerName(playerid, wsData[wid][wOwner], MAX_PLAYER_NAME);
				wsData[wid][wOwnerID] = pData[playerid][pID];
				new str[150];
				format(str,sizeof(str),"[WS]: %s membeli workshop id %d seharga %s!", GetRPName(playerid), wid, FormatMoney(wsData[wid][wPrice]));
				LogServer("Property", str);

				Workshop_Refresh(wid);
				Workshop_Save(wid);
			}
		}
	}
	return 1;
}

forward Revive(playerid);
public Revive(playerid)
{
	new otherid = GetPVarInt(playerid, "gcPlayer");
	TogglePlayerControllable(playerid,1);
	SuccesMsg(playerid, "Sukses revive");
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

	HideTdDeath(otherid);
	UpdateDynamic3DTextLabelText(pData[otherid][pInjuredLabel], COLOR_ORANGE, "");
}

forward DownloadTwitter(playerid);
public DownloadTwitter(playerid)
{
	pData[playerid][pTwitter] = 1;
	pData[playerid][pKuota] -= 38000;
	Servers(playerid, "Twitter berhasil di Download");
}

CMD:selfie(playerid,params[])
{
	if(takingselfie[playerid] == 0)
	{
	    GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
		static Float: n1X, Float: n1Y;
		if(Degree[playerid] >= 360) Degree[playerid] = 0;
		Degree[playerid] += Speed;
		n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		takingselfie[playerid] = 1;
		// HideHpLenz(playerid);
		HidePhone(playerid);
		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 1, 1, 1, 1, 1, 1);
		return 1;
	}
    if(takingselfie[playerid] == 1)
	{
	    TogglePlayerControllable(playerid,1);
		SetCameraBehindPlayer(playerid);
	    takingselfie[playerid] = 0;
	    ApplyAnimation(playerid, "PED", "ATM", 4.1, 0, 1, 1, 0, 1, 1);
	    return 1;
	}
    return 1;
}

CMD:claimsp(playerid, params)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1778.6857,-1942.2041,13.5671))
	if(pData[playerid][pStarterpack] != 0)
	{
		return Error(playerid, "Kamu sudah mengambil Starterpack!");
	}
	else
	{
		GivePlayerMoneyEx(playerid, 2500);
		pData[playerid][pVip] = 1;
		pData[playerid][pVipTime] = gettime() + (3 * 86400);
   		pData[playerid][pMedicine] = 3;
		pData[playerid][pBandage] = 5;
		pData[playerid][pStarterpack] = 1;
		pData[playerid][pLevel] += 1;
		pData[playerid][pLevelUp] += 14;
		pData[playerid][pNasi] += 10;
		pData[playerid][pSprunk] += 10;
		pData[playerid][pGPS] += 1;
		pData[playerid][pComponent] += 250;
		pData[playerid][pMaterial] += 250;
		pData[playerid][pWorm] += 20;
		pData[playerid][pBpjsTime] = gettime() + (20 * 86400);
		SuccesMsg(playerid, "Selamat Anda Berhasil Mengclaim staterpack Anda.!");
		new cQuery[1024];
		new Float: x, Float: y, Float: z, Float: ang;
		
		x = 1777.3759;
		y = -1933.4283;
		z = 13.3869;
		ang = 356.4924;

		UpdatePlayerData(playerid);
		new model = 468, color1 = 1, color2 = 1;
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, x, y, z, ang);
		mysql_tquery(g_SQL, cQuery, "OnVehStarterpack", "dddddffff", playerid, pData[playerid][pID], model, color1, color2, x, y, z, ang);
	}
	return 1;	

}
CMD:fdrpkatanya(playerid, params)
{
	if(pData[playerid][pFdrp] != 0)
	{
		return Error(playerid, "Kamu sudah ambil sedekah bosku, jangan lupa diajak temennya main kesini yah (^_^)!");
	}
	else
	{
		GivePlayerMoneyEx(playerid, 2500);
		pData[playerid][pGold] += 250;
		SuccesMsg(playerid, "Terimakasih sudah meramaikan server Fountain Daily Roleplay!");
		SendClientMessage(playerid, COLOR_GREY, "Anda mendapatkan $2500 dan 250 gold.!");
		pData[playerid][pFdrp] = 1;

		new query[255];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET gold = %d WHERE reg_id = %d", pData[playerid][pGold], pData[playerid][pID]);
	    mysql_tquery(g_SQL, query);
	}
	return 1;	

}

CMD:compentation(playerid, params)
{
	if(pData[playerid][pCompentation] != 0)
	{
		return Error(playerid, "Kamu sudah ambil sedekah bosku, jangan lupa diajak temennya main kesini yah (^_^)!");
	}
	else
	{
		GivePlayerMoneyEx(playerid, 5000);
		pData[playerid][pGold] += 500;
		SuccesMsg(playerid, "Terimakasih sudah meramaikan server Fountain Daily Roleplay!");
		SendClientMessage(playerid, COLOR_GREY, "Anda mendapatkan $5000 dan 500 gold.!");
		pData[playerid][pCompentation] = 1;

		new query[255];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET gold = %d WHERE reg_id = %d", pData[playerid][pGold], pData[playerid][pID]);
	    mysql_tquery(g_SQL, query);
	}
	return 1;	

}

DelaysPlayer(playerid, p2)
{
	new str[(1024 * 2)], headers[500];
	strcat(headers, "Name\tTime\n");

	if(pData[p2][pExitJob] > 0)
    {
        format(str, sizeof(str), "%s{ff0000}Exit Jobs{ffffff}\t%i Second\n", str, ReturnTimelapse(gettime(), pData[p2][pExitJob]));
	}
	if(pData[p2][pJobTime] > 0)
    {
        format(str, sizeof(str), "%sJobs\t%i Second\n", str, pData[p2][pJobTime]);
	}
    if(pData[p2][pSweeperTime] > 0)
    {
        format(str, sizeof(str), "%sSweeper (Sidejob)\t%i Second\n", str, pData[p2][pSweeperTime]);
	}
	if(pData[p2][pForklifterTime] > 0)
    {
        format(str, sizeof(str), "%sForklifter (Sidejob)\t%i Second\n", str, pData[p2][pForklifterTime]);
	}
	if(pData[p2][pBusTime] > 0)
    {
        format(str, sizeof(str), "%sBus (Sidejob)\t%i Second\n", str, pData[p2][pBusTime]);
	}
	if(pData[p2][pMowerTime] > 0)
    {
        format(str, sizeof(str), "%sMower (Sidejob)\t%i Second\n", str, pData[p2][pMowerTime]);
	}
	if(pData[p2][pFisherTime] > 0)
    {
        format(str, sizeof(str), "%sFisher (Sidejob)\t%i Second\n", str, pData[p2][pFisherTime]);
	}
	if(pData[p2][pSideJobTime] > 0)
    {
        format(str, sizeof(str), "%s Sidejob\t%i Second\n", str, pData[p2][pSideJobTime]);
	}
	if(pData[p2][pStreakTime] > 0)
    {
        format(str, sizeof(str), "%s Sidejob\t%i Second\n", str, pData[p2][pStreakTime]);
	}
	if(pData[p2][pDelaySenjata] > 0)
    {
        format(str, sizeof(str), "%s Weapon Create\t%i Second\n", str, pData[p2][pDelaySenjata]);
	}
	if(pData[p2][pDelayHauling] > 0)
    {
        format(str, sizeof(str), "%s Hauling\t%i Second\n", str, pData[p2][pDelayHauling]);
	}
	if(pData[p2][pJualAyamDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Ayam\t%i Minutes\n", str, pData[p2][pJualAyamDelay]);
	}
	if(pData[p2][pJualKayuDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Kayu\t%i Minutes\n", str, pData[p2][pJualKayuDelay]);
	}
	if(pData[p2][pJualIkanDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Ikan\t%i Minutes\n", str, pData[p2][pJualIkanDelay]);
	}
	if(pData[p2][pBuatSabuDelay] > 0)
    {
        format(str, sizeof(str), "%s Pembuatan Sabu\t%i Minutes\n", str, pData[p2][pBuatSabuDelay]);
	}
	if(pData[p2][pJualSusuDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Susu Sapi\t%i Minutes\n", str, pData[p2][pJualSusuDelay]);
	}
	if(pData[p2][pJualOreDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Ore\t%i Minutes\n", str, pData[p2][pJualOreDelay]);
	}
	if(pData[p2][pJualCrateDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Crate Trucker\t%i Minutes\n", str, pData[p2][pJualCrateDelay]);
	}
	if(pData[p2][pJualProductDelay] > 0)
    {
        format(str, sizeof(str), "%s Jual Product\t%i Minutes\n", str, pData[p2][pJualProductDelay]);
	}
	if (pData[p2][pPecahBatuDelay] > 0)
	{
        format(str, sizeof(str), "%s Pecah Batu\t%i Minutes\n", str, pData[p2][pPecahBatuDelay]);
	}
	strcat(headers, str);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Delays", headers, "Okay", "");
	return 1;
}

CMD:delays(playerid, params)
{
	DelaysPlayer(playerid, playerid);
}


CMD:clearchat(playerid, params[])
{
	ClearChat(playerid);
	SuccesMsg(playerid, "Sukses Menghapus Chatlog");
	return 1;
}

CMD:taclight(playerid, params[])
{
	if(!pData[playerid][pFlashlight]) 
		return Error(playerid, "Kamu tidak mempunyai senter.");
	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 6, 0.25, -0.0175, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s attach the flashlight to the gun.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] = 1;
	}
	else
	{
		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
		pData[playerid][pUsedFlashlight] =0;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take the flashlight off the gun.", ReturnName(playerid));
	}
	return 1;
}
CMD:flashlight(playerid, params[])
{
	if(!pData[playerid][pFlashlight])
		return Error(playerid, "Kamu tidak mempunyai senter.");

	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take out the flashlight and turn on the flashlight.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] =1;
	}
	else
	{
 		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
		pData[playerid][pUsedFlashlight] =0;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s turn off the flashlight and put it in.", ReturnName(playerid));
	}
	return 1;
}



CMD:tuning(playerid, params[])
{
	new vehicleid = Vehicle_Nearest(playerid);

    if(IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You must be in front of Vehicle.");

	if(vehicleid == -1)
	    return SendErrorMessage(playerid, "You're not in range of any Vehicle!");

	if(!IsEngineVehicle(pvData[vehicleid][cVeh]))
	    return SendErrorMessage(playerid, "This vehicle can't tuned!");

	/*if(!IsDoorVehicle(pvData[vehicleid][cVeh]))
	    return SendErrorMessage(playerid, "This vehicle can't tuned!");*/

    if(GetEngineStatus(pvData[vehicleid][cVeh]))
        return SendErrorMessage(playerid, "Turn off the engine first!");

    if(!GetHoodStatus(pvData[vehicleid][cVeh]))
        return SendErrorMessage(playerid, "The Hood must be Opened.");

	new string[512];
	format(string, sizeof(string), "Name\tCurrent Tuning\nTurbo\t%s\nBrake\t%s\n",  GetUpgradeName(pvData[vehicleid][cTurboMode]), GetUpgradeName(pvData[vehicleid][cBrakeMode]));
	ShowPlayerDialog(playerid, DIALOG_TUNING, DIALOG_STYLE_TABLIST_HEADERS, "Performance Tuning", string, "Tune", "Close");
	pData[playerid][pTargetVehicle] = vehicleid;
	return 1;
}

CMD:fixvisual(playerid, params[])
{
   SetPlayerInterior(playerid, 0);
   SetPlayerVirtualWorld(playerid, 0);
   SuccesMsg(playerid, "Sukses");
   return 1;
}

CMD:fixstuck(playerid, params[])
{
    pData[playerid][pFreeze] = 0;
    TogglePlayerControllable(playerid, 1);
    SuccesMsg(playerid, "Sukses");
    return 1;
}

CMD:fixinterior(playerid, params[])
{
    pData[playerid][pInDoor] = 1;
    pData[playerid][pInBiz] = 1;
    pData[playerid][pInHouse] = 1;
    SuccesMsg(playerid, "Sukses");
    return 1;
}


CMD:paytax(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 1392.5812, -12.6790, 1000.9166))
		return Error(playerid, "Kamu harus berada di city hall");

	new string[1024];
	format(string, sizeof(string), "Pajak Bisnis\nPajak Rumah\nPajak Dealer\nPajak Dealer VIP(Pemerintah)");
	ShowPlayerDialog(playerid, DIALOG_PAYTAX, DIALOG_STYLE_LIST, "Tagihan Pajak", string , "Yes","No");
	return 1;
}
CMD:allmaskplayer(playerid)
{
	new mstr[4000];
	mstr = "Player Name\tMask ID\n";
	foreach(new i : Player)
	{
		if(pData[i][pMaskOn] == 1)
		{
			format(mstr, sizeof(mstr), "%s%s[%d]\t"YELLOW_E"Mask_%d\n", mstr, pData[i][pName], i, pData[i][pMaskID]);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Masked Users", mstr, "Close","");
		}
	}
}
CMD:togvip(playerid)
{
	if(!pData[playerid][pTogVip])
	{
		pData[playerid][pTogVip] = 1;
		Info(playerid, "Anda telah menonaktifkan Chat Vip.");
	}
	else
	{
		pData[playerid][pTogVip] = 0;
		Info(playerid, "Anda telah mengaktifkan Chat Vip.");
	}
	return 1;
}
CMD:toggleooc(playerid)
{
	if(!pData[playerid][pTogO])
	{
		pData[playerid][pTogO] = 1;
		Info(playerid, "Anda telah menonaktifkan Chat OOC.");
	}
	else
	{
		pData[playerid][pTogO] = 0;
		Info(playerid, "Anda telah mengaktifkan Chat OOC.");
	}
	return 1;
}

CMD:vips(playerid, params[])
{
	new str[345];
	format(str, sizeof(str), "Name\tRank\n");
	foreach(new i : Player)
	{
		if(pData[i][pVip] > 0)
		{
			format(str, sizeof(str), "%s%s\t%s\n", str, GetName(i), GetVipRank(i));
		}
	}
	return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Vip Player's", str, "Close", "");
}

CMD:vchat(playerid, params[])
{
    if (pData[playerid][pVip] < 1)
        return SendErrorMessage(playerid, "You're not a VIP Player.");

	if(pData[playerid][pTogVip])
	    return SendErrorMessage(playerid, "You must enabled your VIP Chats.");

    if (isnull(params))
        return SendSyntaxMessage(playerid, "/vc [vip chat message]");

    new toggleEnabled = (pData[playerid][pTogVip] != 0);

    foreach (new i : Player)
    {
        if (pData[i][pVip] > 0 && (toggleEnabled || pData[i][pTogVip] != 1))
        {
            SendClientMessageEx(i, COLOR_SERVER, "[VIP] %s %s: {FFFFFF}%s", GetVipRank(playerid), GetName(playerid), params);
        }
    }
    
    return 1;
}


CMD:putblindfold(playerid, params[])
{
	new otherid;
	if(pData[playerid][pBlindfold] == 0) return Error(playerid, "Anda tidak memiliki penutup mata");
	if(sscanf(params, "i", otherid)) return SyntaxMsg(playerid, "/putblindfold [PlayerID]");

 	if(otherid == playerid)
		return Error(playerid, "Anda tidak dapat Memasang penutup mata kepada diri sendiri!");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

	if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
	    return Error(playerid, "Anda tidak dapat menutup mata pengemudi.");

	if(pData[otherid][pInBlindfold])
	    return Error(playerid, "Pemain tersebut telah tertutup matanya. /getblindfold untuk membuka penutup mata Pemain tersebut.");

	if(pData[otherid][pAdminDuty])
	    return Error(playerid, "Anda tidak dapat menutup mata administrator yang sedang bertugas.");

	pData[otherid][pInBlindfold] = 1;
	GameTextForPlayer(otherid, "~r~Blindfold", 3000, 3);
	TextDrawShowForPlayer(otherid, tetxdrawBlindfold[0]);
	TogglePlayerControllable(otherid, 0);
	Info(playerid, "Anda berhasil memakaikan penutup mata ke player {ff0000}%s", ReturnName(otherid));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Put a blindfold to %s ", ReturnName(playerid), ReturnName(otherid));
	pData[playerid][pBlindfold]--;
	return 1;
}

CMD:getblindfold(playerid, params[])
{
	new otherid;
	if(sscanf(params, "i", otherid)) return SyntaxMsg(playerid, "/getblindfold [PlayerID]");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

 	if(otherid == playerid)
		return Error(playerid, "Anda tidak dapat Memasang penutup mata kepada diri sendiri!");

	if(!pData[otherid][pInBlindfold]) 
		return Error(playerid, "Player tersebut sedang tidak memakai penutup mata");

	pData[playerid][pBlindfold]++;
	TextDrawHideForPlayer(otherid, tetxdrawBlindfold[0]);
	GameTextForPlayer(otherid, "~g~Unblindfold", 3000, 3);
	TogglePlayerControllable(otherid, 1);
	Info(playerid, "Anda berhasil mencopot penutup mata dari player {ff0000}%s", ReturnName(otherid));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Open the blindfold for %s ", ReturnName(playerid), ReturnName(otherid));
	pData[otherid][pInBlindfold] = 0;
	return 1;
}

CMD:window(playerid,params[])
{
		if(GetPlayerState(playerid) != 2)
		return SendErrorMessage(playerid, "You are not in any vehicle with windows.");
        if(sscanf(params, "d", params[0]))
        {
                SendClientMessage(playerid,-1,"/window [1-2-3-4]");
                SendClientMessage(playerid,-1,"1 - Driver window | 2 - Passenger window | 3 - Rear-left window | 4 - Rear-right window");
                return 1;
        }
        if(params[0] > 4 || params[0] < 1) return SendClientMessage(playerid,-1,"1 - Driver window | 2 - Passenger window | 3 - Rear-left window | 4 - Rear-right window");
        new driver, passenger, backleft, backright;
        GetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), driver, passenger, backleft, backright);
        switch(params[0])
        {
            case 1: driver = !driver ? (1) : (0);
            case 2: passenger = !passenger ? (1) : (0);
            case 3: backleft = !backleft ? (1) : (0);
            case 4: backright = !backright ? (1) : (0);
        }
        SetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), driver, passenger, backleft, backright);
        return 1;
}
CMD:charity(playerid, params[])
{

    new amount = 0;

    if(pData[playerid][pLevel] > 20)
    {
        amount = 20000; 
    }
    else if(pData[playerid][pLevel] > 15)
    {
        amount = 15000; 
    }
    else if(pData[playerid][pLevel] > 10)
    {
        amount = 10000; 
    }
    else if(pData[playerid][pLevel] > 5)
    {
        amount = 5000; 
    }
    else
    {
        return Error(playerid, "Kamu harus minimal level 5 untuk menggunakan perintah ini.");
    }

    if(GetPlayerMoney(playerid) < amount)
    {
        return Error(playerid, "Uang kamu tidak cukup untuk melakukan CK.");
    }

    // Mengurangi uang pemain
    GivePlayerMoneyEx(playerid, -amount);

    // Menampilkan dialog setelah donasi berhasil
	SendClientMessageEx(playerid, COLOR_GREY, "Kamu telah melakukan pembayaran telah sebesar $%d untuk CK!", amount);
    new string[256];
    format(string, sizeof(string), "Kamu telah melakukan pembayaran telah sebesar $%d untuk CK!", amount);
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Character Killed", string, "OK", "");

    return 1;
}
CMD:vehsong(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "Kamu harus berada di dalam kendaraan");

	new songname[128], tmp[512];
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playsong <link>");
		return 1;
	}
	
	format(tmp, sizeof(tmp), "%s", songname);
	if(IsPlayerInAnyVehicle(playerid))
	{
		pData[playerid][pVehSong] = 1;
		PlayAudioStreamForPlayer(playerid, tmp);
		Servers(playerid, "/stopsong, /togsong");
	}
	else
	{
		pData[playerid][pVehSong] = 0;
		StopAudioStreamForPlayer(playerid);
		Servers(playerid, "Song stop!");
	}
	return 1;
}
CMD:intel(playerid, params[])
{
    if (pData[playerid][pFaction] != 1) 
        return Error(playerid, "Anda bukan Anggota SAPD!");
    
    if (pData[playerid][pFactionRank] < 3) 
        return Error(playerid, "Anda bukan Divisi Intel!");
    
    if (pData[playerid][pOnDuty] == 0) 
        return Error(playerid, "Anda belum on duty!");
    
    if (pData[playerid][pMaskOn] == 0) 
    {

        SetPlayerColorEx(playerid, COLOR_BLUE);
        SendClientMessage(playerid, COLOR_WHITE, "Anda belum memakai mask!");
        return 1; 
    }

    if (pData[playerid][pMaskOn] == 1)
    {
        SetPlayerColorEx(playerid, COLOR_WHITE);
        SendClientMessage(playerid, COLOR_WHITE, "Anda sekarang on duty sebagai Intel.");
    }
    else
    {
        SetPlayerColorEx(playerid, COLOR_BLUE);
        SendClientMessage(playerid, COLOR_WHITE, "Anda telah off Intel.");
    }

    return 1; 
}
cmd:hidelogo(playerid, params[])
{
    for(new i = 0; i < 25; i++)
    {
		TextDrawHideForPlayer(playerid, LogoFountain[i]);
        // PlayerTextDrawHide(playerid, LogoTry[playerid][i]);
    }
    return 1; 
}
cmd:showlogo(playerid, params[])
{
    for(new i = 0; i < 25; i++)
    {
		TextDrawShowForPlayer(playerid, LogoFountain[i]);
        // PlayerTextDrawShow(playerid, LogoTry[playerid][i]);
    }
    return 1; 
}
