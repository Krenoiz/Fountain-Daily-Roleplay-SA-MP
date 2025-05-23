#include <YSI_Coding\y_hooks>

#define MAX_DEALGOLD 100

enum DealGoldVariabel
{
	dealgoldOwner[MAX_PLAYER_NAME],
	dealgoldOwnerID,
	dealgoldName[128],
	dealgoldPrice,
	dealgoldType,
	dealgoldLocked,
	dealgoldMoney,
	dgoldVisit,
	dgP[10],
	Float:dealergoldPosX,
	Float:dealergoldPosY,
	Float:dealergoldPosZ,
	Float:dealergoldPosA,
	Float:dgoldPointX,
	Float:dgoldPointY,
	Float:dgoldPointZ,
	Float:dgoldPointA,
	dgoldStock,
	dgoldRestock,

	// Hooked by DgoldRefresh
	dgoldPickup,
	dgoldPickupPoint,
	dgoldMap,
	Text3D:dgoldLabel,
	Text3D:dgoldPointLabel,
};

new DealerGold[MAX_DEALGOLD][DealGoldVariabel];
new Iterator:Dgold<MAX_DEALGOLD>;

GetAnyDgold()
{
	new tmpcount;
	foreach(new id : Dgold)
	{
     	tmpcount++;
	}
	return tmpcount;
}


ReturnDgoldID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_DEALGOLD) return -1;
	foreach(new id : Dgold)
	{
        tmpcount++;
        if(tmpcount == slot)
        {
            return id;
        }
	}
	return -1;
}

CMD:editdgold(playerid, params[])
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
        Usage(playerid, "/editdgold [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, point, price, type, stock, restock, reset");
        return 1;
    }
    if((did < 0 || did > MAX_DEALGOLD))
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dgold, did)) return Error(playerid, "The dealership you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, DealerGold[did][dealergoldPosX], DealerGold[did][dealergoldPosY], DealerGold[did][dealergoldPosZ]);
		GetPlayerFacingAngle(playerid, DealerGold[did][dealergoldPosA]);
        DgoldSave(did);
		DgoldRefresh(did);

        SendAdminMessage(COLOR_RED, "%s Changes Location Dealer ID: %d.", pData[playerid][pAdminname], did);
    }
	else if(!strcmp(type, "owner", true))
    {
		new otherid;
        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/editdealer [id] [owner] [playerid] (use '-1' to no owner/ reset)");
		if(otherid == -1)
			return format(DealerGold[did][dealgoldOwner], MAX_PLAYER_NAME, "-");

        format(DealerGold[did][dealgoldOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
		DealerGold[did][dealgoldOwnerID] = pData[otherid][pID];

		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE dealergold SET owner='%s', ownerid='%d' WHERE ID='%d'", DealerGold[did][dealgoldOwner], DealerGold[did][dealgoldOwnerID], did);
		mysql_tquery(g_SQL, query);

		DgoldSave(did);
		DgoldRefresh(did);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of dealership ID: %d to %s", pData[playerid][pAdminname], did, pData[otherid][pName]);
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/editdealer [id] [Price] [Amount]");

        DealerGold[did][dealgoldPrice] = price;

        DgoldSave(did);
		DgoldRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Changes Price Of The Dealer ID: %d to %d.", pData[playerid][pAdminname], did, price);
    }
	else if(!strcmp(type, "type", true))
    {
        new dtype;

        if(sscanf(string, "d", dtype))
            return Usage(playerid, "/editdealer [id] [Type] [1.VIP 2.VIP 3.VIP 4.VIP Plane 5.VIP]");

        DealerGold[did][dealgoldType] = dtype;
        DgoldSave(did);
		DgoldRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Changes Type Of The Dealer ID: %d to %d.", pData[playerid][pAdminname], did, dtype);
    }
    else if(!strcmp(type, "stock", true))
    {
        new dStock;
        if(sscanf(string, "d", dStock))
            return Usage(playerid, "/editdealer [id] [stock]");

        DealerGold[did][dgoldStock] = dStock;
        DgoldSave(did);
		DgoldRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Set Stock Of The Dealer ID: %d with stock %d.", pData[playerid][pAdminname], did, dStock);
    }
	else if(!strcmp(type, "restock", true))
    {
        new dRstock;
        if(sscanf(string, "d", dRstock))
            return Usage(playerid, "/editdealer [id] [restock]");

        DealerGold[did][dgoldStock] = dRstock;
        DgoldSave(did);
		DgoldRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Set Restock Of The Dealer ID: %d with restock %d.", pData[playerid][pAdminname], did, dRstock);
    }
    else if(!strcmp(type, "reset", true))
    {
        DgoldReset(did);
		DgoldSave(did);
		DgoldRefresh(did);
        SendAdminMessage(COLOR_RED, "%s has reset dealer ID: %d.", pData[playerid][pAdminname], did);
    }
	else if(!strcmp(type, "point", true))
    {
		new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, Float:a);
		DealerGold[did][dgoldPointX] = x;
		DealerGold[did][dgoldPointY] = y;
		DealerGold[did][dgoldPointZ] = z;
		DgoldSave(did);
		DgoldPointRefresh(did);
        SendAdminMessage(COLOR_RED, "%s Change Point Of The Dealer ID: %d.", pData[playerid][pAdminname], did);
    }
    return 1;
}


CMD:createdgold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new query[512];
	new dgoldid = Iter_Free(Dgold), address[128];

	new price, type;
	if(sscanf(params, "dd", price, type))
		return Usage(playerid, "/createdgold [price] [type 1.VIP 2.VIP 3.VIP 4.VIP Plane 5.VIP]");

	if(dgoldid == -1)
		return Error(playerid, "You cant create more dealership");

	if((dgoldid < 0 || dgoldid >= MAX_DEALGOLD))
        return Error(playerid, "You have already input 15 dealership in this server.");

	if(type > 5 || type < 0)
		return Error(playerid, "Invalid dealership Type");

	format(DealerGold[dgoldid][dealgoldOwner], 128, "-");
	DealerGold[dgoldid][dealgoldOwnerID] = 0;
	GetPlayerPos(playerid, DealerGold[dgoldid][dealergoldPosX], DealerGold[dgoldid][dealergoldPosY], DealerGold[dgoldid][dealergoldPosZ]);
	GetPlayerFacingAngle(playerid, DealerGold[dgoldid][dealergoldPosA]);

	DealerGold[dgoldid][dealgoldPrice] = price;
	DealerGold[dgoldid][dealgoldType] = type;

	address = GetLocation(DealerGold[dgoldid][dealergoldPosX], DealerGold[dgoldid][dealergoldPosY], DealerGold[dgoldid][dealergoldPosZ]);
	format(DealerGold[dgoldid][dealgoldName], 128, address);

	DealerGold[dgoldid][dealgoldLocked] = 1;
	DealerGold[dgoldid][dealgoldMoney] = 0;
	DealerGold[dgoldid][dgoldStock] = 0;
	DealerGold[dgoldid][dgoldRestock] = 0;
	DealerGold[dgoldid][dgP][0] = 0;
	DealerGold[dgoldid][dgP][1] = 0;
	DealerGold[dgoldid][dgP][2] = 0;
	DealerGold[dgoldid][dgP][3] = 0;
	DealerGold[dgoldid][dgP][4] = 0;
	DealerGold[dgoldid][dgP][5] = 0;
	DealerGold[dgoldid][dgP][6] = 0;
	DealerGold[dgoldid][dgP][7] = 0;
	DealerGold[dgoldid][dgP][8] = 0;
	DealerGold[dgoldid][dgP][9] = 0;

	Iter_Add(Dgold, dgoldid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO dealergold SET ID='%d', owner='%s', ownerid='%d',price='%d', type='%d', posx='%f', posy='%f', posz='%f', posa='%f', name='%s'", dgoldid, DealerGold[dgoldid][dealgoldOwner],dgoldid, DealerGold[dgoldid][dealgoldOwnerID], DealerGold[dgoldid][dealgoldPrice], DealerGold[dgoldid][dealgoldType], DealerGold[dgoldid][dealergoldPosX], DealerGold[dgoldid][dealergoldPosY], DealerGold[dgoldid][dealergoldPosZ], DealerGold[dgoldid][dealergoldPosA], DealerGold[dgoldid][dealgoldName]);
	mysql_tquery(g_SQL, query, "OnDgoldCreated", "i", dgoldid);
	return 1;
}

CMD:deletedgold(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/deletedgold [id]");

	if(bid < 0 || bid >= MAX_DEALGOLD)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dgold, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	DgoldReset(bid);

	DestroyDynamic3DTextLabel(DealerGold[bid][dgoldLabel]);
	DestroyDynamic3DTextLabel(DealerGold[bid][dgoldPointLabel]);

    DestroyDynamicPickup(DealerGold[bid][dgoldPickup]);
    DestroyDynamicPickup(DealerGold[bid][dgoldPickupPoint]);

	DealerGold[bid][dealergoldPosX] = 0;
	DealerGold[bid][dealergoldPosY] = 0;
	DealerGold[bid][dealergoldPosZ] = 0;
	DealerGold[bid][dealergoldPosA] = 0;
	DealerGold[bid][dgoldPointX] = 0;
	DealerGold[bid][dgoldPointY] = 0;
	DealerGold[bid][dgoldPointZ] = 0;
	DealerGold[bid][dealgoldPrice] = 0;
	DealerGold[bid][dgoldLabel] = Text3D:INVALID_3DTEXT_ID;
	DealerGold[bid][dgoldPointLabel] = Text3D:INVALID_3DTEXT_ID;
	DealerGold[bid][dgoldPickup] = -1;
	DealerGold[bid][dgoldPickupPoint] = -1;

	Iter_Remove(Dgold, bid);
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM dealergold WHERE ID=%d", bid);
	mysql_tquery(g_SQL, query);
    SendAdminMessage(COLOR_RED, "%s has delete dealergold ID: %d.", pData[playerid][pAdminname], bid);
    return 1;
}

CMD:gotodgold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/gotodgold [id]");

	if(bid < 0 || bid >= MAX_DEALGOLD)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dgold, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	SetPlayerPos(playerid, DealerGold[bid][dealergoldPosX], DealerGold[bid][dealergoldPosY], DealerGold[bid][dealergoldPosZ]);
	SetPlayerFacingAngle(playerid, DealerGold[bid][dealergoldPosA]);

    SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to dealership id %d", bid);
    return 1;
}

CMD:gotodgoldpoint(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

	new bid;

	if(sscanf(params, "d", bid))
		return Usage(playerid, "/gotodgoldpoint [id]");

	if(bid < 0 || bid >= MAX_DEALGOLD)
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dgold, bid))
		return Error(playerid, "The dealership you specified ID of doesn't exist.");

	if(DealerGold[bid][dgoldPointX] == 0.0 && DealerGold[bid][dgoldPointY] == 0.0 && DealerGold[bid][dgoldPointZ] == 0.0)
		return Error(playerid, "That point is exists but doesnt have any position");

	SetPlayerPos(playerid, DealerGold[bid][dgoldPointX], DealerGold[bid][dgoldPointY], DealerGold[bid][dgoldPointZ]);

    SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to dealership id %d", bid);
    return 1;
}

CMD:buypg(playerid, params[])
{
    if(pData[playerid][pVip] < 1)
    {
        return Error(playerid, "You are not a VIP player .");
    }
	foreach(new dgoldid : Dgold)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, DealerGold[dgoldid][dealergoldPosX], DealerGold[dgoldid][dealergoldPosY], DealerGold[dgoldid][dealergoldPosZ]) && strcmp(DealerGold[dgoldid][dealgoldOwner], "-") && DealerGold[dgoldid][dgoldPointX] != 0.0 && DealerGold[dgoldid][dgoldPointY] != 0.0 && DealerGold[dgoldid][dgoldPointZ] != 0.0)
		{
			DgoldBuyVehicle(playerid, dgoldid);
		}
	}
	return 1;
}

CMD:dgoldmanage(playerid, params[])
{
	foreach(new dgoldid : Dgold)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerGold[dgoldid][dealergoldPosX], DealerGold[dgoldid][dealergoldPosY], DealerGold[dgoldid][dealergoldPosZ]))
		{
			if(!PlayerOwnsDgold(playerid, dgoldid)) return Error(playerid, "Dealership ini bukan milik anda!");
			ShowPlayerDialog(playerid, DIALOG_DGOLD_MANAGE, DIALOG_STYLE_LIST, "Dealer Manage", "Dealer Information\nDealer Change Name\nDealer Vault\nDealer RequestStock\nEdit Product", "Select", "Cancel");
		}
	}
	return 1;
}

/* ============ [ Stock goes here ] ============ */

DgoldSave(id)
{
	new cQuery[2248];
	format(cQuery, sizeof(cQuery), "UPDATE dealergold SET owner='%s', ownerID='%d', name='%s', price='%d', type='%d', locked='%d', money='%d', stock='%d', dprice0='%d', dprice1='%d', dprice2='%d', dprice3='%d', dprice4='%d', dprice5='%d', dprice6='%d', dprice7='%d', dprice8='%d', dprice9='%d', posx='%f', posy='%f', posz='%f', posa='%f', pointx='%f', pointy='%f', pointz='%f', dvisit='%d', restock='%d' WHERE ID='%d'",
	DealerGold[id][dealgoldOwner],
	DealerGold[id][dealgoldOwnerID],
	DealerGold[id][dealgoldName],
	DealerGold[id][dealgoldPrice],
	DealerGold[id][dealgoldType],
	DealerGold[id][dealgoldLocked],
	DealerGold[id][dealgoldMoney],
	DealerGold[id][dgoldStock],
	DealerGold[id][dgP][0],
	DealerGold[id][dgP][1],
	DealerGold[id][dgP][2],
	DealerGold[id][dgP][3],
	DealerGold[id][dgP][4],
	DealerGold[id][dgP][5],
	DealerGold[id][dgP][6],
	DealerGold[id][dgP][7],
	DealerGold[id][dgP][8],
	DealerGold[id][dgP][9],
	DealerGold[id][dealergoldPosX],
	DealerGold[id][dealergoldPosY],
	DealerGold[id][dealergoldPosZ],
	DealerGold[id][dealergoldPosA],
	DealerGold[id][dgoldPointX],
	DealerGold[id][dgoldPointY],
	DealerGold[id][dgoldPointZ],
	DealerGold[id][dgoldVisit],
	DealerGold[id][dgoldRestock],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}
Player_OgwnsDealer(playerid, id)
{
	return (DealerGold[id][dealgoldOwnerID] == pData[playerid][pID]) || (!strcmp(DealerGold[id][dealgoldOwner], pData[playerid][pName], true));
}
DgoldPointRefresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamic3DTextLabel(DealerGold[id][dgoldPointLabel]))
        DestroyDynamic3DTextLabel(DealerGold[id][dgoldPointLabel]);

    	if(IsValidDynamicPickup(DealerGold[id][dgoldPickupPoint]))
        	DestroyDynamicPickup(DealerGold[id][dgoldPickupPoint]);

		new tstr[218];
		if(DealerGold[id][dgoldPointX] != 0 && DealerGold[id][dgoldPointY] != 0 && DealerGold[id][dgoldPointZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"%s Dealership Vehicle Spawn Point", id, DealerGold[id][dealgoldName]);
			DealerGold[id][dgoldPointLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, DealerGold[id][dgoldPointX], DealerGold[id][dgoldPointY], DealerGold[id][dgoldPointZ], 5.0);
        	DealerGold[id][dgoldPickupPoint] = CreateDynamicPickup(1239, 23, DealerGold[id][dgoldPointX], DealerGold[id][dgoldPointY], DealerGold[id][dgoldPointZ]);
		}
		else if(DealerGold[id][dgoldPointX], DealerGold[id][dgoldPointY], DealerGold[id][dgoldPointZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n"WHITE_E"%s Dealership Vehicle Spawn Point", id, DealerGold[id][dealgoldName]);
			DealerGold[id][dgoldPointLabel] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, DealerGold[id][dgoldPointX], DealerGold[id][dgoldPointY], DealerGold[id][dgoldPointZ], 5.0);
        	DealerGold[id][dgoldPickupPoint] = CreateDynamicPickup(1239, 23, DealerGold[id][dgoldPointX], DealerGold[id][dgoldPointY], DealerGold[id][dgoldPointZ]);
    	}
	}
}

DgoldRefresh(id)
{
    if (id != -1)
    {
        // Destroy existing dynamic objects if they exist
        if (IsValidDynamic3DTextLabel(DealerGold[id][dgoldLabel]))
            DestroyDynamic3DTextLabel(DealerGold[id][dgoldLabel]);

        if (IsValidDynamicPickup(DealerGold[id][dgoldPickup]))
            DestroyDynamicPickup(DealerGold[id][dgoldPickup]);

        if (IsValidDynamicMapIcon(DealerGold[id][dgoldMap]))
            DestroyDynamicMapIcon(DealerGold[id][dgoldMap]);

        // Determine the type of dealer
        new type[128];
        switch (DealerGold[id][dealgoldType])
        {
            case 1: type = "VIP";
            case 2: type = "VIP";
            case 3: type = "VIP";
            case 4: type = "VIP Plane";
            case 5: type = "VIP Plane";
            default: type = "Unknown";
        }

        // Format the text based on dealer's state
        new tstr[218];
        if (DealerGold[id][dealergoldPosX] != 0 && DealerGold[id][dealergoldPosY] != 0 && DealerGold[id][dealergoldPosZ] != 0)
        {
            if (strcmp(DealerGold[id][dealgoldOwner], "-") != 0 || DealerGold[id][dealgoldOwnerID] != 0)
            {
                format(tstr, sizeof(tstr), "[ID: %d]\n" WHITE_E "Name: {FFFF00}%s\n" WHITE_E "Owned by %s\nType: " YELLOW_E "%s\n" WHITE_E "Use " RED_E "/buypg " WHITE_E "to buy vehicle in this dealership",
                       id, DealerGold[id][dealgoldName], DealerGold[id][dealgoldOwner], type);
            }
            else
            {
                format(tstr, sizeof(tstr), "[ID: %d]\n" WHITE_E "This dealership for sale\nLocation: %s\nPrice: " GREEN_E "%d\n" WHITE_E "Type: " YELLOW_E "%s",
                       id, GetLocation(DealerGold[id][dealergoldPosX], DealerGold[id][dealergoldPosY], DealerGold[id][dealergoldPosZ]), DealerGold[id][dealgoldPrice], type);
            }
            
            DealerGold[id][dgoldLabel] = CreateDynamic3DTextLabel(tstr, COLOR_LBLUE, DealerGold[id][dealergoldPosX], DealerGold[id][dealergoldPosY], DealerGold[id][dealergoldPosZ], 5.0);
            DealerGold[id][dgoldPickup] = CreateDynamicPickup(1239, 23, DealerGold[id][dealergoldPosX], DealerGold[id][dealergoldPosY], DealerGold[id][dealergoldPosZ]);

            DealerGold[id][dgoldMap] = CreateDynamicMapIcon(DealerGold[id][dealergoldPosX], DealerGold[id][dealergoldPosY], DealerGold[id][dealergoldPosZ], 55, -1, -1, -1, -1, 70.0);
        }
        else
        {
            DestroyDynamicMapIcon(DealerGold[id][dgoldMap]);
        }

        printf("DEBUG: DgoldRefresh Called on Dealer ID %d", id);
    }
}

DgoldReset(id)
{
	format(DealerGold[id][dealgoldOwner], MAX_PLAYER_NAME, "-");
	DestroyDynamicPickup(DealerGold[id][dgoldPickup]);
	DestroyDynamicPickup(DealerGold[id][dgoldPickupPoint]);
	DealerGold[id][dealgoldOwnerID] = 0;
	DealerGold[id][dealgoldLocked] = 1;
    DealerGold[id][dealgoldMoney] = 0;
	DealerGold[id][dgoldStock] = 0;
	DealerGold[id][dgoldVisit] = 0;
	DealerGold[id][dgoldRestock] = 0;
	DealerGold[id][dgP][0] = 0;
	DealerGold[id][dgP][1] = 0;
	DealerGold[id][dgP][2] = 0;
	DealerGold[id][dgP][3] = 0;
	DealerGold[id][dgP][4] = 0;
	DealerGold[id][dgP][5] = 0;
	DealerGold[id][dgP][6] = 0;
	DealerGold[id][dgP][7] = 0;
	DealerGold[id][dgP][8] = 0;
	DealerGold[id][dgP][9] = 0;
	DgoldRefresh(id);
}

PlayerOwnsDgold(playerid, id)
{
	// if(!IsPlayerConnected(playerid)) return 0;
	// if(id == -1) return 0;
	return (DealerGold[id][dealgoldOwnerID] == pData[playerid][pName]) || (!strcmp(DealerGold[id][dealgoldOwner], pData[playerid][pName], true));
	// return 0;
}

// Player_DealerCount(playerid)
// {
// 	#if LIMIT_PER_PLAYER != 0
//     new count;
// 	foreach(new i : Dgold)
// 	{
// 		if(PlayerOwnsDgold(playerid, i)) count++;
// 	}
// 	return count;
// 	#else
// 		return 0;
// 	#endif
// }
stock CountPlayerVehgold(playerid)
{
    new count = 0;
    foreach(new i : PVehicles)
    {
        if (pvData[i][cOwner] == pData[playerid][pID])
            count++;
    }
    return count;
}

Dgold_ProductMenu(playerid, dgoldid)
{
    if(dgoldid <= -1)
        return 0;

    static
        string[512];

    switch (DealerGold[dgoldid][dealgoldType])
    {
        case 1:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}NRG-500\t{7fff00}%d\n{ffffff}Mower\t{7fff00}%d\n{ffffff}Kart\t{7fff00}%d\n{ffffff}Tracktor\t{7fff00}%d\n{ffffff}Dune\t{7fff00}%d\n{ffffff}Stafford\t{7fff00}%d\n{ffffff}Patriot\t{7fff00}%d\n{ffffff}Banshee\t{7fff00}%d\n{ffffff}Bullet\t{7fff00}%d\n{ffffff}Cheetah\t{7fff00}%d",
                DealerGold[dgoldid][dgP][0],
                DealerGold[dgoldid][dgP][1],
                DealerGold[dgoldid][dgP][2],
				DealerGold[dgoldid][dgP][3],
                DealerGold[dgoldid][dgP][4],
                DealerGold[dgoldid][dgP][5],
				DealerGold[dgoldid][dgP][6],
                DealerGold[dgoldid][dgP][7],
                DealerGold[dgoldid][dgP][8],
                DealerGold[dgoldid][dgP][9]
            );
            ShowPlayerDialog(playerid, DGOLD_EDITPROD, DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
        case 2:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Hotring Racer 2\t{7fff00}%d\n{ffffff}Supet GT\t{7fff00}%d\n{ffffff}Turismo\t{7fff00}%d\n{ffffff}ZR-350\t{7fff00}%d\n{ffffff}Phoenix\t{7fff00}%d\n{ffffff}Monster\t{7fff00}%d\n{ffffff}Sandking\t{7fff00}%d\n{ffffff}Stretch\t{7fff00}%d\n{ffffff}Caddy\t{7fff00}%d\n{ffffff}Bf-Injection\t{7fff00}%d",
                DealerGold[dgoldid][dgP][0],
                DealerGold[dgoldid][dgP][1],
                DealerGold[dgoldid][dgP][2],
                DealerGold[dgoldid][dgP][3],
                DealerGold[dgoldid][dgP][4],
                DealerGold[dgoldid][dgP][5],
                DealerGold[dgoldid][dgP][6],
                DealerGold[dgoldid][dgP][7],
                DealerGold[dgoldid][dgP][8],
                DealerGold[dgoldid][dgP][9]
            );
            ShowPlayerDialog(playerid, DGOLD_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
        case 3:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Bloodring Banger\t{7fff00}%d\n{ffffff}Hotknife\t{7fff00}%d\n{ffffff}Club\t{7fff00}%d\n{ffffff}Infernus\t{7fff00}%d\n{ffffff}Bandito\t{7fff00}%d\n{ffffff}Bloodring Banger\t{7fff00}%d\n{ffffff}Hotknife\t{7fff00}%d\n{ffffff}Club\t{7fff00}%d\n{ffffff}Infernus\t{7fff00}%d\n{ffffff}Bandito\t{7fff00}%d",
                DealerGold[dgoldid][dgP][0],
                DealerGold[dgoldid][dgP][1],
                DealerGold[dgoldid][dgP][2],
				DealerGold[dgoldid][dgP][3],
                DealerGold[dgoldid][dgP][4],
                DealerGold[dgoldid][dgP][5],
				DealerGold[dgoldid][dgP][6],
                DealerGold[dgoldid][dgP][7],
                DealerGold[dgoldid][dgP][8],
                DealerGold[dgoldid][dgP][9]
            );
            ShowPlayerDialog(playerid, DGOLD_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
        case 4:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Maverick\t{7fff00}%d\n{ffffff}Leviathan\t{7fff00}%d\n{ffffff}Sparrow\t{7fff00}%d\n{ffffff}Skimmer\t{7fff00}%d\n{ffffff}Shamal\t{7fff00}%d\n{ffffff}Maverick\t{7fff00}%d\n{ffffff}Leviathan\t{7fff00}%d\n{ffffff}Sparrow\t{7fff00}%d\n{ffffff}Skimmer\t{7fff00}%d\n{ffffff}Shamal\t{7fff00}%d",
                DealerGold[dgoldid][dgP][0],
                DealerGold[dgoldid][dgP][1],
                DealerGold[dgoldid][dgP][2],
				DealerGold[dgoldid][dgP][3],
                DealerGold[dgoldid][dgP][4],
                DealerGold[dgoldid][dgP][5],
				DealerGold[dgoldid][dgP][6],
                DealerGold[dgoldid][dgP][7],
                DealerGold[dgoldid][dgP][8],
                DealerGold[dgoldid][dgP][9]
            );
            ShowPlayerDialog(playerid, DGOLD_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
		case 5:
        {
            format(string, sizeof(string), "Produk\tHarga\n{ffffff}Squalo\t{7fff00}%d\n{ffffff}Dinghy\t{7fff00}%d\n{ffffff}Jetmax\t{7fff00}%d\n{ffffff}Marquis\t{7fff00}%d\n{ffffff}Reefer\t{7fff00}%d\n{ffffff}Speeder\t{7fff00}%d\n{ffffff}Squalo\t{7fff00}%d\n{ffffff}Tropic\t{7fff00}%d\n{ffffff}Dinghy\t{7fff00}%d\n{ffffff}Jetmax\t{7fff00}%d",
                DealerGold[dgoldid][dgP][0],
                DealerGold[dgoldid][dgP][1],
                DealerGold[dgoldid][dgP][2],
				DealerGold[dgoldid][dgP][3],
                DealerGold[dgoldid][dgP][4],
                DealerGold[dgoldid][dgP][5],
				DealerGold[dgoldid][dgP][6],
                DealerGold[dgoldid][dgP][7],
                DealerGold[dgoldid][dgP][8],
                DealerGold[dgoldid][dgP][9]
            );
            ShowPlayerDialog(playerid, DGOLD_EDITPROD,DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Item", string, "Modify", "Cancel");
        }
    }
    return 1;
}

DgoldBuyVehicle(playerid, dgoldid)
{
	if(dgoldid <= -1 )
        return 0;

    switch(DealerGold[dgoldid][dealgoldType])
    {
        case 1:
        {
			
			new maxAllowed;
            if(pData[playerid][pVip] == 1)
                maxAllowed = 4;
            else if(pData[playerid][pVip] == 2)
                maxAllowed = 5; 
            else if(pData[playerid][pVip] == 3)
                maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
			new ownedCount = CountPlayerVehgold(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold",
			GetVehicleModelName(522), DealerGold[dgoldid][dgP][0],
			GetVehicleModelName(572), DealerGold[dgoldid][dgP][1],
			GetVehicleModelName(571), DealerGold[dgoldid][dgP][2],
			GetVehicleModelName(531), DealerGold[dgoldid][dgP][3],
			GetVehicleModelName(573), DealerGold[dgoldid][dgP][4],
			GetVehicleModelName(580), DealerGold[dgoldid][dgP][5],
			GetVehicleModelName(471), DealerGold[dgoldid][dgP][6],
			GetVehicleModelName(429), DealerGold[dgoldid][dgP][7],
			GetVehicleModelName(541), DealerGold[dgoldid][dgP][8],
			GetVehicleModelName(415), DealerGold[dgoldid][dgP][9]
			);

			ShowPlayerDialog(playerid, DIALOG_GOLD1, DIALOG_STYLE_LIST, "VIP Dealership", str, "Buy", "Close");
		}
        case 2:
        {
			new maxAllowed;

            if(pData[playerid][pVip] == 1)
                maxAllowed = 4;
            else if(pData[playerid][pVip] == 2)
                maxAllowed = 5; 
            else if(pData[playerid][pVip] == 3)
                maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehgold(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold",
			GetVehicleModelName(502), DealerGold[dgoldid][dgP][0],
			GetVehicleModelName(506), DealerGold[dgoldid][dgP][1],
			GetVehicleModelName(451), DealerGold[dgoldid][dgP][2],
			GetVehicleModelName(477), DealerGold[dgoldid][dgP][3],
			GetVehicleModelName(603), DealerGold[dgoldid][dgP][4],
			GetVehicleModelName(557), DealerGold[dgoldid][dgP][5],
			GetVehicleModelName(495), DealerGold[dgoldid][dgP][6],
			GetVehicleModelName(409), DealerGold[dgoldid][dgP][7],
			GetVehicleModelName(457), DealerGold[dgoldid][dgP][8],
			GetVehicleModelName(424), DealerGold[dgoldid][dgP][9]
			);

			ShowPlayerDialog(playerid, DIALOG_GOLD2, DIALOG_STYLE_LIST, "VIP Dealership", str, "Buy", "Close");
		}
        case 3:
        {
			new maxAllowed;

            if(pData[playerid][pVip] == 1)
                maxAllowed = 4;
            else if(pData[playerid][pVip] == 2)
                maxAllowed = 5; 
            else if(pData[playerid][pVip] == 3)
                maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehgold(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold",
			GetVehicleModelName(504), DealerGold[dgoldid][dgP][0],
			GetVehicleModelName(434), DealerGold[dgoldid][dgP][1],
			GetVehicleModelName(589), DealerGold[dgoldid][dgP][2],
			GetVehicleModelName(411), DealerGold[dgoldid][dgP][3],
			GetVehicleModelName(568), DealerGold[dgoldid][dgP][4],
			GetVehicleModelName(504), DealerGold[dgoldid][dgP][5],
			GetVehicleModelName(434), DealerGold[dgoldid][dgP][6],
			GetVehicleModelName(589), DealerGold[dgoldid][dgP][7],
			GetVehicleModelName(411), DealerGold[dgoldid][dgP][8],
			GetVehicleModelName(568), DealerGold[dgoldid][dgP][9]
			);

			ShowPlayerDialog(playerid, DIALOG_GOLD3, DIALOG_STYLE_LIST, "VIP Dealership", str, "Buy", "Close");
		}
        case 4:
		{
			new maxAllowed;

            if(pData[playerid][pVip] == 1)
                maxAllowed = 4;
            else if(pData[playerid][pVip] == 2)
                maxAllowed = 5; 
            else if(pData[playerid][pVip] == 3)
                maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehgold(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
			//Job Cars
			new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold",
			GetVehicleModelName(487), DealerGold[dgoldid][dgP][0],
			GetVehicleModelName(417), DealerGold[dgoldid][dgP][1],
			GetVehicleModelName(469), DealerGold[dgoldid][dgP][2],
			GetVehicleModelName(460), DealerGold[dgoldid][dgP][3],
			GetVehicleModelName(519), DealerGold[dgoldid][dgP][4],
			GetVehicleModelName(487), DealerGold[dgoldid][dgP][5],
			GetVehicleModelName(417), DealerGold[dgoldid][dgP][6],
			GetVehicleModelName(469), DealerGold[dgoldid][dgP][7],
			GetVehicleModelName(460), DealerGold[dgoldid][dgP][8],
			GetVehicleModelName(519), DealerGold[dgoldid][dgP][9]
			);

			ShowPlayerDialog(playerid, DIALOG_GOLD4, DIALOG_STYLE_LIST, "VIP", str, "Buy", "Close");
		}
        case 5:
        {
			new maxAllowed;

            if(pData[playerid][pVip] == 1)
                maxAllowed = 4;
            else if(pData[playerid][pVip] == 2)
                maxAllowed = 5; 
            else if(pData[playerid][pVip] == 3)
                maxAllowed = 6; 
			else if(pData[playerid][pVip] == 4)
				maxAllowed = 10; 
            new ownedCount = CountPlayerVehgold(playerid);

            if(ownedCount >= maxAllowed)
            {
                SendClientMessage(playerid, COLOR_RED, "Anda sudah mencapai batas pembelian kendaraan.");
                return 1;
            }
            new str[1024];
			format(str, sizeof(str), "%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold\n%s\t{7fff00}%d Gold",
			GetVehicleModelName(446), DealerGold[dgoldid][dgP][0],
			GetVehicleModelName(473), DealerGold[dgoldid][dgP][1],
			GetVehicleModelName(493), DealerGold[dgoldid][dgP][2],
			GetVehicleModelName(484), DealerGold[dgoldid][dgP][3],
			GetVehicleModelName(453), DealerGold[dgoldid][dgP][4],
			GetVehicleModelName(452), DealerGold[dgoldid][dgP][5],
			GetVehicleModelName(446), DealerGold[dgoldid][dgP][6],
			GetVehicleModelName(454), DealerGold[dgoldid][dgP][7],
			GetVehicleModelName(473), DealerGold[dgoldid][dgP][8],
			GetVehicleModelName(493), DealerGold[dgoldid][dgP][9]
			);

			ShowPlayerDialog(playerid, DIALOG_GOLD5, DIALOG_STYLE_LIST, "VIP", str, "Buy", "Close");
		}
    }
    return 1;
}


/* ============ [ Hook, Function goes here ] ============ */

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_GOLD1)
	{
		static
        dgoldid = -1,
        price;

		if((dgoldid = pData[playerid][pGoldDealer]) != -1 && response)
		{
			price = DealerGold[dgoldid][dgP][listitem];

			if(pData[playerid][pGold] < price)
				return Error(playerid, "Not enough gold!");

			if(DealerGold[dgoldid][dgoldStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerGold[dgoldid][dealgoldType] == 1)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 522;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), DealerGold[dgoldid][dgP][0]);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 572;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
					
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 571;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 531;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 573;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 580;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 470;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 429;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 541;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 415;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
				}
			}
		}
	}
    if(dialogid == DIALOG_GOLD2)
	{
		static
        dgoldid = -1,
        price;

		if((dgoldid = pData[playerid][pGoldDealer]) != -1 && response)
		{
			price = DealerGold[dgoldid][dgP][listitem];

			if(pData[playerid][pGold] < price)
				return Error(playerid, "Not enough money!");

			if(DealerGold[dgoldid][dgoldStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerGold[dgoldid][dealgoldType] == 2)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 502;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 506;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 451;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 477;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 603;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 557;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
					
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 495;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 409;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 457;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 424;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_GOLD3)
	{
		static
        dgoldid = -1,
        price;

		if((dgoldid = pData[playerid][pGoldDealer]) != -1 && response)
		{
			price = DealerGold[dgoldid][dgP][listitem];

			if(pData[playerid][pGold] < price)
				return Error(playerid, "Not enough gold!");

			if(DealerGold[dgoldid][dgoldStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerGold[dgoldid][dealgoldType] == 3)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 504;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 434;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 589;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
	
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 411;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 568;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 504;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 434;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 589;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);

						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 411;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 568;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_GOLD4)
	{
		static
        dgoldid = -1,
        price;

		if((dgoldid = pData[playerid][pGoldDealer]) != -1 && response)
		{
			price = DealerGold[dgoldid][dgP][listitem];

			if(pData[playerid][pGold] < price)
				return Error(playerid, "Not enough money!");

			if(DealerGold[dgoldid][dgoldStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerGold[dgoldid][dealgoldType] == 4)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 487;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 417;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 469;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 460;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 519;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 587;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
					
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 417;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 469;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 460;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 519;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
				}
			}
		}
	}
    if(dialogid == DIALOG_GOLD5)
	{
		static
        dgoldid = -1,
        price;

		if((dgoldid = pData[playerid][pGoldDealer]) != -1 && response)
		{
			price = DealerGold[dgoldid][dgP][listitem];

			if(pData[playerid][pGold] < price)
				return Error(playerid, "Not enough money!");

			if(DealerGold[dgoldid][dgoldStock] < 1)
				return Error(playerid, "This Dealer is out of stock product.");

			if(DealerGold[dgoldid][dealgoldType] == 5)
			{
				switch(listitem)
				{
					case 0:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 446;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][0];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
					
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 1:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 473;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][1];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 2:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 493;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][2];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 3:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 484;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][3];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 4:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 453;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][4];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 5:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 452;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][5];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 6:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 446;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][6];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 7:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 454;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][7];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 8:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 473;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][8];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
					case 9:
					{
						if(price == 0)
							return Error(playerid, "Harga produk belum di setel oleh pemilik dealer");
						new modelid = 493;
						new tstr[128];
						price = DealerGold[dgoldid][dgP][9];
						pData[playerid][pBuyPvModel] = modelid;
						format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), price);
						if(pData[playerid][pGold] < price)
						{
							Error(playerid, "Gold anda tidak mencukupi.!");
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
						new ownedCount = CountPlayerVehgold(playerid);
						if(ownedCount >= maxAllowed)
						{
							Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
							return 1;
						}
						new cQuery[1024];
						new Float:x,Float:y,Float:z, Float:a;
						new model, color1, color2;
						DealerGold[dgoldid][dealgoldMoney] += price;
						DealerGold[dgoldid][dgoldStock]--;
						if(DealerGold[dgoldid][dgoldStock] < 0)
							return Error(playerid, "This dealer is out of stock product.");
						pData[playerid][pGold] -= price;
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Purchase a vehicle at a dealership %s ", ReturnName(playerid), DealerGold[dgoldid][dealgoldName]);
						color1 = 1;
						color2 = 1;
						model = modelid;
						x = DealerGold[dgoldid][dgoldPointX];
						y = DealerGold[dgoldid][dgoldPointY];
						z = DealerGold[dgoldid][dgoldPointZ];
						DgoldSave(dgoldid);
						DgoldRefresh(dgoldid);
						mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, price, x, y, z, a);
						mysql_tquery(g_SQL, cQuery, "OnVehDgold", "ddddddffff", playerid, pData[playerid][pID], model, color1, color2, price, x, y, z, a);
					}
				}
			}
		}
	}
    if(dialogid == DIALOG_DGOLD_MANAGE)
	{
		new dgoldid = pData[playerid][pGoldDealer];
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new string[258];
					format(string, sizeof(string), "Dealer ID: %d\nDealer Name : %s\nDealer Location: %s\nDealership Vault: %d\nDealership Stock: %d",
					dgoldid, DealerGold[dgoldid][dealgoldName], GetLocation(DealerGold[dgoldid][dealergoldPosX], DealerGold[dgoldid][dealergoldPosY], DealerGold[dgoldid][dealergoldPosZ]), DealerGold[dgoldid][dealgoldMoney], DealerGold[dgoldid][dgoldStock]);

					ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Dealerhip Information", string, "Cancel", "");
				}
				case 1:
				{
					new string[218];
					format(string, sizeof(string), "Tulis Nama Dealer baru yang anda inginkan : ( Nama Dealer Lama %s )", DealerGold[dgoldid][dealgoldName]);
					ShowPlayerDialog(playerid, DIALOG_DGOLD_NAME, DIALOG_STYLE_INPUT, "Dealership Change Name", string, "Select", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, DIALOG_DGOLD_VAULT, DIALOG_STYLE_LIST,"Dealership Vault","Dealership Deposit\nDealership Withdraw","Select","Cancel");
				}
				case 3:
				{
					if(DealerGold[dgoldid][dgoldStock] > 25)
						return Error(playerid, "Dealership ini masih memiliki cukup produck.");
					if(DealerGold[dgoldid][dealgoldMoney] < 75000)
						return Error(playerid, "Setidaknya anda mempunyai Gold dalam dealer anda senilai $75.000 untuk merestock product.");
					DealerGold[dgoldid][dgoldRestock] = 1;
					Info(playerid, "Anda berhasil request untuk mengisi stock kendaraan kepada trucker, harap tunggu sampai pekerja trucker melayani.");
				}
				case 4:
				{
					Dgold_ProductMenu(playerid, dgoldid);
				}
			}
		}
		return 1;
	}
    if(dialogid == DIALOG_DGOLD_NAME)
	{
		if(response)
		{
			new bid = pData[playerid][pGoldDealer];

			if(!PlayerOwnsDgold(playerid, pData[playerid][pGoldDealer])) return Error(playerid, "You don't own this Dealership.");

			if (isnull(inputtext))
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Dealership tidak di perbolehkan kosong!\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerGold[bid][dealgoldName]);
				ShowPlayerDialog(playerid, DIALOG_DGOLD_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			if(strlen(inputtext) > 32 || strlen(inputtext) < 5)
			{
				new mstr[512];
				format(mstr,sizeof(mstr),""RED_E"NOTE: "WHITE_E"Nama Dealership harus 5 sampai 32 kata.\n\n"WHITE_E"Nama Dealership sebelumnya: %s\n\nMasukkan nama Dealer yang kamu inginkan\nMaksimal 32 karakter untuk nama Dealer", DealerGold[bid][dealgoldName]);
				ShowPlayerDialog(playerid, DIALOG_DGOLD_NAME, DIALOG_STYLE_INPUT,"Dealership Change Name", mstr,"Done","Back");
				return 1;
			}
			format(DealerGold[bid][dealgoldName], 32, ColouredText(inputtext));

			DgoldRefresh(bid);
			DgoldSave(bid);

			SendClientMessageEx(playerid, COLOR_LBLUE,"Dealer name set to: \"%s\".", DealerGold[bid][dealgoldName]);
		}
		else return callcmd::dgoldmanage(playerid, "\0");
		return 1;
	}
    if(dialogid == DIALOG_DGOLD_VAULT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Gold kamu: %d.\n\nMasukkan berapa banyak Gold yang akan kamu simpan di dalam Dealership ini", pData[playerid][pGold]);
					ShowPlayerDialog(playerid, DIALOG_DGOLD_DEPOSIT, DIALOG_STYLE_INPUT, "Dealer Deposit Input", mstr, "Deposit", "Cancel");
				}
				case 1:
				{
					new mstr[512];
					format(mstr,sizeof(mstr),"Dealer Vault: %d\n\nMasukkan berapa banyak Gold yang akan kamu ambil di dalam Dealer ini", DealerGold[pData[playerid][pGoldDealer]][dealgoldMoney]);
					ShowPlayerDialog(playerid, DIALOG_DGOLD_WITHDRAW, DIALOG_STYLE_INPUT,"Dealer Withdraw Input", mstr, "Withdraw","Cancel");
				}
			}
		}
	}
    if(dialogid == DIALOG_DGOLD_WITHDRAW)
	{
		if(response)
		{
			new bid = pData[playerid][pGoldDealer];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > DealerGold[bid][dealgoldMoney])
				return Error(playerid, "Invalid amount specified!");

			DealerGold[bid][dealgoldMoney] -= amount;
			DgoldSave(bid);

			pData[playerid][pGold] += amount;

			Info(playerid, "You have withdrawn %d from the Dealership vault.", strval(inputtext));
		}
		else
			ShowPlayerDialog(playerid, DIALOG_DGOLD_VAULT, DIALOG_STYLE_LIST,"Dealer Vault","Dealership Deposit\nDealership Withdraw","Next","Back");
		return 1;
	}
    if(dialogid == DIALOG_DGOLD_DEPOSIT)
	{
		if(response)
		{
			new bid = pData[playerid][pGoldDealer];
			new amount = floatround(strval(inputtext));
			if(amount < 1 || amount > pData[playerid][pGold])
				return Error(playerid, "Invalid amount specified!");

			DealerGold[bid][dealgoldMoney] += amount;
			DgoldSave(bid);

			pData[playerid][pGold] -= amount;

			Info(playerid, "You have deposit %d into the Dealership vault.", strval(inputtext));
		}
		else
			ShowPlayerDialog(playerid, DIALOG_DGOLD_VAULT, DIALOG_STYLE_LIST,"Dealership Vault","Dealership Deposit\nDealership Withdraw","Next","Back");
		return 1;
	}
	return 1;
}

function OnVehDgold(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
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
	pvData[i][cSpawn] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
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
	OnVehicleDgoldRespawn(i);
	Servers(playerid, "Anda telah membeli kendaraan %s", GetVehicleModelName(model));
	pData[playerid][pBuyPvModel] = 0;
	SetPlayerVirtualWorld(playerid, 0);
	MySQL_CreateVehicleStorage(i, pvData[i][cID]);
	KickEx(playerid);
	return 1;
}

function OnVehicleDgoldRespawn(i)
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

function OnDgoldCreated(dgoldid)
{
	DgoldRefresh(dgoldid);
	DgoldSave(dgoldid);
	return 1;
}

function LoadDgold()
{
    static bid;

	new rows = cache_num_rows(), owner[128], name[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", bid);
			cache_get_value_name(i, "owner", owner);
			format(DealerGold[bid][dealgoldOwner], 128, owner);
			cache_get_value_name_int(i, "ownerid", DealerGold[bid][dealgoldOwnerID]);
			cache_get_value_name(i, "name", name);
			format(DealerGold[bid][dealgoldName], 128, name);
			cache_get_value_name_int(i, "type", DealerGold[bid][dealgoldType]);
			cache_get_value_name_int(i, "price", DealerGold[bid][dealgoldPrice]);
			cache_get_value_name_float(i, "posx", DealerGold[bid][dealergoldPosX]);
			cache_get_value_name_float(i, "posy", DealerGold[bid][dealergoldPosY]);
			cache_get_value_name_float(i, "posz", DealerGold[bid][dealergoldPosZ]);
			cache_get_value_name_float(i, "posa", DealerGold[bid][dealergoldPosA]);
			cache_get_value_name_int(i, "dprice0", DealerGold[bid][dgP][0]);
			cache_get_value_name_int(i, "dprice1", DealerGold[bid][dgP][1]);
			cache_get_value_name_int(i, "dprice2", DealerGold[bid][dgP][2]);
			cache_get_value_name_int(i, "dprice3", DealerGold[bid][dgP][3]);
			cache_get_value_name_int(i, "dprice4", DealerGold[bid][dgP][4]);
			cache_get_value_name_int(i, "dprice5", DealerGold[bid][dgP][5]);
			cache_get_value_name_int(i, "dprice6", DealerGold[bid][dgP][6]);
			cache_get_value_name_int(i, "dprice7", DealerGold[bid][dgP][7]);
			cache_get_value_name_int(i, "dprice8", DealerGold[bid][dgP][8]);
			cache_get_value_name_int(i, "dprice9", DealerGold[bid][dgP][9]);
			cache_get_value_name_int(i, "money", DealerGold[bid][dealgoldMoney]);
			cache_get_value_name_int(i, "locked", DealerGold[bid][dealgoldLocked]);
			cache_get_value_name_int(i, "stock", DealerGold[bid][dgoldStock]);
			cache_get_value_name_float(i, "pointx", DealerGold[bid][dgoldPointX]);
			cache_get_value_name_float(i, "pointy", DealerGold[bid][dgoldPointY]);
			cache_get_value_name_float(i, "pointz", DealerGold[bid][dgoldPointZ]);
			cache_get_value_name_int(i, "dvisit", DealerGold[bid][dgoldVisit]);
			cache_get_value_name_int(i, "restock", DealerGold[bid][dgoldRestock]);
			DgoldRefresh(bid);
			DgoldPointRefresh(bid);
			Iter_Add(Dgold, bid);
		}
		printf("[Dynamic Dealergold] Number of Loaded: %d.", rows);
	}
}


ptask PlayerDgoldUpdate[1000](playerid)
{
	foreach(new vid : Dgold)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, DealerGold[vid][dealergoldPosX], DealerGold[vid][dealergoldPosY], DealerGold[vid][dealergoldPosZ]))
		{
			pData[playerid][pGoldDealer] = vid;
			/*Info(playerid, "DEBUG MESSAGE: Kamu berada di dekat Dealer ID %d", vid);*/
		}
	}
	return 1;
}
