#include <YSI_Coding\y_hooks>

#define MAX_DEALERSHIP 100

enum DealerVariabel
{
	dealerOwner[MAX_PLAYER_NAME],
	dealerOwnerID,
	dealerName[128],
	dealerPrice,
	dealerType,
	dealerLocked,
	dealerMoney,
	dVisit,
	dP[10],
	Float:dealerPosX,
	Float:dealerPosY,
	Float:dealerPosZ,
	Float:dealerPosA,
	Float:dealerPointX,
	Float:dealerPointY,
	Float:dealerPointZ,
	Float:dealerPointA,
	dealerStock,
	dealerRestock,

	// Hooked by DealerRefresh
	dealerPickup,
	dealerPickupPoint,
	dealerMap,
	Text3D:dealerLabel,
	Text3D:dealerPointLabel,
};

new DealerData[MAX_DEALERSHIP][DealerVariabel];
new Iterator:Dealer<MAX_DEALERSHIP>;

GetAnyDealer()
{
	new tmpcount;
	foreach(new id : Dealer)
	{
     	tmpcount++;
	}
	return tmpcount;
}


ReturnDealershipID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_DEALERSHIP) return -1;
	foreach(new id : Dealer)
	{
        tmpcount++;
        if(tmpcount == slot)
        {
            return id;
        }
	}
	return -1;
}

CMD:editdealer(playerid, params[])
{
    static
        did,
        type[24],
        string[128];

	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");

    if(pData[playerid][pAdmin] < 201)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", did, type, string))
    {
        Usage(playerid, "/editdealer [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, point, price, type, stock, restock, reset");
        return 1;
    }
    if((did < 0 || did > MAX_DEALERSHIP))
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, did)) return Error(playerid, "The dealership you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, DealerData[did][dealerPosX], DealerData[did][dealerPosY], DealerData[did][dealerPosZ]);
		GetPlayerFacingAngle(playerid, DealerData[did][dealerPosA]);
        DealerSave(did);
		DealerRefresh(did);

        SendAdminMessage(COLOR_RED, "%s Changes Location Dealer ID: %d.", pData[playerid][pAdminname], did);
    }
	else if(!strcmp(type, "owner", true))
    {
		new otherid;
        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/editdealer [id] [owner] [playerid] (use '-1' to no owner/ reset)");
		if(otherid == -1)
			return format(DealerData[did][dealerOwner], MAX_PLAYER_NAME, "-");

        format(DealerData[did][dealerOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
		DealerData[did][dealerOwnerID] = pData[otherid][pID];

		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE dealership SET owner='%s', ownerid='%d' WHERE ID='%d'", DealerData[did][dealerOwner], DealerData[did][dealerOwnerID], did);
		mysql_tquery(g_SQL, query);

		DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of dealership ID: %d to %s", pData[playerid][pAdminname], did, pData[otherid][pName]);
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/editdealer [id] [Price] [Amount]");

        DealerData[did][dealerPrice] = price;

        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Changes Price Of The Dealer ID: %d to %d.", pData[playerid][pAdminname], did, price);
    }
	else if(!strcmp(type, "type", true))
    {
        new dtype;

        if(sscanf(string, "d", dtype))
            return Usage(playerid, "/editdealer [id] [Type] [1.Motorcycle 2.Cars 3.Unique Cars 4.Job Cars 5.Truck]");

        DealerData[did][dealerType] = dtype;
        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Changes Type Of The Dealer ID: %d to %d.", pData[playerid][pAdminname], did, dtype);
    }
    else if(!strcmp(type, "stock", true))
    {
        new dStock;
        if(sscanf(string, "d", dStock))
            return Usage(playerid, "/editdealer [id] [stock]");

        DealerData[did][dealerStock] = dStock;
        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Set Stock Of The Dealer ID: %d with stock %d.", pData[playerid][pAdminname], did, dStock);
    }
	else if(!strcmp(type, "restock", true))
    {
        new dRstock;
        if(sscanf(string, "d", dRstock))
            return Usage(playerid, "/editdealer [id] [restock]");

        DealerData[did][dealerStock] = dRstock;
        DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Set Restock Of The Dealer ID: %d with restock %d.", pData[playerid][pAdminname], did, dRstock);
    }
    else if(!strcmp(type, "reset", true))
    {
        DealerReset(did);
		DealerSave(did);
		DealerRefresh(did);
        SendAdminMessage(COLOR_RED, "%s has reset dealer ID: %d.", pData[playerid][pAdminname], did);
    }
	else if(!strcmp(type, "point", true))
    {
		new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, Float:a);
		DealerData[did][dealerPointX] = x;
		DealerData[did][dealerPointY] = y;
		DealerData[did][dealerPointZ] = z;
		DealerSave(did);
		DealerPointRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Change Point Of The Dealer ID: %d.", pData[playerid][pAdminname], did);
    }
    return 1;
}

CMD:createdealer(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new query[512];
	new dealerid = Iter_Free(Dealer), address[128];

	new price, type;
	if(sscanf(params, "dd", price, type))
		return Usage(playerid, "/createdealer [price] [type 1.Motorcycle 2.Cars 3.Unique Cars 4. Jobs Vehicle 5. Truck]");

	if(dealerid == -1)
		return Error(playerid, "You cant create more dealership");

	if((dealerid < 0 || dealerid >= MAX_DEALERSHIP))
        return Error(playerid, "You have already input 15 dealership in this server.");

	if(type > 5 || type < 0)
		return Error(playerid, "Invalid dealership Type");

	format(DealerData[dealerid][dealerOwner], 128, "-");
	DealerData[dealerid][dealerOwnerID] = 0;
	GetPlayerPos(playerid, DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]);
	GetPlayerFacingAngle(playerid, DealerData[dealerid][dealerPosA]);

	DealerData[dealerid][dealerPrice] = price;
	DealerData[dealerid][dealerType] = type;

	address = GetLocation(DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]);
	format(DealerData[dealerid][dealerName], 128, address);

	DealerData[dealerid][dealerLocked] = 1;
	DealerData[dealerid][dealerMoney] = 0;
	DealerData[dealerid][dealerStock] = 0;
	DealerData[dealerid][dealerRestock] = 0;
	DealerData[dealerid][dP][0] = 0;
	DealerData[dealerid][dP][1] = 0;
	DealerData[dealerid][dP][2] = 0;
	DealerData[dealerid][dP][3] = 0;
	DealerData[dealerid][dP][4] = 0;
	DealerData[dealerid][dP][5] = 0;
	DealerData[dealerid][dP][6] = 0;
	DealerData[dealerid][dP][7] = 0;
	DealerData[dealerid][dP][8] = 0;
	DealerData[dealerid][dP][9] = 0;

	Iter_Add(Dealer, dealerid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO dealership SET ID='%d', owner='%s', ownerid='%d',price='%d', type='%d', posx='%f', posy='%f', posz='%f', posa='%f', name='%s'", dealerid, DealerData[dealerid][dealerOwner],dealerid, DealerData[dealerid][dealerOwnerID], DealerData[dealerid][dealerPrice], DealerData[dealerid][dealerType], DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ], DealerData[dealerid][dealerPosA], DealerData[dealerid][dealerName]);
	mysql_tquery(g_SQL, query, "OnDealerCreated", "i", dealerid);
	return 1;
}

CMD:deletedealer(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/deletedealer [id]");

	if(bid < 0 || bid >= MAX_DEALERSHIP)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	DealerReset(bid);

	DestroyDynamic3DTextLabel(DealerData[bid][dealerLabel]);
	DestroyDynamic3DTextLabel(DealerData[bid][dealerPointLabel]);

    DestroyDynamicPickup(DealerData[bid][dealerPickup]);
    DestroyDynamicPickup(DealerData[bid][dealerPickupPoint]);

	DealerData[bid][dealerPosX] = 0;
	DealerData[bid][dealerPosY] = 0;
	DealerData[bid][dealerPosZ] = 0;
	DealerData[bid][dealerPosA] = 0;
	DealerData[bid][dealerPointX] = 0;
	DealerData[bid][dealerPointY] = 0;
	DealerData[bid][dealerPointZ] = 0;
	DealerData[bid][dealerPrice] = 0;
	DealerData[bid][dealerLabel] = Text3D:INVALID_3DTEXT_ID;
	DealerData[bid][dealerPointLabel] = Text3D:INVALID_3DTEXT_ID;
	DealerData[bid][dealerPickup] = -1;
	DealerData[bid][dealerPickupPoint] = -1;

	Iter_Remove(Dealer, bid);
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM dealership WHERE ID=%d", bid);
	mysql_tquery(g_SQL, query);
    SendAdminMessage(COLOR_RED, "%s has delete dealership ID: %d.", pData[playerid][pAdminname], bid);
    return 1;
}

CMD:gotodealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/gotodealer [id]");

	if(bid < 0 || bid >= MAX_DEALERSHIP)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	SetPlayerPos(playerid, DealerData[bid][dealerPosX], DealerData[bid][dealerPosY], DealerData[bid][dealerPosZ]);
	SetPlayerFacingAngle(playerid, DealerData[bid][dealerPosA]);

    SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to dealership id %d", bid);
    return 1;
}

CMD:gotodealerpoint(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/gotodealerpoint [id]");

	if(bid < 0 || bid >= MAX_DEALERSHIP)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	if(DealerData[bid][dealerPointX] == 0.0 && DealerData[bid][dealerPointY] == 0.0 && DealerData[bid][dealerPointZ] == 0.0)
		return Error(playerid, "That point is exists but doesnt have any position");

	SetPlayerPos(playerid, DealerData[bid][dealerPointX], DealerData[bid][dealerPointY], DealerData[bid][dealerPointZ]);

    SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to dealership id %d", bid);
    return 1;
}

CMD:buypv(playerid, params[])
{
	foreach(new dealerid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]) && strcmp(DealerData[dealerid][dealerOwner], "-") && DealerData[dealerid][dealerPointX] != 0.0 && DealerData[dealerid][dealerPointY] != 0.0 && DealerData[dealerid][dealerPointZ] != 0.0)
		{
			DealerBuyVehicle(playerid, dealerid);
		}
	}
	return 1;
}

CMD:dealermanage(playerid, params[])
{
	foreach(new dealerid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]))
		{
			if(!PlayerOwnsDealership(playerid, dealerid)) return Error(playerid, "Dealership ini bukan milik anda!");
			ShowPlayerDialog(playerid, DIALOG_DEALER_MANAGE, DIALOG_STYLE_LIST, "Dealer Manage", "Dealer Information\nDealer Change Name\nDealer Vault\nDealer RequestStock\nEdit Product", "Select", "Cancel");
		}
	}
	return 1;
}

/* ============ [ Stock goes here ] ============ */

DealerSave(id)
{
	new cQuery[2248];
	format(cQuery, sizeof(cQuery), "UPDATE dealership SET owner='%s', ownerID='%d', name='%s', price='%d', type='%d', locked='%d', money='%d', stock='%d', dprice0='%d', dprice1='%d', dprice2='%d', dprice3='%d', dprice4='%d', dprice5='%d', dprice6='%d', dprice7='%d', dprice8='%d', dprice9='%d', posx='%f', posy='%f', posz='%f', posa='%f', pointx='%f', pointy='%f', pointz='%f', dvisit='%d', restock='%d' WHERE ID='%d'",
	DealerData[id][dealerOwner],
	DealerData[id][dealerOwnerID],
	DealerData[id][dealerName],
	DealerData[id][dealerPrice],
	DealerData[id][dealerType],
	DealerData[id][dealerLocked],
	DealerData[id][dealerMoney],
	DealerData[id][dealerStock],
	DealerData[id][dP][0],
	DealerData[id][dP][1],
	DealerData[id][dP][2],
	DealerData[id][dP][3],
	DealerData[id][dP][4],
	DealerData[id][dP][5],
	DealerData[id][dP][6],
	DealerData[id][dP][7],
	DealerData[id][dP][8],
	DealerData[id][dP][9],
	DealerData[id][dealerPosX],
	DealerData[id][dealerPosY],
	DealerData[id][dealerPosZ],
	DealerData[id][dealerPosA],
	DealerData[id][dealerPointX],
	DealerData[id][dealerPointY],
	DealerData[id][dealerPointZ],
	DealerData[id][dVisit],
	DealerData[id][dealerRestock],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}
Player_OwnsDealer(playerid, id)
{
	return (DealerData[id][dealerOwnerID] == pData[playerid][pID]) || (!strcmp(DealerData[id][dealerOwner], pData[playerid][pName], true));
}
DealerPointRefresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamic3DTextLabel(DealerData[id][dealerPointLabel]))
        DestroyDynamic3DTextLabel(DealerData[id][dealerPointLabel]);

    	if(IsValidDynamicPickup(DealerData[id][dealerPickupPoint]))
        	DestroyDynamicPickup(DealerData[id][dealerPickupPoint]);

		new tstr[218];
		if(DealerData[id][dealerPointX] != 0 && DealerData[id][dealerPointY] != 0 && DealerData[id][dealerPointZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"%s Dealership Vehicle Spawn Point", id, DealerData[id][dealerName]);
			DealerData[id][dealerPointLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ], 5.0);
        	DealerData[id][dealerPickupPoint] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ]);
		}
		else if(DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"%s Dealership Vehicle Spawn Point", id, DealerData[id][dealerName]);
			DealerData[id][dealerPointLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ], 5.0);
        	DealerData[id][dealerPickupPoint] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPointX], DealerData[id][dealerPointY], DealerData[id][dealerPointZ]);
    	}
	}
}

// DealerRefresh(id)
// {
// 	if(id != -1)
// 	{
// 		if(IsValidDynamic3DTextLabel(DealerData[id][dealerLabel]))
//             DestroyDynamic3DTextLabel(DealerData[id][dealerLabel]);

//         if(IsValidDynamicPickup(DealerData[id][dealerPickup]))
//             DestroyDynamicPickup(DealerData[id][dealerPickup]);

//         DestroyDynamicMapIcon(bData[id][bMap]);

//         new type[128];
// 		if(DealerData[id][dealerType] == 1)
// 		{
// 			type= "Motorcycle";
// 		}
// 		else if(DealerData[id][dealerType] == 2)
// 		{
// 			type= "Cars";
// 		}
// 		else if(DealerData[id][dealerType] == 3)
// 		{
// 			type= "Unique Cars";
// 		}
// 		else if(DealerData[id][dealerType] == 4)
// 		{
// 			type= "Jobs Cars";
// 		}
// 		else if(DealerData[id][dealerType] == 5)
// 		{
// 			type= "Truck";
// 		}
// 		else
// 		{
// 			type= "Unknown";
// 		}

// 		new tstr[218];
// 		if(DealerData[id][dealerPosX] != 0 && DealerData[id][dealerPosY] != 0 && DealerData[id][dealerPosZ] != 0 && strcmp(DealerData[id][dealerOwner], "-")|| DealerData[id][dealerOwnerID] != 0)
// 		{
// 			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"Name: {FFFF00}%s\n"WHITE_E"Owned by %s\nType: "YELLOW_E"%s\n"WHITE_E"Use "RED_E"/buypv "WHITE_E"to buy vehicle in this dealership", id, DealerData[id][dealerName], DealerData[id][dealerOwner], type);
// 			DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(tstr, COLOR_LBLUE, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 5.0);
//             DealerData[id][dealerPickup] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]);
// 		}
// 		else if(DealerData[id][dealerPosX] != 0 && DealerData[id][dealerPosY] != 0 && DealerData[id][dealerPosZ] != 0)
// 		{
// 			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"This dealership for sell\nLocation: %s\nPrice: "GREEN_E"%s\n"WHITE_E"Type: "YELLOW_E"%s", id, GetLocation(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]), FormatMoney(DealerData[id][dealerPrice]), type);
// 			DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(tstr, COLOR_LBLUE, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 5.0);
//             DealerData[id][dealerPickup] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]);
//    		}

//         if(DealerData[id][dealerType] == 1)
// 		{
// 			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
// 		}
// 		else if(DealerData[id][dealerType] == 2)
// 		{
// 			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
// 		}
// 		else if(DealerData[id][dealerType] == 3)
// 		{
// 			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
// 		}
// 		else if(DealerData[id][dealerType] == 4)
// 		{
// 			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
// 		}
// 		else if(DealerData[id][dealerType] == 5)
// 		{
// 			DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
// 		}
// 		else
// 		{
// 			DestroyDynamicMapIcon(DealerData[id][dealerMap]);
// 		}
// 		printf("DEBUG: DealerRefresh Called on Dealer ID %d", id);
// 	}
// }
DealerRefresh(id)
{
    if (id != -1)
    {
        // Destroy existing dynamic objects if they exist
        if (IsValidDynamic3DTextLabel(DealerData[id][dealerLabel]))
            DestroyDynamic3DTextLabel(DealerData[id][dealerLabel]);

        if (IsValidDynamicPickup(DealerData[id][dealerPickup]))
            DestroyDynamicPickup(DealerData[id][dealerPickup]);

        if (IsValidDynamicMapIcon(DealerData[id][dealerMap]))
            DestroyDynamicMapIcon(DealerData[id][dealerMap]);

        // Determine the type of dealer
        new type[128];
        switch (DealerData[id][dealerType])
        {
            case 1: type = "Motorcycle";
            case 2: type = "Cars";
            case 3: type = "Unique Cars";
            case 4: type = "Jobs Cars";
            case 5: type = "Truck";
            default: type = "Unknown";
        }

        // Format the text based on dealer's state
        new tstr[218];
        if (DealerData[id][dealerPosX] != 0 && DealerData[id][dealerPosY] != 0 && DealerData[id][dealerPosZ] != 0)
        {
            if (strcmp(DealerData[id][dealerOwner], "-") != 0 || DealerData[id][dealerOwnerID] != 0)
            {
                format(tstr, sizeof(tstr), "[ID: %d]\n" WHITE_E "Name: {FFFF00}%s\n" WHITE_E "Owned by %s\nType: " YELLOW_E "%s\n" WHITE_E "Use " RED_E "/buypv " WHITE_E "to buy vehicle in this dealership",
                       id, DealerData[id][dealerName], DealerData[id][dealerOwner], type);
            }
            else
            {
                format(tstr, sizeof(tstr), "[ID: %d]\n" WHITE_E "This dealership for sale\nLocation: %s\nPrice: " GREEN_E "%s\n" WHITE_E "Type: " YELLOW_E "%s",
                       id, GetLocation(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]), FormatMoney(DealerData[id][dealerPrice]), type);
            }
            
            DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(tstr, COLOR_LBLUE, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 5.0);
            DealerData[id][dealerPickup] = CreateDynamicPickup(1239, 23, DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ]);

            DealerData[id][dealerMap] = CreateDynamicMapIcon(DealerData[id][dealerPosX], DealerData[id][dealerPosY], DealerData[id][dealerPosZ], 55, -1, -1, -1, -1, 70.0);
        }
        else
        {
            DestroyDynamicMapIcon(DealerData[id][dealerMap]);
        }

        printf("DEBUG: DealerRefresh Called on Dealer ID %d", id);
    }
}

DealerReset(id)
{
	format(DealerData[id][dealerOwner], MAX_PLAYER_NAME, "-");
	DestroyDynamicPickup(DealerData[id][dealerPickup]);
	DestroyDynamicPickup(DealerData[id][dealerPickupPoint]);
	DealerData[id][dealerOwnerID] = 0;
	DealerData[id][dealerLocked] = 1;
    DealerData[id][dealerMoney] = 0;
	DealerData[id][dealerStock] = 0;
	DealerData[id][dVisit] = 0;
	DealerData[id][dealerRestock] = 0;
	DealerData[id][dP][0] = 0;
	DealerData[id][dP][1] = 0;
	DealerData[id][dP][2] = 0;
	DealerData[id][dP][3] = 0;
	DealerData[id][dP][4] = 0;
	DealerData[id][dP][5] = 0;
	DealerData[id][dP][6] = 0;
	DealerData[id][dP][7] = 0;
	DealerData[id][dP][8] = 0;
	DealerData[id][dP][9] = 0;
	DealerRefresh(id);
}

PlayerOwnsDealership(playerid, id)
{
	// if(!IsPlayerConnected(playerid)) return 0;
	// if(id == -1) return 0;
	return (DealerData[id][dealerOwnerID] == pData[playerid][pName]) || (!strcmp(DealerData[id][dealerOwner], pData[playerid][pName], true));
	// return 0;
}

// Player_DealerCount(playerid)
// {
// 	#if LIMIT_PER_PLAYER != 0
//     new count;
// 	foreach(new i : Dealer)
// 	{
// 		if(PlayerOwnsDealership(playerid, i)) count++;
// 	}
// 	return count;
// 	#else
// 		return 0;
// 	#endif
// }

stock CountPlayerVehicles(playerid)
{
    new count = 0;
    foreach(new i : PVehicles)
    {
        if (pvData[i][cOwner] == pData[playerid][pID])
            count++;
    }
    return count;
}

Dealer_ProductMenu(playerid, dealerid)
{
    if(dealerid <= -1)
        return 0;

    static
        string[512];

    switch (DealerData[dealerid][dealerType])
    {
        case 1:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}BMX\t{7fff00}%s\n{ffffff}Bike\t{7fff00}%s\n{ffffff}Mountain Bike\t{7fff00}%s\n{ffffff}Faggio\t{7fff00}%s\n{ffffff}Wayfarer\t{7fff00}%s\n{ffffff}Bf-400\t{7fff00}%s\n{ffffff}PCJ-600\t{7fff00}%s\n{ffffff}FCR-900\t{7fff00}%s\n{ffffff}Freeway\t{7fff00}%s\n{ffffff}Sanchez\t{7fff00}%s",
                FormatMoney(DealerData[dealerid][dP][0]),
                FormatMoney(DealerData[dealerid][dP][1]),
                FormatMoney(DealerData[dealerid][dP][2]),
				FormatMoney(DealerData[dealerid][dP][3]),
                FormatMoney(DealerData[dealerid][dP][4]),
                FormatMoney(DealerData[dealerid][dP][5]),
				FormatMoney(DealerData[dealerid][dP][6]),
                FormatMoney(DealerData[dealerid][dP][7]),
                FormatMoney(DealerData[dealerid][dP][8]),
                FormatMoney(DealerData[dealerid][dP][9])
            );
            ShowPlayerDialog(playerid, DEALER_EDITPROD, DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
        case 2:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Landstalker\t{7fff00}%s\n{ffffff}Vodoo\t{7fff00}%s\n{ffffff}Esperanto\t{7fff00}%s\n{ffffff}Preimer\t{7fff00}%s\n{ffffff}Previon\t{7fff00}%s\n{ffffff}Glendale\t{7fff00}%s\n{ffffff}Oceanic\t{7fff00}%s\n{ffffff}Hermes\t{7fff00}%s\n{ffffff}Sabre\t{7fff00}%s\n{ffffff}Comet\t{7fff00}%s",
                FormatMoney(DealerData[dealerid][dP][0]),
                FormatMoney(DealerData[dealerid][dP][1]),
                FormatMoney(DealerData[dealerid][dP][2]),
				FormatMoney(DealerData[dealerid][dP][3]),
                FormatMoney(DealerData[dealerid][dP][4]),
                FormatMoney(DealerData[dealerid][dP][5]),
				FormatMoney(DealerData[dealerid][dP][6]),
                FormatMoney(DealerData[dealerid][dP][7]),
                FormatMoney(DealerData[dealerid][dP][8]),
                FormatMoney(DealerData[dealerid][dP][9])
            );
            ShowPlayerDialog(playerid, DEALER_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
        case 3:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Camper\t{7fff00}%s\n{ffffff}Remington\t{7fff00}%s\n{ffffff}Slamvan\t{7fff00}%s\n{ffffff}Blade\t{7fff00}%s\n{ffffff}Uranus\t{7fff00}%s\n{ffffff}Jester\t{7fff00}%s\n{ffffff}Sultan\t{7fff00}%s\n{ffffff}Stratum\t{7fff00}%s\n{ffffff}Elegy\t{7fff00}%s\n{ffffff}Flash\t{7fff00}%s",
                FormatMoney(DealerData[dealerid][dP][0]),
                FormatMoney(DealerData[dealerid][dP][1]),
                FormatMoney(DealerData[dealerid][dP][2]),
				FormatMoney(DealerData[dealerid][dP][3]),
                FormatMoney(DealerData[dealerid][dP][4]),
                FormatMoney(DealerData[dealerid][dP][5]),
				FormatMoney(DealerData[dealerid][dP][6]),
                FormatMoney(DealerData[dealerid][dP][7]),
                FormatMoney(DealerData[dealerid][dP][8]),
                FormatMoney(DealerData[dealerid][dP][9])
            );
            ShowPlayerDialog(playerid, DEALER_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
        case 4:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Taxi\t{7fff00}%s\n{ffffff}Cabbie\t{7fff00}%s\n{ffffff}Linerunner\t{7fff00}%s\n{ffffff}Poni\t{7fff00}%s\n{ffffff}Mule\t{7fff00}%s\n{ffffff}Bobcat\t{7fff00}%s\n{ffffff}Rumpo\t{7fff00}%s\n{ffffff}Flatbed\t{7fff00}%s\n{ffffff}Yanke\t{7fff00}%s\n{ffffff}Roadtrain\t{7fff00}%s",
                FormatMoney(DealerData[dealerid][dP][0]),
                FormatMoney(DealerData[dealerid][dP][1]),
                FormatMoney(DealerData[dealerid][dP][2]),
				FormatMoney(DealerData[dealerid][dP][3]),
                FormatMoney(DealerData[dealerid][dP][4]),
                FormatMoney(DealerData[dealerid][dP][5]),
				FormatMoney(DealerData[dealerid][dP][6]),
                FormatMoney(DealerData[dealerid][dP][7]),
                FormatMoney(DealerData[dealerid][dP][8]),
                FormatMoney(DealerData[dealerid][dP][9])
            );
            ShowPlayerDialog(playerid, DEALER_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
		case 5:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Mule\t{7fff00}%s\n{ffffff}Benson\t{7fff00}%s\n{ffffff}Boxville\t{7fff00}%s\n{ffffff}Flatbed\t{7fff00}%s\n{ffffff}Cement Truck\t{7fff00}%s\n{ffffff}DFT-30\t{7fff00}%s\n{ffffff}Linerunner\t{7fff00}%s\n{ffffff}Tanker\t{7fff00}%s\n{ffffff}Roadtrain\t{7fff00}%s\n{ffffff}Tow Truck\t{7fff00}%s",
                FormatMoney(DealerData[dealerid][dP][0]),
                FormatMoney(DealerData[dealerid][dP][1]),
                FormatMoney(DealerData[dealerid][dP][2]),
				FormatMoney(DealerData[dealerid][dP][3]),
                FormatMoney(DealerData[dealerid][dP][4]),
                FormatMoney(DealerData[dealerid][dP][5]),
				FormatMoney(DealerData[dealerid][dP][6]),
                FormatMoney(DealerData[dealerid][dP][7]),
                FormatMoney(DealerData[dealerid][dP][8]),
                FormatMoney(DealerData[dealerid][dP][9])
            );
            ShowPlayerDialog(playerid, DEALER_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
    }
    return 1;
}

DealerBuyVehicle(playerid, dealerid)
{
	if(dealerid <= -1 )
        return 0;

    switch(DealerData[dealerid][dealerType])
    {
        case 1:
        {
			
			new maxAllowed;
			if(pData[playerid][pVip] == 0)
				maxAllowed = 3;
			else if(pData[playerid][pVip] == 1)
				maxAllowed = 4;
			else if(pData[playerid][pVip] == 2)
				maxAllowed = 5; 
			else if(pData[playerid][pVip] == 3)
				maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
			new ownedCount = CountPlayerVehicles(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s",
			GetVehicleModelName(481), FormatMoney(DealerData[dealerid][dP][0]),
			GetVehicleModelName(509), FormatMoney(DealerData[dealerid][dP][1]),
			GetVehicleModelName(510), FormatMoney(DealerData[dealerid][dP][2]),
			GetVehicleModelName(462), FormatMoney(DealerData[dealerid][dP][3]),
			GetVehicleModelName(586), FormatMoney(DealerData[dealerid][dP][4]),
			GetVehicleModelName(581), FormatMoney(DealerData[dealerid][dP][5]),
			GetVehicleModelName(461), FormatMoney(DealerData[dealerid][dP][6]),
			GetVehicleModelName(521), FormatMoney(DealerData[dealerid][dP][7]),
			GetVehicleModelName(463), FormatMoney(DealerData[dealerid][dP][8]),
			GetVehicleModelName(468), FormatMoney(DealerData[dealerid][dP][9])
			);

			ShowPlayerDialog(playerid, DIALOG_BUYMOTORCYCLEVEHICLE, DIALOG_STYLE_LIST, "Motorcyle Dealership", str, "Buy", "Close");
		}
        case 2:
        {
			new maxAllowed;
			if(pData[playerid][pVip] == 0)
				maxAllowed = 3;
			else if(pData[playerid][pVip] == 1)
				maxAllowed = 4;
			else if(pData[playerid][pVip] == 2)
				maxAllowed = 5; 
			else if(pData[playerid][pVip] == 3)
				maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 

            new ownedCount = CountPlayerVehicles(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s",
			GetVehicleModelName(400), FormatMoney(DealerData[dealerid][dP][0]),
			GetVehicleModelName(567), FormatMoney(DealerData[dealerid][dP][1]),
			GetVehicleModelName(419), FormatMoney(DealerData[dealerid][dP][2]),
			GetVehicleModelName(426), FormatMoney(DealerData[dealerid][dP][3]),
			GetVehicleModelName(579), FormatMoney(DealerData[dealerid][dP][4]),
			GetVehicleModelName(566), FormatMoney(DealerData[dealerid][dP][5]),
			GetVehicleModelName(467), FormatMoney(DealerData[dealerid][dP][6]),
			GetVehicleModelName(474), FormatMoney(DealerData[dealerid][dP][7]),
			GetVehicleModelName(475), FormatMoney(DealerData[dealerid][dP][8]),
			GetVehicleModelName(480), FormatMoney(DealerData[dealerid][dP][9])
			);

			ShowPlayerDialog(playerid, DIALOG_BUYCARSVEHICLE, DIALOG_STYLE_LIST, "Cars Dealership", str, "Buy", "Close");
		}
        case 3:
        {
			new maxAllowed;
			if(pData[playerid][pVip] == 0)
				maxAllowed = 3;
			else if(pData[playerid][pVip] == 1)
				maxAllowed = 4;
			else if(pData[playerid][pVip] == 2)
				maxAllowed = 5; 
			else if(pData[playerid][pVip] == 3)
				maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehicles(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s",
			GetVehicleModelName(483), FormatMoney(DealerData[dealerid][dP][0]),
			GetVehicleModelName(534), FormatMoney(DealerData[dealerid][dP][1]),
			GetVehicleModelName(535), FormatMoney(DealerData[dealerid][dP][2]),
			GetVehicleModelName(536), FormatMoney(DealerData[dealerid][dP][3]),
			GetVehicleModelName(558), FormatMoney(DealerData[dealerid][dP][4]),
			GetVehicleModelName(559), FormatMoney(DealerData[dealerid][dP][5]),
			GetVehicleModelName(560), FormatMoney(DealerData[dealerid][dP][6]),
			GetVehicleModelName(561), FormatMoney(DealerData[dealerid][dP][7]),
			GetVehicleModelName(562), FormatMoney(DealerData[dealerid][dP][8]),
			GetVehicleModelName(565), FormatMoney(DealerData[dealerid][dP][9])
			);

			ShowPlayerDialog(playerid, DIALOG_BUYUCARSVEHICLE, DIALOG_STYLE_LIST, "Unique Cars Dealership", str, "Buy", "Close");
		}
        case 4:
		{
			new maxAllowed;
			if(pData[playerid][pVip] == 0)
				maxAllowed = 3;
			else if(pData[playerid][pVip] == 1)
				maxAllowed = 4;
			else if(pData[playerid][pVip] == 2)
				maxAllowed = 5; 
			else if(pData[playerid][pVip] == 3)
				maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehicles(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
			//Job Cars
			new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s",
			GetVehicleModelName(420), FormatMoney(DealerData[dealerid][dP][0]),
			GetVehicleModelName(438), FormatMoney(DealerData[dealerid][dP][1]),
			GetVehicleModelName(403), FormatMoney(DealerData[dealerid][dP][2]),
			GetVehicleModelName(588), FormatMoney(DealerData[dealerid][dP][3]),
			GetVehicleModelName(423), FormatMoney(DealerData[dealerid][dP][4]),
			GetVehicleModelName(422), FormatMoney(DealerData[dealerid][dP][5]),
			GetVehicleModelName(543), FormatMoney(DealerData[dealerid][dP][6]),
			GetVehicleModelName(455), FormatMoney(DealerData[dealerid][dP][7]),
			GetVehicleModelName(609), FormatMoney(DealerData[dealerid][dP][8]),
			GetVehicleModelName(515), FormatMoney(DealerData[dealerid][dP][9])
			);

			ShowPlayerDialog(playerid, DIALOG_BUYJOBCARSVEHICLE, DIALOG_STYLE_LIST, "Job Cars", str, "Buy", "Close");
		}
        case 5:
        {
			new maxAllowed;
			if(pData[playerid][pVip] == 0)
				maxAllowed = 3;
			else if(pData[playerid][pVip] == 1)
				maxAllowed = 4;
			else if(pData[playerid][pVip] == 2)
				maxAllowed = 5; 
			else if(pData[playerid][pVip] == 3)
				maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehicles(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s\n%s\t{7fff00}%s",
			GetVehicleModelName(414), FormatMoney(DealerData[dealerid][dP][0]),
			GetVehicleModelName(499), FormatMoney(DealerData[dealerid][dP][1]),
			GetVehicleModelName(498), FormatMoney(DealerData[dealerid][dP][2]),
			GetVehicleModelName(455), FormatMoney(DealerData[dealerid][dP][3]),
			GetVehicleModelName(524), FormatMoney(DealerData[dealerid][dP][4]),
			GetVehicleModelName(578), FormatMoney(DealerData[dealerid][dP][5]),
			GetVehicleModelName(403), FormatMoney(DealerData[dealerid][dP][6]),
			GetVehicleModelName(514), FormatMoney(DealerData[dealerid][dP][7]),
			GetVehicleModelName(515), FormatMoney(DealerData[dealerid][dP][8]),
			GetVehicleModelName(525), FormatMoney(DealerData[dealerid][dP][9])
			);

			ShowPlayerDialog(playerid, DIALOG_BUYTRUCKVEHICLE, DIALOG_STYLE_LIST, "Truck Dealership", str, "Buy", "Close");
		}
    }
    return 1;
}


/* ============ [ Hook, Function goes here ] ============ */

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_BUYMOTORCYCLEVEHICLE)
	{
		static
        dealerid = -1,
        price;

		if((dealerid = pData[playerid][pInDealer]) != -1 && response)
		{
			price = DealerData[dealerid][dP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return Error(playerid, "Not enough money!");

			if(DealerData[dealerid][dealerStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerData[dealerid][dealerType] == 1)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 481;
						new tstr[128];
						price = DealerData[dealerid][dP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), DealerData[dealerid][dP][0]);
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10;
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new count = 0, limit = maxAllowed;
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
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 509;
						new tstr[128];
						price = DealerData[dealerid][dP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 510;
						new tstr[128];
						price = DealerData[dealerid][dP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 462;
						new tstr[128];
						price = DealerData[dealerid][dP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 586;
						new tstr[128];
						price = DealerData[dealerid][dP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 581;
						new tstr[128];
						price = DealerData[dealerid][dP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 461;
						new tstr[128];
						price = DealerData[dealerid][dP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 521;
						new tstr[128];
						price = DealerData[dealerid][dP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 463;
						new tstr[128];
						price = DealerData[dealerid][dP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 468;
						new tstr[128];
						price = DealerData[dealerid][dP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
				}
			}
		}
	}
    if(dialogid == DIALOG_BUYCARSVEHICLE)
	{
		static
        dealerid = -1,
        price;

		if((dealerid = pData[playerid][pInDealer]) != -1 && response)
		{
			price = DealerData[dealerid][dP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return Error(playerid, "Not enough money!");

			if(DealerData[dealerid][dealerStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerData[dealerid][dealerType] == 2)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 400;
						new tstr[128];
						price = DealerData[dealerid][dP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 567;
						new tstr[128];
						price = DealerData[dealerid][dP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						new lenzvip3 = pData[playerid][pVip] + 4;
						new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
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
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 419;
						new tstr[128];
						price = DealerData[dealerid][dP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 426;
						new tstr[128];
						price = DealerData[dealerid][dP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 579;
						new tstr[128];
						price = DealerData[dealerid][dP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 566;
						new tstr[128];
						price = DealerData[dealerid][dP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 467;
						new tstr[128];
						price = DealerData[dealerid][dP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 474;
						new tstr[128];
						price = DealerData[dealerid][dP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 475;
						new tstr[128];
						price = DealerData[dealerid][dP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 480;
						new tstr[128];
						price = DealerData[dealerid][dP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYUCARSVEHICLE)
	{
		static
        dealerid = -1,
        price;

		if((dealerid = pData[playerid][pInDealer]) != -1 && response)
		{
			price = DealerData[dealerid][dP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return Error(playerid, "Not enough money!");

			if(DealerData[dealerid][dealerStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerData[dealerid][dealerType] == 3)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 483;
						new tstr[128];
						price = DealerData[dealerid][dP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 534;
						new tstr[128];
						price = DealerData[dealerid][dP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 535;
						new tstr[128];
						price = DealerData[dealerid][dP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 536;
						new tstr[128];
						price = DealerData[dealerid][dP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 558;
						new tstr[128];
						price = DealerData[dealerid][dP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 559;
						new tstr[128];
						price = DealerData[dealerid][dP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 560;
						new tstr[128];
						price = DealerData[dealerid][dP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 561;
						new tstr[128];
						price = DealerData[dealerid][dP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 562;
						new tstr[128];
						price = DealerData[dealerid][dP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 565;
						new tstr[128];
						price = DealerData[dealerid][dP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_BUYJOBCARSVEHICLE)
	{
		static
        dealerid = -1,
        price;

		if((dealerid = pData[playerid][pInDealer]) != -1 && response)
		{
			price = DealerData[dealerid][dP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return Error(playerid, "Not enough money!");

			if(DealerData[dealerid][dealerStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerData[dealerid][dealerType] == 4)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 420;
						new tstr[128];
						price = DealerData[dealerid][dP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 438;
						new tstr[128];
						price = DealerData[dealerid][dP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 403;
						new tstr[128];
						price = DealerData[dealerid][dP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 588;
						new tstr[128];
						price = DealerData[dealerid][dP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 423;
						new tstr[128];
						price = DealerData[dealerid][dP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 422;
						new tstr[128];
						price = DealerData[dealerid][dP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 543;
						new tstr[128];
						price = DealerData[dealerid][dP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 455;
						new tstr[128];
						price = DealerData[dealerid][dP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 609;
						new tstr[128];
						price = DealerData[dealerid][dP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 515;
						new tstr[128];
						price = DealerData[dealerid][dP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
				}
			}
		}
	}
    if(dialogid == DIALOG_BUYTRUCKVEHICLE)
	{
		static
        dealerid = -1,
        price;

		if((dealerid = pData[playerid][pInDealer]) != -1 && response)
		{
			price = DealerData[dealerid][dP][listitem];

			if(GetPlayerMoney(playerid) < price)
				return Error(playerid, "Not enough money!");

			if(DealerData[dealerid][dealerStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerData[dealerid][dealerType] == 5)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 414;
						new tstr[128];
						price = DealerData[dealerid][dP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 499;
						new tstr[128];
						price = DealerData[dealerid][dP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 498;
						new tstr[128];
						price = DealerData[dealerid][dP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 455;
						new tstr[128];
						price = DealerData[dealerid][dP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 524;
						new tstr[128];
						price = DealerData[dealerid][dP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 578;
						new tstr[128];
						price = DealerData[dealerid][dP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 403;
						new tstr[128];
						price = DealerData[dealerid][dP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 514;
						new tstr[128];
						price = DealerData[dealerid][dP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 515;
						new tstr[128];
						price = DealerData[dealerid][dP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 525;
						new tstr[128];
						price = DealerData[dealerid][dP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
						if(pData[playerid][pMoney] < price)
						{
							Error(playerid, "Uang anda tidak mencukupi.!");
							return 1;
						}
						// new lenzvip3 = pData[playerid][pVip] + 4;
						// new count = 0, limit = MAX_PLAYER_VEHICLE + lenzvip3;
						new maxAllowed;
						if(pData[playerid][pVip] == 0)
							maxAllowed = 3;
						else if(pData[playerid][pVip] == 1)
							maxAllowed = 4;
						else if(pData[playerid][pVip] == 2)
							maxAllowed = 5; 
						else if(pData[playerid][pVip] == 3)
							maxAllowed = 6; 
						else if(pData[playerid][pVip] == 4)
							maxAllowed = 10; 
						new ownedCount = CountPlayerVehicles(playerid);

						if(ownedCount >= maxAllowed)
						{
							SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerData[dealerid][dealerMoney] += price;
						DealerData[dealerid][dealerStock]--;
						if(DealerData[dealerid][dealerStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						GivePlayerMoneyEx(playerid, -price);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerData[dealerid][dealerName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerData[dealerid][dealerPointX];
						y = DealerData[dealerid][dealerPointY];
						z = DealerData[dealerid][dealerPointZ];
						DealerSave(dealerid);
						DealerRefresh(dealerid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDealer", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						KickEx(playerid);
					}
				}
			}
		}
	}
    if(dialogid == DIALOG_DEALER_MANAGE)
	{
		new dealerid = pData[playerid][pInDealer];
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new string[258];
					format(string, sizeof(string), "Dealer ID: %d\nDealer Name : %s\nDealer Location: %s\nDealership Vault: %s\nDealership Stock: %d",
					dealerid, DealerData[dealerid][dealerName], GetLocation(DealerData[dealerid][dealerPosX], DealerData[dealerid][dealerPosY], DealerData[dealerid][dealerPosZ]), FormatMoney(DealerData[dealerid][dealerMoney]), DealerData[dealerid][dealerStock]);

					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Dealerhip Information", string, "Cancel", "");
				}
				case 1:
				{
					new string[218];
					format(string, sizeof(string), "Tulis Nama Dealer baru yang anda inginkan : ( Nama Dealer Lama %s )", DealerData[dealerid][dealerName]);
					ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT, "Dealership Change Name", string, "Select", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, DIALOG_DEALER_VAULT, DIALOG_STYLE_LIST,"Dealership Vault","Dealership Deposit\nDealership Withdraw","Select","Cancel");
				}
				case 3:
				{
					if(DealerData[dealerid][dealerStock] > 25)
						return Error(playerid, "Dealership ini masih memiliki cukup produck.");
					if(DealerData[dealerid][dealerMoney] < 75000)
						return Error(playerid, "Setidaknya anda mempunyai uang dalam dealer anda senilai $75.000 untuk merestock product.");
					DealerData[dealerid][dealerRestock] = 1;
					Info(playerid, "Anda berhasil request untuk mengisi stock kendaraan kepada trucker, harap tunggu sampai pekerja trucker melayani.");
				}
				case 4:
				{
					Dealer_ProductMenu(playerid, dealerid);
				}
			}
		}
		return 1;
	}
    if(dialogid == DIALOG_DEALER_NAME)
	{
		if(response)
		{
			new bid = pData[playerid][pInDealer];

			if(!PlayerOwnsDealership(playerid, pData[playerid][pInDealer])) return Error(playerid, "You don't own this Dealership.");

			// dealer sql 
			if (!CheckAntiCharacters(inputtext))
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Error! Input mengandung karakter yang tidak diizinkan\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerData[bid][dealerName]);
				ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			if (isnull(inputtext))
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Dealership tidak di perbolehkan kosong!\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerData[bid][dealerName]);
				ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			if(strlen(inputtext) > 32 || strlen(inputtext) < 5)
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Dealership harus 5 sampai 32 kata.\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerData[bid][dealerName]);
				ShowPlayerDialog(playerid, DIALOG_DEALER_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			format(DealerData[bid][dealerName], 32, ColouredText(inputtext));

			DealerRefresh(bid);
			DealerSave(bid);

			SendClientMessageEx(playerid, COLOR_LBLUE,"Dealer name set to: \"%s\".", DealerData[bid][dealerName]);
		}
		else return callcmd::dealermanage(playerid, "\0");
		return 1;
	}
    if(dialogid == DIALOG_DEALER_VAULT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Uang kamu: %s.\n\nMasukkan berapa banyak uang yang akan kamu simpan di dalam Dealership ini", FormatMoney(GetPlayerMoney(playerid)));
					ShowPlayerDialog(playerid, DIALOG_DEALER_DEPOSIT, DIALOG_STYLE_INPUT, "Dealer Deposit Input", mstr, "Deposit", "Cancel");
				}
				case 1:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Dealer Vault: %s\n\nMasukkan berapa banyak uang yang akan kamu ambil di dalam Dealer ini", FormatMoney(DealerData[pData[playerid][pInDealer]][dealerMoney]));
					ShowPlayerDialog(playerid, DIALOG_DEALER_WITHDRAW, DIALOG_STYLE_INPUT,"Dealer Withdraw Input", mstr, "Withdraw","Cancel");
				}
			}
		}
	}
    if(dialogid == DIALOG_DEALER_WITHDRAW)
	{
		if(response)
		{
			new bid = pData[playerid][pInDealer];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > DealerData[bid][dealerMoney])
				return Error(playerid, "Invalid amount specified!");

			DealerData[bid][dealerMoney] -= amount;
			DealerSave(bid);

			GivePlayerMoneyEx(playerid, amount);

			Info(playerid, "You have withdrawn %s from the Dealership vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, DIALOG_DEALER_VAULT, DIALOG_STYLE_LIST,"Dealer Vault","Dealership Deposit\nDealership Withdraw","Next","Back");
		return 1;
	}
    if(dialogid == DIALOG_DEALER_DEPOSIT)
	{
		if(response)
		{
			new bid = pData[playerid][pInDealer];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > GetPlayerMoney(playerid))
				return Error(playerid, "Invalid amount specified!");

			DealerData[bid][dealerMoney] += amount;
			DealerSave(bid);

			GivePlayerMoneyEx(playerid, -amount);

			Info(playerid, "You have deposit %s into the Dealership vault.", FormatMoney(strval(inputtext)));
		}
		else
			ShowPlayerDialog(playerid, DIALOG_DEALER_VAULT, DIALOG_STYLE_LIST,"Dealership Vault","Dealership Deposit\nDealership Withdraw","Next","Back");
		return 1;
	}
	return 1;
}

function OnVehDealer(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
{
	
	new i = Iter_Free(PVehicles);
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
	format(pvData[i][cPlate], 16, "NoHave");
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
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	pvData[i][cSpawn] = 0;
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
		
	pvData[i][vInGarage] = INVALID_GARAGE_ID;
	pvData[i][vLoaded] = true;
	pvData[i][vHandbrake] = true;
	pvData[i][vVehicleUpdate] = false;

	Iter_Add(PVehicles, i);
	OnVehicleDealerRespawn(i);
	Servers(playerid, "Anda telah membeli kendaraan %s", GetVehicleModelName(model));
	pData[playerid][pBuyPvModel] = 0;
	SetPlayerVirtualWorld(playerid, 0);
	MySQL_CreateVehicleStorage(i, pvData[i][cID]);
	KickEx(playerid);
	return 1;
}

function OnVehicleDealerRespawn(i)
{
	pvData[i][cVeh] = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], 60000);
	SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
	SetVehicleVirtualWorld(pvData[i][cVeh], pvData[i][cVw]);
	LinkVehicleToInterior(pvData[i][cVeh], pvData[i][cInt]);
	SetVehicleFuel(pvData[i][cVeh], pvData[i][cFuel]);
	if(pvData[i][cHealth] < 350.0)
	{
		SetValidVehicleHealth(pvData[i][cVeh], 350.0);
	}
	else
	{
		SetValidVehicleHealth(pvData[i][cVeh], pvData[i][cHealth]);
	}
	UpdateVehicleDamageStatus(pvData[i][cVeh], pvData[i][cDamage0], pvData[i][cDamage1], pvData[i][cDamage2], pvData[i][cDamage3]);
	if(pvData[i][cVeh] != INVALID_VEHICLE_ID)
    {
        if(pvData[i][cPaintJob] != -1)
        {
            ChangeVehiclePaintjob(pvData[i][cVeh], pvData[i][cPaintJob]);
        }
		for(new z = 0; z < 17; z++)
		{
			if(pvData[i][cMod][z]) AddVehicleComponent(pvData[i][cVeh], pvData[i][cMod][z]);
		}
		if(pvData[i][cLocked] == 1)
		{
			SwitchVehicleDoors(pvData[i][cVeh], true);
		}
		else
		{
			SwitchVehicleDoors(pvData[i][cVeh], false);
		}
	}
	return 1;
}

function OnDealerCreated(dealerid)
{
	DealerRefresh(dealerid);
	DealerSave(dealerid);
	return 1;
}

function LoadDealership()
{
    static bid;

	new rows = cache_num_rows(), owner[128], name[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", bid);
			cache_get_value_name(i, "owner", owner);
			format(DealerData[bid][dealerOwner], 128, owner);
			cache_get_value_name_int(i, "ownerid", DealerData[bid][dealerOwnerID]);
			cache_get_value_name(i, "name", name);
			format(DealerData[bid][dealerName], 128, name);
			cache_get_value_name_int(i, "type", DealerData[bid][dealerType]);
			cache_get_value_name_int(i, "price", DealerData[bid][dealerPrice]);
			cache_get_value_name_float(i, "posx", DealerData[bid][dealerPosX]);
			cache_get_value_name_float(i, "posy", DealerData[bid][dealerPosY]);
			cache_get_value_name_float(i, "posz", DealerData[bid][dealerPosZ]);
			cache_get_value_name_float(i, "posa", DealerData[bid][dealerPosA]);
			cache_get_value_name_int(i, "dprice0", DealerData[bid][dP][0]);
			cache_get_value_name_int(i, "dprice1", DealerData[bid][dP][1]);
			cache_get_value_name_int(i, "dprice2", DealerData[bid][dP][2]);
			cache_get_value_name_int(i, "dprice3", DealerData[bid][dP][3]);
			cache_get_value_name_int(i, "dprice4", DealerData[bid][dP][4]);
			cache_get_value_name_int(i, "dprice5", DealerData[bid][dP][5]);
			cache_get_value_name_int(i, "dprice6", DealerData[bid][dP][6]);
			cache_get_value_name_int(i, "dprice7", DealerData[bid][dP][7]);
			cache_get_value_name_int(i, "dprice8", DealerData[bid][dP][8]);
			cache_get_value_name_int(i, "dprice9", DealerData[bid][dP][9]);
			cache_get_value_name_int(i, "money", DealerData[bid][dealerMoney]);
			cache_get_value_name_int(i, "locked", DealerData[bid][dealerLocked]);
			cache_get_value_name_int(i, "stock", DealerData[bid][dealerStock]);
			cache_get_value_name_float(i, "pointx", DealerData[bid][dealerPointX]);
			cache_get_value_name_float(i, "pointy", DealerData[bid][dealerPointY]);
			cache_get_value_name_float(i, "pointz", DealerData[bid][dealerPointZ]);
			cache_get_value_name_int(i, "dvisit", DealerData[bid][dVisit]);
			cache_get_value_name_int(i, "restock", DealerData[bid][dealerRestock]);
			DealerRefresh(bid);
			DealerPointRefresh(bid);
			Iter_Add(Dealer, bid);
		}
		printf("[Dynamic Dealership] Number of Loaded: %d.", rows);
	}
}


ptask PlayerDealerUpdate[1000](playerid)
{
	foreach(new vid : Dealer)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerData[vid][dealerPosX], DealerData[vid][dealerPosY], DealerData[vid][dealerPosZ]))
		{
			pData[playerid][pInDealer] = vid;
			/*Info(playerid, "DEBUG MESSAGE: Kamu berada di dekat Dealer ID %d", vid);*/
		}
	}
	return 1;
}
