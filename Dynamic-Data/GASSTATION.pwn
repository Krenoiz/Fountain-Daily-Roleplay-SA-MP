#define MAX_GSTATION 50


enum gsinfo
{
    gOwner[MAX_PLAYER_NAME],
    gPrice,
	gsStock,
	gName[128],
	gMoney,
	gStockPrice,
	gRestock,
	Float:gsPosX,
	Float:gsPosY,
	Float:gsPosZ,
	STREAMER_TAG_3D_TEXT_LABEL:gsLabel,
	gMapIcon,
	gsPickup
};

new gsData[MAX_GSTATION][gsinfo],
	Iterator: GStation<MAX_GSTATION>;


GStation_Refresh(gsid)
{
	if(gsid != -1)
    {
		if(IsValidDynamic3DTextLabel(gsData[gsid][gsLabel]))
		{
			DestroyDynamic3DTextLabel(gsData[gsid][gsLabel]);
			gsData[gsid][gsLabel] = STREAMER_TAG_3D_TEXT_LABEL: -1;
		}

        if(IsValidDynamicPickup(gsData[gsid][gsPickup]))
            DestroyDynamicPickup(gsData[gsid][gsPickup]);
            
        if(IsValidDynamicMapIcon(gsData[gsid][gMapIcon]))
			DestroyDynamicMapIcon(gsData[gsid][gMapIcon]);


        static
        string[255];

        if(strcmp(gsData[gsid][gOwner], "-"))
		{
			format(string, sizeof(string), "[ID: %d]\n"WHITE_E"Name: "YELLOW_E"%s\n"WHITE_E"Owned by "LG_E"%s\n"WHITE_E"Stock "YELLOW_E"%dL\n"WHITE_E"PriceGas "YELLOW_E"%s\n"WHITE_E"Type '"RED_E"/fill"WHITE_E"' to refill", gsid, gsData[gsid][gName], gsData[gsid][gOwner], gsData[gsid][gsStock], FormatMoney(gsData[gsid][gStockPrice]));
            gsData[gsid][gsLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.5, 10.5);
			gsData[gsid][gsPickup] = CreateDynamicPickup(1650, 23,  gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.2, 0, 0, _, 10.0);
        }
        else
        {
            format(string, sizeof(string), "[ID: %d]\n"YELLOW_E"This gas for sell\n{FFFFFF}PriceGas: "AQUA"%s\n{FFFFFF}Price: {FFFF00}%s\n"WHITE_E"use command '"YELLOW_E"/buy"WHITE_E"' to purchase\n"WHITE_E"Type '"RED_E"/fill"WHITE_E"' to refill", gsid, FormatMoney(gsData[gsid][gStockPrice]), FormatMoney(gsData[gsid][gPrice]));
            gsData[gsid][gsLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.5, 10.5);
			gsData[gsid][gsPickup] = CreateDynamicPickup(1650, 23,  gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.2, 0, 0, _, 10.0);
        }
        gsData[gsid][gMapIcon] = CreateDynamicMapIcon(gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ], 63, 1, -1, -1, -1, 50000.0);
	}
    return 1;
}

function LoadGStations()
{
    static gsid;
	
	new rows = cache_num_rows(), owner[128], name[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{   cache_get_value_name_int(i, "id", gsid);
   			cache_get_value_name(i, "owner", owner);
			format(gsData[gsid][gOwner], 128, owner);
			cache_get_value_name(i, "name", name);
			format(gsData[gsid][gName], 128, name);
			cache_get_value_name_int(i, "price", gsData[gsid][gPrice]);
			cache_get_value_name_int(i, "money", gsData[gsid][gMoney]);
  			cache_get_value_name_int(i, "stockprice", gsData[gsid][gStockPrice]);
  			cache_get_value_name_int(i, "restock", gsData[gsid][gRestock]);
			cache_get_value_name_int(i, "stock", gsData[gsid][gsStock]);
			cache_get_value_name_float(i, "posx", gsData[gsid][gsPosX]);
			cache_get_value_name_float(i, "posy", gsData[gsid][gsPosY]);
			cache_get_value_name_float(i, "posz", gsData[gsid][gsPosZ]);
			GStation_Refresh(gsid);
			Iter_Add(GStation, gsid);
		}
		printf("[Dynamic Gas Station] Number of Loaded: %d.", rows);
	}
}

GStation_Save(gsid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE gstations SET owner='%s', name='%s', price='%d', money='%d', stockprice='%d', stock='%d', restock='%d', posx='%f', posy='%f', posz='%f' WHERE id='%d'",
	gsData[gsid][gOwner],
	gsData[gsid][gName],
	gsData[gsid][gPrice],
	gsData[gsid][gMoney],
	gsData[gsid][gStockPrice],
	gsData[gsid][gsStock],
	gsData[gsid][gRestock],
	gsData[gsid][gsPosX],
	gsData[gsid][gsPosY],
	gsData[gsid][gsPosZ],
	gsid
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:creategs(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new gsid = Iter_Free(GStation), query[128];
	if(gsid == -1) return Error(playerid, "You cant create more gs!");
	new stok, price;
	if(sscanf(params, "d", price, stok)) return Usage(playerid, "/creategs [stock - max: 10000/liters]");
	
//	if(stok < 1 || stok > 1000) return Error(playerid, "Invagsid stok.");
	
	GetPlayerPos(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
	gsData[gsid][gsStock] = stok;
	gsData[gsid][gPrice] = price;
    GStation_Refresh(gsid);
	Iter_Add(GStation, gsid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gstations SET id='%d', stock='%d', posx='%f', posy='%f', posz='%f'", gsid, gsData[gsid][gsStock], gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
	mysql_tquery(g_SQL, query, "OnGstationCreated", "i", gsid);
	return 1;
}

function OnGstationCreated(gsid)
{
	GStation_Save(gsid);
	return 1;
}
/*GetOwnedGas(playerid)
{
	new tmpcount;
	foreach(new id : GStation)
	{
	    if(!strcmp(gsData[id][gOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}*/
/*ReturnPlayerGasID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > LIMIT_PER_PLAYER) return -1;
	foreach(new id : GStation)
	{
	    if(!strcmp(pData[playerid][pName], gsData[id][gOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}*/

PlayerOwnsGas(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(id == -1) return 0;
	if(!strcmp(gsData[id][gOwner], pData[playerid][pName], true)) return 1;
	return 0;
}

/*Player_GasCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new id : GStation)
	{
		if(PlayerOwnsGas(playerid, id)) count++;
	}
	return count;
	#else
		return 0;
	#endif
}*/
CMD:gs(playerid, params[])
{
	foreach(new id : GStation)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]))
		{
			pData[playerid][pInGas] = id;
			if(!PlayerOwnsGas(playerid, id)) return Error(playerid, "Gas Station ini bukan milik anda!");
			ShowPlayerDialog(playerid, GAS_MENU, DIALOG_STYLE_LIST, "Gas Station Manage", "Gas Information\nGas Change Name\nGas Vault\nGas SetPrice\nRestock Gas", "Select", "Cancel");
		}
	}
	return 1;
}
CMD:gotogs(playerid, params[])
{
	new gsid;
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", gsid))
		return Usage(playerid, "/gotogs [id]");
		
	if(!Iter_Contains(GStation, gsid)) return Error(playerid, "The gs you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ], 2.0);
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	Servers(playerid, "You has teleport to gs id %d", gsid);
	return 1;
}

CMD:editgs(playerid, params[])
{
    static
        gsid,
        type[24],
        string[128];

	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");

    if(pData[playerid][pAdmin] < 201)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", gsid, type, string))
    {
        Usage(playerid, "/editgs [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, stock, delete");
        return 1;
    }
    if((gsid < 0 || gsid >= MAX_GSTATION))
        return Error(playerid, "You have specified an invagsid ID.");
	if(!Iter_Contains(GStation, gsid)) return Error(playerid, "The doors you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
        GStation_Save(gsid);
		GStation_Refresh(gsid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of gs ID: %d.", pData[playerid][pAdminname], gsid);
    }
    else if(!strcmp(type, "stock", true))
    {
        new stok;

        if(sscanf(string, "d", stok))
            return Usage(playerid, "/editgs [id] [type] [stock - 10000]");

        if(stok < 1 || stok > 10000)
            return Error(playerid, "You must specify at least 1 - 5.");

        gsData[gsid][gsStock] = stok;
        GStation_Save(gsid);
		GStation_Refresh(gsid);

        SendAdminMessage(COLOR_RED, "%s has set gs ID: %d stock to %d.", pData[playerid][pAdminname], gsid, stok);
    }
    else if(!strcmp(type, "owner", true))
    {
        new owners[MAX_PLAYER_NAME];

        if(sscanf(string, "s[32]", owners))
            return Usage(playerid, "/editbisnis [id] [owner] [player name] (use '-' to no owner)");

        format(gsData[gsid][gOwner], MAX_PLAYER_NAME, owners);

        GStation_Save(gsid);
		GStation_Refresh(gsid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of bisnis ID: %d to %s", pData[playerid][pAdminname], gsid, owners);
    }
    else if(!strcmp(type, "delete", true))
    {
		new query[128];
		DestroyDynamic3DTextLabel(gsData[gsid][gsLabel]);
		DestroyDynamicPickup(gsData[gsid][gsPickup]);
		DestroyDynamicMapIcon(gsData[gsid][gMapIcon]);
		gsData[gsid][gsPosX] = 0;
		gsData[gsid][gsPosY] = 0;
		gsData[gsid][gsPosY] = 0;
		gsData[gsid][gsStock] = 0;
		gsData[gsid][gsLabel] = Text3D: INVALID_3DTEXT_ID;
		gsData[gsid][gsPickup] = -1;
		Iter_Remove(GStation, gsid);
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gstations WHERE id=%d", gsid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s has delete gs ID: %d.", pData[playerid][pAdminname], gsid);
    }
    return 1;
}
CMD:fill(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return Error(playerid, "You must be driving a vehicle with the engine on.");

    new vehid = GetPlayerVehicleID(playerid);
    if(!IsEngineVehicle(vehid))
        return Error(playerid, "You are not in an engine vehicle.");

    if(GetEngineStatus(vehid))
        return Error(playerid, "Turn off the vehicle engine before refueling.");

    if(GetVehicleFuel(vehid) >= 1999.0)
        return Error(playerid, "The vehicle's fuel tank is full.");

    if(pData[playerid][pFill] != -1)
        return Error(playerid, "You are already filling up the vehicle. Please wait!");

    foreach(new gsid : GStation)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.5, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
        {
            if(gsData[gsid][gsStock] < 1)
                return Error(playerid, "This gas station is out of stock!");

            new currentFuel = GetVehicleFuel(vehid);
            new fuelNeeded = 2000 - currentFuel;
            new totalCost = fuelNeeded / 10 * gsData[gsid][gStockPrice];

            if(pData[playerid][pMoney] < totalCost)
                return Error(playerid, "You do not have enough money. You need $%d.", totalCost);

            pData[playerid][pFill] = gsid;
            pData[playerid][pFillStatus] = 1;
            pData[playerid][pFillPrice] = totalCost;  
            gsData[gsid][gMoney] += totalCost; 
            pData[playerid][pFillTime] = SetTimerEx("Filling", 500, true, "i", playerid);
			GStation_Save(gsid);
            return 1; 
        }
    }
    return Error(playerid, "You are not near any gas station.");
}
function Filling(playerid)
{
    if (pData[playerid][pFillStatus] != 1)
        return 0;

    new vehid = GetPlayerVehicleID(playerid);
    foreach (new gsid : GStation)
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.5, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
        {
            if (GetEngineStatus(vehid) || GetVehicleFuel(vehid) >= 1999.0 || GetPlayerMoney(playerid) < gsData[gsid][gStockPrice])
            {
                StopFilling(playerid);
                return 1;
            }

            new oldFuel = GetVehicleFuel(vehid);
            if (oldFuel < 2000.0)
            {
                new fuelToAdd = 100;
                if (oldFuel + fuelToAdd > 2000.0) 
                    fuelToAdd = 2000 - oldFuel; 

                SetVehicleFuel(vehid, oldFuel + fuelToAdd);
                pData[playerid][pFillPrice] += gsData[gsid][gStockPrice]; 
                gsData[gsid][gsStock] -= 1;  

                if (pData[playerid][pMoney] >= gsData[gsid][gStockPrice])
                {
                    pData[playerid][pMoney] -= gsData[gsid][gStockPrice];
                }
                else
                {
    
                    StopFilling(playerid);
                    return 1;
                }

                if (GetVehicleFuel(vehid) >= 1999)
                {
                    SetVehicleFuel(vehid, 2000);
                    StopFilling(playerid);
                    return 1;
                }

                return 1; 
            }
        }
    }
    StopFilling(playerid);
    return 1;
}

function StopFilling(playerid)
{
    pData[playerid][pFill] = -1;
    pData[playerid][pFillStatus] = 0;
    pData[playerid][pFillPrice] = 0;

    KillTimer(pData[playerid][pFillTime]);
    pData[playerid][pFillTime] = -1;
}

// StopFilling(playerid)
// {
//     new gsid = pData[playerid][pFill];
//     GivePlayerMoneyEx(playerid, -pData[playerid][pFillPrice]);
//     GStation_Refresh(gsid);
//     Info(playerid, "Your vehicle's tank has been filled. You paid "RED_E"%s.", FormatMoney(pData[playerid][pFillPrice]));
//     KillTimer(pData[playerid][pFillTime]);
//     pData[playerid][pFillStatus] = 0;
//     pData[playerid][pFillPrice] = 0;
//     pData[playerid][pFill] = -1;
//     return 1;
// }

// function Filling(playerid)
// {
//     if(pData[playerid][pFillStatus] != 1)
//         return 0;

//     new vehid = GetPlayerVehicleID(playerid);
//     foreach(new gsid : GStation)
//     {
//         if(IsPlayerInRangeOfPoint(playerid, 4.0, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
//         {
//             if(GetEngineStatus(vehid) || GetVehicleFuel(vehid) >= 1999.0 || GetPlayerMoney(playerid) < gsData[gsid][gStockPrice])
//             {
//                 StopFilling(playerid);
//                 return 1;
//             }

//             new oldFuel = GetVehicleFuel(vehid);
//             SetVehicleFuel(vehid, oldFuel + 10);
//             pData[playerid][pFillPrice] += gsData[gsid][gStockPrice];
//             gsData[gsid][gsStock] -= 1;

//             if(GetVehicleFuel(vehid) >= 1999.0)
//             {
//                 SetVehicleFuel(vehid, 2000);
//                 StopFilling(playerid);
//                 return 1;
//             }

//             return 1; 
//         }
//     }
//     StopFilling(playerid); 
//     return 1;
// }



 
/*upgrade()
{
   foreach(new i : PVehicles)
   {
   	
   SetVehicleMaxFuel(i);
 }
   return 1;
 }*/
