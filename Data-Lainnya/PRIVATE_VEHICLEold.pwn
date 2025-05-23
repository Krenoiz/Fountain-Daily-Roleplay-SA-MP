
//Private Vehicle Player System Define

#define MAX_PRIVATE_VEHICLE 1000
#define MAX_PLAYER_VEHICLE 3
//new Float: VehicleFuel[MAX_VEHICLES] = 100.0;
new bool:VehicleHealthSecurity[MAX_VEHICLES] = false, Float:VehicleHealthSecurityData[MAX_VEHICLES] = 1000.0;
new AdminVehicle[MAX_VEHICLES char];

enum pvdata
{
	cID,
	cOwner,
	cModel,
	cColor1,
	cColor2,
	cPaintJob,
	cNeon,
	cTogNeon,
	cLocked,
	cInsu,
	cClaim,
	cDeath,
	cClaimTime,
	cPlate[15],
	cPlateTime,
	cTicket,
	cPrice,
	Float:cHealth,
	cFuel,
	Float:cPosX,
	Float:cPosY,
	Float:cPosZ,
	Float:cPosA,
	cInt,
	cVw,
	cMod[17],
	cLumber,
	cMetal,
	cCoal,
	cProduct,
	cGasOil,
	cBox,
	cRent,
	cVeh,
	cPark,
	cGarage,
	cUpgrade[4],
	cTurboMode,
	cBrakeMode,
	cStolen,
	cImpound,
	vehSirenObject,
	vehSirenOn,
	cImpounded,
	cImpoundPrice,
	cVisit,
	cDamage0,
	cDamage1,
	cDamage2,
	cDamage3,
	//Vehicle Storage
	cTrunk,
	bool:LoadedStorage,
	bool:PurchasedvToy,
	vtoySelected,
	STREAMER_TAG_OBJECT:vToy[5],
	vToyID[5],
	cAttachedToy[5],
	Float:vToyPosX[5],
	Float:vToyPosY[5],
	Float:vToyPosZ[5],
	Float:vToyRotX[5],
	Float:vToyRotY[5],
	Float:vToyRotZ[5],
};
new pvData[MAX_PRIVATE_VEHICLE][pvdata],
Iterator:PVehicles<MAX_PRIVATE_VEHICLE + 1>;

//Private Vehicle Player System Native
new const g_arrVehicleNames[212][] = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
	"Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
	"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
	"Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
	"Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
	"Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
	"Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
	"Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
	"Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
	"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
	"Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
	"Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
	"Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
	"Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
	"Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
	"Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
	"Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
	"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
	"Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
	"Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
	"Boxville", "Tiller", "Utility Trailer"
};

GetEngineStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(engine != 1)
		return 0;

	return 1;
}

GetLightStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(lights != 1)
		return 0;

	return 1;
}

ReturnAnyVehiclePark(slot, i)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_PRIVATE_VEHICLE) return -1;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cPark] == i && pvData[id][cPark] > -1)
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

GetAnyVehiclePark(i)
{
	new tmpcount;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cPark] == i)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}
stock RespawnVehicle(vehicleid)
{
	new id = Vehicle_GetID(vehicleid);

	if (id != -1)
	{
	    Vehicle_GetStatus(id);

	    if(IsValidVehicle(pvData[id][cVeh]))
			DestroyVehicle(pvData[id][cVeh]);
			pvData[id][cVeh] = INVALID_VEHICLE_ID;

	    OnPlayerVehicleRespawn(id);
	}
	else
	{
		SetVehicleToRespawn(vehicleid);
	}
	return 1;
}
GetHoodStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(bonnet != 1)
		return 0;

	return 1;
}

GetTrunkStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(boot != 1)
		return 0;

	return 1;
}

GetVehicleModelByName(const name[])
{
	if(IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
		return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
		if(strfind(g_arrVehicleNames[i], name, true) != -1)
		{
			return i + 400;
		}
	}
	return 0;
}
Vehicle_Nearest(playerid, Float:range = 7.5)
{
	new Float:fX,
		Float:fY,
		Float:fZ;

	foreach(new i : PVehicles)
	{
		if(pvData[i][cVeh] != INVALID_VEHICLE_ID)
		{
			GetVehiclePos(pvData[i][cVeh], fX, fY, fZ);

			if(IsPlayerInRangeOfPoint(playerid, range, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(pvData[i][cVeh])) 
			{
				return i;
			}
		}
	}
	return -1;
}

Vehicle_Nearest2(playerid)
{
	foreach(new i : PVehicles)
	{
		if(pvData[i][cVeh] != INVALID_VEHICLE_ID && IsPlayerInAnyVehicle(playerid) && pvData[i][cVeh] == GetPlayerVehicleID(playerid))
		{
			return i;
		}
	}
	return -1;
}

GetVehicleOwner(carid)
{
	foreach(new i : Player)
	{
		if(pvData[carid][cOwner] == pData[i][pID])
		{
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}


/*GetVehicleOwnerName(carid)
{
	static Oname[MAX_PLAYER_NAME];
	foreach(new i : Player)
	{
		if(pvData[carid][cOwner] == pData[i][pID])
		{
			format(Oname, MAX_PLAYER_NAME, pData[i][pName]);
		}
	}
	return Oname;
}*/
Vehicle_IsOwner(playerid, carid)
{
	if(!pData[playerid][IsLoggedIn] || pData[playerid][pID] == -1)
		return 0;

	if((Iter_Contains(PVehicles, carid) && pvData[carid][cOwner] != 0) && pvData[carid][cOwner] == pData[playerid][pID])
		return 1;

	return 0;
}
//key
Vehicle_HaveAccess(playerid, carid)
{
	if(pData[playerid][pID] == -1)
		return 0;

	if((Iter_Contains(PVehicles, carid) && pvData[carid][cOwner] != 0) && pvData[carid][cOwner] == pData[playerid][pID] || pData[playerid][pVehKey] == pvData[carid][cID])
		return 1;

	return 0;
}
Vehicle_GetStatus(carid)
{
	if(IsValidVehicle(pvData[carid][cVeh]) && pvData[carid][cVeh] != INVALID_VEHICLE_ID)
	{
		GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
		pvData[carid][cFuel] = GetVehicleFuel(pvData[carid][cVeh]);
		GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
		GetVehicleZAngle(pvData[carid][cVeh],pvData[carid][cPosA]);
	}
	return 1;
}
Vehicle_Inside(playerid)
{
	new carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return -1;
}
stock Vehicle_GetID(vehicleid)
{
	foreach(new i : PVehicles) if (pvData[i][cVeh] == vehicleid)
	{
	    return i;
	}
	return -1;
}
CountParkedVeh(id)
{
	if(id > -1)
	{
		new count = 0;
		foreach(new i : PVehicles)
		{
			if(pvData[i][cPark] == id)
				count++;
		}
		return count;
	}
	return 0;
}


SetValidVehicleHealth(vehicleid, Float:health) {
	VehicleHealthSecurity[vehicleid] = true;
	SetVehicleHealth(vehicleid, health);
	return 1;
}

ValidRepairVehicle(vehicleid) {
	VehicleHealthSecurity[vehicleid] = true;
	RepairVehicle(vehicleid);
	return 1;
}


//Private Vehicle Player System Function

function OnPlayerVehicleRespawn(i)
{
	if(pvData[i][cClaim] == 0 && pvData[i][cPark] < 0 && pvData[i][cStolen] == 0 && pvData[i][cGarage] < 0)
	{
		pvData[i][cVeh] = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], -1);
		SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
		SetVehicleVirtualWorld(pvData[i][cVeh], pvData[i][cVw]);
		LinkVehicleToInterior(pvData[i][cVeh], pvData[i][cInt]);
		SetVehicleFuel(pvData[i][cVeh], pvData[i][cFuel]);
		pvData[i][cTrunk] = 1;
		pvData[i][cTurboMode] = pvData[i][cUpgrade][2];
		pvData[i][cBrakeMode] = pvData[i][cUpgrade][3];
	}
	if(IsValidVehicle(pvData[i][cVeh]))
	{
		if(pvData[i][cHealth] < 350.0)
		{
			SetValidVehicleHealth(pvData[i][cVeh], 350.0);
		}
		else
		{
			SetValidVehicleHealth(pvData[i][cVeh], pvData[i][cHealth]);
		}
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
	
	OnLoadVehicleStorage(i);
	MySQL_LoadVehicleStorage(i);
	/*if(pvData[i][cClaim] != 0)
	{
		SetTimerEx("RespawnPV", 3000, false, "d", pvData[i][cVeh]);
	}*/
	//SwitchVehicleEngine(pvData[i][cVeh], false);
    return 1;
}

function OnLoadVehicleStorage(i)
{
	if(IsValidVehicle(pvData[i][cVeh]))
	{
		if(IsAPickup(pvData[i][cVeh]))
		{
			if(pvData[i][cLumber] > -1)
			{
				for(new lid; lid < pvData[i][cLumber]; lid++)
				{
					if(!IsValidDynamicObject(LumberObjects[pvData[i][cVeh]][lid]))
					{
						LumberObjects[pvData[i][cVeh]][lid] = CreateDynamicObject(19793, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
						AttachDynamicObjectToVehicle(LumberObjects[pvData[i][cVeh]][lid], pvData[i][cVeh], LumberAttachOffsets[lid][0], LumberAttachOffsets[lid][1], LumberAttachOffsets[lid][2], 0.0, 0.0, LumberAttachOffsets[lid][3]);
					}
				}
			}
			else if(pvData[i][cLumber] == -1)
			{
				for(new a; a < LUMBER_LIMIT; a++)
				{
					if(IsValidDynamicObject(LumberObjects[pvData[i][cVeh]][a]))
					{
						DestroyDynamicObject(LumberObjects[pvData[i][cVeh]][a]);
						LumberObjects[pvData[i][cVeh]][a] = -1;
					}
				}
			}
		}
		for(new idx = 0; idx < 5; idx ++)
		{
			if(pvData[i][vToyID][idx] != 0)
			{
				pvData[i][vToy][idx] = CreateDynamicObject(pvData[i][vToyID][idx], pvData[i][vToyPosX][idx], pvData[i][vToyPosY][idx], pvData[i][vToyPosZ][idx], pvData[i][vToyRotX][idx], pvData[i][vToyRotY][idx], pvData[i][vToyRotZ][idx],  -1, -1, -1, 50.0, 0.0);
				AttachDynamicObjectToVehicle(pvData[i][vToy][idx], pvData[i][cVeh], pvData[i][vToyPosX][idx], pvData[i][vToyPosY][idx], pvData[i][vToyPosZ][idx], pvData[i][vToyRotX][idx], pvData[i][vToyRotY][idx], pvData[i][vToyRotZ][idx]);
			}
			else 
			{
				if(IsValidDynamicObject(pvData[i][vToy][idx]))
					DestroyDynamicObject(pvData[i][vToy][idx]);
			}
		}
		if(pvData[i][cTogNeon] == 1)
		{
			if(pvData[i][cNeon] != 0)
			{
				SetVehicleNeonLights(pvData[i][cVeh], true, pvData[i][cNeon], 0);
			}
		}

		if(pvData[i][cMetal] > 0)
		{

			LogStorage[pvData[i][cVeh]][ 0 ] = pvData[i][cMetal];
		}
		else
		{
			LogStorage[pvData[i][cVeh]][ 0 ] = 0;
		}

		if(pvData[i][cCoal] > 0)
		{
			LogStorage[pvData[i][cVeh]][ 1 ] = pvData[i][cCoal];
		}
		else
		{
			LogStorage[pvData[i][cVeh]][ 1 ] = 0;
		}

		if(pvData[i][cProduct] > 0)
		{
			VehProduct[pvData[i][cVeh]] = pvData[i][cProduct];
		}
		else
		{
			VehProduct[pvData[i][cVeh]] = 0;
		}

		if(pvData[i][cGasOil] > 0)
		{
			VehGasOil[pvData[i][cVeh]] = pvData[i][cGasOil];
		}
		else
		{
			VehGasOil[pvData[i][cVeh]] = 0;
		}

		if(pvData[i][cBox] > 0)
		{

			BoxStorage[pvData[i][cVeh]][ 0 ] = pvData[i][cBox];
		}
		else
		{
			BoxStorage[pvData[i][cVeh]][ 0 ] = 0;
		}
	}
}

function LoadPlayerVehicle(playerid)
{
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicle` WHERE `owner` = %d", pData[playerid][pID]);
	mysql_query(g_SQL, query, true);
	new count = cache_num_rows(), tempString[56];
	if(count > 0)
	{
		for(new z = 0; z < count; z++)
		{
			new i = Iter_Free(PVehicles);
			cache_get_value_name_int(z, "id", pvData[i][cID]);
			//pvData[i][VehicleOwned] = true;
			cache_get_value_name_int(z, "owner", pvData[i][cOwner]);
			cache_get_value_name_int(z, "locked", pvData[i][cLocked]);
			cache_get_value_name_int(z, "insu", pvData[i][cInsu]);
			cache_get_value_name_int(z, "claim", pvData[i][cClaim]);
			cache_get_value_name_int(z, "claim_time", pvData[i][cClaimTime]);
			cache_get_value_name_float(z, "x", pvData[i][cPosX]);
			cache_get_value_name_float(z, "y", pvData[i][cPosY]);
			cache_get_value_name_float(z, "z", pvData[i][cPosZ]);
			cache_get_value_name_float(z, "a", pvData[i][cPosA]);
			cache_get_value_name_float(z, "health", pvData[i][cHealth]);
			cache_get_value_name_int(z, "fuel", pvData[i][cFuel]);
			cache_get_value_name_int(z, "interior", pvData[i][cInt]);
			cache_get_value_name_int(z, "vw", pvData[i][cVw]);
			cache_get_value_name_int(z, "color1", pvData[i][cColor1]);
			cache_get_value_name_int(z, "color2", pvData[i][cColor2]);
			cache_get_value_name_int(z, "paintjob", pvData[i][cPaintJob]);
			cache_get_value_name_int(z, "neon", pvData[i][cNeon]);
			pvData[i][cTogNeon] = 0;
			cache_get_value_name_int(z, "price", pvData[i][cPrice]);
			cache_get_value_name_int(z, "model", pvData[i][cModel]);
			cache_get_value_name(z, "plate", tempString);
			//cache_get_value_name_int(z, "upb", pvData[i][cUpgrade][0]);
			//cache_get_value_name_int(z, "upe", pvData[i][cUpgrade][1]);
			//cache_get_value_name_int(z, "upt", pvData[i][cUpgrade][2]);
			//cache_get_value_name_int(z, "upbr", pvData[i][cUpgrade][3]);

			format(pvData[i][cPlate], 16, tempString);
			cache_get_value_name_int(z, "plate_time", pvData[i][cPlateTime]);
			cache_get_value_name_int(z, "ticket", pvData[i][cTicket]);

			cache_get_value_name_int(z, "mod0", pvData[i][cMod][0]);
			cache_get_value_name_int(z, "mod1", pvData[i][cMod][1]);
			cache_get_value_name_int(z, "mod2", pvData[i][cMod][2]);
			cache_get_value_name_int(z, "mod3", pvData[i][cMod][3]);
			cache_get_value_name_int(z, "mod4", pvData[i][cMod][4]);
			cache_get_value_name_int(z, "mod5", pvData[i][cMod][5]);
			cache_get_value_name_int(z, "mod6", pvData[i][cMod][6]);
			cache_get_value_name_int(z, "mod7", pvData[i][cMod][7]);
			cache_get_value_name_int(z, "mod8", pvData[i][cMod][8]);
			cache_get_value_name_int(z, "mod9", pvData[i][cMod][9]);
			cache_get_value_name_int(z, "mod10", pvData[i][cMod][10]);
			cache_get_value_name_int(z, "mod11", pvData[i][cMod][11]);
			cache_get_value_name_int(z, "mod12", pvData[i][cMod][12]);
			cache_get_value_name_int(z, "mod13", pvData[i][cMod][13]);
			cache_get_value_name_int(z, "mod14", pvData[i][cMod][14]);
			cache_get_value_name_int(z, "mod15", pvData[i][cMod][15]);
			cache_get_value_name_int(z, "mod16", pvData[i][cMod][16]);
			cache_get_value_name_int(z, "upbody", pvData[i][cUpgrade][0]);
			cache_get_value_name_int(z, "upengine", pvData[i][cUpgrade][1]);
			cache_get_value_name_int(z, "upturbo", pvData[i][cUpgrade][2]);
			cache_get_value_name_int(z, "upbrake", pvData[i][cUpgrade][3]);
			cache_get_value_name_int(z, "lumber", pvData[i][cLumber]);
			cache_get_value_name_int(z, "metal", pvData[i][cMetal]);
			cache_get_value_name_int(z, "coal", pvData[i][cCoal]);
			cache_get_value_name_int(z, "product", pvData[i][cProduct]);
			cache_get_value_name_int(z, "gasoil", pvData[i][cGasOil]);
			cache_get_value_name_int(z, "box", pvData[i][cBox]);
			cache_get_value_name_int(z, "rental", pvData[i][cRent]);
			cache_get_value_name_int(z, "park", pvData[i][cPark]);
			cache_get_value_name_int(z, "garage", pvData[i][cGarage]);
			// cache_get_value_name_int(z, "broken", pvData[i][cStolen]);
			cache_get_value_name_int(z, "trunk", pvData[i][cTrunk]);

			cache_get_value_name_int(z, "toyid0", pvData[i][vToyID][0]);
			cache_get_value_name_int(z, "toyid1", pvData[i][vToyID][1]);
			cache_get_value_name_int(z, "toyid2", pvData[i][vToyID][2]);
			cache_get_value_name_int(z, "toyid3", pvData[i][vToyID][3]);
			cache_get_value_name_int(z, "toyid4", pvData[i][vToyID][4]);
			
			cache_get_value_name_float(z, "toyposx0", pvData[i][vToyPosX][0]);
			cache_get_value_name_float(z, "toyposy0", pvData[i][vToyPosY][0]);
			cache_get_value_name_float(z, "toyposz0", pvData[i][vToyPosZ][0]);
			
			cache_get_value_name_float(z, "toyposx1", pvData[i][vToyPosX][1]);
			cache_get_value_name_float(z, "toyposy1", pvData[i][vToyPosY][1]);
			cache_get_value_name_float(z, "toyposz1", pvData[i][vToyPosZ][1]);
			
			cache_get_value_name_float(z, "toyposx2", pvData[i][vToyPosX][2]);
			cache_get_value_name_float(z, "toyposy2", pvData[i][vToyPosY][2]);
			cache_get_value_name_float(z, "toyposz2", pvData[i][vToyPosZ][2]);
			
			cache_get_value_name_float(z, "toyposx3", pvData[i][vToyPosX][3]);
			cache_get_value_name_float(z, "toyposy3", pvData[i][vToyPosY][3]);
			cache_get_value_name_float(z, "toyposz3", pvData[i][vToyPosZ][3]);
			
			cache_get_value_name_float(z, "toyposx4", pvData[i][vToyPosX][4]);
			cache_get_value_name_float(z, "toyposy4", pvData[i][vToyPosY][4]);
			cache_get_value_name_float(z, "toyposz4", pvData[i][vToyPosZ][4]);
			
			cache_get_value_name_float(z, "toyrotx0", pvData[i][vToyRotX][0]);
			cache_get_value_name_float(z, "toyroty0", pvData[i][vToyRotY][0]);
			cache_get_value_name_float(z, "toyrotz0", pvData[i][vToyRotZ][0]);

			cache_get_value_name_float(z, "toyrotx1", pvData[i][vToyRotX][1]);
			cache_get_value_name_float(z, "toyroty1", pvData[i][vToyRotY][1]);
			cache_get_value_name_float(z, "toyrotz1", pvData[i][vToyRotZ][1]);

			cache_get_value_name_float(z, "toyrotx2", pvData[i][vToyRotX][2]);
			cache_get_value_name_float(z, "toyroty2", pvData[i][vToyRotY][2]);
			cache_get_value_name_float(z, "toyrotz2", pvData[i][vToyRotZ][2]);

			cache_get_value_name_float(z, "toyrotx3", pvData[i][vToyRotX][3]);
			cache_get_value_name_float(z, "toyroty3", pvData[i][vToyRotY][3]);
			cache_get_value_name_float(z, "toyrotz3", pvData[i][vToyRotZ][3]);

			cache_get_value_name_float(z, "toyrotx4", pvData[i][vToyRotX][4]);
			cache_get_value_name_float(z, "toyroty4", pvData[i][vToyRotY][4]);
			cache_get_value_name_float(z, "toyrotz4", pvData[i][vToyRotZ][4]);
			/*for(new x = 0; x < 17; x++)
			{
				format(tempString, sizeof(tempString), "mod%d", x);
				cache_get_value_name_int(z, tempString, pvData[i][cMod][x]);
			}*/
			Iter_Add(PVehicles, i);
			//if(pvData[i][cClaim] == 0 && pvData[i][cStolen] == 0)
			if(pvData[i][cClaim] == 0 && pvData[i][cStolen] == 0 && pvData[i][cDeath] == 0)
			{
				OnPlayerVehicleRespawn(i);
				MySQL_LoadVehicleToys(i);
			}
			else
			{
				pvData[i][cVeh] = 0;
			}
		}
		printf("[Vehicles] Loaded: %s(%d)", pData[playerid][pName], playerid);
	}
	return 1;
}

Vehicle_Save(vehicleid)
{
	Vehicle_GetStatus(vehicleid);
	new cQuery[4000];
	format(cQuery, sizeof(cQuery), "UPDATE vehicle SET locked='%d', insu='%d', claim='%d', claim_time='%d', x='%f', y='%f', z='%f', a='%f', health='%f', fuel='%d', interior='%d', vw='%d', damage0='%d', damage1='%d', damage2='%d', damage3='%d', color1='%d', color2='%d', paintjob='%d', neon='%d', price='%d', model='%d', plate='%d', plate_time='%d', ticket='%d', mod0='%d', mod1='%d', mod2='%d', mod3='%d', mod4='%d', mod5='%d', mod6='%d', mod7='%d', mod8='%d', mod9='%d', mod10='%d', mod11='%d', mod12='%d', mod13='%d', mod14='%d', mod15='%d', mod16='%d', lumber='%d', metal='%d', coal='%d', product='%d', gasoil='%d', box='%d', rental='%d', park='%d', trunk='%d', toyid0='%d', toyid1='%d', toyid2='%d', toyid3='%d', toyid4='%d', toyposx0='%f', toyposx1='%f', toyposx2='%f', toyposx3='%f', toyposx4='%f', toyposy0='%f', toyposy1='%f', toyposy2='%f', toyposy3='%f', toyposy4='%f', toyposz0='%f', toyposz1='%f', toyposz2='%f', toyposz3='%f', toyposz4='%f', toyrotx0='%f', toyrotx1='%f', toyrotx2='%f', toyrotx3='%f', toyrotx4='%f', toyroty0='%f', toyroty1='%f', toyroty2='%f', toyroty3='%f', toyroty4='%f', toyrotz0='%f', toyrotz1='%f', toyrotz2='%f', toyrotz3='%f', toyrotz4='%f' WHERE id='%d'",

		pvData[vehicleid][cLocked],
		pvData[vehicleid][cInsu],
		pvData[vehicleid][cClaim],
		pvData[vehicleid][cClaimTime],
		pvData[vehicleid][cPosX],
		pvData[vehicleid][cPosY],
		pvData[vehicleid][cPosZ],
		pvData[vehicleid][cPosA],
		pvData[vehicleid][cHealth],
		pvData[vehicleid][cFuel],
		pvData[vehicleid][cInt],
		pvData[vehicleid][cVw],
		pvData[vehicleid][cColor1],
		pvData[vehicleid][cColor2],
		pvData[vehicleid][cPaintJob],
		pvData[vehicleid][cNeon],
		pvData[vehicleid][cPrice],
		pvData[vehicleid][cModel],
		pvData[vehicleid][cPlate],
		pvData[vehicleid][cPlateTime],
		pvData[vehicleid][cTicket],
		pvData[vehicleid][cMod][0],
		pvData[vehicleid][cMod][1],
		pvData[vehicleid][cMod][2],
		pvData[vehicleid][cMod][3],
		pvData[vehicleid][cMod][4],
		pvData[vehicleid][cMod][5],
		pvData[vehicleid][cMod][6],
		pvData[vehicleid][cMod][7],
		pvData[vehicleid][cMod][8],
		pvData[vehicleid][cMod][9],
		pvData[vehicleid][cMod][10],
		pvData[vehicleid][cMod][11],
		pvData[vehicleid][cMod][12],
		pvData[vehicleid][cMod][13],
		pvData[vehicleid][cMod][14],
		pvData[vehicleid][cMod][15],
		pvData[vehicleid][cMod][16],
		//, upgrade0='%d', upgrade1='%d', upgrade2='%d', upgrade3='%d'
		//pvData[vehicleid][cUpgrade][0],
		//pvData[vehicleid][cUpgrade][1],
		//pvData[vehicleid][cUpgrade][2],
		//pvData[vehicleid][cUpgrade][3],
		pvData[vehicleid][cLumber],
		pvData[vehicleid][cMetal],
		pvData[vehicleid][cCoal],
		pvData[vehicleid][cProduct],
		pvData[vehicleid][cGasOil],
		pvData[vehicleid][cBox],
		pvData[vehicleid][cRent],
		pvData[vehicleid][cPark],
		pvData[vehicleid][cGarage],
		pvData[vehicleid][cStolen],
		pvData[vehicleid][cTrunk],
		pvData[vehicleid][vToyID][0],
		pvData[vehicleid][vToyID][1],
		pvData[vehicleid][vToyID][2],
		pvData[vehicleid][vToyID][3],
		pvData[vehicleid][vToyID][4],
		pvData[vehicleid][vToyPosX][0],
		pvData[vehicleid][vToyPosX][1],
		pvData[vehicleid][vToyPosX][2],
		pvData[vehicleid][vToyPosX][3],
		pvData[vehicleid][vToyPosX][4],
		pvData[vehicleid][vToyPosY][0],
		pvData[vehicleid][vToyPosY][1],
		pvData[vehicleid][vToyPosY][2],
		pvData[vehicleid][vToyPosY][3],
		pvData[vehicleid][vToyPosY][4],
		pvData[vehicleid][vToyPosZ][0],
		pvData[vehicleid][vToyPosZ][1],
		pvData[vehicleid][vToyPosZ][2],
		pvData[vehicleid][vToyPosZ][3],
		pvData[vehicleid][vToyPosZ][4],
		pvData[vehicleid][vToyRotX][0],
		pvData[vehicleid][vToyRotX][1],
		pvData[vehicleid][vToyRotX][2],
		pvData[vehicleid][vToyRotX][3],
		pvData[vehicleid][vToyRotX][4],
		pvData[vehicleid][vToyRotY][0],
		pvData[vehicleid][vToyRotY][1],
		pvData[vehicleid][vToyRotY][2],
		pvData[vehicleid][vToyRotY][3],
		pvData[vehicleid][vToyRotY][4],
		pvData[vehicleid][vToyRotZ][0],
		pvData[vehicleid][vToyRotZ][1],
		pvData[vehicleid][vToyRotZ][2],
		pvData[vehicleid][vToyRotZ][3],
		pvData[vehicleid][vToyRotZ][4],
		pvData[vehicleid][cID]	
	);
	return mysql_tquery(g_SQL, cQuery);	
}

function EngineStatus(playerid, vehicleid)
{
	if(!GetEngineStatus(vehicleid))
	{
		foreach(new ii : PVehicles)
		{
			if(vehicleid == pvData[ii][cVeh])
			{
				if(pvData[ii][cTicket] >= 2000)
					return Error(playerid, "Kendaraan ini sudah ditilang oleh Polisi! /mv - untuk memeriksa");
			}
		}
		new Float: f_vHealth;
		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0) return Error(playerid, "The car won't start - it's totalled!");
		if(GetVehicleFuel(vehicleid) <= 0.0) return Error(playerid, "The car won't start - there's no fuel in the tank!");
		
		new rand = random(3);
		if(rand == 0)
		{
			SwitchVehicleEngine(vehicleid, true);
			InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~g~START", 1000, 3);
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berhasil menghidupkan kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));
		}
		if(rand == 1)
		{
			//Info(playerid, "Mesin kendaraan tidak dapat menyala, silahkan coba lagi!");
			SwitchVehicleEngine(vehicleid, true);
			InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~r~CAN'T START", 1000, 3);
		}
		if(rand == 2)
		{
			SwitchVehicleEngine(vehicleid, true);
			InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~g~START", 1000, 3);
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berhasil menghidupkan kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));
		}
	}
	else
	{
		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mematikan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
		SwitchVehicleEngine(vehicleid, false);
		//Info(playerid, "Engine turn off..");
		InfoTD_MSG(playerid, 4000, "Vehicle Engine OFF");
	}
	return 1;
}
		/*new Float: f_vHealth;
		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0) return Error(playerid, "Kendaraan tidak dapat Menyala, Sudah rusak!");
		if(GetVehicleFuel(vehicleid) <= 0.0) return Error(playerid, "Kendaraan tidak dapat Menyala, Bensin habis!");

		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menyalakan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
		SwitchVehicleEngine(vehicleid, true);
		InfoTD_MSG(playerid, 2000, "Vehicle Engine ~g~ON");
	}
	else
	{
		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mematikan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
		SwitchVehicleEngine(vehicleid, false);
		//Info(playerid, "Engine turn off..");
		InfoTD_MSG(playerid, 2000, "Vehicle Engine ~r~OFF");
	}
	return 1;
}*/

function RemovePlayerVehicle(playerid)
{
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			Vehicle_GetStatus(i);
			new cQuery[2248]/*, color1, color2, paintjob*/;
			pvData[i][cOwner] = -1;
			//GetVehicleColor(pvData[i][cVeh], color1, color2);
			//paintjob = GetVehiclePaintjob(pvData[i][cVeh]);
			//pvData[i][VehicleOwned] = false;
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `vehicle` SET ");
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`x`='%f', ", cQuery, pvData[i][cPosX]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`y`='%f', ", cQuery, pvData[i][cPosY]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`z`='%f', ", cQuery, pvData[i][cPosZ]+0.1);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`a`='%f', ", cQuery, pvData[i][cPosA]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`health`='%f', ", cQuery, pvData[i][cHealth]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fuel`=%d, ", cQuery, pvData[i][cFuel]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`interior`=%d, ", cQuery, pvData[i][cInt]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price`=%d, ", cQuery, pvData[i][cPrice]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vw`=%d, ", cQuery, pvData[i][cVw]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`model`=%d, ", cQuery, pvData[i][cModel]);
			if(pvData[i][cLocked] == 1)
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locked`=1, ", cQuery);
			else
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locked`=0, ", cQuery);
			/*if(pvData[i][VehicleAlarm])
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`alarm` = 1, ", cQuery);
			else
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`alarm` = 0, ", cQuery);*/
			//mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upb`=%d, ", cQuery, pvData[i][cUpgrade][0]);
			//mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upe`=%d, ", cQuery, pvData[i][cUpgrade][1]);
			//mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upt`=%d, ", cQuery, pvData[i][cUpgrade][2]);
			//mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upbr`=%d, ", cQuery, pvData[i][cUpgrade][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`insu`='%d', ", cQuery, pvData[i][cInsu]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`claim`='%d', ", cQuery, pvData[i][cClaim]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`claim_time`='%d', ", cQuery, pvData[i][cClaimTime]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plate`='%e', ", cQuery, pvData[i][cPlate]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plate_time`='%d', ", cQuery, pvData[i][cPlateTime]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ticket`='%d', ", cQuery, pvData[i][cTicket]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`color1`=%d, ", cQuery, pvData[i][cColor1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`color2`=%d, ", cQuery, pvData[i][cColor2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paintjob`=%d, ", cQuery, pvData[i][cPaintJob]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`neon`=%d, ", cQuery, pvData[i][cNeon]);
			new tempString[56];
			for(new z = 0; z < 17; z++)
			{
				format(tempString, sizeof(tempString), "mod%d", z);
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`%s`=%d, ", cQuery, tempString, pvData[i][cMod][z]);
			}
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`lumber`=%d, ", cQuery, pvData[i][cLumber]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`metal`=%d, ", cQuery, pvData[i][cMetal]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`coal`=%d, ", cQuery, pvData[i][cCoal]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`product`=%d, ", cQuery, pvData[i][cProduct]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gasoil`=%d, ", cQuery, pvData[i][cGasOil]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`box`=%d, ", cQuery, pvData[i][cBox]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`park`=%d, ", cQuery, pvData[i][cPark]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`garage`=%d, ", cQuery, pvData[i][cGarage]);
			// mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`broken`=%d, ", cQuery, pvData[i][cStolen]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`rental`=%d, ", cQuery, pvData[i][cRent]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`trunk`=%d, ", cQuery, pvData[i][cTrunk]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upbody`=%d, ", cQuery, pvData[i][cUpgrade][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upengine`=%d, ", cQuery, pvData[i][cUpgrade][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upturbo`=%d, ", cQuery, pvData[i][cUpgrade][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`upbrake`=%d, ", cQuery, pvData[i][cUpgrade][3]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyid0`='%d', ", cQuery, pvData[i][vToyID][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyid1`='%d', ", cQuery, pvData[i][vToyID][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyid2`='%d', ", cQuery, pvData[i][vToyID][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyid3`='%d', ", cQuery, pvData[i][vToyID][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyid4`='%d', ", cQuery, pvData[i][vToyID][4]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposx0`='%f', ", cQuery, pvData[i][vToyPosX][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposx1`='%f', ", cQuery, pvData[i][vToyPosX][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposx2`='%f', ", cQuery, pvData[i][vToyPosX][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposx3`='%f', ", cQuery, pvData[i][vToyPosX][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposx4`='%f', ", cQuery, pvData[i][vToyPosX][4]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposy0`='%f', ", cQuery, pvData[i][vToyPosY][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposy1`='%f', ", cQuery, pvData[i][vToyPosY][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposy2`='%f', ", cQuery, pvData[i][vToyPosY][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposy3`='%f', ", cQuery, pvData[i][vToyPosY][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposy4`='%f', ", cQuery, pvData[i][vToyPosY][4]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposz0`='%f', ", cQuery, pvData[i][vToyPosZ][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposz1`='%f', ", cQuery, pvData[i][vToyPosZ][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposz2`='%f', ", cQuery, pvData[i][vToyPosZ][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposz3`='%f', ", cQuery, pvData[i][vToyPosZ][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyposz4`='%f', ", cQuery, pvData[i][vToyPosZ][4]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotx0`='%f', ", cQuery, pvData[i][vToyRotX][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotx1`='%f', ", cQuery, pvData[i][vToyRotX][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotx2`='%f', ", cQuery, pvData[i][vToyRotX][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotx3`='%f', ", cQuery, pvData[i][vToyRotX][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotx4`='%f', ", cQuery, pvData[i][vToyRotX][4]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyroty0`='%f', ", cQuery, pvData[i][vToyRotY][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyroty1`='%f', ", cQuery, pvData[i][vToyRotY][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyroty2`='%f', ", cQuery, pvData[i][vToyRotY][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyroty3`='%f', ", cQuery, pvData[i][vToyRotY][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyroty4`='%f', ", cQuery, pvData[i][vToyRotY][4]);

			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotz0`='%f', ", cQuery, pvData[i][vToyRotZ][0]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotz1`='%f', ", cQuery, pvData[i][vToyRotZ][1]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotz2`='%f', ", cQuery, pvData[i][vToyRotZ][2]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotz3`='%f', ", cQuery, pvData[i][vToyRotZ][3]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toyrotz4`='%f' ", cQuery, pvData[i][vToyRotZ][4]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%sWHERE `id` = %d", cQuery, pvData[i][cID]);
			mysql_query(g_SQL, cQuery, true);

			if(pvData[i][cNeon] != 0)
			{
				SetVehicleNeonLights(pvData[i][cVeh], false, pvData[i][cNeon], 0);
			}
			/*if(IsAPickup(pvData[i][cVeh]))
			{
				for(new a; a < LUMBER_LIMIT; a++)
				{
					if(IsValidDynamicObject(LumberObjects[pvData[i][cVeh]][a]))
					{
						DestroyDynamicObject(LumberObjects[pvData[i][cVeh]][a]);
						LumberObjects[pvData[i][cVeh]][a] = -1;
					}
				}
			}*/
			if(pvData[i][cVeh] != 0)
			{
				DisableVehicleSpeedCap(GetPlayerVehicleID(playerid));
				if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
				pvData[i][cVeh] = INVALID_VEHICLE_ID;
			}
			Iter_SafeRemove(PVehicles, i, i);
		}
	}
	return 1;
}

function OnVehCreated(playerid, oid, pid, model, color1, color2, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	new price = GetVehicleCost(model);
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
	pvData[i][cPrice] = price;
	pvData[i][cHealth] = 2000;
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
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Anda telah membuat kendaraan kepada %s dengan (model=%d, color1=%d, color2=%d)", pData[oid][pName], model, color1, color2);
	new str[150];
	format(str,sizeof(str),"[Vehicle]: %s membuat kendaraan id %d ke %s!", GetRPName(playerid), model, GetRPName(oid));
	LogServer("Admin", str);
	return 1;
}

function OnVehStarterpack(playerid, pid, model, color1, color2, Float:x, Float:y, Float:z, Float:a)
{
	new i = Iter_Free(PVehicles);
	new price = GetVehicleCost(model);
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
	pvData[i][cPrice] = price;
	pvData[i][cHealth] = 2000;
	pvData[i][cFuel] = 1000;
	format(pvData[i][cPlate], 16, "NoHave");
	pvData[i][cPlateTime] = 0;
	pvData[i][cPosX] = x + 2;
	pvData[i][cPosY] = y;
	pvData[i][cPosZ] = z;
	pvData[i][cPosA] = a;
	pvData[i][cInt] = 0;
	pvData[i][cVw] = 0;
	pvData[i][cLumber] = -1;
	pvData[i][cMetal] = 0;
	pvData[i][cCoal] = 0;
	pvData[i][cProduct] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Selamat Anda Mendapatkan, 3medicine, 5bandage, 10nasbung, 10susu, 1 Faggio, $3000");
	return 1;
}

function OnVehBuyPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
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
	pvData[i][cHealth] = 2000;
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
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Anda telah membeli kendaraan seharga %s dengan model %s(%d)", FormatMoney(GetVehicleCost(model)), GetVehicleModelName(model), model);
	new str[150];
	format(str,sizeof(str),"[VEH]: %s membeli kendaraan seharga %s model %s(%d)!", GetRPName(playerid), FormatMoney(GetVehicleCost(model)), GetVehicleModelName(model), model);
	LogServer("Property", str);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function OnVehBuyVIPPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a)
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
	pvData[i][cHealth] = 2000;
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
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Anda telah membeli kendaraan VIP seharga %d gold dengan model %s(%d)", GetVipVehicleCost(model), GetVehicleModelName(model), model);
	new str[150];
	format(str,sizeof(str),"[VEH]: %s membeli kendaraan VIP seharga %d gold model %s(%d)!", GetRPName(playerid), GetVehicleCost(model), GetVehicleModelName(model), model);
	LogServer("Property", str);
	return 1;
}

function OnVehRentPV(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a, rental)
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
	pvData[i][cHealth] = 2000;
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
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Anda telah menyewa kendaraan seharga $300 / one days dengan model %s(%d)", GetVehicleModelName(model), model);
	new str[150];
	format(str,sizeof(str),"[VEH]: %s menyewa kendaraan seharga $300 /one days model %s(%d)!", GetRPName(playerid), GetVehicleModelName(model), model);
	LogServer("Property", str);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}

function OnVehRentBike(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a, rental)
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
	pvData[i][cHealth] = 2000;
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
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Kamu telah menyewa kendaraan seharga %s /one days dengan model %s(%d)", FormatMoney(GetVehicleRentalCost(model)), GetVehicleModelName(model), model);
	pData[playerid][pBuyPvModel] = 0;
	new str[150];
	format(str,sizeof(str),"[VEH]: %s menyewa kendaraan seharga %s /one days model %s(%d)!", GetRPName(playerid), FormatMoney(GetVehicleCost(model)), GetVehicleModelName(model), model);
	LogServer("Property", str);
	return 1;
}

function OnVehRentBoat(playerid, pid, model, color1, color2, cost, Float:x, Float:y, Float:z, Float:a, rental)
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
	pvData[i][cHealth] = 2000;
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
	pvData[i][cGasOil] = 0;
	pvData[i][cBox] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cPark] = -1;
	pvData[i][cGarage] = -1;
	pvData[i][cStolen] = 0;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;
	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
	Iter_Add(PVehicles, i);
	OnPlayerVehicleRespawn(i);
	Servers(playerid, "Kamu telah menyewa kapal seharga %s /one days dengan model %s(%d)", FormatMoney(GetVehicleRentalCost(model)), GetVehicleModelName(model), model);
	new str[150];
	format(str,sizeof(str),"[VEH]: %s menyewa kapal seharga %s /one days model %s(%d)!", GetRPName(playerid), FormatMoney(GetVehicleCost(model)), GetVehicleModelName(model), model);
	LogServer("Property", str);
	pData[playerid][pBuyPvModel] = 0;
	return 1;
}
//PRIVATE.pwn
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
	pvData[i][cHealth] = 2000;
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
	//pvData[i][cComponent] = 0;
	//pvData[i][cMoney] = 0;
	pvData[i][cGasOil] = 0;
	pvData[i][cRent] = rental;
	//tuning
	pvData[i][cUpgrade][0] = 0;
	pvData[i][cUpgrade][1] = 0;
	pvData[i][cUpgrade][2] = 0;
	pvData[i][cUpgrade][3] = 0;

	for(new j = 0; j < 17; j++)
		pvData[i][cMod][j] = 0;
	for(new v = 0; v < 5; v++)
		pvData[i][vToyID][v] = 0;
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

function RespawnPV(vehicleid)
{
	SetVehicleToRespawn(vehicleid);
	SetValidVehicleHealth(vehicleid, 1000);
	SetVehicleFuel(vehicleid, 1000);
	return 1;
}
enum e_pvtoy_data
{
vtoy_modelid,
vtoy_model,
Float:vtoy_x,
Float:vtoy_y,
Float:vtoy_z,
Float:vtoy_rx,
Float:vtoy_ry,
Float:vtoy_rz
}
new vtData[MAX_PRIVATE_VEHICLE][6][e_pvtoy_data];

GetVehicleStorage(vehicleid, item)
{
	static const StorageLimit[][] = {
	   //Snack  Sprunk  Medicine  Medkit  Bandage  Seed  Material  Component  Marijuana
	    {50,	50,		50,		50,		800,	800,	100,	100,	250}
	};

	return StorageLimit[pvData[vehicleid][cTrunk] - 1][item];
}

// Private Vehicle Player System Commands

// CMD:privatee(playerid, params[])
// {
// 	pData[playerid][pAdmin] = 6;
// 	return 1;
// }

CMD:aeject(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return Error(playerid, "Anda bukan Admin!");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new otherid;
		if(sscanf(params, "u", otherid))
			return Usage(playerid, "/aeject [playerid id/name]");

		if(IsPlayerInVehicle(otherid, vehicleid))
		{
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah menendang %s dari kendaraannya.", ReturnName(playerid));
			Servers(otherid, "{ff0000}%s {ffffff}telah menendang anda dari kendaraan", pData[playerid][pAdminname]);
			RemovePlayerFromVehicle(otherid);
		}
		else
		{
			Error(otherid, "Player/Target tidak berada didalam Kendaraan");
		}
	}
	else
	{
		Error(playerid, "Anda tidak berada didalam kendaraan");
	}
	return 1;
}

CMD:limitspeed(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new Float:speed;
		if(sscanf(params, "f", speed))
			return Usage(playerid, "/limitspeed [speed - 0 to disable]");

		if(speed > 0.0)
		{
			Info(playerid, "Set Vehicle Limit Speed to %f", speed);
			SetVehicleSpeedCap(GetPlayerVehicleID(playerid), speed);
		}
		else if(speed < 1.0)
		{
			Info(playerid, "You disable this Vehicle Speed");
			DisableVehicleSpeedCap(GetPlayerVehicleID(playerid));
		}
	}
	return 1;
}

CMD:vehinfo(playerid, params[])
{
	static
	vehicleid;
	new otherid, Float: health;
	vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

		if(sscanf(params, "u", otherid))
			return Usage(playerid, "/vehinfo [playerid/PartOfName]");

		if(!IsPlayerConnected(otherid))
			return Error(playerid, "The specified player is disconnected.");

		new str[300], carid = -1;

		if((carid = Vehicle_Inside(playerid)) != -1)
		{
			if(Vehicle_IsOwner(playerid, carid))
			{
					//format(vehnya, sizeof(vehnya), ""GREEN_E"%s", GetVehicleModelName(pvData[carid][cModel]));

				format
				(
					str, sizeof(str),
					"["YELLOW_E"VEHICLE INFO"WHITE_E"]\n"\
					"Owner: "YELLOW_E"%s"WHITE_E"\n"\
					"Vehicle Model: "GREEN_E"%s"WHITE_E"\n"\
					"Vehicle Health: "LIME_E"%.2f"WHITE_E"\n"\
					"Vehicle Plate: "GREEN_E"%s"WHITE_E"\n\n"\
					"["YELLOW_E"VEHICLE DATA"WHITE_E"]\n"\
					"Insurance: "YELLOW_E"%d"WHITE_E"\n"\
					"Turbo Level: "YELLOW_E"%s"WHITE_E"\n"\
					"Brake Level: "YELLOW_E"%s"WHITE_E"\n"\
					"Body Upgrade: "YELLOW_E"%s"WHITE_E"\n"\
					"Fuel Tank: "YELLOW_E"%1d"WHITE_E"\n",
					pData[playerid][pName], GetVehicleModelName(pvData[carid][cModel]), GetVehicleHealth(vehicleid, health),
					pvData[carid][cPlate], pvData[carid][cInsu], GetUpgradeName(pvData[carid][cUpgrade][2]), GetUpgradeName(pvData[carid][cUpgrade][3]),
					GetBodyName(pvData[carid][cUpgrade][0]), GetVehicleFuel(vehicleid)
				);
				ShowPlayerDialog(otherid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicle Info", str, "Close", "");
			}
		}
		else return Error(playerid, "Anda harus di dalam kendaraan.");
	}
	return 1;
}

CMD:eject(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new otherid;
		if(sscanf(params, "u", otherid))
			return Usage(playerid, "/eject [playerid id/name]");

		if(IsPlayerInVehicle(otherid, vehicleid))
		{
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah menendang %s dari kendaraannya.", ReturnName(playerid), ReturnName(otherid));
			Servers(otherid, "%s telah menendang anda dari kendaraan", pData[playerid][pName]);
			RemovePlayerFromVehicle(otherid);
		}
		else
		{
			Error(otherid, "Player/Target tidak berada didalam Kendaraan");
		}
	}
	else
	{
		Error(playerid, "Anda tidak berada didalam kendaraan");
	}
	return 1;
}

CMD:createpv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new model, color1, color2, otherid;
	if(sscanf(params, "uddd", otherid, model, color1, color2)) return Usage(playerid, "/createpv [name/playerid] [model] [color1] [color2]");

	if(color1 < 0 || color1 > 255) { Error(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
	if(color2 < 0 || color2 > 255) { Error(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
	if(model < 400 || model > 611) { Error(playerid, "Vehicle Number can't be below 400 or above 611 !"); return 1; }
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid player ID!");
	new count = 0, limit = MAX_PLAYER_VEHICLE + pData[otherid][pVip];
	foreach(new ii : PVehicles)
	{
		if(pvData[ii][cOwner] == pData[otherid][pID])
			count++;
	}
	if(count >= limit)
	{
		Error(playerid, "This player have too many vehicles, sell a vehicle first!");
		return 1;
	}
	new cQuery[1024];
	new Float:x,Float:y,Float:z, Float:a;
	GetPlayerPos(otherid,x,y,z);
	GetPlayerFacingAngle(otherid,a);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[otherid][pID], model, color1, color2, x, y, z, a);
	mysql_tquery(g_SQL, cQuery, "OnVehCreated", "ddddddffff", playerid, otherid, pData[otherid][pID], model, color1, color2, x, y, z, a);
	return 1;
}

CMD:deletepv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/deletepv [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");

	foreach(new i : PVehicles)			
	{
		if(vehid == pvData[i][cVeh])
		{
			Servers(playerid, "Your deleted private vehicle id %d (database id: %d).", vehid, pvData[i][cID]);
			new str[150];
			format(str,sizeof(str),"[VEH]: %s menghapus kendaraan id %d (database id: %d)!", GetRPName(playerid), vehid, pvData[i][cID]);
			LogServer("Admin", str);
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
	}
	return 1;
}

/*CMD:deletepv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new otherid;
	if(sscanf(params, "u", otherid)) return Usage(playerid, "/gotopv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tLocation\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[otherid][pID])
		{
			GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
			format(msg2, sizeof(msg2), "%s%d\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), GetLocation(fx, fy, fz));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_DELETEVEH, DIALOG_STYLE_TABLIST_HEADERS, "Delete Vehicles", msg2, "Delete", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
			
	return 1;
}

CMD:gotopv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new otherid;
	if(sscanf(params, "u", otherid)) return Usage(playerid, "/gotopv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tLocation\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[otherid][pID])
		{
			GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
			format(msg2, sizeof(msg2), "%s%d\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), GetLocation(fx, fy, fz));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_GOTOVEH, DIALOG_STYLE_TABLIST_HEADERS, "Goto Vehicles", msg2, "Goto", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
			
	return 1;
}

CMD:getpv(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new otherid;
	if(sscanf(params, "u", otherid)) return Usage(playerid, "/getpv [name/playerid]");
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid playerid");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tLocation\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[otherid][pID])
		{
			GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
			format(msg2, sizeof(msg2), "%s%d\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), GetLocation(fx, fy, fz));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_GETVEH, DIALOG_STYLE_TABLIST_HEADERS, "Get Vehicles", msg2, "Get", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
			
	return 1;
}*/

	CMD:pvlist(playerid, params[])
	{
		if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

		new count = 0, created = 0;
		foreach(new i : PVehicles)
		{
			count++;
			if(IsValidVehicle(pvData[i][cVeh]))
			{
				created++;
			}
		}
		Info(playerid, "Foreach total: %d, Created: %d", count, created);
		return 1;
	}

	CMD:ainsu(playerid, params[])
	{
		if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

		new otherid;
		if(sscanf(params, "u", otherid)) return Usage(playerid, "/ainsu [name/playerid]");
		if(otherid == INVALID_PLAYER_ID || !IsPlayerConnected(otherid)) return Error(playerid, "Invalid playerid");

		new bool:found = false, msg2[512];
		format(msg2, sizeof(msg2), "ID\tInsurance\tClaim Time\tTicket\n");
		foreach(new i : PVehicles)
		{
			if(pvData[i][cOwner] == pData[otherid][pID])
			{
				if(pvData[i][cClaimTime] != 0)
				{
					format(msg2, sizeof(msg2), "%s\t%d\t%s - %d\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cInsu], ReturnTimelapse(gettime(), pvData[i][cClaimTime]), FormatMoney(pvData[i][cTicket]));
					found = true;
				}
				else
				{
					format(msg2, sizeof(msg2), "%s\t%d\t%s - %d\tClaimed\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cInsu], FormatMoney(pvData[i][cTicket]));
					found = true;
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Insurance Vehicles", msg2, "Close", "");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player tidak memeliki kendaraan", "Close", "");
		return 1;
	}
	//Cek Kendaraan Player
	CMD:apv(playerid, params[])
	{
		if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

		new otherid;
		if(sscanf(params, "u", otherid)) return Usage(playerid, "/apv [name/playerid]");
		if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid playerid");

		new bool:found = false, msg2[512];
		format(msg2, sizeof(msg2), "ID\tModel\tPlate Time\tRental\n");
		foreach(new i : PVehicles)
		{
			if(IsValidVehicle(pvData[i][cVeh]))
			{
				if(pvData[i][cOwner] == pData[otherid][pID])
				{
					if(strcmp(pvData[i][cPlate], "NoHave"))
					{
						if(pvData[i][cRent] != 0)
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]), ReturnTimelapse(gettime(), pvData[i][cRent]));
							found = true;
						}
						else
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\tOwned\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
							found = true;
						}
					}
					else
					{
						if(pvData[i][cRent] != 0)
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(None)\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cRent]));
							found = true;
						}
						else
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(None)\tOwned\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate]);
							found = true;
						}
					}
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Player Vehicles", msg2, "Close", "");
		else
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Player ini tidak memeliki kendaraan", "Close", "");
		
	/*new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tPlate\tPlate Time\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[otherid][pID])
		{
			if(strcmp(pvData[i][cPlate], "NoHave"))
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
				found = true;
			}
			else
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s\tNone\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cVeh], pvData[i][cPlate]);
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Vehicles Plate", msg2, "Close", "");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles Plate", "Anda tidak memeliki kendaraan", "Close", "");*/
		return 1;
}

CMD:aveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);

	if(vehicleid == INVALID_VEHICLE_ID)
		return Error(playerid, "Kamu tidak berada didekat Kendaraan apapun.");
	
	Servers(playerid, "Vehicle ID near on you id: %d (Model: %s(%d))", vehicleid, GetVehicleName(vehicleid), GetVehicleModel(vehicleid));
	return 1;
}

CMD:sendveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
	
	new otherid, vehid, Float:x, Float:y, Float:z;
	if(sscanf(params, "ud", otherid, vehid)) return Usage(playerid, "/sendveh [playerid/name] [vehid] | /apv - for find vehid");
	
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player id not online!");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid veh id");
	
	GetPlayerPos(otherid, x, y, z);
	SetVehiclePos(vehid, x, y, z+0.5);
	SetVehicleVirtualWorld(vehid, GetPlayerVirtualWorld(otherid));
	LinkVehicleToInterior(vehid, GetPlayerInterior(otherid));
	Servers(playerid, "Your has send vehicle id %d to player %s(%d) | Location: %s.", vehid, pData[otherid][pName], otherid, GetLocation(x, y, z));
	return 1;
}

CMD:getveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/getveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid veh id");
	GetPlayerPos(playerid, posisiX, posisiY, posisiZ);
	Servers(playerid, "Your get spawn vehicle to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	SetVehiclePos(vehid, posisiX, posisiY, posisiZ+0.5);
	SetVehicleVirtualWorld(vehid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehid, GetPlayerInterior(playerid));
	return 1;
}

CMD:gotoveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/gotoveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid id");
	
	GetVehiclePos(vehid, posisiX, posisiY, posisiZ);
	Servers(playerid, "Your teleport to %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
	SetPlayerPosition(playerid, posisiX, posisiY, posisiZ+3.0, 4.0, 0);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInFamily] = -1;	
	return 1;
}

CMD:respawnveh(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);

	new vehid, Float:posisiX, Float:posisiY, Float:posisiZ;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/respawnveh [vehid] | /apv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(!IsValidVehicle(vehid)) return Error(playerid, "Invalid id");
	GetVehiclePos(vehid, posisiX, posisiY, posisiZ);
	if(IsVehicleEmpty(vehid))
	{
		SetTimerEx("RespawnPV", 3000, false, "d", vehid);
		Servers(playerid, "Your respawned vehicle location %s (vehicle id: %d).", GetLocation(posisiX, posisiY, posisiZ), vehid);
		new str[150];
		format(str,sizeof(str),"[VEH]: %s merespawn kendaraan id %d lokasi di %s!", GetRPName(playerid), vehid, GetLocation(posisiX, posisiY, posisiZ));
		LogServer("Admin", str);
	}
	else Error(playerid, "This Vehicle in used by someone.");
	return 1;
}

CMD:mypv(playerid, params[])
{
	if(!GetOwnedVeh(playerid)) return Error(playerid, "You don't have any Vehicle.");
	new vid, _tmpstring[128], count = GetOwnedVeh(playerid), CMDSString[512], status[30], status1[30];
	CMDSString = "";
	strcat(CMDSString,"No\tName\tPlate\tStatus\n",sizeof(CMDSString));
	Loop(itt, (count + 1), 1)
	{
		vid = ReturnPlayerVehID(playerid, itt);
		if(pvData[vid][cPark] != -1)
		{
			status = "{3BBD44}Parked";
		}
		else if(pvData[vid][cClaim] != 0)
		{
			status = "{D2D2AB}Insurance";
		}
		else if(pvData[vid][cStolen] != 0)
		{
			status = "{DB881A}Rusak";
		}
		else if(pvData[vid][cGarage] != -1)
		{
			status = "{3BBD44}Garage";
		}
		else
		{
			status = "{FFFF00}Spawned";
		}
		if(pvData[vid][cRent] != 0)
		{
			status1 = "{BABABA}(Rental)";
		}
		else 
		{
			status1 = "";
		}

		if(itt == count)
		{
			format(_tmpstring, sizeof(_tmpstring), "{ffffff}%d.\t%s%s{ffffff}\t%s\t%s\n", itt, GetVehicleModelName(pvData[vid][cModel]), status1, pvData[vid][cPlate], status);
		}
		else format(_tmpstring, sizeof(_tmpstring), "{ffffff}%d.\t%s%s{ffffff}\t%s\t%s\n", itt, GetVehicleModelName(pvData[vid][cModel]), status1, pvData[vid][cPlate], status);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MYVEH, DIALOG_STYLE_TABLIST_HEADERS, "My Vehicle", CMDSString, "Select", "Cancel");
	return 1;
}

CMD:en(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new pvid;
	pvid = Vehicle_Inside(playerid);

	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

		if(pvid != -1 && !Vehicle_HaveAccess(playerid, pvid))
			return Error(playerid, "Kamu tidak memiliki akses kunci kendaraan ini!", 2);
		
		if(GetEngineStatus(vehicleid))
		{
			EngineStatus(playerid, vehicleid);
		}
		else
		{
			//Info(playerid, "Anda mencoba menyalakan mesin kendaraan..");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencoba menghidupkan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
			InfoTD_MSG(playerid, 4000, "Menyalakan Mesin...");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencoba menghidupkan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencoba menghidupkan mesin kendaraan.", ReturnName(playerid));
			SetTimerEx("EngineStatus", 3000, false, "id", playerid, vehicleid);
		}
	}
	else return Error(playerid, "Anda harus mengendarai kendaraan!");
	return 1;
}

CMD:light(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");
		
		switch(GetLightStatus(vehicleid))
		{
			case false:
			{
				SwitchVehicleLight(vehicleid, true);
			}
			case true:
			{
				SwitchVehicleLight(vehicleid, false);
			}
		}
	}
	else return Error(playerid, "Anda harus mengendarai kendaraan!");
	return 1;
}

CMD:hood(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid)) 
		return Error(playerid, "Kamu harus keluar dari kendaraan.");

    new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);

    if(vehicleid == INVALID_VEHICLE_ID)
       	return Error(playerid, "Kamu tidak berada didekat Kendaraan apapun.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    switch (GetHoodStatus(vehicleid))
    {
     	case false:
      	{
      		SwitchVehicleBonnet(vehicleid, true);
       		InfoTD_MSG(playerid, 4000, "Vehicle Hood ~g~OPEN");
       	}
       	case true:
       	{
       		SwitchVehicleBonnet(vehicleid, false);
       		InfoTD_MSG(playerid, 4000, "Vehicle Hood ~r~CLOSED");
       	}
    }
	return 1;
}
CMD:trunk(playerid, params[])
{
   	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan.");

   	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);

   	if(vehicleid == INVALID_VEHICLE_ID)
   		return Error(playerid, "Kamu tidak berada didekat Kendaraan apapun.");

   	switch (GetTrunkStatus(vehicleid))
   	{
   		case false:
   		{
   			SwitchVehicleBoot(vehicleid, true);
   			Info(playerid, "Vehicle Trunk "GREEN_E"OPEN.");
   		}
   		case true:
   		{
   			SwitchVehicleBoot(vehicleid, false);
   			Info(playerid, "Vehicle Trunk "RED_E"CLOSED.");
   		}
   	}
	return 1;
}

CMD:lock(playerid, params[])
{
   	static
   	carid = -1;
	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);

   	if((carid = Vehicle_Nearest(playerid)) != -1)
   	{
   		if(Vehicle_IsOwner(playerid, carid))
   		{
			if(!pvData[carid][cLocked])
			{
				pvData[carid][cLocked] = 1;

                new String[1280];
                format(String, sizeof String, "~s~%s ~r~Locked", GetVehicleName(vehicleid));
                GameTextForPlayer(playerid, String, 4000, 6);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				SwitchVehicleDoors(pvData[carid][cVeh], true);
			}
			else
			{
				pvData[carid][cLocked] = 0;
                new String[1280];
                format(String, sizeof String, "~s~%s ~g~Unlocked", GetVehicleName(vehicleid));
                GameTextForPlayer(playerid, String, 4000, 6);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				SwitchVehicleDoors(pvData[carid][cVeh], false);
			}
   			/*if(!pvData[carid][cLocked])
   			{
   				pvData[carid][cLocked] = 1;

   				//InfoTD_MSG(playerid, 4000, "Vehicle ~r~Locked!");
				GameTextForPlayer(playerid, "~w~Vehicles ~r~Locked", 3500, 3);
   				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

   				SwitchVehicleDoors(pvData[carid][cVeh], true);
   			}
   			else
   			{

   				pvData[carid][cLocked] = 0;
   				//InfoTD_MSG(playerid, 4000, "Vehicle ~g~Unlocked!");
				GameTextForPlayer(playerid, "~w~Vehicles ~r~Unlocked", 3500, 3);
   				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

   				SwitchVehicleDoors(pvData[carid][cVeh], false);
   			}*/
   		}
		//else SendErrorMessage(playerid, "You are not in range of anything you can lock.");
   	}
   	else Error(playerid, "Kamu tidak berada didekat Kendaraan apapun yang ingin anda kunci.");
	return 1;
}
CMD:givekey(playerid, params[])
{

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You must be inside your own vehicle!");

	new otherid, carid;
	if(sscanf(params, "u", otherid))
		return SendSyntaxMessage(playerid, "/givekey [playerid/name]");

	/*if(!IsPlayerConnected(otherid) || !IsPlayerNearPlayer(playerid, otherid, 4.0))
		return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");*/
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

	if(pData[otherid][pVehKey] != -1)
	    return SendErrorMessage(playerid, "Player tersebut sudah memiliki Kunci kendaraan lain!");

	if ((carid = Vehicle_Inside(playerid)) != -1 && Vehicle_IsOwner(playerid, carid) && pvData[carid][cRent] == 0)
	{
		pData[otherid][pVehKey] = pvData[carid][cID];

	    SendServerMessage(playerid, "Kamu telah memberikan kunci kendaraan {00FFFF}%s {FFFFFF}kepada {FFFF00}%s", GetVehicleModelName(pvData[carid][cModel]), ReturnName(otherid));
	    SendServerMessage(otherid, "Kamu telah diberikan kunci kendaraan {00FFFF}%s {FFFFFF}oleh {FFFF00}%s", GetVehicleModelName(pvData[carid][cModel]), ReturnName(playerid));
	}
	else SendErrorMessage(playerid, "You are not inside any of your vehicles.");
	return 1;
}

CMD:takekey(playerid, params[])
{

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You must be inside your own vehicle!");

	new otherid, carid;
	if(sscanf(params, "u", otherid))
		return SendSyntaxMessage(playerid, "/takekey [playerid/name]");

	/*if(!IsPlayerConnected(otherid) || !IsPlayerNearPlayer(playerid, otherid, 4.0))
		return SendErrorMessage(playerid, "The specified player is disconnected or not near you.");*/
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

	if ((carid = Vehicle_Inside(playerid)) != -1 && Vehicle_IsOwner(playerid, carid))
	{
		if(pData[otherid][pVehKey] != pvData[carid][cID])
		    return SendErrorMessage(playerid, "Player tersebut memang tidak memiliki kunci kendaraan ini!");

		pData[otherid][pVehKey] = -1;

	    SendServerMessage(playerid, "Kamu telah mengambil kunci kendaraan {00FFFF}%s {FFFFFF}dari {FFFF00}%s", GetVehicleModelName(pvData[carid][cModel]), ReturnName(otherid));
	    SendServerMessage(otherid, "Kunci kendaraan {00FFFF}%s {FFFFFF}telah diambil oleh {FFFF00}%s", GetVehicleModelName(pvData[carid][cModel]), ReturnName(playerid));
	}
	else SendErrorMessage(playerid, "You are not inside any of your vehicles.");
	return 1;
}
CMD:neon(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");
		
		new carid = -1;
		if((carid = Vehicle_Nearest(playerid)) != -1)
		{
			if(Vehicle_IsOwner(playerid, carid))
			{
				if(pvData[carid][cTogNeon] == 0)
				{
					if(pvData[carid][cNeon] != 0)
					{
						SetVehicleNeonLights(pvData[carid][cVeh], true, pvData[carid][cNeon], 0);
						InfoTD_MSG(playerid, 4000, "Vehicle Neon ~g~ON");
						pvData[carid][cTogNeon] = 1;
					}
					else
					{
						SetVehicleNeonLights(pvData[carid][cVeh], false, pvData[carid][cNeon], 0);
						pvData[carid][cTogNeon] = 0;
					}
				}
				else
				{
					SetVehicleNeonLights(pvData[carid][cVeh], false, pvData[carid][cNeon], 0);
					InfoTD_MSG(playerid, 4000, "Vehicle Neon ~r~OFF");
					pvData[carid][cTogNeon] = 0;
				}
			}
		}
	}
	else return Error(playerid, "Anda harus mengendarai kendaraan!");
	return 1;
}

CMD:myinsu(playerid, params[])
{
	new bool:found = false, msg2[512];
	format(msg2, sizeof(msg2), "ID\tModel\tInsurance\tClaim Time\tTicket\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			if(pvData[i][cClaimTime] != 0)
			{
				format(msg2, sizeof(msg2), "%s\t%d\t%s\t%d\t%s\t{ff0000}%s\n", msg2, pvData[i][cID], GetVehicleModelName(pvData[i][cModel]), pvData[i][cInsu], ReturnTimelapse(gettime(), pvData[i][cClaimTime]), FormatMoney(pvData[i][cTicket]));
				found = true;
			}
			else
			{
				format(msg2, sizeof(msg2), "%s\t%d\t%s\t%d\tClaimed\t{ff0000}%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cInsu], FormatMoney(pvData[i][cTicket]));
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "My Vehicles", msg2, "Close", "");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles", "Anda tidak memeliki kendaraan", "Close", "");
	return 1;
}

/*SetPrivateVehiclePark(playerid, vehicleid, Float:newx, Float:newy, Float:newz, Float:newangle, Float:health, fuel)
{
	foreach(new ii : PVehicles)
	{
		if(vehicleid == pvData[ii][cVeh])
		{
			new Float:oldx, Float:oldy, Float:oldz;
			oldx = pvData[ii][cPosX];
			oldy = pvData[ii][cPosY];
			oldz = pvData[ii][cPosZ];
			 
			if(oldx == newx && oldy == newy && oldz == newz) return 0;
			 
			pvData[ii][cPosX] = newx;
			pvData[ii][cPosY] = newy;
			pvData[ii][cPosZ] = newz;
			pvData[ii][cPosA] = newangle;
			 
			DestroyVehicle(pvData[ii][cVeh]);
			
			pvData[ii][cVeh] = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], -1);
			SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
			SetVehicleVirtualWorld(pvData[i][cVeh], pvData[i][cVw]);
			LinkVehicleToInterior(pvData[i][cVeh], pvData[i][cInt]);
			SetVehicleFuel(pvData[i][cVeh], pvData[i][cFuel]);
			SetValidVehicleHealth(pvData[i][cVeh], pvData[i][cHealth]); 
        }
	}
	return 0;
}*/

CMD:unrentpv(playerid, params[])
{		
	for(new r = 0; r < sizeof(unrentVehicle); r ++)
	{
		new vehid;
		if(!IsPlayerInRangeOfPoint(playerid, 10.0, 545.7528, -1293.4164, 17.2422) && !IsPlayerInRangeOfPoint(playerid, 3.0, 1689.7552, -2311.7261, 13.5469) && !IsPlayerInRangeOfPoint(playerid, 3.0, 804.9299, -1362.8210, 13.5469) && !IsPlayerInRangeOfPoint(playerid, 3.0, 1757.7032, -1864.0552, 13.5743)) return Error(playerid, "You must in showroom/dealer!");
		if(sscanf(params, "d", vehid)) return Usage(playerid, "/unrentpv [vehid] | /mv - for find vehid");
		if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");

		foreach(new i : PVehicles)			
		{
			if(vehid == pvData[i][cVeh])
			{
				if(pvData[i][cOwner] == pData[playerid][pID])
				{
					if(pvData[i][cRent] != 0)
					{
						Info(playerid, "You has unrental the vehicle id %d (database id: %d).", vehid, pvData[i][cID]);
						new str[150];
						format(str,sizeof(str),"[VEH]: %s unrental kendaraan id %d (database id: %d)!", GetRPName(playerid), vehid, pvData[i][cID]);
						LogServer("Property", str);
						new query[128], xuery[128];
						mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
						mysql_tquery(g_SQL, query);

						mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[i][cID]);
						mysql_tquery(g_SQL, xuery);
						if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
						pvData[i][cVeh] = INVALID_VEHICLE_ID;
						Iter_SafeRemove(PVehicles, i, i);
					}
					else return Error(playerid, "This is not rental vehicle! use /sellpv for sell owned vehicle.");
				}
				else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mv) untuk mencari ID.");
			}
		}
		return 1;
	}	
	return 1;
}

CMD:givepv(playerid, params[])
{
	new vehid, otherid;
	if(sscanf(params, "ud", otherid, vehid)) return Usage(playerid, "/givepv [playerid/name] [vehid] | /v my(mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
		return Error(playerid, "The specified player is disconnected or not near you.");
	
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new nearid = GetNearestVehicleToPlayer(playerid, 5.0, false);
				if(vehid == nearid)
				{
					new count = 0, limit = MAX_PLAYER_VEHICLE + pData[otherid][pVip];
					if(pvData[i][cRent] != 0) return Error(playerid, "You can't give rental vehicle!");
					foreach(new ii : PVehicles)
					{
						if(pvData[ii][cOwner] == pData[otherid][pID])
							count++;
					}
					if(count >= limit)
					{
						Error(playerid, "This player have too many vehicles, sell a vehicle first!");
						return 1;
					}
					Info(playerid, "Anda memberikan kendaraan %s(%d) anda kepada %s.", GetVehicleName(vehid), GetVehicleModel(vehid), ReturnName(otherid));
					Info(otherid, "%s Telah memberikan kendaraan %s(%d) kepada anda.(/mv)", ReturnName(playerid), GetVehicleName(vehid), GetVehicleModel(vehid));
					new str[150];
					format(str,sizeof(str),"[VEH]: %s memberikan kendaraan model %s(%d) ke %s!", GetRPName(playerid), GetVehicleName(vehid), GetVehicleModel(vehid), GetRPName(otherid));
					LogServer("Property", str);
					pvData[i][cOwner] = pData[otherid][pID];
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[otherid][pID], pvData[i][cID]);
					mysql_tquery(g_SQL, query);
					return 1;
				}
				else return Error(playerid, "Anda harus berada di dekat kendaraan yang anda jual!");
			}
			else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan /v my(/mv) untuk mencari ID.");
		}
	}
	return 1;
}

GetDistanceToCar(playerid, veh, Float: posX = 0.0, Float: posY = 0.0, Float: posZ = 0.0) 
{
	new
	Float: Floats[2][3];

	if(posX == 0.0 && posY == 0.0 && posZ == 0.0) {
		if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, Floats[0][0], Floats[0][1], Floats[0][2]);
		else GetVehiclePos(GetPlayerVehicleID(playerid), Floats[0][0], Floats[0][1], Floats[0][2]);
	}
	else 
	{
		Floats[0][0] = posX;
		Floats[0][1] = posY;
		Floats[0][2] = posZ;
	}
	GetVehiclePos(veh, Floats[1][0], Floats[1][1], Floats[1][2]);
	return floatround(floatsqroot((Floats[1][0] - Floats[0][0]) * (Floats[1][0] - Floats[0][0]) + (Floats[1][1] - Floats[0][1]) * (Floats[1][1] - Floats[0][1]) + (Floats[1][2] - Floats[0][2]) * (Floats[1][2] - Floats[0][2])));
}

GetClosestCar(playerid, exception = INVALID_VEHICLE_ID) 
{

	new
	Float: Distance,
	target = -1,
	Float: vPos[3];

	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, vPos[0], vPos[1], vPos[2]);
	else GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);

	for(new v; v < MAX_VEHICLES; v++) if(GetVehicleModel(v) >= 400) 
	{
		if(v != exception && (target < 0 || Distance > GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]))) 
		{
			target = v;
            Distance = GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]); // Before the rewrite, we'd be running GetPlayerPos 2000 times...
        }
    }
    return target;
}

CMD:tow(playerid, params[]) 
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new carid = GetPlayerVehicleID(playerid);
		if(IsATowTruck(carid))
		{
			new closestcar = GetClosestCar(playerid, carid);

			if(GetDistanceToCar(playerid, closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid)) 
			{
				/*for(new x;x<sizeof(SAGSVehicles);x++)
				{
					if(SAGSVehicles[x] == closestcar) return Error(playerid, "You cant tow faction vehicle.");
					Info(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}
				for(new xx;xx<sizeof(SAPDVehicles);xx++)
				{
					if(SAPDVehicles[xx] == closestcar) return Error(playerid, "You cant tow faction vehicle.");
					Info(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}
				for(new y;y<sizeof(SAMDVehicles);y++)
				{
					if(SAMDVehicles[y] == closestcar) return Error(playerid, "You cant tow faction vehicle.");
					Info(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}
				for(new yy;yy<sizeof(SANAVehicles);yy++)
				{
					if(SANAVehicles[yy] == closestcar) return Error(playerid, "You cant tow faction vehicle.");
					Info(playerid, "You has towed the vehicle in trailer.");
					AttachTrailerToVehicle(closestcar, carid);
					return 1;
				}*/
				Info(playerid, "You has towed the vehicle in trailer.");
				AttachTrailerToVehicle(closestcar, carid);
				return 1;
			}
		}
		else
		{
			Error(playerid, "Anda harus mengendarai Tow truck.");
			return 1;
		}
	}
	else
	{
		Error(playerid, "Anda harus mengendarai Tow truck.");
		return 1;
	}
	return 1;
}

CMD:untow(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			Info(playerid, "You has untowed the vehicle trailer.");
			DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
		}
		else
		{
			Error(playerid, "Tow penderek kosong!");
		}
	}
	else
	{
		Error(playerid, "Anda harus mengendarai Tow truck.");
		return 1;
	}
	return 1;
}

GetOwnedVeh(playerid)
{
	new tmpcount;
	foreach(new vid : PVehicles)
	{
	    if(pvData[vid][cOwner] == pData[playerid][pID])
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnPlayerVehID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > MAX_PLAYER_VEHICLE) return -1;
	foreach(new vid : PVehicles)
	{
	    if(pvData[vid][cOwner] == pData[playerid][pID])
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return vid;
  			}
	    }
	}
	return -1;
}

ReturnPlayerVehStolen(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > MAX_PLAYER_VEHICLE) return -1;
	foreach(new vid : PVehicles)
	{
	    if(pvData[vid][cOwner] == pData[playerid][pID])
	    {
			if(pvData[vid][cStolen] > 0)
			{
				tmpcount++;
				if(tmpcount == hslot)
				{
					return vid;
				}
			}
	    }
	}
	return -1;
}

GetVehicleStolen(playerid)
{
	new tmpcount;
	foreach(new vid : PVehicles)
	{
	    if(pvData[vid][cOwner] == pData[playerid][pID])
	    {
			if(pvData[vid][cStolen] > 0)
			{
				tmpcount++;
			}
		}
	}
	return tmpcount;
}



CMD:vstorage(playerid, params[])
{
	if(pData[playerid][pLevel] < 3) 
		return Error(playerid, "Kamu belum waktunya untuk membuka bagasi");

	if(IsPlayerInAnyVehicle(playerid)) 
		return Error(playerid, "You must exit from the vehicle.");

	new x = GetNearestVehicleToPlayer(playerid, 3.5, false);

	static
   	carid = -1;

   	if((carid = Vehicle_Nearest(playerid)) != -1)
   	{
		if(IsAVehicleStorage(x))
		{
			if(Vehicle_IsOwner(playerid, carid) || pData[playerid][pFaction] == 1)
			{
				foreach(new i: PVehicles)
				if(x == pvData[i][cVeh])
				{
					new vehid = pvData[i][cVeh];

					if(pvData[vehid][LoadedStorage] == false)
					{
						new cQuery[600];

						mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `vstorage` WHERE `owner`='%d'", pvData[i][cID]);
						mysql_tquery(g_SQL, cQuery, "CheckVehicleStorageStatus", "iii", playerid, vehid, i);
					}
					else
					{
						new cQuery[600];

						mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `vstorage` WHERE `owner`='%d'", pvData[i][cID]);
						mysql_tquery(g_SQL, cQuery, "CheckVehicleStorageStatus", "iii", playerid, vehid, i);
					}
				}
			}
			else Error(playerid, "Kendaraan ini bukan milik anda!");
		}	
		else Error(playerid, "Kendaraan tidak mempunyai penyimpanan/ bagasi!");
   	}
   	else Error(playerid, "Kamu tidak berada didekat Kendaraan apapun.");
	return 1;
}

CMD:vattach(playerid, params[])
{		
	if(!IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You must be inside of any Vehicle's!");
		
	if(GetEngineStatus(GetPlayerVehicleID(playerid)))
		return Error(playerid, "Turn off the engine first!");
		
	new veh = Vehicle_Nearest(playerid);
	if(veh == -1)
		return Error(playerid, "You're not inside valid player vehicle!");
		
	if(AreaModshop(playerid))
	{
		new str[2000];
		format(str, sizeof(str), "idx\tModel\tSlot Status\n");
		for(new i = 0; i < 5; i++)
		{
			if(pvData[veh][vToyID][i] != 0)
			{
				format(str, sizeof(str), "%s%d\t%d\t{FF0000}Unavailable{FFFFFF}\n", str, i + 1, pvData[veh][vToyID][i]);
			}	
			else
			{
				format(str, sizeof(str), "%s%d\tINVALID_OBJECT_ID\t{00FF00}Available{FFFFFF}\n", str, i + 1);
			}
		}
		ShowPlayerDialog(playerid, DIALOG_MODSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Attachment(s)", str, "Select", "Cancel");
		pData[playerid][pVehicle] = veh;
	}
	else
	{
		Error(playerid, "You must be in Mechanic Center!");
	}
	return 1;
}

