#include <YSI_Coding\y_hooks>

Ladang_Refresh(id)
{
    if(id != -1)
    {
        if(IsValidDynamic3DTextLabel(opData[id][oText]))
		{
            DestroyDynamic3DTextLabel(opData[id][oText]);
		}
        if(IsValidDynamicPickup(opData[id][oPickup]))
            DestroyDynamicPickup(opData[id][oPickup]);

        new str[316], stats[64];
        if(opData[id][oStatus] == 1)
        {
            stats = "{ff0000}PRIVATE FARM{ffffff}";
        }
        else
        {
            stats = "{ff0000}PRIVATE FARM{ffffff}";
        }

        format(str, sizeof str,"[Ladang ID:%d]\n{ffffff}Ladang Price: {7fff00}%s{ffffff}\n{ffffff}Type '/buy' to buy this Ladang", id, FormatMoney(opData[id][oPrice]));

        // if(opData[id][oOwnerID] != 0 || strcmp(opData[id][oOwner], "-", true))
		if(opData[id][oOwnerID] != 0 || strcmp(opData[id][oOwner], "") != 0)
            format(str, sizeof str,"[ID:%d]\nFarm: %s\nOwner: %s\n{ffff00}/pfmenu akses ladang", id, opData[id][oName], opData[id][oOwner], stats);

        opData[id][oText] = CreateDynamic3DTextLabel(str, ARWIN, opData[id][oX], opData[id][oY], opData[id][oZ]+0.5, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 8.0);
        opData[id][oPickup] = CreateDynamicPickup(1239, 23, opData[id][oX], opData[id][oY], opData[id][oZ]+0.2, 0, 0, _, 50.0);
    }
}

Ladang_Save(id)
{
    new query[2248];
    format(query, sizeof query,"UPDATE farm SET owner='%s', ownerid='%d', name='%s', seeds=%d, marijuana=%d, money=%d, posx='%f', posy='%f', posz='%f', status=%d, price=%d",
        opData[id][oOwner],
        opData[id][oOwnerID],
        opData[id][oName],
        opData[id][oSeeds],
        opData[id][oMj],
        opData[id][oMoney],
        opData[id][oX],
        opData[id][oY],
        opData[id][oZ],
        opData[id][oStatus],
        opData[id][oPrice]);
    for(new z = 0; z < MAX_LADANG_EMPLOYEE; z++)
    {
        format(query, sizeof query,"%s, employe%d='%s'", query, z, opEmploy[id][z]);
    }
    format(query, sizeof query,"%s WHERE id = %d", query, id);
    return mysql_tquery(g_SQL, query);
}

Ladang_Reset(id)
{
    format(opData[id][oOwner], MAX_PLAYER_NAME, "-");
    format(opEmploy[id][0], MAX_PLAYER_NAME, "-");
    format(opEmploy[id][1], MAX_PLAYER_NAME, "-");
    format(opEmploy[id][2], MAX_PLAYER_NAME, "-");
    opData[id][oOwnerID] = 0;
    opData[id][oSeeds] = 0;
    opData[id][oMj] = 0;
    opData[id][oMoney] = 0;
    for(new z = 0; z < MAX_LADANG_EMPLOYEE; z++)
    {
        format(opEmploy[id][z], MAX_PLAYER_NAME, "-");
    }
    Ladang_Refresh(id);
}

IsLadangEmploye(playerid, id)
{
    if(!strcmp(opEmploy[id][0], pData[playerid][pName], true)) return 1;
    if(!strcmp(opEmploy[id][1], pData[playerid][pName], true)) return 1;
    if(!strcmp(opEmploy[id][2], pData[playerid][pName], true)) return 1;
    return 0;
}

IsLadangOwner(playerid, id)
{
    return (opData[id][oOwnerID] == pData[playerid][pID]) || (!strcmp(opData[id][oOwner], pData[playerid][pName], true));
}

function LoadLadang()
{
    static oid;
	
	new rows = cache_num_rows(), owner[128], name[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", oid);
			cache_get_value_name(i, "owner", owner);
			format(opData[oid][oOwner], 128, owner);            
			cache_get_value_name_int(i, "ownerid", opData[oid][oOwnerID]);
			cache_get_value_name(i, "name", name);
			format(opData[oid][oName], 128, name);
			cache_get_value_name_int(i, "price", opData[oid][oPrice]);
			cache_get_value_name_float(i, "posx", opData[oid][oX]);
			cache_get_value_name_float(i, "posy", opData[oid][oY]);
			cache_get_value_name_float(i, "posz", opData[oid][oZ]);
			cache_get_value_name_int(i, "seeds", opData[oid][oSeeds]);
			cache_get_value_name_int(i, "marijuana", opData[oid][oMj]);
            cache_get_value_name_int(i, "money", opData[oid][oMoney]);
            for(new z = 0; z < MAX_LADANG_EMPLOYEE; z++)
            {
                new str[64];
                format(str, sizeof str,"employe%d", z);
                cache_get_value_name(i, str, opEmploy[oid][z]);
            }
			Ladang_Refresh(oid);
			Iter_Add(Ladang, oid);
		}
		printf("[Ladangs] %d Loaded.", rows);
	}
}

GetOwnedLadang(playerid)
{
	new tmpcount;
	foreach(new oid : Ladang)
	{
	    if(!strcmp(opData[oid][oOwner], pData[playerid][pName], true) || (opData[oid][oOwnerID] == pData[playerid][pID]))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnPlayerLadangID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > LIMIT_PER_PLAYER) return -1;
	foreach(new oid : Ladang)
	{
	    if(!strcmp(pData[playerid][pName], opData[oid][oOwner], true) || (opData[oid][oOwnerID] == pData[playerid][pID]))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return oid;
  			}
	    }
	}
	return -1;
}

// GetAnyLadang()
// {
// 	new tmpcount;
// 	foreach(new id : Ladang)
// 	{
//      	tmpcount++;
// 	}
// 	return tmpcount;
// }

// ReturnLadangID(slot)
// {
// 	new tmpcount;
// 	if(slot < 1 && slot > MAX_LADANG) return -1;
// 	foreach(new id : Ladang)
// 	{
//         tmpcount++;
//         if(tmpcount == slot)
//         {
//             return id;
//         }
// 	}
// 	return -1;
// }

// Player_LadangCount(playerid)
// {
// 	#if LIMIT_PER_PLAYER != 0
//     new count;
// 	foreach(new i : Ladang)
// 	{
// 		if(IsLadangOwner(playerid, i)) count++;
// 	}

// 	return count;
// 	#else
// 	return 0;
// 	#endif
// }

CMD:pfmenu(playerid, params[])
{
    foreach(new id : Ladang)
	{
        if(IsPlayerInRangeOfPoint(playerid, 4.0, opData[id][oX], opData[id][oY], opData[id][oZ]))
        {
            if(!IsLadangOwner(playerid, id) && !IsLadangEmploye(playerid, id))
                return Error(playerid, "You're not the Owner or Employee of this Ladang");
            
            ShowLadangMenu(playerid, id);
        }
    }
    return 1;
}

ShowLadangMenu(playerid, id)
{
    pData[playerid][pMenuLadang] = 0;
    pData[playerid][pInOp] = id;

    new str[256], vstr[64], StatusLadang[30];
    if(opData[id][oStatus] == 1)
    {
        StatusLadang = "{FFFF00}PRIVATE FARM{FFFFFF}";
    }
    else
    {
        StatusLadang = "{FF0000}PRIVATE FARM{FFFFFF}";
    }
    format(vstr, sizeof vstr,"Ladang (%s) Menu", opData[id][oName]);
    format(str, sizeof str,"Set Ladang Name\nType: %s\nEmploye Menu\nSeeds\t(%d/%d)\nMarijuana\t(%d/%d)\nMoney\t({7fff00}%s{ffffff})",
        StatusLadang,
        opData[id][oSeeds],
        MAX_LADANG_INT,
        opData[id][oMj],
        MAX_LADANG_INT,
        FormatMoney(opData[id][oMoney]));
    ShowPlayerDialog(playerid, OP_MENU, DIALOG_STYLE_LIST, vstr, str, "Select", "Cancel");
    return 1;
}
alias:createladang("createls")
CMD:createladang(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
	
	new query[512];
	new oid = Iter_Free(Ladang);
	if(oid == -1) return Error(playerid, "You cant create more Ladang!");
	new price;
	if(sscanf(params, "d", price)) return Usage(playerid, "/createLadang [price]");
	new totalcash[25];
	format(totalcash, sizeof totalcash,"%d00",price);
	price = strval(totalcash);
	format(opData[oid][oOwner], MAX_PLAYER_NAME, "-");
    format(opEmploy[oid][0], MAX_PLAYER_NAME, "-");
    format(opEmploy[oid][1], MAX_PLAYER_NAME, "-");
    format(opEmploy[oid][2], MAX_PLAYER_NAME, "-");
    format(opData[oid][oName], 24, "-");
	GetPlayerPos(playerid, opData[oid][oX], opData[oid][oY], opData[oid][oZ]);
	opData[oid][oPrice] = price;
	opData[oid][oStatus] = 0;
    opData[oid][oOwnerID] = 0;

    Ladang_Refresh(oid);
	Iter_Add(Ladang, oid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO farm SET id=%d, owner='%s', ownerid='%d', price=%d, posx='%f', posy='%f', posz='%f', name='%s'", oid, opData[oid][oOwner], opData[oid][oOwnerID], opData[oid][oPrice], opData[oid][oX], opData[oid][oY], opData[oid][oZ], opData[oid][oName]);
	mysql_tquery(g_SQL, query, "OnfarmCreated", "i", oid);
    Info(playerid, "Created farm ID:%d", oid);
    new str[150];
	format(str,sizeof(str),"[Ladang] %s membuat Ladang id %d!", GetRPName(playerid), oid);
	LogServer("Admin", str);
	return 1;
}

function OnLadangCreated(oid)
{
	Ladang_Save(oid);
    Ladang_Refresh(oid);
	return 1;
}
alias:gotoladang("gotols")
CMD:gotoladang(playerid, params[])
{
	new oid;
	if(pData[playerid][pAdmin] < 6)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	if(sscanf(params, "d", oid))
		return Usage(playerid, "/gotoLadang [id]");
	if(!Iter_Contains(Ladang, oid)) return Error(playerid, "The Ladang you specified ID of doesn't exist.");
	SetPlayerPos(playerid, opData[oid][oX], opData[oid][oY], opData[oid][oZ]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInFamily] = -1;	
	Info(playerid, "You has teleport to Ladang id %d", oid);
	return 1;
}
alias:editladang("editls")
CMD:editladang(playerid, params[])
{
    static
        oid,
        type[24],
        string[128];

	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");

    if(pData[playerid][pAdmin] < 201)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", oid, type, string))
    {
        Usage(playerid, "/editladang [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, delete, owner, price, money, seeds, marijuana");
        return 1;
    }
    if((oid < 0 || oid >= MAX_LADANG))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Ladang, oid)) return Error(playerid, "The Ladang you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, opData[oid][oX], opData[oid][oY], opData[oid][oZ]);
        Ladang_Save(oid);
		Ladang_Refresh(oid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of Ladang ID: %d.", pData[playerid][pAdminname], oid);
    }
    else if(!strcmp(type, "status", true))
    {
        new locked;

        if(sscanf(string, "d", locked))
            return Usage(playerid, "/editladang [id] [locked] [0/1]");

        if(locked < 0 || locked > 1)
            return Error(playerid, "You must specify at least 0 or 1.");

        opData[oid][oStatus] = locked;
        Ladang_Save(oid);
		Ladang_Refresh(oid);

        if(locked) {
            SendAdminMessage(COLOR_RED, "%s has Ladang ID: %d.", pData[playerid][pAdminname], oid);
        }
        else {
            SendAdminMessage(COLOR_RED, "%s has Ladang ID: %d.", pData[playerid][pAdminname], oid);
        }
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/editls [id] [Price] [Amount]");

        opData[oid][oPrice] = price;

        Ladang_Save(oid);
		Ladang_Refresh(oid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the price of Ladang ID: %d to %d.", pData[playerid][pAdminname], oid, price);
    }
	else if(!strcmp(type, "money", true))
    {
        new money;

        if(sscanf(string, "d", money))
            return Usage(playerid, "/editls [id] [money] [Ammount]");

        opData[oid][oMoney] = money;
        Ladang_Save(oid);
		Ladang_Refresh(oid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the money of Ladang ID: %d to %s.", pData[playerid][pAdminname], oid, FormatMoney(money));
    }
	else if(!strcmp(type, "seeds", true))
    {
        new amount;

        if(sscanf(string, "d", amount))
            return Usage(playerid, "/editls [id] [seeds] [Ammount]");

        opData[oid][oSeeds] = amount;
        Ladang_Save(oid);
		Ladang_Refresh(oid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the seeds of Ladang ID: %d to %d.", pData[playerid][pAdminname], oid, amount);
    }
    else if(!strcmp(type, "marijuana", true))
    {
        new amount;

        if(sscanf(string, "d", amount))
            return Usage(playerid, "/editls [id] [marijuana] [Ammount]");

        opData[oid][oMj] = amount;
        Ladang_Save(oid);
		Ladang_Refresh(oid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the marijuana of Ladang ID: %d to %d.", pData[playerid][pAdminname], oid, amount);
    }
    else if(!strcmp(type, "owner", true))
    {
		new otherid;
        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/editladang [id] [owner] [playerid] (use '-1' to no owner/ reset)");
		if(otherid == -1)
			return format(opData[oid][oOwner], MAX_PLAYER_NAME, "-");

        format(opData[oid][oOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
        opData[oid][oOwnerID] = pData[otherid][pID];
  
        Ladang_Save(oid);
		Ladang_Refresh(oid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of Ladang ID: %d to %s", pData[playerid][pAdminname], oid, pData[otherid][pName]);
    }
    else if(!strcmp(type, "reset", true))
    {
        Ladang_Reset(oid);
		Ladang_Save(oid);
		Ladang_Refresh(oid);
        SendAdminMessage(COLOR_RED, "%s has reset Ladang ID: %d.", pData[playerid][pAdminname], oid);
    }
	else if(!strcmp(type, "delete", true))
    {
		Ladang_Reset(oid);
		
		DestroyDynamic3DTextLabel(opData[oid][oText]);
        DestroyDynamicPickup(opData[oid][oPickup]);
		
		opData[oid][oX] = 0;
		opData[oid][oY] = 0;
		opData[oid][oZ] = 0;
		opData[oid][oPrice] = 0;
		opData[oid][oText] = Text3D: INVALID_3DTEXT_ID;
		opData[oid][oPickup] = -1;
		
		Iter_Remove(Ladang, oid);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM farm WHERE ID=%d", oid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s has delete Ladang ID: %d.", pData[playerid][pAdminname], oid);
        new str[150];
        format(str,sizeof(str),"[Ladang] %s menghapus Ladang id %d!", GetRPName(playerid), oid);
        LogServer("Admin", str);
	}
    return 1;
}

/*CMD:lockLadang(playerid, params[])
{
	foreach(new oid : Ladang)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.5, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
		{
			if(!IsLadangOwner(playerid, oid) && !IsLadangEmploye(playerid, oid)) return Error(playerid, "Kamu bukan pengurus Ladang ini.");
			if(!opData[oid][oStatus])
			{
				opData[oid][oStatus] = 1;
				Ladang_Save(oid);

				InfoTD_MSG(playerid, 4000, "Ladang anda berhasil ~g~Dibuka!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				opData[oid][oStatus] = 0;
				Ladang_Save(oid);

				InfoTD_MSG(playerid, 4000,"Ladang anda berhasil ~r~Ditutup");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
            Ladang_Refresh(oid);
		}
	}
	return 1;
}*/
alias:myladang("mypf")
CMD:myladang(playerid)
{
	if(!GetOwnedLadang(playerid)) return Error(playerid, "You don't have any Ladang.");
	new oid, _tmpstring[128], count = GetOwnedLadang(playerid), CMDSString[512];
	CMDSString = "";
	new lock[128];
	strcat(CMDSString,"No\tLocation\n",sizeof(CMDSString));
	Loop(itt, (count + 1), 1)
	{
	    oid = ReturnPlayerLadangID(playerid, itt);
		if(opData[oid][oStatus] == 1)
		{
			lock = "{FF0000}PRIVATE FARM{ffffff}";
		}
		else
		{
			lock = "{FF0000}PRIVATE FARM{ffffff}";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), "%d\t%s{ffffff}(%s)\t%s{ffffff}\n", itt, opData[oid][oName], GetLocation(opData[oid][oX], opData[oid][oY], opData[oid][oZ]));
		}
		else format(_tmpstring, sizeof(_tmpstring), "%d\t%s{ffffff}(%s)\t%s{ffffff}\n", itt, opData[oid][oName],GetLocation(opData[oid][oX], opData[oid][oY], opData[oid][oZ]));
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MY_OP, DIALOG_STYLE_TABLIST_HEADERS, "My Ladang", CMDSString, "Track", "Cancel");
	return 1;
}

CMD:pflant(playerid, params[])
{
    foreach(new id : Ladang)
	{
        if(IsPlayerInRangeOfPoint(playerid, 45.0, opData[id][oX], opData[id][oY], opData[id][oZ]))
		{
			if(!IsLadangOwner(playerid, id) && !IsLadangEmploye(playerid, id))
				return Error(playerid, "kamu bukan pekerja Ladang");
		}
        
    }
	if(isnull(params)) return SyntaxMsg(playerid, "/pflant [plant/harvest]");
	
	if(!strcmp(params, "plant", true))
	{
		if(pData[playerid][pJob] == 6 || pData[playerid][pJob2] == 6)
		{
			if(GetPlayerInterior(playerid) > 0) return Error(playerid, "You cant plant at here!");
			if(GetPlayerVirtualWorld(playerid) > 0) return Error(playerid, "You cant plant at here!");
			
			new mstr[512], tstr[64];
			format(tstr, sizeof(tstr), ""WHITE_E"My Seed: "GREEN_E"%d", pData[playerid][pSeed]);
			format(mstr, sizeof(mstr), "Plant\tSeed\n\
			"WHITE_E"Potato\t"GREEN_E"5 Seed\n\
			"WHITE_E"Wheat\t"GREEN_E"8 Seed\n\
			"WHITE_E"Orange\t"GREEN_E"8 Seed\n\
			"RED_E"[ILEGAL]Marijuana\t"GREEN_E"100 Seed");
			//"RED_E"[ILEGAL]Marijuana\t"GREEN_E"10 Seed");
			ShowPlayerDialog(playerid, DIALOG_PFLANT, DIALOG_STYLE_TABLIST_HEADERS, tstr, mstr, "Plant", "Close");
		}
		else return Error(playerid, "You are not farmer!");
	}
	else if(!strcmp(params, "harvest", true))
	{
        foreach(new id : Ladang)
        {
            if(IsPlayerInRangeOfPoint(playerid, 45.0, opData[id][oX], opData[id][oY], opData[id][oZ]))
            // if(IsLadangOwner(playerid, id) || IsLadangEmploye(playerid, id))
            if(!IsLadangOwner(playerid, id) && !IsLadangEmploye(playerid, id))
            return Error(playerid, "kamu bukan pekerja Ladang");
            
        }
		if(pData[playerid][pJob] == 6 || pData[playerid][pJob2] == 6)
		{
			new id = GetClosestPlant(playerid);
			if(id == -1) return Error(playerid, "You must closes on the plant!");
			if(PlantData[id][PlantTime] > 1) return Error(playerid, "This plant is not ready!");
			if(PlantData[id][PlantHarvest] == true) return Error(playerid, "This plant already harvesting by someone!");
			if(GetPlayerWeapon(playerid) != WEAPON_KNIFE) return Error(playerid, "You need holding a knife(pisau)!");
			
			pData[playerid][pHarvestID] = id;
			pData[playerid][pHarvest] = SetTimerEx("HarvestPlant", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Harvesting...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			SetPlayerArmedWeapon(playerid, WEAPON_KNIFE);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);

			PlantData[id][PlantHarvest] = true;
		}
		else return Error(playerid, "You are not farmer!");
	}
	// else if(!strcmp(params, "destroy", true))
	// {
	// 	if(pData[playerid][pFaction] == 1 || pData[playerid][pFaction] == 2)
	// 	{
	// 		new id = GetClosestPlant(playerid);
	// 		if(id == -1) return Error(playerid, "You must closes on the plant!");
	// 		if(PlantData[id][PlantHarvest] == true) return Error(playerid, "This plant already harvesting by someone!");
			
	// 		new query[128];
	// 		PlantData[id][PlantType] = 0;
	// 		PlantData[id][PlantTime] = 0;
	// 		PlantData[id][PlantX] = 0.0;
	// 		PlantData[id][PlantY] = 0.0;
	// 		PlantData[id][PlantZ] = 0.0;
	// 		PlantData[id][PlantHarvest] = false;
	// 		KillTimer(PlantData[id][PlantTimer]);
	// 		PlantData[id][PlantTimer] = -1;
	// 		DestroyDynamicObject(PlantData[id][PlantObjID]);
	// 		DestroyDynamicCP(PlantData[id][PlantCP]);
	// 		DestroyDynamic3DTextLabel(PlantData[id][PlantLabel]);
	// 		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM plants WHERE id='%d'", id);
	// 		mysql_query(g_SQL, query);
	// 		Iter_SafeRemove(Plants, id, id);
	// 		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	// 		SuccesMsg(playerid, "You has destroyed this plant!");
	// 	}
	// 	else return Error(playerid, "You cant destroy a plant!");
	// }
	// else if(!strcmp(params, "sell", true))
	// {
	// 	if(!IsPlayerInRangeOfPoint(playerid, 3.5, -381.44, -1426.13, 25.93))
	// 		return Error(playerid, "You must near in food/farmer warehouse!");
			
	// 	new potato = pData[playerid][pPotato] * PotatoPrice,
	// 	wheat = pData[playerid][pWheat] * WheatPrice,
	// 	orange = pData[playerid][pOrange] * OrangePrice;
		
	// 	new total = pData[playerid][pPotato] + pData[playerid][pWheat] + pData[playerid][pOrange];
	// 	new pay = potato + wheat + orange;
		
	// 	if(total < 1) return Error(playerid, "You dont have plant!");
	// 	GivePlayerMoneyEx(playerid, pay);
	// 	Food += total;
	// 	Server_MinMoney(pay);
		
	// 	pData[playerid][pPotato] = 0;
	// 	pData[playerid][pWheat] = 0;
	// 	pData[playerid][pOrange] = 0;
	// 	Info(playerid, "You selling "RED_E"%d kg "WHITE_E"all plant to "GREEN_E"%s", total, FormatMoney(pay));
	// }
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_PFLANT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(pData[playerid][pSeed] < 5) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					foreach(new oid : Ladang)
					if(IsPlayerInRangeOfPoint(playerid, 15.0, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
					{
					
						pData[playerid][pSeed] -= 5;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						PlantData[id][PlantType] = 1;
						PlantData[id][PlantTime] = 1800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
						Info(playerid, "Planting Potato.");
					}
				}
				case 1:
				{
					if(pData[playerid][pSeed] < 8) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					foreach(new oid : Ladang)

					if(IsPlayerInRangeOfPoint(playerid, 15.0, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
					{
					
						pData[playerid][pSeed] -= 8;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 2;
						PlantData[id][PlantTime] = 1800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
						Info(playerid, "Planting Wheat.");
					}
				}
				case 2:
				{
					if(pData[playerid][pSeed] < 8) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					foreach(new oid : Ladang)
					if(IsPlayerInRangeOfPoint(playerid, 15.0, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
					{
					
						pData[playerid][pSeed] -= 8;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 3;
						PlantData[id][PlantTime] = 1800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
						Info(playerid, "Planting Orange.");
					}			
				}
				case 3:
				{
					if(pData[playerid][pSeed] < 100) return Error(playerid, "Not enough seed!");
					new pid = GetNearPlant(playerid);
					if(pid != -1) return Error(playerid, "You too closes with other plant!");
					
					new id = Iter_Free(Plants);
					if(id == -1) return Error(playerid, "Cant plant any more plant!");
					
					if(pData[playerid][pPlantTime] > 0) return Error(playerid, "You must wait 10 minutes for plant again!");
					foreach(new oid : Ladang)
					if(IsPlayerInRangeOfPoint(playerid, 15.0, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
					{
					
						pData[playerid][pSeed] -= 100;
						new Float:x, Float:y, Float:z, query[512];
						GetPlayerPos(playerid, x, y, z);
						
						PlantData[id][PlantType] = 4;
						PlantData[id][PlantTime] = 1800;
						PlantData[id][PlantX] = x;
						PlantData[id][PlantY] = y;
						PlantData[id][PlantZ] = z;
						PlantData[id][PlantHarvest] = false;
						PlantData[id][PlantTimer] = SetTimerEx("PlantGrowup", 1000, true, "i", id);
						Iter_Add(Plants, id);
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO plants SET id='%d', type='%d', time='%d', posx='%f', posy='%f', posz='%f'", id, PlantData[id][PlantType], PlantData[id][PlantTime], x, y, z);
						mysql_tquery(g_SQL, query, "OnPlantCreated", "di", playerid, id);
						pData[playerid][pPlant]++;
						Info(playerid, "Planting Marijuana.");
					}
				}
			}
		}
	}

    if(dialogid == DIALOG_MY_OP)
	{
		if(!response) return true;
		new id = ReturnPlayerLadangID(playerid, (listitem + 1));
		SetPlayerRaceCheckpoint(playerid,1, opData[id][oX], opData[id][oY], opData[id][oZ], 0.0, 0.0, 0.0, 3.5);
		Info(playerid, "Ikuti checkpoint untuk menemukan ladang anda!");
		return 1;
	}
	if(dialogid == OP_MENU)
	{
		if(response)
		{
			new id = pData[playerid][pInOp];
			switch(listitem)
			{
				case 0:
				{
					if(!IsLadangOwner(playerid, id))
						return Error(playerid, "Only Ladang Owner who can use this");

					new str[256];
					format(str, sizeof str,"Current Ladang Name:\n%s\n\nInput new name to Change Ladang Name", opData[id][oName]);
					ShowPlayerDialog(playerid, OP_SETNAME, DIALOG_STYLE_INPUT, "Change Ladang Name", str,"Change","Cancel");
				}
				case 1:
				{
					foreach(new oid : Ladang)
					{
						if(IsPlayerInRangeOfPoint(playerid, 3.5, opData[oid][oX], opData[oid][oY], opData[oid][oZ]))
						{
							if(!IsLadangOwner(playerid, oid) && !IsLadangEmploye(playerid, oid)) return Error(playerid, "Kamu bukan pengurus Ladang ini.");
							if(!opData[oid][oStatus])
							{
								opData[oid][oStatus] = 1;
								Ladang_Save(oid);
								ShowLadangMenu(playerid, oid);

								InfoTD_MSG(playerid, 4000, "PRIVATE FARM!");
								PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							}
							else
							{
								opData[oid][oStatus] = 0;
								Ladang_Save(oid);
								ShowLadangMenu(playerid, oid);

								InfoTD_MSG(playerid, 4000,"PRIVATE FARM!");
								PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							}
							Ladang_Refresh(oid);
						}
					}
					return 1;
				}
				case 2:
				{
					new str[556];
					format(str, sizeof str,"Name\tRank\n(%s)\tOwner\n",opData[id][oOwner]);
					for(new z = 0; z < MAX_LADANG_EMPLOYEE; z++)
					{
						format(str, sizeof str,"%s(%s)\tEmploye\n", str, opEmploy[id][z]);
					}
					ShowPlayerDialog(playerid, OP_SETEMPLOYE, DIALOG_STYLE_TABLIST_HEADERS, "Employe Menu", str, "Change","Cancel");
				}
				case 3:
				{
					ShowPlayerDialog(playerid, OP_SEEDS, DIALOG_STYLE_LIST, "Ladang Seeds", "Withdraw\nDeposit", "Select","Cancel");
				}
				case 4:
				{
					ShowPlayerDialog(playerid, OP_MARIJUANA, DIALOG_STYLE_LIST, "Ladang Marijuana", "Withdraw\nDeposit", "Select","Cancel");
				}
				case 5:
				{
					ShowPlayerDialog(playerid, OP_MONEY, DIALOG_STYLE_LIST, "Ladang Money", "Withdraw\nDeposit", "Select","Cancel");
				}
			}
		}
	}
	if(dialogid == OP_SETNAME)
	{
		if(response)
		{
			new id = pData[playerid][pInOp];

			if(!IsLadangOwner(playerid, id))
				return Error(playerid, "Only Ladang Owner who can use this");

			if(strlen(inputtext) > 24) 
				return Error(playerid, "Maximal 24 Character");

			if(strfind(inputtext, "'", true) != -1)
				return Error(playerid, "You can't put ' in Ladang Name");
			
			SendClientMessageEx(playerid, ARWIN, "Ladang: {ffffff}You've successfully set Ladang Name from {ffff00}%s{ffffff} to {7fffd4}%s", opData[id][oName], inputtext);
			format(opData[id][oName], 24, inputtext);
			Ladang_Save(id);
			Ladang_Refresh(id);
		}
	}
	if(dialogid == OP_SETEMPLOYE)
	{
		if(response)
		{
			new id = pData[playerid][pInOp], str[256];

			if(!IsLadangOwner(playerid, id))
				return Error(playerid, "Only Ladang Owner who can use this");

			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pMenuLadang] = 0;
					format(str, sizeof str, "Current Owner:\n%s\n\nInput Player ID/Name to Change Ownership", opData[id][oOwner]);
					Ladang_Save(id);
					Ladang_Refresh(id);					
				}
				case 1:
				{
					pData[playerid][pMenuLadang] = 1;
					format(str, sizeof str, "Current Employe:\n%s\n\nInput Player ID/Name to Change", opEmploy[id][0]);
					Ladang_Save(id);
					Ladang_Refresh(id);					
				}
				case 2:
				{
					pData[playerid][pMenuLadang] = 2;
					format(str, sizeof str, "Current Employe:\n%s\n\nInput Player ID/Name to Change", opEmploy[id][1]);
					Ladang_Save(id);
					Ladang_Refresh(id);					
				}
				case 3:
				{
					pData[playerid][pMenuLadang] = 3;
					format(str, sizeof str, "Current Employe:\n%s\n\nInput Player ID/Name to Change", opEmploy[id][2]);
					Ladang_Save(id);
					Ladang_Refresh(id);					
				}
			}
			ShowPlayerDialog(playerid, OP_SETEMPLOYEE, DIALOG_STYLE_INPUT, "Employe Menu", str, "Change", "Cancel");
		}
	}
	if(dialogid == OP_SETEMPLOYEE)
	{
		if(response)
		{
			new otherid, id = pData[playerid][pInOp], eid = pData[playerid][pMenuLadang];
			if(!strcmp(inputtext, "-", true))
			{
				SendClientMessageEx(playerid, ARWIN, "Ladang: {ffffff}You've successfully removed %s from Ladang", opEmploy[id][(eid - 1)]);
				format(opEmploy[id][(eid - 1)], MAX_PLAYER_NAME, "-");
				Ladang_Save(id);
				return 1;
			}

			if(sscanf(inputtext,"u", otherid))
				return Error(playerid, "You must put Player ID/Name");

			if(!IsLadangOwner(playerid, id))
				return Error(playerid, "Only Ladang Owner who can use this");

			if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
				return Error(playerid, "Player itu Disconnect or not near you.");

			if(otherid == playerid)
				return Error(playerid, "You can't set to yourself as owner.");

			if(eid == 0)
			{
				new str[128];
				pData[playerid][pTransferOp] = otherid;
				format(str, sizeof str,"Are you sure want to transfer ownership to %s?", ReturnName(otherid));
				ShowPlayerDialog(playerid, OP_SETOWNERCONFIRM, DIALOG_STYLE_MSGBOX, "Transfer Ownership", str,"Confirm","Cancel");
			}
			else if(eid > 0 && eid < 4)
			{
				format(opEmploy[id][(eid - 1)], MAX_PLAYER_NAME, pData[otherid][pName]);
				SendClientMessageEx(playerid, ARWIN, "Ladang: {ffffff}You've successfully add %s to Ladang", pData[otherid][pName]);
				SendClientMessageEx(otherid, ARWIN, "Ladang: {ffffff}You've been hired in Ladang %s by %s", opData[id][oName], pData[playerid][pName]);
				Ladang_Save(id);
			}
			Ladang_Save(id);
			Ladang_Refresh(id);
		}
	}
	if(dialogid == OP_SETOWNERCONFIRM)
	{
		if(!response) 
			pData[playerid][pTransferOp] = INVALID_PLAYER_ID;

		new otherid = pData[playerid][pTransferOp], id = pData[playerid][pInOp];
		if(response)
		{
			if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
				return Error(playerid, "Player itu Disconnect or not near you.");

			SendClientMessageEx(playerid, ARWIN, "Ladang: {ffffff}You've successfully transfered %s Ladang to %s",opData[id][oName], pData[otherid][pName]);
			SendClientMessageEx(otherid, ARWIN, "Ladang: {ffffff}You've been transfered to owner in %s Ladang by %s", opData[id][oName], pData[playerid][pName]);
			format(opData[id][oOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
			Ladang_Save(id);
			Ladang_Refresh(id);
		}
	}
	if(dialogid == OP_SEEDS)
	{
		if(response)
		{
			new str[256], id = pData[playerid][pInOp];
			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pMenuLadang] = 1;
					format(str, sizeof str,"Current Seeds: %d\n\nPlease Input amount to Withdraw", opData[id][oSeeds]);
				}
				case 1:
				{
					pData[playerid][pMenuLadang] = 2;
					format(str, sizeof str,"Current Seeds: %d\n\nPlease Input amount to Deposit", opData[id][oSeeds]);
				}
			}
			ShowPlayerDialog(playerid, OP_SEEDS2, DIALOG_STYLE_INPUT, "Seeds Menu", str, "Input","Cancel");
		}
	}
	if(dialogid == OP_SEEDS2)
	{
		if(response)
		{
			new amount = strval(inputtext), id = pData[playerid][pInOp];
			if(pData[playerid][pMenuLadang] == 1)
			{
				if(amount < 1)
					return Error(playerid, "Minimum amount is 1");

				if(opData[id][oSeeds] < amount) return Error(playerid, "Not Enough Ladang Seeds");

				if((pData[playerid][pSeed] + amount) >= 701)
					return Error(playerid, "You've reached maximum of Seeds");

				pData[playerid][pSeed] += amount;
				opData[id][oSeeds] -= amount;
				Ladang_Save(id);
				Info(playerid, "You've successfully withdraw %d Seeds from Ladang", amount);
			}
			else if(pData[playerid][pMenuLadang] == 2)
			{
				if(amount < 1)
					return Error(playerid, "Minimum amount is 1");

				if(pData[playerid][pSeed] < amount) return Error(playerid, "Not Enough Seeds");

				if((opData[id][oSeeds] + amount) >= MAX_LADANG_INT)
					return Error(playerid, "You've reached maximum of Seeds");

				pData[playerid][pSeed] -= amount;
				opData[id][oSeeds] += amount;
				Ladang_Save(id);
				Info(playerid, "You've successfully deposit %d Seeds to Ladang", amount);
			}
		}
	}
	if(dialogid == OP_MARIJUANA)
	{
		if(response)
		{
			new str[256], id = pData[playerid][pInOp];
			switch(listitem)
			{
				case 0:
				{
					pData[playerid][pMenuLadang] = 1;
					format(str, sizeof str,"Current Marijuana: %d\n\nPlease Input amount to Withdraw", opData[id][oMj]);
				}
				case 1:
				{
					pData[playerid][pMenuLadang] = 2;
					format(str, sizeof str,"Current Marijuana: %d\n\nPlease Input amount to Deposit", opData[id][oMj]);
				}
			}
			ShowPlayerDialog(playerid, OP_MARIJUANA2, DIALOG_STYLE_INPUT, "Marijuana Menu", str, "Input","Cancel");
		}
	}
	if(dialogid == OP_MARIJUANA2)
	{
		if(response)
		{
			new amount = strval(inputtext), id = pData[playerid][pInOp];
			if(pData[playerid][pMenuLadang] == 1)
			{
				if(amount < 1)
					return Error(playerid, "Minimum amount is 1");

				if(opData[id][oMj] < amount) return Error(playerid, "Not Enough Ladang Marijuana");

				if((pData[playerid][pMarijuana] + amount) >= 500)
					return Error(playerid, "You've reached maximum of Marijuana");

				pData[playerid][pMarijuana] += amount;
				opData[id][oMj] -= amount;
				Ladang_Save(id);
				Info(playerid, "You've successfully withdraw %d Marijuana from Ladang", amount);
			}
			else if(pData[playerid][pMenuLadang] == 2)
			{
				if(amount < 1)
					return Error(playerid, "Minimum amount is 1");

				if(pData[playerid][pMarijuana] < amount) return Error(playerid, "Not Enough Marijuana");

				if((opData[id][oMj] + amount) >= MAX_LADANG_INT)
					return Error(playerid, "You've reached maximum of Marijuana");

				pData[playerid][pMarijuana] -= amount;
				opData[id][oMj] += amount;
				Ladang_Save(id);
				Info(playerid, "You've successfully deposit %d Marijuana to Ladang", amount);
			}
		}
		return 1;
	}
	if(dialogid == OP_MONEY)
	{
		if(response)
		{
			new str[264], id = pData[playerid][pInOp];
			switch(listitem)
			{
				case 0:
				{
					if(!IsLadangOwner(playerid, id))
						return Error(playerid, "Only Ladang Owner who can use this");

					format(str, sizeof str, "Current Money:\n{7fff00}%s\n\n{ffffff}Input Amount to Withdraw", FormatMoney(opData[id][oMoney]));
					ShowPlayerDialog(playerid, OP_WITHDRAWMONEY, DIALOG_STYLE_INPUT, "Withdraw Ladang Money",str,"Withdraw","Cancel");
				}
				case 1:
				{
					format(str, sizeof str, "Current Money:\n{7fff00}%s\n\n{ffffff}Input Amount to Deposit", FormatMoney(opData[id][oMoney]));
					ShowPlayerDialog(playerid, OP_DEPOSITMONEY, DIALOG_STYLE_INPUT, "Deposit Ladang Money",str,"Deposit","Cancel");
				}
			}
		}
	}
	if(dialogid == OP_WITHDRAWMONEY)
	{
		if(response)
		{
			new amount = strval(inputtext), id = pData[playerid][pInOp];

			if(amount < 1)
				return Error(playerid, "Minimum amount is $1");

			if(opData[id][oMoney] < amount)
				return Error(playerid, "Not Enough Ladang Money");

			GivePlayerMoneyEx(playerid, amount);
			opData[id][oMoney] -= amount;
			Ladang_Save(id);
		}
	}
	if(dialogid == OP_DEPOSITMONEY)
	{
		if(response)
		{
			new amount = strval(inputtext), id = pData[playerid][pInOp];
			
			if(amount < 1)
				return Error(playerid, "Minimum amount is $1");

			if(pData[playerid][pMoney] < amount)
				return Error(playerid, "Not Enough Money");

			GivePlayerMoneyEx(playerid, -amount);
			opData[id][oMoney] += amount;
			Ladang_Save(id);
		}
	}
    return 1;
}
