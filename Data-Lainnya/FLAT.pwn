#define MAX_FLAT 					100
#define MAX_PLAYER_FLAT 			1

enum flatData
{
	flatID,
	flatExists,
	flatOwner,
	flatOwnerName[32],
	flatMoney,
	flatPrice,
	Float:flatPos[6],
	Float:flatPoint[4],
	Float:flatTextPos[3],
	Float:flatEntrance,
	Text3D:flatText3D,
	STREAMER_TAG_OBJECT:flatDoor,//1502
	flatStatus,
	flatVW,
	flatInterior,
	flatLocked,
	flatWeapons[5],
	flatAmmo[5],
	flatDurability[5],
	flatSerial[5],
	flatType
};

new FlatData[MAX_FLAT][flatData];

stock Flat_Save(flatid)
{
	static
	    query[1536];

	format(query, sizeof(query), "UPDATE `flat` SET `flatOwner` = '%d', `flatPrice` = '%d', `flatOwnerName` = '%s', `flatPosX` = '%.4f', `flatPosY` = '%.4f', `flatPosZ` = '%.4f', `flatPosRX` = '%.4f', `flatPosRY` = '%.4f', `flatPosRZ` = '%.4f', `flatInterior` = '%d', `flatVW` = '%d', `flatPointX` = '%.4f', `flatPointY` = '%.4f', `flatPointZ` = '%.4f', `flatPointRadius` = '%.4f'",
	    FlatData[flatid][flatOwner],
	    FlatData[flatid][flatPrice],
	    FlatData[flatid][flatOwnerName],
	    FlatData[flatid][flatPos][0],
	    FlatData[flatid][flatPos][1],
	    FlatData[flatid][flatPos][2],
	    FlatData[flatid][flatPos][3],
	    FlatData[flatid][flatPos][4],
	    FlatData[flatid][flatPos][5],
        FlatData[flatid][flatInterior],
        FlatData[flatid][flatVW],
        FlatData[flatid][flatPoint][0],
        FlatData[flatid][flatPoint][1],
        FlatData[flatid][flatPoint][2],
        FlatData[flatid][flatPoint][3]
	);
	for (new i = 0; i < 5; i ++)
	{
		format(query, sizeof(query), "%s, `flatWeapon%d` = '%d', `flatAmmo%d` = '%d', `flatDurability%d` = '%d', `flatSerial%d` = '%d'", query, i + 1, FlatData[flatid][flatWeapons][i], i + 1, FlatData[flatid][flatAmmo][i], i + 1, FlatData[flatid][flatDurability][i], i + 1, FlatData[flatid][flatSerial][i]);
	}
	format(query, sizeof(query), "%s, `flatLocked` = '%d', `flatMoney` = '%d', `flatTextX` = '%.4f', `flatTextY` = '%.4f', `flatTextZ` = '%.4f', `flatStatus` = '%d' WHERE `flatID` = '%d'",
	    query,
	    FlatData[flatid][flatLocked],
	    FlatData[flatid][flatMoney],
		FlatData[flatid][flatTextPos][0],
		FlatData[flatid][flatTextPos][1],
		FlatData[flatid][flatTextPos][2],
		FlatData[flatid][flatStatus],
		FlatData[flatid][flatID]
	);
	return mysql_tquery(g_SQL, query);
}

Flat_GetType(type)
{
	static
	    str[15];

	switch (type)
	{
	    case 1: str = "Low";
	    case 2: str = "Medium";
	    case 3: str = "High";
	    default: str = "Low";
	}
	return str;
}

Flat_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_FLAT; i ++)
	{
		if (FlatData[i][flatExists] && Flat_IsOwner(playerid, i))
   		{
   		    count++;
		}
	}
	return count;
}

stock Flat_Create(playerid, price, type)
{
    new
	    Float:x,
	    Float:y,
	    Float:z;

	if (GetPlayerPos(playerid, x, y, z))
	{
		for (new i = 0; i < MAX_FLAT; i ++) if (!FlatData[i][flatExists])
		{
			FlatData[i][flatExists] = true;

			FlatData[i][flatPos][0] = x;
			FlatData[i][flatPos][1] = y;
			FlatData[i][flatPos][2] = z;
			FlatData[i][flatVW] = GetPlayerVirtualWorld(playerid);
			FlatData[i][flatInterior] = GetPlayerInterior(playerid);
			FlatData[i][flatPrice] = price;
			FlatData[i][flatLocked] = 1;
			FlatData[i][flatType] = type;

			Flat_Refresh(i);
			mysql_tquery(g_SQL, "INSERT INTO `flat` (`flatInterior`) VALUES(0)", "OnFlatCreated", "d", i);

			return i;
		}
	}
	return -1;
}

Flat_Delete(flatid)
{
	if (flatid != -1 && FlatData[flatid][flatExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `flat` WHERE `flatID` = '%d'", FlatData[flatid][flatID]);
		mysql_tquery(g_SQL, string);

	    if (IsValidDynamic3DTextLabel(FlatData[flatid][flatText3D]))
	        DestroyDynamic3DTextLabel(FlatData[flatid][flatText3D]);

	    if (IsValidDynamicObject(FlatData[flatid][flatDoor]))
	        DestroyDynamicObject(FlatData[flatid][flatDoor]);

	    FlatData[flatid][flatExists] = false;
	    FlatData[flatid][flatOwner] = 0;
	    FlatData[flatid][flatID] = 0;
	}
	return 1;
}

stock Flat_Refresh(flatid)//ngent
{
	if (flatid != -1 && FlatData[flatid][flatExists])
	{
	    if (IsValidDynamic3DTextLabel(FlatData[flatid][flatText3D]))
	        DestroyDynamic3DTextLabel(FlatData[flatid][flatText3D]);

	    if (IsValidDynamicObject(FlatData[flatid][flatDoor]))
	        DestroyDynamicObject(FlatData[flatid][flatDoor]);

		new
		    string[256];

		if(FlatData[flatid][flatPoint][0] != 0.0 && FlatData[flatid][flatPoint][1] != 0.0 && FlatData[flatid][flatPoint][2] != 0.0)
		{
			if(!FlatData[flatid][flatOwner])
			{
			    format(string, sizeof(string), "{00FFFF}[ID:%d]\n{FFFF00}Flat Price: {FFFFFF}%s\n{FFFF00}Type: {FFFFFF}%s\n{FF0000}/buyflat {FFFFFF}For buy.", flatid, FormatMoney(FlatData[flatid][flatPrice]), Flat_GetType(FlatData[flatid][flatType]));
			}
			else
			{
			    format(string, sizeof(string), "{00FFFF}[ID:%d]\n{FFFF00}Owner: {FFFFFF}%s\n{FFFF00}Type: {FFFFFF}%s", flatid, FlatData[flatid][flatOwnerName], Flat_GetType(FlatData[flatid][flatType]));
			}

			FlatData[flatid][flatText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW,  FlatData[flatid][flatPoint][0], FlatData[flatid][flatPoint][1], FlatData[flatid][flatPoint][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0,  FlatData[flatid][flatVW], FlatData[flatid][flatInterior]);
		}
		switch(FlatData[flatid][flatLocked])
		{
		    case 0:
		    {
		        FlatData[flatid][flatDoor] = CreateDynamicObject(1502, FlatData[flatid][flatPos][0], FlatData[flatid][flatPos][1], FlatData[flatid][flatPos][2], FlatData[flatid][flatPos][3], FlatData[flatid][flatPos][4],FlatData[flatid][flatPos][5], FlatData[flatid][flatVW], FlatData[flatid][flatInterior]);
			}
			case 1:
			{
			    FlatData[flatid][flatDoor] = CreateDynamicObject(19802, FlatData[flatid][flatPos][0], FlatData[flatid][flatPos][1], FlatData[flatid][flatPos][2], FlatData[flatid][flatPos][3], FlatData[flatid][flatPos][4],FlatData[flatid][flatPos][5], FlatData[flatid][flatVW], FlatData[flatid][flatInterior]);
			}
		}
  		return 1;
	}
	return 0;
}

Flat_NearestPoint(playerid)
{
    for (new i = 0; i != MAX_FLAT; i ++) if (FlatData[i][flatExists] && IsPlayerInRangeOfPoint(playerid, FlatData[i][flatPoint][3], FlatData[i][flatTextPos][0], FlatData[i][flatTextPos][1], FlatData[i][flatTextPos][2]))
	{
		return i;
	}
	return -1;
}

Flat_NearestDoor(playerid)
{
    for (new i = 0; i != MAX_FLAT; i ++) if (FlatData[i][flatExists] && IsPlayerInRangeOfPoint(playerid, 2.0, FlatData[i][flatPos][0], FlatData[i][flatPos][1], FlatData[i][flatPos][2]))
	{
		if (GetPlayerInterior(playerid) == FlatData[i][flatInterior] && GetPlayerVirtualWorld(playerid) == FlatData[i][flatVW])
			return i;
	}
	return -1;
}

Flat_IsOwner(playerid, flatid)
{
	if (pData[playerid][pID] == -1)
	    return 0;

	if (FlatData[flatid][flatExists] && FlatData[flatid][flatOwner] == 99999999 && pData[playerid][pAdmin] > 0)
		return 1;

    if ((FlatData[flatid][flatExists] && FlatData[flatid][flatOwner] != 0) && FlatData[flatid][flatOwner] == pData[playerid][pID])
		return 1;

	return 0;
}

stock Flat_WeaponStorage(playerid, flatid)
{
	if (flatid == -1 || !FlatData[flatid][flatExists])
	    return 0;

	static
	    string[320];

	string[0] = 0;

	for (new i = 0; i < 5; i ++)
	{
	    if (!FlatData[flatid][flatWeapons][i])
	        format(string, sizeof(string), "%sEmpty Slot\n", string);

		else
			format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(FlatData[flatid][flatWeapons][i]), FlatData[flatid][flatAmmo][i]);
	}
	ShowPlayerDialog(playerid, DIALOG_FLATWEAPON, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
	return 1;
}

stock UpdatePlayerStreamer(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	foreach(new i : Player)
	{
	    if(IsPlayerInRangeOfPoint(i, 20.0, pos[0], pos[1], pos[2]))
	    {
	        Streamer_Update(i);
		}
	}
	return 1;
}


function OnFlatCreated(flatid)
{
    if (flatid == -1 || !FlatData[flatid][flatExists])
		return 0;

	FlatData[flatid][flatID] = cache_insert_id();
 	Flat_Save(flatid);
	return 1;
}

function KickFlat(playerid, flatid)
{
	if (pData[playerid][pFaction] != 1 || Flat_NearestDoor(playerid) != flatid)
	    return 0;

	switch (random(6))
	{
	    case 0..2:
	    {
	       // //ShowMessage(playerid, "You have ~r~failed~w~ to kick the door down.", 3);
	        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has failed to kick the door down.", ReturnName(playerid));
		}
		default:
		{
		    FlatData[flatid][flatLocked] = false;
            MoveDynamicObject(FlatData[flatid][flatDoor], FlatData[flatid][flatPos][0], FlatData[flatid][flatPos][1], FlatData[flatid][flatPos][2], 10, FlatData[flatid][flatPos][3]+90.0, FlatData[flatid][flatPos][4],FlatData[flatid][flatPos][5]);

		    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has successfully kicked the door down.", ReturnName(playerid));
		}
	}
	return 1;
}

function LoadFlat()
{
	new rows = cache_num_rows(), str[128];
 	if(rows)
  	{
    	for(new i; i < rows; i++)
		{
			FlatData[i][flatExists] = true;
	        cache_get_value_name_int(i,"flatID",FlatData[i][flatID]);
	        cache_get_value_name_int(i,"flatPrice",FlatData[i][flatPrice]);
	        cache_get_value_name_int(i,"flatOwner",FlatData[i][flatOwner]);
	        cache_get_value_name(i,"flatOwnerName",FlatData[i][flatOwnerName]);

	        cache_get_value_name_float(i,"flatPosX",FlatData[i][flatPos][0]);
	        cache_get_value_name_float(i,"flatPosY",FlatData[i][flatPos][1]);
	        cache_get_value_name_float(i,"flatPosZ",FlatData[i][flatPos][2]);
	        cache_get_value_name_float(i,"flatPosRX",FlatData[i][flatPos][3]);
	        cache_get_value_name_float(i,"flatPosRY",FlatData[i][flatPos][4]);
	        cache_get_value_name_float(i,"flatPosRZ",FlatData[i][flatPos][5]);

	        cache_get_value_name_float(i,"flatTextX",FlatData[i][flatTextPos][0]);
	        cache_get_value_name_float(i,"flatTextY",FlatData[i][flatTextPos][1]);
	        cache_get_value_name_float(i,"flatTextZ",FlatData[i][flatTextPos][2]);

	        cache_get_value_name_int(i,"flatInterior",FlatData[i][flatInterior]);
	        cache_get_value_name_int(i,"flatVW",FlatData[i][flatVW]);

	        cache_get_value_name_int(i,"flatLocked",FlatData[i][flatLocked]);
	        cache_get_value_name_int(i,"flatMoney",FlatData[i][flatMoney]);
	        cache_get_value_name_int(i,"flatStatus",FlatData[i][flatStatus]);

	        cache_get_value_name_float(i,"flatPointX",FlatData[i][flatPoint][0]);
	        cache_get_value_name_float(i,"flatPointY",FlatData[i][flatPoint][1]);
	        cache_get_value_name_float(i,"flatPointZ",FlatData[i][flatPoint][2]);
	        cache_get_value_name_float(i,"flatPointRadius",FlatData[i][flatPoint][3]);
	        for (new j = 0; j < 5; j ++)
			{
	            format(str, 24, "flatWeapon%d", j + 1);
	            cache_get_value_name_int(i, str, FlatData[i][flatWeapons][j]);

	            format(str, 24, "flatAmmo%d", j + 1);
	           	cache_get_value_name_int(i, str, FlatData[i][flatAmmo][j]);

	            format(str, 24, "flatSerial%d", j + 1);
	           	cache_get_value_name_int(i, str, FlatData[i][flatSerial][j]);

	            format(str, 24, "flatDurability%d", j + 1);
	           	cache_get_value_name_int(i, str, FlatData[i][flatDurability][j]);
			}
	        Flat_Refresh(i);
		}
		printf("[Flat] %d Loaded.", rows);
	}
	return 1;
}

CMD:flatstorage(playerid, params[])
{
    new id = Flat_NearestPoint(playerid), items[1];

	for (new i = 0; i < 5; i ++) if (FlatData[id][flatWeapons][i])
	{
	    items[0]++;
	}
	if (id != -1)
	{
	    if(Flat_IsOwner(playerid, id) || pData[playerid][pFaction] == 1)//\nWeapon Storage (%d/10)\nMoney Safe (%s)", items[0], MAX_HOUSE_STORAGE, items[1], FormatMoney(HouseData[houseid][houseMoney]));
	    {
		    new str[64];
		    format(str, sizeof(str), "Cash Vault\t\t\t%s\nWeapon Storage\t\t%d/5", FormatMoney(FlatData[id][flatMoney]), items[0]);
		    ShowPlayerDialog(playerid, DIALOG_FLAT, DIALOG_STYLE_LIST, "Flat Storage", str, "Select", "Cancel");
		}
	}
	else
	    return Error(playerid, "You're not at inside your Flat!");
	return 1;
}

CMD:flatlock(playerid, params[])
{
    new id = Flat_NearestDoor(playerid);
	if (id != -1)
	{
		if(Flat_IsOwner(playerid, id))
		{
			switch (FlatData[id][flatLocked])
			{
			    case 0:
			    {
				    //ShowMessage(playerid, "You have ~r~Locked~w~ the Flat!", 3);
				    FlatData[id][flatLocked] = 1;
				    Flat_Refresh(id);
				    UpdatePlayerStreamer(playerid);

				}
		        case 1:
				{
				    //ShowMessage(playerid, "You have ~g~Unlocked~w~ the Flat!", 3);
				    FlatData[id][flatLocked] = 0;
				    Flat_Refresh(id);
				    UpdatePlayerStreamer(playerid);
				}
			}
		}
	}
	return 1;
}

CMD:buyflat(playerid, params[])
{
	new
		id = -1;

	if(pData[playerid][pID] == -1)
	    return Error(playerid, "Your database ID value is '-1', you must relogin first for doing any Transactions");

	if(Flat_GetCount(playerid) >= 1)
	    return Error(playerid, "You only can own 1 house at the moment.");

	if ((id = Flat_NearestDoor(playerid)) != -1)
	{
	    if (Flat_GetCount(playerid) >= MAX_PLAYER_FLAT)
			return Error(playerid, "You can only own %d Flat at a time.", MAX_PLAYER_FLAT);

		if (FlatData[id][flatOwner] != 0)
		    return Error(playerid, "This Flat is already owned at the moment.");

		if (FlatData[id][flatPrice] > GetPlayerMoney(playerid))
		    return Error(playerid, "You have insufficient funds for the purchase.");

	    FlatData[id][flatOwner] = pData[playerid][pID];
	    format(FlatData[id][flatOwnerName], 32, GetName(playerid));

		Flat_Refresh(id);
		Flat_Save(id);
	    GivePlayerMoneyEx(playerid, -FlatData[id][flatPrice]);
	    Servers(playerid, "You have purchased Flat ID %d for %s!", id, FormatMoney(FlatData[id][flatPrice]));
        UpdatePlayerStreamer(playerid);
	  //  Log_Write("logs/house_log.txt", "[%s] %s has purchased house ID: %d for %s.", ReturnDate(), ReturnName(playerid), id, FormatMoney(HouseData[id][housePrice]));
	}
	return 1;
}

CMD:createflat(playerid, params[])
{
	new id, price, type;

	if(pData[playerid][pAdmin] < 7)
		return Error(playerid, "You don't have permission to use this Command!");

	if(sscanf(params, "dd", price, type))
	    return Usage(playerid, "/createflat [price] [type 1. Low | 2. Medium | 3.High]");

	if(type < 1 || type > 3)
	    return Error(playerid, "Invalid type ID!");

	id = Flat_Create(playerid, price, type);

	Servers(playerid, "You've successfully created Flat ID: %d.", id);
	return 1;
}


CMD:breachflat(playerid, params[])
{
	new
	    id = -1;

	if (pData[playerid][pFaction] != 1)
	    return Error(playerid, "You must be a police officer.");

	if ((id = Flat_NearestDoor(playerid)) != -1)
	{
	    if (!FlatData[id][flatLocked])
	        return Error(playerid, "This flat is already unlocked.");

	    //ShowMessage(playerid, "Attempting to ~r~break~w~ flat door...", 3);
	    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s attempts to kick the flat's door down.", ReturnName(playerid));
	    SetTimerEx("KickFlat", 2000, false, "dd", playerid, id);
	}
	else
	{
		Error(playerid, "You must be in range of a flat door!");
	}
	return 1;
}

CMD:asellflat(playerid, params[])
{
	new bizid = -1;

	if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", bizid))
	    return Usage(playerid, "/asellflat [flat id]");

	if ((bizid < 0 || bizid >= MAX_FLAT) || !FlatData[bizid][flatExists])
	    return Error(playerid, "You have specified an invalid Flat ID.");

	FlatData[bizid][flatOwner] = 0;

	Flat_Refresh(bizid);
	Flat_Save(bizid);

	Servers(playerid, "You have sold Flat ID: %d.", bizid);
	return 1;
}

CMD:destroyflat(playerid, params[])
{
	static
	    id = 0;

    if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return Usage(playerid, "/destroyflat [flat id]");

	if ((id < 0 || id >= MAX_FLAT) || !FlatData[id][flatExists])
	    return Error(playerid, "You have specified an invalid Flat ID.");

	Flat_Delete(id);
	Servers(playerid, "You have successfully destroyed Flat ID: %d.", id);
	return 1;
}

CMD:editflat(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	Usage(playerid, "/editflat [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} pos, move, textpoint, point, price");
		return 1;
	}
	if ((id < 0 || id >= MAX_FLAT) || !FlatData[id][flatExists])
	    return Error(playerid, "You have specified an invalid Flat ID.");


    if (!strcmp(type, "pos", true))
	{
	    pData[playerid][pEditFlat] = -1;
	   	EditDynamicObject(playerid, FlatData[id][flatDoor]);

		pData[playerid][pEditFlat] = id;

		Servers(playerid, "You are now adjusting the Door position of Flat ID: %d.", id);
		return 1;
	}
	else if(!strcmp(type, "point", true))
	{
	    new Float:konz[3];
	    new Float:radius;

		if(sscanf(string, "f", radius))
		    return Usage(playerid, "/editflat point [radius]");

	    GetPlayerPos(playerid, konz[0], konz[1], konz[2]);

		FlatData[id][flatTextPos][0] = konz[0];
		FlatData[id][flatTextPos][1] = konz[1];
		FlatData[id][flatTextPos][2] = konz[2];
		FlatData[id][flatPoint][3] = radius;
		Servers(playerid, "You've adjusted Point of Flat ID %d", id);
		Flat_Refresh(id);
		Flat_Save(id);
	}
	else if(!strcmp(type, "price", true))
	{
	    new harga;
	    if(sscanf(string, "d", harga))
	        return Error(playerid, "/editflat price [price]");

		FlatData[id][flatPrice] = harga;
		Flat_Refresh(id);
		Flat_Save(id);
	}
	else if (!strcmp(type, "textpoint", true))
	{
		new Float:pos[3];

		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		FlatData[id][flatPoint][0] = pos[0];
		FlatData[id][flatPoint][1] = pos[1];
		FlatData[id][flatPoint][2] = pos[2];

		Servers(playerid, "You've adjusted Flat Text Point of id %d", id);
		Flat_Save(id);
		Flat_Refresh(id);
	}
	return 1;
}
