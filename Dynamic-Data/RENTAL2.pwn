

//Rental
#define MAX_RENTAL 500

enum E_RENTAL
{
	Float:rExtposX,
	Float:rExtposY,
	Float:rExtposZ,
	Float:rExtposA,
	Float:rVehposX,
	Float:rVehposY,
	Float:rVehposZ,
	Float:rVehposA,
	rPrice,
	//Not Saved
	rPickup,
	Text3D:rLabel,
	rType
};

new rnData[MAX_RENTAL][E_RENTAL],
	Iterator: Rental<MAX_RENTAL>;

Rental_Save(id)
{
	new cQuery[2248];
	format(cQuery, sizeof(cQuery), "UPDATE rental SET type='%d', price='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', vehposx='%f', vehposy='%f', vehposz='%f', vehposa='%f' WHERE id='%d'",
	rnData[id][rType],
	rnData[id][rPrice],
	rnData[id][rExtposX],
	rnData[id][rExtposY],
	rnData[id][rExtposZ],
	rnData[id][rExtposA],
	rnData[id][rVehposX],
	rnData[id][rVehposY],
	rnData[id][rVehposZ],
	rnData[id][rVehposA],
	id);

	return mysql_tquery(g_SQL, cQuery);
}

Rental_BuyMenu(playerid, rentalid)
{
    if(rentalid <= -1 )
        return 0;

    switch(rnData[rentalid][rType])
    {
        case 1:
        {
			if(rnData[rentalid][rVehposX] == 0 && rnData[rentalid][rVehposY] == 0 && rnData[rentalid][rVehposZ] == 0)
				return Error(playerid, "Rental ini belum memiliki spawn point kendaraan.");

			new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t"LG_E"%s / one days\n%s\t"LG_E"%s / one days\n%s\t"LG_E"%s / one days",
			GetVehicleModelName(509), 
			FormatMoney(rnData[rentalid][rPrice]),
			GetVehicleModelName(481),
			FormatMoney(rnData[rentalid][rPrice]),
			GetVehicleModelName(510),
			FormatMoney(rnData[rentalid][rPrice])
			);

			ShowPlayerDialog(playerid, DIALOG_RENTBIKES, DIALOG_STYLE_LIST, "Rent Bikes", str, "Rent", "Close");
        }
        case 2:
        {
			if(rnData[rentalid][rVehposX] == 0 && rnData[rentalid][rVehposY] == 0 && rnData[rentalid][rVehposZ] == 0)
				return Error(playerid, "Rental ini belum memiliki spawn point kendaraan.");

			new str[1024];
			format(str, sizeof(str), ""WHITE_E"%s\t"LG_E"%s / one days\n%s\t"LG_E"%s / one days\n%s\t"LG_E"%s / one days\n%s\t"LG_E"%s / one days",
			GetVehicleModelName(453), 
			FormatMoney(rnData[rentalid][rPrice]),
			GetVehicleModelName(454),
			FormatMoney(rnData[rentalid][rPrice]),
			GetVehicleModelName(484),
			FormatMoney(rnData[rentalid][rPrice]),
			GetVehicleModelName(595),
			FormatMoney(rnData[rentalid][rPrice])
			);

			ShowPlayerDialog(playerid, DIALOG_RENTBOAT, DIALOG_STYLE_LIST, "Rent Boat", str, "Rent", "Close");
        }
    }
    return 	1;
}

Rental_Refresh(id)
{
    if(id != -1)
    {
    	if(IsValidDynamicPickup(rnData[id][rPickup]))
            DestroyDynamicPickup(rnData[id][rPickup]);

        if(IsValidDynamic3DTextLabel(rnData[id][rLabel]))
            DestroyDynamic3DTextLabel(rnData[id][rLabel]);

        static
        string[255], type[128];

        if(rnData[id][rType] == 1)
        {
        	type = "Bikes";
        }
        else if(rnData[id][rType] == 2)
        {
        	type = "Boat";
        }
        else
        {
        	type = "Unknown";
        }
		format(string, sizeof(string), "[Rental ID: %d]\n"WHITE_E"Rental Type: "YELLOW_E"%s\n"WHITE_E"use "YELLOW_E"/rentveh "WHITE_E"for rent a vehicle", id, type);
		rnData[id][rPickup] = CreateDynamicPickup(1239, 23, rnData[id][rExtposX], rnData[id][rExtposY], rnData[id][rExtposZ]+0.2, 0, 0, _, 50.0);
		rnData[id][rLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, rnData[id][rExtposX], rnData[id][rExtposY], rnData[id][rExtposZ]+0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    }
    return 1;
}

function LoadRental()
{
    static rnid;
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", rnid);
			cache_get_value_name_int(i, "type", rnData[rnid][rType]);
			cache_get_value_name_int(i, "price", rnData[rnid][rPrice]);
			cache_get_value_name_float(i, "extposx", rnData[rnid][rExtposX]);
			cache_get_value_name_float(i, "extposy", rnData[rnid][rExtposY]);
			cache_get_value_name_float(i, "extposz", rnData[rnid][rExtposZ]);
			cache_get_value_name_float(i, "extposa", rnData[rnid][rExtposA]);
			cache_get_value_name_float(i, "vehposx", rnData[rnid][rVehposX]);
			cache_get_value_name_float(i, "vehposy", rnData[rnid][rVehposY]);
			cache_get_value_name_float(i, "vehposz", rnData[rnid][rVehposZ]);
			cache_get_value_name_float(i, "vehposa", rnData[rnid][rVehposA]);
			Rental_Refresh(rnid);
			Iter_Add(Rental, rnid);
		}
		printf("[Rental] Number of Loaded: %d.", rows);
	}
}

//------------[ Bisnis Command ]------------
CMD:createrent(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new query[512];
	new rnid = Iter_Free(Rental), address[128];
	if(rnid == -1) return Error(playerid, "You cant create more door!");
	
	new type;
	if(sscanf(params, "dd", type))
	 return Usage(playerid, "/createrental [type 1.Rental Bikes 2.Rental Boat]");

	if(type < 0 || type > 2)
		return Error(playerid, "You have specified an invalid rental type 1 - 2.");

	GetPlayerPos(playerid, rnData[rnid][rExtposX], rnData[rnid][rExtposY], rnData[rnid][rExtposZ]);
	GetPlayerFacingAngle(playerid, rnData[rnid][rExtposA]);
	address = GetLocation(rnData[rnid][rExtposX], rnData[rnid][rExtposY], rnData[rnid][rExtposZ]);
	rnData[rnid][rType] = type;
	rnData[rnid][rPrice] = 1000;

    Rental_Refresh(rnid);
	Iter_Add(Rental, rnid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO rental SET id='%d', type='%d', price='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f'", rnid, rnData[rnid][rType], rnData[rnid][rPrice], rnData[rnid][rExtposX], rnData[rnid][rExtposY], rnData[rnid][rExtposZ], rnData[rnid][rExtposA]);
	mysql_tquery(g_SQL, query, "OnRentalCreated", "i", rnid);
	return 1;
}

function OnRentalCreated(rnid)
{
	Rental_Save(rnid);
	return 1;
}

CMD:gotorent(playerid, params[])
{
	static
        rnid,
        type[24];

	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
    if(sscanf(params, "ds[24]S()[128]", rnid, type))
    {
        Usage(playerid, "/gotorental [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} pickup, spawnveh");
        return 1;
    }
	if(!Iter_Contains(Rental, rnid))
		return Error(playerid, "The Rental you specified ID of doesn't exist.");

	if(!strcmp(type, "pickup", true))
	{
		SetPlayerPosition(playerid, rnData[rnid][rExtposX], rnData[rnid][rExtposY], rnData[rnid][rExtposZ], rnData[rnid][rExtposA]);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 0);
		SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to rental pickup id %d", rnid);
		pData[playerid][pInDoor] = -1;
		pData[playerid][pInHouse] = -1;
		pData[playerid][pInBiz] = -1;
	}
	else if(!strcmp(type, "spawnveh", true))
	{
		SetPlayerPosition(playerid, rnData[rnid][rVehposX], rnData[rnid][rVehposY], rnData[rnid][rVehposZ], rnData[rnid][rVehposA]);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 0);
		SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to rental spawn vehice point id %d", rnid);
		pData[playerid][pInDoor] = -1;
		pData[playerid][pInHouse] = -1;
		pData[playerid][pInBiz] = -1;
	}
	return 1;
}

CMD:editrent(playerid, params[])
{
    static
        rnid,
        type[24],
        string[128];

	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");

    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", rnid, type, string))
    {
        Usage(playerid, "/editrental [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, spawnpoint, type, price, delete");
        return 1;
    }
    if((rnid < 0 || rnid >= MAX_RENTAL))
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Rental, rnid)) 
		return Error(playerid, "The rental you specified ID of doesn't exist.");

	if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, rnData[rnid][rExtposX], rnData[rnid][rExtposY], rnData[rnid][rExtposZ]);
		GetPlayerFacingAngle(playerid, rnData[rnid][rExtposA]);
        Rental_Save(rnid);
		Rental_Refresh(rnid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of rental ID: %d.", pData[playerid][pAdminname], rnid);
    }
    else if(!strcmp(type, "spawnpoint", true))
    {
		GetPlayerPos(playerid, rnData[rnid][rVehposX], rnData[rnid][rVehposY], rnData[rnid][rVehposZ]);
		GetPlayerFacingAngle(playerid, rnData[rnid][rVehposA]);
        Rental_Save(rnid);
		Rental_Refresh(rnid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the spawn vehicle point of rental ID: %d.", pData[playerid][pAdminname], rnid);
    }
    else if(!strcmp(type, "type", true))
    {
        new types;

        if(sscanf(string, "d", types))
            return Usage(playerid, "/editrental [id] [Type] [1.Rental Bikes 2.Rental Boat]");

        if(0 < types || types > 2)
        	return Error(playerid, "Rental type only 1-2");

        rnData[rnid][rType] = types;
        Rental_Save(rnid);
		Rental_Refresh(rnid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the type of rental ID: %d to %d.", pData[playerid][pAdminname], rnid, types);
    }
    else if(!strcmp(type, "price", true))
    {
        new ammount;

        if(sscanf(string, "d", ammount))
            return Usage(playerid, "/editrental [id] [price] [ammount]");

        if(ammount < 0)
        	return Error(playerid, "Rental price tidak boleh dibawah $0");

        rnData[rnid][rPrice] = ammount;
        Rental_Save(rnid);
		Rental_Refresh(rnid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the price of rental ID: %d to %s.", pData[playerid][pAdminname], rnid, FormatMoney(ammount));
    }
	else if(!strcmp(type, "delete", true))
    {
		DestroyDynamic3DTextLabel(rnData[rnid][rLabel]);
        DestroyDynamicPickup(rnData[rnid][rPickup]);
		rnData[rnid][rType] = 0;
		rnData[rnid][rPrice] = 0;
		rnData[rnid][rExtposX] = 0;
		rnData[rnid][rExtposY] = 0;
		rnData[rnid][rExtposZ] = 0;
		rnData[rnid][rExtposA] = 0;
		rnData[rnid][rVehposX] = 0;
		rnData[rnid][rVehposY] = 0;
		rnData[rnid][rVehposZ] = 0;
		rnData[rnid][rVehposA] = 0;
		rnData[rnid][rLabel] = Text3D: INVALID_3DTEXT_ID;
		rnData[rnid][rPickup] = -1;
		
		Iter_Remove(Rental, rnid);

		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM rental WHERE id=%d", rnid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s has delete rental ID: %d.", pData[playerid][pAdminname], rnid);
	}
    return 1;
}

CMD:rentveh(playerid, params[])
{
	foreach(new rnid : Rental)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, rnData[rnid][rExtposX], rnData[rnid][rExtposY], rnData[rnid][rExtposZ]))
		{
			pData[playerid][pGetRENID] = rnid;
			Rental_BuyMenu(playerid, rnid);
		}
	}
	return 1;
}
/*	

----------//DIALOG ENUM RENTAL
	//DEALER SYSTEM
	DIALOG_RENTBOAT,
	DIALOG_RENTBOAT_CONFIRM,
	DIALOG_RENTBIKES,
	DIALOG_RENTAL_CONFIRM,





------------//ENUM PLAYER
pGetRENID,





-------------//DIALOG.PWN

	if(dialogid == DIALOG_RENTBIKES)
	{
		new renid = pData[playerid][pGetRENID];
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 509;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Bikes", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 481;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Bikes", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 510;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Bikes", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENTBOAT)
	{
		new renid = pData[playerid][pGetRENID];
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new modelid = 453;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Boat", tstr, "Rental", "Batal");
				}
				case 1:
				{
					new modelid = 454;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Boat", tstr, "Rental", "Batal");
				}
				case 2:
				{
					new modelid = 484;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Boat", tstr, "Rental", "Batal");
				}
				case 3:
				{
					new modelid = 595;
					new tstr[128];
					pData[playerid][pBuyPvModel] = modelid;
					format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s / one days", GetVehicleModelName(modelid), FormatMoney(rnData[renid][rPrice]));
					ShowPlayerDialog(playerid, DIALOG_RENTAL_CONFIRM, DIALOG_STYLE_MSGBOX, "Rental Boat", tstr, "Rental", "Batal");
				}
			}
		}
	}
	if(dialogid == DIALOG_RENTAL_CONFIRM)
	{
		new modelid = pData[playerid][pBuyPvModel], renid = pData[playerid][pGetRENID];
		if(response)
		{
			if(modelid <= 0)
				return Error(playerid, "Invalid model id.");

			new cost = rnData[renid][rPrice];
			if(pData[playerid][pMoney] < cost)
				return Error(playerid, "Uang anda tidak mencukupi.!");

			new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
			foreach(new ii : PVehicles)
			{
				if(pvData[ii][cOwner] == pData[playerid][pID])
					count++;
			}
			if(count >= limit)
			{
				Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
				return 1;
			}
			GivePlayerMoneyEx(playerid, -cost);
			new cQuery[1024];
			new Float:x,Float:y,Float:z, Float:a;
			new pid, model, color1, color2, rental;

			pid = pData[playerid][pID];
			color1 = 0;
			color2 = 0;
			model = modelid;
			x = rnData[renid][rVehposX];
			y = rnData[renid][rVehposY];
			z = rnData[renid][rVehposZ]+0.5;
			a = rnData[renid][rVehposA];
			rental = gettime() + (1 * 86400);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
			mysql_tquery(g_SQL, cQuery, "OnVehRenidPV", "ddddddffffd", playerid, pid, model, color1, color2, cost, x, y, z, a, rental);
			return 1;
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
	}




-----------//PRIVATE.pwn
function OnVehRenidPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a, rental)
{
	new i = Iter_Free(PVehicles);
	new renid = pData[playerid][pGetRENID];
	
	pvData[i][cID] = cache_insert_id();
	pvData[i][cOwner] = pid;
	pvData[i][cModel] = model;
	pvData[i][cColor1] = color1;
	pvData[i][cColor2] = color2;
	pvData[i][cPaintJob] = -1;
	pvData[i][cNeon] = 0;
	pvData[i][cTogNeon] = 0;
	pvData[i][cLocked] = 0;
	pvData[i][cInsu] = 3;
	pvData[i][cClaim] = 0;
	pvData[i][cClaimTime] = 0;
	pvData[i][cTicket] = 0;
	pvData[i][cPrice] = cost;
	pvData[i][cHealth] = 1000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "None");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cComponent] = 0;
	pvData[i][cMoney] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cRent] = rental;

	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;

	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);

	SetPlayerRaceCheckpoint(playerid, 1, x, y, z, 0.0, 0.0, 0.0, 3.5);
	Servers(playerid, "Anda telah menyewa kendaraan selama 1 hari dengan harga %s model %s(%d)", FormatMoney(rnData[renid][rPrice]), GetVehicleModelName(model), model);
	Info(playerid, "Pergi menuju checkpoint untuk mengambil kendaraan yang sudah disewa");

	new Float:PX, Float:PY, Float:PZ;
	GetPlayerPos(playerid, PX, PY, PZ);
	SetPlayerPos(playerid, PX, PY, PZ+0.5);

	pData[playerid][pGetRENID] = -1;
	return 1;
}