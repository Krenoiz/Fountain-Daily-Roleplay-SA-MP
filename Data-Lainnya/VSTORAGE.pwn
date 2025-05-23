enum VehicleStorageData
{
	vsMoney,
	vsWeapon[3],
	vsAmmo[3],
	vsRedMoney,
	vsMedicine,
	vsMedkit,
	vsBandage,
	vsSeed,
	vsMetal,
	vsMaterial,
	vsMarijuana,
	vsComponent,
	vsCrack,
	vsShrooms,
	vsXanax,
	vsPeyote,
	vsScheSLC,
	vsScheColt,
	vsScheSG,
	vsScheDE,
	vsScheRiffle,
	vsScheUzi,
	vsScheAk,
};
new vsData[MAX_PRIVATE_VEHICLE][VehicleStorageData];

Vehicle_WeaponStorage(playerid, vehicleid)
{
    if(vehicleid == -1)
        return 0;

    static
        string[320];

    string[0] = 0;

    for (new i = 0; i < 3; i ++)
    {
        if(!vsData[vehicleid][vsWeapon][i])
            format(string, sizeof(string), "%sEmpty Slot\n", string);

        else
            format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(vsData[vehicleid][vsWeapon][i]), vsData[vehicleid][vsAmmo][i]);
    }
    ShowPlayerDialog(playerid, VEHICLE_WEAPON, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
    return 1;
}

Vehicle_OpenStorage(playerid, vehicleid)
{
    if(vehicleid == -1)
        return 0;

	new
		items[1],
		string[10 * 32];

	for (new i = 0; i < 3; i ++) if(vsData[vehicleid][vsWeapon][i]) 
	{
		items[0]++;
	}
	format(string, sizeof(string), "Weapon Storage (%d/3)\nMoney Safe\nDrugs\nOther\nSchematic", items[0]);

	SetPVarInt(playerid, "SelectVehicle", vehicleid);

	ShowPlayerDialog(playerid, VEHICLE_STORAGE, DIALOG_STYLE_LIST, "Vehicle Trunk", string, "Select", "Cancel");
	return 1;
}

MySQL_LoadVehicleStorage(vehicleid)
{
	new query[1536];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vstorage` WHERE `owner`='%d' LIMIT 1", pvData[vehicleid][cID]);
	mysql_tquery(g_SQL, query, "LoadVehicleTrunk", "i", vehicleid);
}

function LoadVehicleTrunk(vehicleid)
{
	new rows = cache_num_rows(), vehid = pvData[vehicleid][cVeh];
	new str[24];
 	if (rows > 0 && vehid >= 0 && vehid < MAX_PRIVATE_VEHICLE)
  	{
		for(new z = 0; z < rows; z++)
		{
			pvData[vehid][LoadedStorage] = true;

			cache_get_value_name_int(z, "money", vsData[vehid][vsMoney]);
            cache_get_value_name_int(z, "redmoney", vsData[vehid][vsRedMoney]);
            cache_get_value_name_int(z, "medicine", vsData[vehid][vsMedicine]);
            cache_get_value_name_int(z, "medkit", vsData[vehid][vsMedkit]);
            cache_get_value_name_int(z, "bandage", vsData[vehid][vsBandage]);
            cache_get_value_name_int(z, "seed", vsData[vehid][vsSeed]);
			cache_get_value_name_int(z, "material", vsData[vehid][vsMaterial]);
			cache_get_value_name_int(z, "marijuana", vsData[vehid][vsMarijuana]);
			cache_get_value_name_int(z, "vcrack", vsData[vehid][vsCrack]);
			cache_get_value_name_int(z, "component", vsData[vehid][vsComponent]);
			cache_get_value_name_int(z, "slcsche", vsData[vehid][vsScheSLC]);
            cache_get_value_name_int(z, "coltsche", vsData[vehid][vsScheColt]);
            cache_get_value_name_int(z, "sgsche", vsData[vehid][vsScheSG]);
			cache_get_value_name_int(z, "desche", vsData[vehid][vsScheDE]);
			cache_get_value_name_int(z, "rifflesche", vsData[vehid][vsScheRiffle]);
			cache_get_value_name_int(z, "uzische", vsData[vehid][vsScheUzi]);
			cache_get_value_name_int(z, "aksche", vsData[vehid][vsScheAk]);
			cache_get_value_name_int(z, "vsMetal", vsData[vehid][vsMetal]);
			cache_get_value_name_int(z, "vsShrooms", vsData[vehid][vsShrooms]);
			cache_get_value_name_int(z, "vsXanax", vsData[vehid][vsXanax]);
			cache_get_value_name_int(z, "vsPeyote", vsData[vehid][vsPeyote]);

			for (new j = 0; j < 3; j ++)
			{
				format(str, 24, "weapon%d", j + 1);
				cache_get_value_name_int(z, str, vsData[vehid][vsWeapon][j]);

				format(str, 24, "ammo%d", j + 1);
				cache_get_value_name_int(z, str, vsData[vehid][vsAmmo][j]);
			}
		}
	}
}

Vehicle_StorageSave(vehicleid)
{
    new cQuery[1536];
    new x = pvData[vehicleid][cVeh];
    
    format(cQuery, sizeof(cQuery), "UPDATE `vstorage` SET ");
    
    format(cQuery, sizeof(cQuery), "%s`money`= %d,", cQuery, vsData[x][vsMoney]);
    format(cQuery, sizeof(cQuery), "%s`redmoney`= %d,", cQuery, vsData[x][vsRedMoney]);
    format(cQuery, sizeof(cQuery), "%s`medicine`= %d,", cQuery, vsData[x][vsMedicine]);
    format(cQuery, sizeof(cQuery), "%s`medkit`= %d,", cQuery, vsData[x][vsMedkit]);
    format(cQuery, sizeof(cQuery), "%s`bandage`= %d,", cQuery, vsData[x][vsBandage]);
    format(cQuery, sizeof(cQuery), "%s`seed`= %d,", cQuery, vsData[x][vsSeed]);
    format(cQuery, sizeof(cQuery), "%s`material`= %d,", cQuery, vsData[x][vsMaterial]);
    format(cQuery, sizeof(cQuery), "%s`marijuana`= %d,", cQuery, vsData[x][vsMarijuana]);
    format(cQuery, sizeof(cQuery), "%s`vcrack`= %d,", cQuery, vsData[x][vsCrack]);
    format(cQuery, sizeof(cQuery), "%s`component`= %d,", cQuery, vsData[x][vsComponent]);
	format(cQuery, sizeof(cQuery), "%s`slcsche`= %d,", cQuery, vsData[x][vsScheSLC]);
    format(cQuery, sizeof(cQuery), "%s`coltsche`= %d,", cQuery, vsData[x][vsScheColt]);
    format(cQuery, sizeof(cQuery), "%s`sgsche`= %d,", cQuery, vsData[x][vsScheSG]);
    format(cQuery, sizeof(cQuery), "%s`desche`= %d,", cQuery, vsData[x][vsScheDE]);
    format(cQuery, sizeof(cQuery), "%s`rifflesche`= %d,", cQuery, vsData[x][vsScheRiffle]);
    format(cQuery, sizeof(cQuery), "%s`uzische`= %d,", cQuery, vsData[x][vsScheUzi]);
    format(cQuery, sizeof(cQuery), "%s`aksche`= %d,", cQuery, vsData[x][vsScheAk]);
    format(cQuery, sizeof(cQuery), "%s`vsMetal`= %d,", cQuery, vsData[x][vsMetal]);
    format(cQuery, sizeof(cQuery), "%s`vsShrooms`= %d,", cQuery, vsData[x][vsShrooms]);
    format(cQuery, sizeof(cQuery), "%s`vsXanax`= %d,", cQuery, vsData[x][vsXanax]);
    format(cQuery, sizeof(cQuery), "%s`vsPeyote`= %d", cQuery, vsData[x][vsPeyote]);
	
    
    for (new i = 0; i < 3; i++)
    {
        format(cQuery, sizeof(cQuery), "%s, `weapon%d`='%d', `ammo%d`='%d'", cQuery, i + 1, vsData[x][vsWeapon][i], i + 1, vsData[x][vsAmmo][i]);
    }
    
    format(cQuery, sizeof(cQuery), "%s WHERE `owner` = %d", cQuery, pvData[vehicleid][cID]);
    
    mysql_query(g_SQL, cQuery);
    
    return 1;
}

function MySQL_CreateVehicleStorage(vehicleid, vehid)
{
	new query[512];

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `vstorage` (`owner`) VALUES ('%d')", pvData[vehicleid][cID]);
	mysql_tquery(g_SQL, query);

	vsData[vehicleid][vsMoney] = 0;
    vsData[vehicleid][vsRedMoney] = 0;
    vsData[vehicleid][vsMedicine] = 0;
    vsData[vehicleid][vsMedkit] = 0;
    vsData[vehicleid][vsBandage] = 0;
    vsData[vehicleid][vsSeed] = 0;
    vsData[vehicleid][vsMetal] = 0;
    vsData[vehicleid][vsMaterial] = 0;
	vsData[vehicleid][vsMarijuana] = 0;
	vsData[vehicleid][vsCrack] = 0;
	vsData[vehicleid][vsShrooms] = 0;
	vsData[vehicleid][vsXanax] = 0;
	vsData[vehicleid][vsPeyote] = 0;
	vsData[vehicleid][vsComponent] = 0;
	vsData[vehicleid][vsScheSLC] = 0;
    vsData[vehicleid][vsScheColt] = 0;
    vsData[vehicleid][vsScheSG] = 0;
    vsData[vehicleid][vsScheDE] = 0;
	vsData[vehicleid][vsScheRiffle] = 0;
	vsData[vehicleid][vsScheUzi] = 0;
	vsData[vehicleid][vsScheAk] = 0;
	pvData[vehid][LoadedStorage] = true;
	for (new h4n = 0; h4n < 3; h4n ++)
    {
        vsData[vehicleid][vsWeapon][h4n] = 0;

		vsData[vehicleid][vsAmmo][h4n] = 0;
    }
}

function CheckVehicleStorageStatus(playerid, vehicleid, vid)
{
	new count = cache_num_rows();
	if(count > 0)
	{
		Vehicle_OpenStorage(playerid, vehicleid);
	}
	else
	{
		MySQL_CreateVehicleStorage(vid, vehicleid);
	}
}