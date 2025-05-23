#define MAX_GARAGE 500

enum    garageData
{
    garageOwner[MAX_PLAYER_NAME],
    garageOwnerID,
    garagePrice,
    garageSlot,
	Float: garagePosX,
	Float: garagePosY,
	Float: garagePosZ,
	garageInt,
	garageWorld,
	garagePickup,
	Text3D: garageLabel
}

new GarageData[MAX_GARAGE][garageData],
	Iterator:Garages<MAX_GARAGE>;

function LoadGarage()
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
  	{
 		new id, i = 0, owner[128];
		while(i < rows)
		{
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name(i, "owner", owner);
			format(GarageData[id][garageOwner], 128, owner);
            cache_get_value_name_int(i, "ownerid", GarageData[id][garageOwnerID]);
            cache_get_value_name_int(i, "price", GarageData[id][garagePrice]);
            cache_get_value_name_int(i, "slot", GarageData[id][garageSlot]);
			cache_get_value_name_float(i, "posx", GarageData[id][garagePosX]);
			cache_get_value_name_float(i, "posy", GarageData[id][garagePosY]);
			cache_get_value_name_float(i, "posz", GarageData[id][garagePosZ]);
			cache_get_value_name_int(i, "interior", GarageData[id][garageInt]);
			cache_get_value_name_int(i, "world", GarageData[id][garageWorld]);
            
            Garage_Refresh(id);
            Iter_Add(Garages, id);
	    	i++;
		}
		printf("[Garage]: %d Loaded.", i);
	}
}

stock Garage_Refresh(i)
{
    static str[128];
    if(i != -1)
    {
        if(IsValidDynamic3DTextLabel(GarageData[i][garageLabel]))
            DestroyDynamic3DTextLabel(GarageData[i][garageLabel]);

        if(IsValidDynamicPickup(GarageData[i][garagePickup]))
            DestroyDynamicPickup(GarageData[i][garagePickup]);

        if(strcmp(GarageData[i][garageOwner], "-") || GarageData[i][garageOwnerID] != 0)
		{
            format(str, sizeof(str), "[GARAGE ID: %d]\n{ffffff}Owner: {00FF00}%s{FFFFFF}\nPark Slot: {00FF00}%d"YELLOW_E"\nPress 'Y' to Parkveh/ PickupVeh", i, GarageData[i][garageOwner], GarageData[i][garageSlot]);
        }
        else
        {
            format(str, sizeof(str), "[GARAGE ID: %d]\n{ffffff}Price: {00FF00}%s{FFFFFF}\nPark Slot: {00FF00}%d"YELLOW_E"\nType {FFFF00}'/buy' {FFFFFF}to buy", i, FormatMoney(GarageData[i][garagePrice]), GarageData[i][garageSlot]);
        }
        GarageData[i][garagePickup] = CreateDynamicPickup(19134, 23, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ], GarageData[i][garageWorld],  GarageData[i][garageInt], -1, 50);
		GarageData[i][garageLabel] = CreateDynamic3DTextLabel(str, ARWIN, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GarageData[i][garageWorld], GarageData[i][garageInt], -1, 10.0);
    }
    return 1;
}

stock Garage_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE garage SET owner='%s', ownerid='%d', price='%d', slot='%d', posx='%f', posy='%f', posz='%f', interior=%d, world=%d WHERE id=%d",
	GarageData[id][garageOwner],
    GarageData[id][garageOwnerID],
    GarageData[id][garagePrice],
    GarageData[id][garageSlot],
    GarageData[id][garagePosX],
	GarageData[id][garagePosY],
	GarageData[id][garagePosZ],
	GarageData[id][garageInt],
	GarageData[id][garageWorld],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}


stock GetClosestGarage(playerid, Float: range = 4.3)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Garages)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist && GetPlayerInterior(playerid) == GarageData[i][garageInt] && GetPlayerVirtualWorld(playerid) == GarageData[i][garageWorld])
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

stock ReturnAnyVehicleGarage(slot, i)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_PRIVATE_VEHICLE) return -1;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cGarage] == i && pvData[id][cGarage] > -1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

stock CountGarageVeh(id)
{
	if(id > -1)
	{
		new count = 0;
		foreach(new i : PVehicles)
		{
			if(pvData[i][cGarage] == id)
				count++;
		}
		return count;
	}
	return 0;
}

stock GetAnyVehicleGarage(i)
{
	new tmpcount;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cGarage] == i)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

stock GetNearbyGarage(playerid)
{
	for(new i = 0; i < MAX_GARAGE; i ++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]))
	    {
	        return i;
	    }
	}
	return -1;
}

stock Player_OwnsGarage(playerid, id)
{
	return (GarageData[id][garageOwnerID] == pData[playerid][pID]) || (!strcmp(GarageData[id][garageOwner], pData[playerid][pName], true));
}


CMD:creategarage(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	new id = Iter_Free(Garages), query[512];
	if(id == -1) return Error(playerid, "Can't add any more garage Point.");
    new price, slot;
    if(sscanf(params, "dd", price, slot))   return Usage(playerid, "/creategarage [price] [slot]");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
	
    format(GarageData[id][garageOwner], 128, "-");
    GarageData[id][garageOwnerID] = 0;
    GarageData[id][garagePrice] = price;
    GarageData[id][garageSlot] = slot;
	GarageData[id][garagePosX] = x;
	GarageData[id][garagePosY] = y;
	GarageData[id][garagePosZ] = z;
	GarageData[id][garageInt] = GetPlayerInterior(playerid);
	GarageData[id][garageWorld] = GetPlayerVirtualWorld(playerid);
	
	Garage_Refresh(id);
	Iter_Add(Garages, id);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO garage SET id='%d', owner='%s', ownerid='%d', price='%d', slot='%d', posx='%f', posy='%f', posz='%f', interior=%d, world=%d", id, GarageData[id][garageOwner], GarageData[id][garageOwnerID], GarageData[id][garagePrice], GarageData[id][garageSlot], GarageData[id][garagePosX], GarageData[id][garagePosY], GarageData[id][garagePosZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query, "OnGarageCreated", "ii", playerid, id);
	return 1;
}

function OnGarageCreated(playerid, id)
{
	Garage_Save(id);
	Servers(playerid, "You has created garage Point id: %d.", id);
	new str[150];
	format(str,sizeof(str),"[Garage]: %s membuat garage id %d!", GetRPName(playerid), id);
	LogServer("Admin", str);	
	return 1;
}

CMD:removegarage(playerid, params[])
{
    if(pData[playerid][pAdmin] < 7)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return Usage(playerid, "/removegarage [id]");
	if(!Iter_Contains(Garages, id)) return Error(playerid, "Invalid ID.");
	
	DestroyDynamic3DTextLabel(GarageData[id][garageLabel]);
	DestroyDynamicPickup(GarageData[id][garagePickup]);
	
    GarageData[id][garagePrice] = 0;
    GarageData[id][garageSlot] = 0;
	GarageData[id][garagePosX] = GarageData[id][garagePosY] = GarageData[id][garagePosZ] = 0.0;
	GarageData[id][garageInt] = GarageData[id][garageWorld] = 0;
	GarageData[id][garagePickup] = -1;
	GarageData[id][garageLabel] = Text3D: -1;
	Iter_Remove(Garages, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM parks WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "Menghapus ID Garage Point %d.", id);
	new str[150];
	format(str,sizeof(str),"[Garkot]: %s menghapus garkot id %d!", GetRPName(playerid), id);
	LogServer("Admin", str);	
	return 1;
}

CMD:gotogarage(playerid, params[])
{
	new id;
	if(pData[playerid][pAdmin] < 7)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	if(sscanf(params, "d", id))
		return Usage(playerid, "/gotogarage [id]");
	if(!Iter_Contains(Garages, id)) return Error(playerid, "Garage Point ID tidak ada.");
	
	SetPlayerPosition(playerid, GarageData[id][garagePosX], GarageData[id][garagePosY], GarageData[id][garagePosZ], 2.0);
    SetPlayerInterior(playerid, GarageData[id][garageInt]);
    SetPlayerVirtualWorld(playerid, GarageData[id][garageWorld]);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInFamily] = -1;	
	Servers(playerid, "Teleport ke ID Garage Point %d", id);
	return 1;
}

CMD:editgarage(playerid, params[])
{
    static
        gid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 7)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", gid, type, string))
    {
        Usage(playerid, "/editgarage [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, slot, owner, price");
        return 1;
    }
    if((gid < 0 || gid >= MAX_GARAGE))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Garages, gid)) return Error(playerid, "The garage you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, GarageData[gid][garagePosX], GarageData[gid][garagePosY], GarageData[gid][garagePosZ]);
        GarageData[gid][garageInt] = GetPlayerInterior(playerid);
        GarageData[gid][garageWorld] = GetPlayerVirtualWorld(playerid);

        Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the location of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    else if(!strcmp(type, "slot", true))
    {
        new slot;

        if(sscanf(string, "d", slot))
            return Usage(playerid, "/editgarage [id] [slot] [ammount]");

		GarageData[gid][garageSlot] = slot;

        Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the slot of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/editgarage [id] [price] [ammount]");

		GarageData[gid][garagePrice] = price;

        Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the price of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    else if(!strcmp(type, "owner", true))
    {
        new otherid;

        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/editgarage [id] [owner] [playerid]");
        
        format(GarageData[gid][garageOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
		GarageData[gid][garageOwnerID] = pData[otherid][pID];

		Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    return 1;
}
