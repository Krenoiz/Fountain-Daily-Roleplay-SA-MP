
#define MAX_FACTION_VEHICLE 500
#define MAX_FACTIONS 5
enum e_faction_vehicle
{
	fvID,
	bool:fvExists,
	fvModel,
	Float:fvPos[4],
	fvColor[2],
	fvFaction,
	fvVehicle,
};
enum FactionDataInfo
{
    factionID,
    factionExists,
    // Tambahkan field lainnya sesuai kebutuhan
};
new FactionVehicle[MAX_FACTION_VEHICLE][e_faction_vehicle];
new FactionData[MAX_FACTIONS][FactionDataInfo];
stock FactionVehicle_Create(factionid, model, Float:x, Float:y, Float:z, Float:a, color1, color2)
{
    for (new i = 0; i < MAX_FACTION_VEHICLE; i++) 
    {
        if (!FactionVehicle[i][fvExists]) 
        {
            new cQuery[1024];
            FactionVehicle[i][fvPos][0] = x;
            FactionVehicle[i][fvPos][1] = y;
            FactionVehicle[i][fvPos][2] = z;
            FactionVehicle[i][fvPos][3] = a;
            FactionVehicle[i][fvColor][0] = color1;
            FactionVehicle[i][fvColor][1] = color2;
            FactionVehicle[i][fvModel] = model;
            FactionVehicle[i][fvExists] = true;
            FactionVehicle[i][fvFaction] = factionid;

            FactionVehicle[i][fvVehicle] = CreateVehicle(model, x, y, z, a, color1, color2, 60000);
            SetVehicleFuel(FactionVehicle[i][fvVehicle], 2000);

            // Ensure the query string is correctly formatted
            mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `factionvehicle` (`Model`) VALUES(%d)", FactionVehicle[i][fvModel]);
			mysql_tquery(g_SQL, cQuery, "OnFactionVehicleCreated", "d", i);
            return 1;
        }
    }
    return -1;
}

function OnFactionVehicleCreated(id)
{
    FactionVehicle[id][fvID] = cache_insert_id();
    FactionVehicle_Save(id);
}

stock FactionVehicle_Save(id)
{
    if (!FactionVehicle[id][fvExists])
        return 0;

    new query[1012];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE `factionvehicle` SET ""`Model` = '%d', ""`PosX` = '%f', ""`PosY` = '%f', ""`PosZ` = '%f', ""`PosA` = '%f', ""`Color1` = '%d', ""`Color2` = '%d', ""`Faction` = '%d' ""WHERE `ID` = '%d'",FactionVehicle[id][fvModel],FactionVehicle[id][fvPos][0],FactionVehicle[id][fvPos][1],FactionVehicle[id][fvPos][2], FactionVehicle[id][fvPos][3],FactionVehicle[id][fvColor][0],FactionVehicle[id][fvColor][1],FactionVehicle[id][fvFaction],FactionVehicle[id][fvID]);
    
    mysql_query(g_SQL, query, true);
    return 1;
}

function FactionVehicle_Load()
{
    if (cache_num_rows() > 0)
    {
        for (new i = 0; i < cache_num_rows(); i++)
        {
            FactionVehicle[i][fvExists] = true;
            cache_get_value_name_int(i, "ID", FactionVehicle[i][fvID]);
            cache_get_value_name_int(i, "Model", FactionVehicle[i][fvModel]);
            cache_get_value_name_float(i, "PosX", FactionVehicle[i][fvPos][0]);
            cache_get_value_name_float(i, "PosY", FactionVehicle[i][fvPos][1]);
            cache_get_value_name_float(i, "PosZ", FactionVehicle[i][fvPos][2]);
            cache_get_value_name_float(i, "PosA", FactionVehicle[i][fvPos][3]);
            cache_get_value_name_int(i, "Color1", FactionVehicle[i][fvColor][0]);
            cache_get_value_name_int(i, "Color2", FactionVehicle[i][fvColor][1]);
            cache_get_value_name_int(i, "Faction", FactionVehicle[i][fvFaction]);

            FactionVehicle[i][fvVehicle] = CreateVehicle(FactionVehicle[i][fvModel], 
            FactionVehicle[i][fvPos][0], FactionVehicle[i][fvPos][1], FactionVehicle[i][fvPos][2], FactionVehicle[i][fvPos][3], FactionVehicle[i][fvColor][0], FactionVehicle[i][fvColor][1], 60000);
            SetVehicleFuel(FactionVehicle[i][fvVehicle], 2000); // Adjusted fuel value
        }
        printf("[FACTION VEHICLE] Loaded %d faction vehicles from the database", cache_num_rows());
    }
    return 1;
}

stock FactionVehicle_Delete(id)
{
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `factionvehicle` WHERE `ID` = '%d'", FactionVehicle[id][fvID]);
	mysql_query(g_SQL, query, true);

	if(IsValidVehicle(FactionVehicle[id][fvVehicle]))
		DestroyVehicle(FactionVehicle[id][fvVehicle]);

	FactionVehicle[id][fvExists] = false;
	FactionVehicle[id][fvModel] = 0;
	return 1;
}
stock IsFactionVehicle(vehicleid)
{
    for (new i = 0; i < MAX_FACTION_VEHICLE; i++)
    {
        if (FactionVehicle[i][fvExists] && FactionVehicle[i][fvVehicle] == vehicleid)
            return i;
    }

    return -1;
}

CMD:createfactionveh(playerid, params[])
{
	new
	    model[32],
		color1,
		color2,
		factid;

	if(PlayerData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	if (sscanf(params, "ds[32]I(-1)I(-1)", factid, model, color1, color2))
	    return Error(playerid, "/createfactionveh [factionid] [model id/name] <color 1> <color 2>", 5);


	if(!FactionData[factid][factionExists])
		return Error(playerid, "Invalid factionid!");

	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return Error(playerid, "Invalid model ID.");

	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:a;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	new id = FactionVehicle_Create(FactionData[factid][factionID], model[0], x, y, z, a, color1, color2);

	if(id == -1)
		return Error(playerid, "You cannot create more faction vehicle!");

	SendServerMessage(playerid, "You have successfully create vehicle for faction id %d", factid);
	return 1;
}

CMD:editfactionveh(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	Error(playerid, "/editfactionveh [id] [name]", 5);
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} pos");
		return 1;
	}
	if(!strcmp(type, "pos", true))
	{
		if(!IsPlayerInVehicle(playerid, FactionVehicle[id][fvVehicle]))
			return Error(playerid, "You must inside the faction vehicle!");

		GetVehiclePos(GetPlayerVehicleID(playerid), FactionVehicle[id][fvPos][0], FactionVehicle[id][fvPos][1], FactionVehicle[id][fvPos][2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), FactionVehicle[id][fvPos][3]);

		SendServerMessage(playerid, "You have adjusted position for faction vehicle id %d", id);
		FactionVehicle_Save(id);
	}

	return 1;
}

CMD:gotofactionveh(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if(isnull(params))
		return Error(playerid, "/gotofactionveh [id]", 5);

	if(!IsNumeric(params))
		return Error(playerid, "Invalid faction vehicle ID!");

	if(!FactionVehicle[strval(params)][fvExists])
		return Error(playerid, "Invalid faction vehicle ID!");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehiclePos(FactionVehicle[strval(params)][fvVehicle], x, y, z);
	SetPlayerPos(playerid, x, y - 2, z + 2);
	return 1;
}

CMD:destroyfactionveh(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");
	
	if(isnull(params))
		return Error(playerid, "/destroyfactionveh [vehicleid]", 5);

	if(!IsNumeric(params))
		return Error(playerid, "Invalid vehicle ID");

	if(!IsValidVehicle(strval(params)))
		return Error(playerid, "Invalid vehicle ID");

	if(IsFactionVehicle(strval(params)) == -1)
		return Error(playerid, "That vehicle is not faction vehicle!");	

	FactionVehicle_Delete(IsFactionVehicle(strval(params)));
	SendServerMessage(playerid, "You have removed faction vehicle id", IsFactionVehicle(strval(params)));
	return 1;
}