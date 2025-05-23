#define MAX_PRIVATE_VEHICLE 20000
#define MAX_PLAYER_VEHICLE 3
// Define limits for different storage types
#define LIMIT_VSEED 500
#define LIMIT_VMATERIAL 2500
#define LIMIT_VCOMPONENT 2500
#define LIMIT_VMARIJUANA 100
#define LIMIT_VCRACK 100
#define LIMIT_VMETAL 100
#define LIMIT_VSHROOMS	100
#define LIMIT_VXANAX	100
#define LIMIT_VPEYOTE	100
#define LIMIT_VMEDICINE 5
#define LIMIT_VMEDKIT 5
#define LIMIT_VBANDAGE 5
#define LIMIT_VREDMONEY 100000
#define DESPAWN_DISTANCE 50.0
#define LIMIT_VSLC 1
#define LIMIT_VCOLT 1
#define LIMIT_VSG 1
#define LIMIT_VDE 1
#define LIMIT_VRIFFLE 1
#define LIMIT_VUZI 1
#define LIMIT_VAK 1


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
	cBox,
	cRent,
	cVeh,
	cSpawn,
	cTrunk,

	cUpgrade[4],
	cTurboMode,
	cBrakeMode,
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
	cLockTire,
	cReason[30],
	//Vehicle Storage
	vehWindowsDown,
	
	//vtoynew
	bool:PurchasedvToy,
	vtoySelected,	
	//vtoyold
	bool:LoadedStorage,
	STREAMER_TAG_OBJECT:vToy[5],
	vToyID[5],
	cAttachedToy[5],
	Float:vToyPosX[5],
	Float:vToyPosY[5],
	Float:vToyPosZ[5],
	Float:vToyRotX[5],
	Float:vToyRotY[5],
	Float:vToyRotZ[5],
	//crate
	cCrateFish,
	cCrateCompo,
	cCrateMats,
	cCrateFood,
	//
	vInGarage,
	bool: vLoaded,
	bool: vHandbrake,
	bool: vVehicleUpdate
};
new pvData[MAX_PRIVATE_VEHICLE][pvdata],
Iterator:PVehicles<MAX_PRIVATE_VEHICLE + 1>;

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

// IsPlayerInRangeOfVehicle(playerid, Float: radius)
// {
// 	new
// 		Float:Floats[3];

// 	for( new i = 0; i < MAX_VEHICLES; i++ ) {
// 	    GetVehiclePos(i, Floats[0], Floats[1], Floats[2]);
// 	    if( IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]) ) {
// 		    return i;
// 		}
// 	}

// 	return false;
// }

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
Vehicle_NearestPD(playerid, Float:range = 5.5)
{
    new Float:fX, Float:fY, Float:fZ;

    foreach(new i : PVehicles)
    {
        if(pvData[i][cVeh] != INVALID_VEHICLE_ID) 
        {
            GetVehiclePos(pvData[i][cVeh], fX, fY, fZ); 

            if(IsPlayerInRangeOfPoint(playerid, range, fX, fY, fZ)) 
            {
                return i; 
            }
        }
    }
    return -1; 
}
Vehicle_Nearest(playerid, Float:range = 4.0)
{
    new Float:fX, Float:fY, Float:fZ;


    new playerID = pData[playerid][pID];

    foreach(new i : PVehicles)
    {
        if(pvData[i][cVeh] != INVALID_VEHICLE_ID && pvData[i][cOwner] == playerID) 
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

		new panels, doors, lights, tires;
		GetVehicleDamageStatus(pvData[carid][cVeh], panels, doors, lights, tires);
		pvData[carid][cDamage0] = panels;
		pvData[carid][cDamage1] = doors;
		pvData[carid][cDamage2] = lights;
		pvData[carid][cDamage3] = tires;
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
	foreach(new pid : Player)
	{
		if (Vehicle_IsOwner(pid, i))
		{
			if(pvData[i][cClaim] == 0  && pvData[i][cImpounded] == 0 && pvData[i][vInGarage] == INVALID_GARAGE_ID)
			{
				pvData[i][cVeh] = CreateVehicle(pvData[i][cModel], pvData[i][cPosX], pvData[i][cPosY], pvData[i][cPosZ], pvData[i][cPosA], pvData[i][cColor1], pvData[i][cColor2], -1);
				SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
				SetVehicleVirtualWorld(pvData[i][cVeh], pvData[i][cVw]);
				LinkVehicleToInterior(pvData[i][cVeh], pvData[i][cInt]);
				SetVehicleFuel(pvData[i][cVeh], pvData[i][cFuel]);
				pvData[i][cTurboMode] = pvData[i][cUpgrade][2];
				pvData[i][cBrakeMode] = pvData[i][cUpgrade][3];

				if (pvData[i][cSpawn] == 1)
				{
					SetVehicleVirtualWorld(pvData[i][cVeh], random(99999) + 1);
					Vehicle_Save(i);

					/*new Float: x, Float: y, Float: z, Float: angle, vw, int;
					GetVehiclePos(pvData[i][cVeh], x, y, z);
					GetVehicleZAngle(pvData[i][cVeh], angle);

					vw = GetVehicleVirtualWorld(pvData[i][cVeh]);
					int = GetVehicleInterior(pvData[i][cVeh]);

					pvData[i][cPosX] = x;
					pvData[i][cPosY] = y;
					pvData[i][cPosZ] = z;
					pvData[i][cPosA] = angle;

					pvData[i][cVw] = vw;
					pvData[i][cInt] = int;

					Vehicle_Save(i);

					// Destroy vehicle
					DestroyVehicle(pvData[i][cVeh]);
					pvData[i][cVeh] = INVALID_VEHICLE_ID;*/
				}
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

				UpdateVehicleDamageStatus(pvData[i][cVeh], pvData[i][cDamage0], pvData[i][cDamage1], pvData[i][cDamage2], pvData[i][cDamage3]);

				pvData[i][vVehicleUpdate] = false;

				// Crate data
				vCrateData[pvData[i][cVeh]][vCrateFish] = pvData[i][cCrateFish];
				vCrateData[pvData[i][cVeh]][vCrateCompo] = pvData[i][cCrateCompo];
				vCrateData[pvData[i][cVeh]][vCrateMats] = pvData[i][cCrateMats];
				vCrateData[pvData[i][cVeh]][vCrateFood] = pvData[i][cCrateFood];
			}
			OnLoadVehicleStorage(i);
			MySQL_LoadVehicleStorage(i);
			/*if(pvData[i][cClaim] != 0)
			{
				SetTimerEx("RespawnPV", 3000, false, "d", pvData[i][cVeh]);
			}*/
			//SwitchVehicleEngine(pvData[i][cVeh], false);
		}
	}
    return pvData[i][cVeh];
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
			cache_get_value_name_int(z, "trunk", pvData[i][cTrunk]);
			cache_get_value_name_int(z, "insu", pvData[i][cInsu]);
			cache_get_value_name_int(z, "impound", pvData[i][cImpounded]);
			cache_get_value_name_int(z, "impoundprice", pvData[i][cImpoundPrice]);
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

			cache_get_value_name_int(z, "damage0", pvData[i][cDamage0]);
			cache_get_value_name_int(z, "damage1", pvData[i][cDamage1]);
			cache_get_value_name_int(z, "damage2", pvData[i][cDamage2]);
			cache_get_value_name_int(z, "damage3", pvData[i][cDamage3]);

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
			cache_get_value_name_int(z, "box", pvData[i][cBox]);
			cache_get_value_name_int(z, "rental", pvData[i][cRent]);
			cache_get_value_name_int(z, "spawn", pvData[i][cSpawn]);
			cache_get_value_name_int(z, "locktire", pvData[i][cLockTire]);
			cache_get_value_name(z, "reason", tempString);
			format(pvData[i][cReason], 30, tempString);

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

			cache_get_value_name_int(z, "cCrateFish", pvData[i][cCrateFish]);
			cache_get_value_name_int(z, "cCrateCompo", pvData[i][cCrateCompo]);
			cache_get_value_name_int(z, "cCrateMats", pvData[i][cCrateMats]);
			cache_get_value_name_int(z, "cCrateFood", pvData[i][cCrateFood]);

			cache_get_value_name_int(z, "vInGarage", pvData[i][vInGarage]);
			cache_get_value_name_int(z, "vHandbrake", pvData[i][vHandbrake]);

			pvData[i][vVehicleUpdate] = false;

			pvData[i][vLoaded] = true;

			/*for(new x = 0; x < 17; x++)
			{
				format(tempString, sizeof(tempString), "mod%d", x);
				cache_get_value_name_int(z, tempString, pvData[i][cMod][x]);
			}*/
			Iter_Add(PVehicles, i);

			if(pvData[i][cClaim] == 0)
			{
				OnPlayerVehicleRespawn(i);
				MySQL_LoadVehicleStorage(i);
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
	format(cQuery, sizeof(cQuery), "UPDATE vehicle SET locked='%d', \
		trunk='%d', \
		insu='%d', \
		impound='%d', \
		impoundprice='%d', \
		claim='%d', \
		claim_time='%d', \
		x='%f', y='%f', z='%f', a='%f', health='%f', \
		fuel='%d', \
		interior='%d', \
		vw='%d', \
		damage0='%d', \
		damage1='%d', \
		damage2='%d', \
		damage3='%d', \
		color1='%d', \
		color2='%d', \
		paintjob='%d', \
		neon='%d', \
		price='%d', \
		model='%d', \
		plate='%s', \
		plate_time='%d', \
		ticket='%d', \
		mod0='%d', \
		mod1='%d', \
		mod2='%d', \
		mod3='%d', \
		mod4='%d', \
		mod5='%d', \
		mod6='%d', \
		mod7='%d', \
		mod8='%d', \
		mod9='%d', \
		mod10='%d', \
		mod11='%d', \
		mod12='%d', \
		mod13='%d', \
		mod14='%d', \
		mod15='%d', \
		mod16='%d', \
		lumber='%d', \
		metal='%d', \
		coal='%d', \
		product='%d', \
		box='%d', \
		rental='%d', \
		toyid0='%d', \
		toyid1='%d', \
		toyid2='%d', \
		toyid3='%d', \
		toyid4='%d', \
		toyposx0='%f', \
		toyposx1='%f', \
		toyposx2='%f', \
		toyposx3='%f', \
		toyposx4='%f', \
		toyposy0='%f', \
		toyposy1='%f', \
		toyposy2='%f', \
		toyposy3='%f', \
		toyposy4='%f', \
		toyposz0='%f', \
		toyposz1='%f', \
		toyposz2='%f', \
		toyposz3='%f', \
		toyposz4='%f', \
		toyrotx0='%f', \
		toyrotx1='%f', \
		toyrotx2='%f', \
		toyrotx3='%f', \
		toyrotx4='%f', \
		toyroty0='%f', \
		toyroty1='%f', \
		toyroty2='%f', \
		toyroty3='%f', \
		toyroty4='%f', \
		toyrotz0='%f', \
		toyrotz1='%f', \
		toyrotz2='%f', \
		toyrotz3='%f', \
		toyrotz4='%f', \
		cCrateFish='%d', \
		cCrateCompo='%d', \
		cCrateMats='%d', \
		cCrateFood='%d', \
		vInGarage='%d', \
		vHandbrake='%d', \
		spawn='%d' WHERE id='%d'",

		pvData[vehicleid][cLocked],
		pvData[vehicleid][cTrunk],
		pvData[vehicleid][cInsu],
		pvData[vehicleid][cImpounded],
		pvData[vehicleid][cImpoundPrice],
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

		//
		pvData[vehicleid][cDamage0],
		pvData[vehicleid][cDamage1],
		pvData[vehicleid][cDamage2],
		pvData[vehicleid][cDamage3],

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
		pvData[vehicleid][cLumber],
		pvData[vehicleid][cMetal],
		pvData[vehicleid][cCoal],
		pvData[vehicleid][cProduct],
		pvData[vehicleid][cBox],
		pvData[vehicleid][cRent],
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
		pvData[vehicleid][cCrateFish],
		pvData[vehicleid][cCrateCompo],
		pvData[vehicleid][cCrateMats],
		pvData[vehicleid][cCrateFood],
		pvData[vehicleid][vInGarage],
		pvData[vehicleid][vHandbrake],
		pvData[vehicleid][cSpawn],
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
				if(pvData[ii][cTicket] >= 100)
					return Error(playerid, "Kendaraan ini sudah ditilang oleh Polisi! /mv - untuk memeriksa");

				if (pvData[ii][vHandbrake])
				{
					pvData[ii][vHandbrake] = false;
					pvData[ii][vVehicleUpdate] = false;

					SendClientMessage(playerid, ARWIN, "VEHICLE: "WHITE_E"Handbrake "RED_E"OFF");
				}
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
			SuccesMsg(playerid, "Mesin Menyala");
			//InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~g~START", 1000, 3);
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berhasil menghidupkan kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));
		}
		if(rand == 1)
		{
			//Error(playerid, "Mesin kendaraan tidak dapat menyala, silahkan coba lagi!");
			SwitchVehicleEngine(vehicleid, true);
			SuccesMsg(playerid, "Mesin Menyala");
			//InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~r~CAN'T START", 1000, 3);
		}
		if(rand == 2)
		{
			SwitchVehicleEngine(vehicleid, true);
			SuccesMsg(playerid, "Mesin Menyala");
			//InfoTD_MSG(playerid, 4000, "Vehicle Engine ON");
			//GameTextForPlayer(playerid, "~w~ENGINE ~g~START", 1000, 3);
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berhasil menghidupkan kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));
		}
	}
	else
	{
		foreach(new ii : PVehicles)
		{
			if(vehicleid == pvData[ii][cVeh])
			{
				GetVehiclePos(vehicleid, pvData[ii][cPosX], pvData[ii][cPosY], pvData[ii][cPosZ]);
				GetVehicleZAngle(vehicleid, pvData[ii][cPosA]);
			}
		}

		//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mematikan mesin kendaraan %s.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
		SwitchVehicleEngine(vehicleid, false);
		//Info(playerid, "Engine turn off..");
		SuccesMsg(playerid, "Mesin Dimatikan");
		//InfoTD_MSG(playerid, 4000, "Vehicle Engine OFF");
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
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`impound`='%d', ", cQuery, pvData[i][cImpounded]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`impoundprice`='%d', ", cQuery, pvData[i][cImpoundPrice]);
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
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`box`=%d, ", cQuery, pvData[i][cBox]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`spawn`=%d, ", cQuery, pvData[i][cSpawn]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`rental`=%d, ", cQuery, pvData[i][cRent]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`locktire`=%d, ", cQuery, pvData[i][cLockTire]);
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`reason`='%e', ", cQuery, pvData[i][cReason]);


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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	pvData[i][cHealth] = 1000;
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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	OnPlayerVehicleRespawn(i);
	new line3[500];
	format(line3, sizeof(line3), "Selamat Anda Mendapatkan\n1.VIP Bronze 3 hari\n2. Uang $2500\n3. Kendaraan Sanchez\n4. Medicine 3\n5. Bandage 5\n6. Level +1\n6. Sprunk 10\n7. GPS\n11. Component 250\n12. Material 250\n13. Worm 20\n14. Health Insurance 20 Days");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, SBLUE_E "Fountain Daily:RP: " WHITE_E "Starterpack", line3, "OK", "");
	Servers(playerid, "Gunakan /gps untuk mengetahui lokasi");
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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = 0;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	pvData[i][cBox] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cSpawn] = 0;
	pvData[i][cLockTire] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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
	//pvData[i][cComponent] = 0;
	//pvData[i][cMoney] = 0;
	pvData[i][cRent] = rental;
	pvData[i][cLockTire] = 0;
	pvData[i][cSpawn] = 0;
	pvData[i][cImpounded] = 0;
	pvData[i][cImpoundPrice] = 0;
	format(pvData[i][cReason], 30, "NoHave");
	//tuning
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


CMD:aeject(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return Error(playerid, "Anda bukan Admin!");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new otherid;
		if(sscanf(params, "u", otherid))
			return SyntaxMsg(playerid, "/aeject [playerid id/name]");

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
			return SyntaxMsg(playerid, "/limitspeed [speed - 0 to disable]");

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
			return SyntaxMsg(playerid, "/vehinfo [playerid/PartOfName]");

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
			return SyntaxMsg(playerid, "/eject [playerid id/name]");

		if(IsPlayerInVehicle(otherid, vehicleid))
		{
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s telah menendang %s dari kendaraannya.", ReturnName(playerid), ReturnName(otherid));
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s telah menendang %s dari kendaraannya.", pData[playerid][pName], ReturnName(otherid));
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
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 201)
		return PermissionError(playerid);

	new model, color1, color2, otherid;
	if(sscanf(params, "uddd", otherid, model, color1, color2)) return SyntaxMsg(playerid, "/createpv [name/playerid] [model] [color1] [color2]");

	if(color1 < 0 || color1 > 255) { Error(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
	if(color2 < 0 || color2 > 255) { Error(playerid, "Color Number can't be below 0 or above 255 !"); return 1; }
	if(model < 400 || model > 611) { Error(playerid, "Vehicle Number can't be below 400 or above 611 !"); return 1; }
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Invalid player ID!");
	new maxAllowed = 3; 

	if(pData[playerid][pVip] == 1)
		maxAllowed = 4;
	else if(pData[playerid][pVip] == 2)
		maxAllowed = 5; 
	else if(pData[playerid][pVip] == 3)
		maxAllowed = 6; 
	else if(pData[playerid][pVip] == 4)
		maxAllowed = 10; 
	new count = CountPlayerVehicles(otherid);
	if(count >= maxAllowed)
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
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new vehid;
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/deletepv [vehid] | /apv - for find vehid");
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
	if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/gotopv [name/playerid]");
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
	if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/gotopv [name/playerid]");
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
	if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/getpv [name/playerid]");
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
		if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/ainsu [name/playerid]");
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
		if(sscanf(params, "u", otherid)) return SyntaxMsg(playerid, "/apv [name/playerid]");
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
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cID], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]), ReturnTimelapse(gettime(), pvData[i][cRent]));
							found = true;
						}
						else
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(%s)\tOwned\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cID], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
							found = true;
						}
					}
					else
					{
						if(pvData[i][cRent] != 0)
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(None)\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cID], pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cRent]));
							found = true;
						}
						else
						{
							format(msg2, sizeof(msg2), "%s%d\t%s(id: %d)\t%s(None)\tOwned\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cID], pvData[i][cPlate]);
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
	if(sscanf(params, "ud", otherid, vehid)) return SyntaxMsg(playerid, "/sendveh [playerid/name] [vehid] | /apv - for find vehid");
	
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
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/getveh [vehid] | /apv - for find vehid");
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
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/gotoveh [vehid] | /apv - for find vehid");
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
	if(sscanf(params, "d", vehid)) return SyntaxMsg(playerid, "/respawnveh [vehid] | /apv - for find vehid");
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

CMD:mv(playerid, params[])
{
	if(!GetOwnedVeh(playerid)) return Error(playerid, "Anda Tidak Memiliki Kendaraan.");

	new limit;
	if(pData[playerid][pVip] == 0)
		limit = 3;
	else if(pData[playerid][pVip] == 1)
		limit = 4;
	else if(pData[playerid][pVip] == 2)
		limit = 5; 
	else if(pData[playerid][pVip] == 3)
		limit = 6; 
	else if(pData[playerid][pVip] == 4)
		limit = 10;

	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z);
	new vidstr[32];

	new vid, _tmpstring[128], count = GetOwnedVeh(playerid), CMDSString[1024], status[256], status1[30], header[64];
	CMDSString = "";
	strcat(CMDSString,"VID\tName\tStatus\tDistance\n",sizeof(CMDSString));
	Loop(itt, (count + 1), 1)
	{
		vid = ReturnPlayerVehID(playerid, itt);
		if(pvData[vid][cClaim] != 0)
		{
			status = "{D2D2AB}Insurance";
		}
		else if(pvData[vid][cSpawn] == 1)
		{
			status = "{DB881A}Despawned";
		}
		else if(pvData[vid][cLockTire] == 1)
		{
			status = "{00f629}Tirelocked";
		}
		else if(pvData[vid][vInGarage] != INVALID_GARAGE_ID)
		{
			format(status, sizeof status, "{FFFF00}In Garage (%s)", GarageInfo[pvData[vid][vInGarage]][gkName]);
		}
		else if(pvData[vid][cImpounded] != 0)
		{
			status = "{D2D2AB}Impound";
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
		format(vidstr, sizeof vidstr, "V%d", pvData[vid][cVeh]);
		if(itt == count)
		{
			format(_tmpstring, sizeof(_tmpstring), "{ffffff}%s\t%s%s{ffffff}\t%s\t{FFFF00}%.2f\n", IsValidVehicle(pvData[vid][cVeh]) ? vidstr : "-", GetVehicleModelName(pvData[vid][cModel]), status1, status, GetDistance2D(pvData[vid][cPosX], pvData[vid][cPosY], x, y));
		}
		else format(_tmpstring, sizeof(_tmpstring), "{ffffff}%s\t%s%s{ffffff}\t%s\t{FFFF00}%.2f\n", IsValidVehicle(pvData[vid][cVeh]) ? vidstr : "-", GetVehicleModelName(pvData[vid][cModel]), status1, status, GetDistance2D(pvData[vid][cPosX], pvData[vid][cPosY], x, y));
		strcat(CMDSString, _tmpstring);
	}

	format(header, sizeof header, "My Vehicles (%d/%d)", count, limit);

	ShowPlayerDialog(playerid, DIALOG_MYVEH, DIALOG_STYLE_TABLIST_HEADERS, header, CMDSString, "Select", "Cancel");
	return 1;
}

CMD:en(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	//new pvid;
	//pvid = Vehicle_Inside(playerid);

	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

		//if(pvData[carid][cLocked] = 1)
		//	return Error(playerid, "Kamu tidak memilik");
		
		if(GetEngineStatus(vehicleid))
		{
			EngineStatus(playerid, vehicleid);
		}
		else
		{
			SetPlayerChatBubble(playerid,"let's 'juice up the whip..",COLOR_PURPLE,30.0,10000);
			// SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s let's 'juice up the whip", pData[playerid][pName]);
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
				SuccesMsg(playerid, "Berhasil Menyalakan Lampu");
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s menyalakan lampunya", pData[playerid][pName]);
			}
			case true:
			{
				SwitchVehicleLight(vehicleid, false);
				SendClientMessage(playerid, COLOR_WHITE,"Berhasil Mematikan Lampu");
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s mematikan lampunya", pData[playerid][pName]);
			}
		}
	}
	else return Error(playerid, "Anda harus mengendarai kendaraan!");
	return 1;
}


CMD:hood(playerid, params[])
{
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
			SuccesMsg(playerid, "Berhasil Membuka Hood Kendaraan");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s membuka hoodnya", pData[playerid][pName]);
       		//InfoTD_MSG(playerid, 4000, "Vehicle Hood ~g~OPEN");
       	}
       	case true:
       	{
       		SwitchVehicleBonnet(vehicleid, false);
       		SendClientMessage(playerid, COLOR_WHITE,"Berhasil Menutup Kembali Hood");
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s menutup hoodnya", pData[playerid][pName]);
			//InfoTD_MSG(playerid, 4000, "Vehicle Hood ~r~CLOSED");
       	}
    }
	return 1;
}
CMD:trunk(playerid, params[])
{
	if(pData[playerid][pCuffed] == 1)
        return Error(playerid, "You can't do that in this time.");
    new vehicleid = Vehicle_Nearest(playerid, 3.5); 

    if (vehicleid != -1) 
    {

        if (Vehicle_IsOwner(playerid, vehicleid))
        {
            if (!GetTrunkStatus(pvData[vehicleid][cVeh]))
            {
                SwitchVehicleBoot(pvData[vehicleid][cVeh], true);
                new String[1280];
                format(String, sizeof(String), "~s~%s ~g~Trunk dibuka", GetVehicleName(pvData[vehicleid][cVeh]));
                GameTextForPlayer(playerid, String, 4000, 6);
                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s membuka trunk %s", pData[playerid][pName], GetVehicleName(pvData[vehicleid][cVeh]));
				new vehid = pvData[vehicleid][cVeh];
			
				//if(!IsABike(vehid)) return Error(playerid,"Ini bukan mobil kocak");
				
				if(IsAVehicleStorage(vehid))
				{
					if(pvData[vehid][LoadedStorage] == false)
					{
						Vehicle_OpenStorage(playerid, vehid);
					}
					else
					{
						new cQuery[600];

						mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `vstorage` WHERE `owner`='%d'", pvData[vehicleid][cID]);
						mysql_tquery(g_SQL, cQuery, "CheckVehicleStorageStatus", "iii", playerid, vehid, vehicleid);
						
					}
				}
            }
            else
            {
                SwitchVehicleBoot(pvData[vehicleid][cVeh], false); 
                new String[1280];
                format(String, sizeof(String), "~s~%s ~r~Trunk ditutup", GetVehicleName(pvData[vehicleid][cVeh]));
                GameTextForPlayer(playerid, String, 4000, 6);
                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s menutup trunk %s", pData[playerid][pName], GetVehicleName(pvData[vehicleid][cVeh]));
            }
        }
        else
        {
            ErrorMsg(playerid, "Kamu tidak memiliki kendaraan ini."); 
        }
    }
    else
    {
        ErrorMsg(playerid, "Kamu tidak berada di dekat kendaraan apapun yang ingin kamu akses."); 
    }
    
    return 1;
}

CMD:lock(playerid, params[])
{
    if(!GetOwnedVeh(playerid)) return Error(playerid, "Anda Tidak Memiliki Kendaraan.");

    new vid, _tmpstring[128], count = GetOwnedVeh(playerid), CMDSString[512], status[30];
    CMDSString = "";
    strcat(CMDSString, "Name\tPlate\tStatus\n", sizeof(CMDSString));

    Loop(itt, (count + 1), 1)
    {
        vid = ReturnPlayerVehID(playerid, itt);

        // Set status kunci kendaraan
        if(pvData[vid][cLocked])
        {
            status = "{FF0000}Locked"; 
        }
        else
        {
            status = "{00FF00}Unlocked"; 
        }

        format(_tmpstring, sizeof(_tmpstring), "{ffffff}%s\t%s\t%s\n", GetVehicleModelName(pvData[vid][cModel]), pvData[vid][cPlate], status);
        strcat(CMDSString, _tmpstring);
    }

    ShowPlayerDialog(playerid, DIALOG_LOCK, DIALOG_STYLE_TABLIST_HEADERS, "Lock/Unlock Vehicle", CMDSString, "Select", "Cancel");
    return 1;
}
CMD:nlock(playerid, params[])
{
    new vehicleid = Vehicle_Nearest(playerid, 4.5);

    if (vehicleid != -1)
    {
        if (Vehicle_IsOwner(playerid, vehicleid))
        {
            if (!pvData[vehicleid][cLocked])
            {
                pvData[vehicleid][cLocked] = 1;

                new String[1280];
                format(String, sizeof(String), "~s~%s ~r~Locked", GetVehicleName(pvData[vehicleid][cVeh]));
                GameTextForPlayer(playerid, String, 4000, 6);
                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                SwitchVehicleDoors(pvData[vehicleid][cVeh], true);
            }
            else
            {
                pvData[vehicleid][cLocked] = 0;

                new String[1280];
                format(String, sizeof(String), "~s~%s ~g~Unlocked", GetVehicleName(pvData[vehicleid][cVeh]));
                GameTextForPlayer(playerid, String, 4000, 6);
                PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                SwitchVehicleDoors(pvData[vehicleid][cVeh], false);
            }
        }
        else
        {
            ErrorMsg(playerid, "Kamu tidak memiliki kendaraan ini.");
        }
    }
    else
    {
        ErrorMsg(playerid, "Kamu tidak berada di dekat kendaraan apapun yang ingin kamu kunci.");
    }
    return 1;
}

// CMD:nlock(playerid, params[])
// {
//    	static
//    	carid = -1;
// 	new vehicleid = GetNearestVehicleToPlayer(playerid, 7.5, false);


//    	if((carid = Vehicle_Nearest(playerid)) != -1)
//    	{
//    		if(Vehicle_IsOwner(playerid, carid))
//    		{
// 			if(!pvData[carid][cLocked])
// 			{
// 				pvData[carid][cLocked] = 1;

//                 new String[1280];
//                 format(String, sizeof String, "~s~%s ~r~Locked", GetVehicleName(vehicleid));
//                 GameTextForPlayer(playerid, String, 4000, 6);
// 				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
// 				SwitchVehicleDoors(pvData[carid][cVeh], true);
// 			}
// 			else
// 			{
// 				pvData[carid][cLocked] = 0;
//                 new String[1280];
//                 format(String, sizeof String, "~s~%s ~g~Unlocked", GetVehicleName(vehicleid));
//                 GameTextForPlayer(playerid, String, 4000, 6);
// 				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
// 				SwitchVehicleDoors(pvData[carid][cVeh], false);
// 			}
//    		}
//    	}
//    	else ErrorMsg(playerid, "Kamu tidak berada didekat Kendaraan apapun yang ingin anda kunci.");
// 	return 1;
// }


CMD:givekey(playerid, params[])
{

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You must be inside your own vehicle!");

	new otherid, carid;
	if(sscanf(params, "u", otherid))
		return SyntaxMsg(playerid, "/givekey [playerid/name]");

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
						SuccesMsg(playerid, "Berhasil Menyalakan Neon Kendaraan");
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s menyalakan neonnya", pData[playerid][pName]);
						//InfoTD_MSG(playerid, 4000, "Vehicle Neon ~g~ON");
						pvData[carid][cTogNeon] = 1;
					}
					else
					{
						SetVehicleNeonLights(pvData[carid][cVeh], false, pvData[carid][cNeon], 0);
						//SuccesMsg(playerid, "Berhasil Mematikan Neon Kendaraan");
						pvData[carid][cTogNeon] = 0;
					}
				}
				else
				{
					SetVehicleNeonLights(pvData[carid][cVeh], false, pvData[carid][cNeon], 0);
					SuccesMsg(playerid, "Berhasil Mematikan Neon Kendaraan");
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, ""WHITE_E"ACTION: "PURPLE_E"%s mematikan neonnya", pData[playerid][pName]);
					//InfoTD_MSG(playerid, 4000, "Vehicle Neon ~r~OFF");
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

/* CMD:givepv(playerid, params[])
{
	new vehid, otherid;
	if(sscanf(params, "ud", otherid, vehid)) return SyntaxMsg(playerid, "/givepv [playerid/name] [vehid] | /v my(mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
	if(pData[otherid][pMaskOn] == 1) return Error(playerid, "Player lawan menggunakan mask, silahkan lepas mask terlebih dahulu.");
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
					new maxAllowed = 3;
					if(pData[otherid][pVip] == 1)
						maxAllowed = 4;
					else if(pData[otherid][pVip] == 2)
						maxAllowed = 5; 
					else if(pData[otherid][pVip] == 3)
						maxAllowed = 6; 
					else if(pData[otherid][pVip] == 4)
						maxAllowed = 10; 

					new ownedCount = CountPlayerVehicles(otherid);

					if(ownedCount >= maxAllowed)
					{
						Error(otherid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
						Error(playerid, "Slot kendaraan lawan anda sudah penuh, silahkan suruh jual beberapa kendaraannya terlebih dahulu!");
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
} */

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



CMD:checktrunk(playerid, params[])
{
    if (pData[playerid][pInjured] >= 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini saat yang tidak tepat!");
	if(IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You must exit from the vehicle.");

	new x = GetNearestVehicleToPlayer(playerid, 3.5, false);

	if(!GetTrunkStatus(x) && !IsABike(x)) return Error(playerid,"Buka bagasi(trunk) terlebih dahulu");

	if(Vehicle_NearestPD(playerid) != -1)
	{
		if(IsAVehicleStorage(x))
		{
			if(pData[playerid][pFaction] == 1)
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

					ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				}
			}
			else Error(playerid, "Kamu bukan anggota SAPD!");
		}
		else Error(playerid, "Kendaraan tidak mempunyai penyimpanan/ bagasi!");
	}
	else Error(playerid, "Kamu tidak berada didekat Kendaraan apapun.");
	return 1;
}

CMD:vstorage(playerid, params[])
{
	if(pData[playerid][pCuffed] == 1)
        return Error(playerid, "You can't do that in this time.");
    if (pData[playerid][pInjured] >= 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini saat yang tidak tepat!");
	if(IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You must exit from the vehicle.");

    new carid = Vehicle_Nearest(playerid, 3.5); 

    if (carid != -1) 
    {
        if (Vehicle_IsOwner(playerid, carid))
        {
			new vehid = pvData[carid][cVeh];
			
			if(!GetTrunkStatus(vehid) && !IsABike(vehid)) return Error(playerid,"Buka bagasi(trunk) terlebih dahulu");
			
			if(IsAVehicleStorage(vehid))
			{
				if(pvData[vehid][LoadedStorage] == false)
				{
					Vehicle_OpenStorage(playerid, vehid);
				}
				else
				{
					new cQuery[600];

					mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `vstorage` WHERE `owner`='%d'", pvData[carid][cID]);
					mysql_tquery(g_SQL, cQuery, "CheckVehicleStorageStatus", "iii", playerid, vehid, carid);
					
				}
			}
        }
        else
        {
            ErrorMsg(playerid, "Kamu tidak memiliki kendaraan ini."); 
        }
    }
    else
    {
        ErrorMsg(playerid, "Kamu tidak berada di dekat kendaraan apapun yang ingin kamu akses."); 
    }
    
    return 1;
}

CMD:vshop(playerid, params[])
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
CMD:unimpound(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1554.9960,-1670.1924,20061.9648) && !IsPlayerInRangeOfPoint(playerid, 3.0, 1126.1908,6.4489,883.6204))
	   return ErrorMsg(playerid, "You're not at LSPD Unimpound point!");

    ShowImpoundedVehicle(playerid);
    return 1;
}

CMD:impound(playerid, params[])
{
	new
		price;

    if (pData[playerid][pFaction] != 1)
		return ErrorMsg(playerid, "You must be a police officer.");

    if (sscanf(params, "d", price))
        return SendSyntaxMessage(playerid, "/impound [price]");

	if (price < 1 || price > 1000)
	    return ErrorMsg(playerid, "The price can't be above $1,000 or below $1.");

	if (!IsPlayerInRangeOfPoint(playerid, 7.0, 1585.3680,-1677.9712,5.8970))
		return ErrorMsg(playerid, "You are not in range of impound point.");

	if(IsPlayerInAnyVehicle(playerid))
		return ErrorMsg(playerid, "Anda harus berada diluar kendaraan!");

	new vehicleid = GetNearestVehicleToPlayer(playerid, 4.0, false);
	if(IsValidVehicle(vehicleid))
	{
		foreach(new vid : PVehicles)
		{
			if(vehicleid == pvData[vid][cVeh])
			{
				new xuery[128];
				pvData[vid][cImpounded] = 1;
				pvData[vid][cImpoundPrice] = price;

			    Vehicle_GetStatus(vid);

			    mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE ID = '%d'", pvData[vid][cID]);
				mysql_tquery(g_SQL, xuery);

				if(IsValidVehicle(pvData[vid][cVeh])) DestroyVehicle(pvData[vid][cVeh]);
				pvData[vid][cVeh] = INVALID_VEHICLE_ID;

				new ownerID = pvData[vid][cOwner];
				
				if(IsPlayerConnected(ownerID))
				{
					Info(ownerID, "Your vehicle %s was impounded by {ff0000}%s", GetVehicleModelName(pvData[vid][cModel]),  ReturnName(playerid));
				}
				SendFactionMessage(1, COLOR_RADIO, "DISPATCH: %s has impounded a %s for %s.", ReturnName(playerid), GetVehicleModelName(pvData[vid][cModel]), FormatMoney(price));
			 	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
			}
		}
	}
	else ErrorMsg(playerid, "Kamu tidak berada didekat Kendaraan");

	return 1;
}
/* CMD:unlocktire(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
		return ErrorMsg(playerid, "Anda harus berada diluar kendaraan!");

	if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
	if(pData[playerid][pFaction] != 1) return Error(playerid, "You don't have permission");

	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
	new Float:x, Float:y, Float:z;
	if(IsValidVehicle(vehicleid))
	{
		foreach(new vid : PVehicles)
		{
			if(vehicleid == pvData[vid][cVeh])
			{
				if(pvData[vid][cLockTire] == 0) 
					return Error(playerid, "This vehicle has no Tire lock status");
			}
		}
		Info(playerid, "You are locking the vehicle in front of you.");
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, true, 0, 0, 0, 0, 1);
		GetPlayerPos(playerid, Float:x, Float:y, Float:z);
		PlayerPlaySound(playerid, 25800, Float:x, Float:y, Float:z);
		pData[playerid][pActivityStatus] = 1;
		pData[playerid][pActivity] = SetTimerEx("unlctire", 1000, true, "id", playerid, vehicleid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Locking...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		return 1;
	}
	else ErrorMsg(playerid, "Kamu tidak berada didekat Kendaraan");

	return 1;
}

function unlctire(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pActivityStatus] != 1) return 0;
	new Float:x, Float:y, Float:z;
	if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
    {
		if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
		{
			foreach(new vid : PVehicles)
			{
				if(vehicleid == pvData[vid][cVeh])
				{
					InfoTD_MSG(playerid, 8000, "Unlocking done!");
					GetPlayerPos(playerid, Float:x, Float:y, Float:z);
					PlayerPlaySound(playerid, 24600, Float:x, Float:y, Float:z);
					pvData[vid][cLockTire] = 0;
					TogglePlayerControllable(playerid, 1);
					KillTimer(pData[playerid][pActivity]);
					pData[playerid][pActivityStatus] = 0;
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
		else
		{
			Error(playerid, "Unlocking Fail! Kamu tidak berada didekat kendaraan apapun");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityStatus] = 0;
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
	}
	else
	{
		Error(playerid, "Unlocking Fail! Kamu tidak berada didekat kendaraan apapun");
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pActivityStatus] = 0;
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		return 1;
	}
	return 1;
} */

CMD:unlocktire(playerid, params[])
{
	if  (!IsPlayerInRangeOfPoint(playerid, 3.0, 1554.5439,-1670.4426,20061.9648))
		return Error(playerid, "You are not at police station.");

	if(!GetOwnedVeh(playerid)) 
		return Error(playerid, "Kamu tidak memiliki kendaraan.");

	new String[512];
	format(String, sizeof String, "{FFFFFF}Please select the vehicle to unlock:\n");

	new bool: found = false;

	foreach(new vid : PVehicles)
	{
		if(pvData[vid][cOwner] == pData[playerid][pID] && pvData[vid][cLockTire] == 1)
		{
			found = true;
			format(String, sizeof(String), "%s%s\n", String, GetVehicleModelName(pvData[vid][cModel]));
		}
	}

	if (!found)
		return Error(playerid, "Kamu tidak memiliki kendaraan yang sedang di kunci roda.");

	ShowPlayerDialog(playerid, DIALOG_UNLCKTIRE, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Unlock Vehicle Tire", String, "Select", "Cancel");

	return 1;
}

CMD:locktire(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
			return ErrorMsg(playerid, "Anda harus berada diluar kendaraan!");

	if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
	if(pData[playerid][pFaction] != 1) return Error(playerid, "You don't have permission");

	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
	new Float:x, Float:y, Float:z;
	if(IsValidVehicle(vehicleid))
	{
		foreach(new vid : PVehicles)
		{
			if(vehicleid == pvData[vid][cVeh])
			{
				if(pvData[vid][cLockTire] == 1) 
					return Error(playerid, "This vehicle tire is already locked!");
			}
		}
		Info(playerid, "You are locking the vehicle in front of you.");
		GetPlayerPos(playerid, Float:x, Float:y, Float:z);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, true, 0, 0, 0, 0, 1);
		pData[playerid][pActivityStatus] = 1;
		pData[playerid][pActivity] = SetTimerEx("trlock", 1000, true, "id", playerid, vehicleid);
		PlayerPlaySound(playerid, 25800, Float:x, Float:y, Float:z);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Locking...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		return 1;
	}
	else ErrorMsg(playerid, "Kamu tidak berada didekat Kendaraan");

	return 1;
}

function trlock(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pActivityStatus] != 1) return 0;
	new Float:x, Float:y, Float:z;
	if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
    {
		if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
		{
			foreach(new vid : PVehicles)
			{
				if(vehicleid == pvData[vid][cVeh])
				{
					InfoTD_MSG(playerid, 8000, "Locking done!");
					GetPlayerPos(playerid, Float:x, Float:y, Float:z);
					PlayerPlaySound(playerid, 24600, Float:x, Float:y, Float:z);
					pvData[vid][cLockTire] = 1;
					new ownerID = pvData[vid][cOwner];
					
					if(IsPlayerConnected(ownerID))
					{
						Info(ownerID, "Your vehicle %s was locktire by {ff0000}%s", GetVehicleModelName(pvData[vid][cModel]),  ReturnName(playerid));
					}
					TogglePlayerControllable(playerid, 1);
					KillTimer(pData[playerid][pActivity]);
					pData[playerid][pActivityStatus] = 0;
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
		else
		{
			Error(playerid, "Locking Fail! Kamu tidak berada didekat kendaraan apapun");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityStatus] = 0;
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
	}
	else
	{
		Error(playerid, "Locking Fail! Kamu tidak berada didekat kendaraan apapun");
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pActivityStatus] = 0;
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		return 1;
	}
	return 1;
}

/* CMD:tradepv(playerid, params[])
{
    new vehid, vehid2;

    if (sscanf(params, "dd", vehid, vehid2))
        return SyntaxMsg(playerid, "/tradepv [your vehicleid] [other vehicleid]");

    if (!IsValidVehicle(vehid))
        return Error(playerid, "Invalid your vehicle ID.");
    
    if (!IsValidVehicle(vehid2))
        return Error(playerid, "Invalid other vehicle ID.");

    new index = GetVehicleIndex(playerid, vehid);
    if (index == -1)
        return Error(playerid, "You do not own this vehicle.");

    if (!IsPlayerNearVehicle(playerid, index))
        return Error(playerid, "You are too far away from your vehicle.");
    
    if (HasVehicleStorage(vehid))
        return Error(playerid, "Pickup the items in your vehicle storage first.");

    new Target = GetVehicleOwner2(vehid2);
    if (Target == INVALID_PLAYER_ID)
        return Error(playerid, "The other vehicle does not belong to any player.");

    if (Target == playerid)
        return Error(playerid, "You cannot trade with your own vehicle.");

	if (!NearPlayer(playerid, Target, 5.0))
		return Error(playerid, "That player is not near you.");

	new targetIndex = GetVehicleIndex(Target, vehid2);

    if (HasVehicleStorage(vehid2))
        return Error(playerid, "That player vehicle storage should be empty.");

    StartTradePV(playerid, Target, index, targetIndex);

    return 1;
}

IsPlayerNearVehicle(playerid, vehicleIndex)
{
    return Vehicle_Nearest(playerid) == vehicleIndex;
}

GetVehicleOwner2(targetVehicleId)
{
    foreach (new pid : Player)
    {
        foreach (new i : PVehicles)
        {
            if (targetVehicleId == pvData[i][cVeh] && Vehicle_IsOwner(pid, i))
            {
                return pid;
            }
        }
    }
    return INVALID_PLAYER_ID;
}

StartTradePV(playerid, targetid, index, targetindex)
{
	SetPVarInt(targetid, "OfferedTradePV", 1);
	SetPVarInt(targetid, "TradePVWith", playerid);

	SetPVarInt(playerid, "TradePVIndex", index);
	SetPVarInt(targetid, "TradePVIndex", targetindex);

	new String[144];
	format(String, sizeof String, "* Kamu telah menawarkan trade untuk %s milik %s dengan %s milikmu.", GetVehicleName(pvData[targetindex][cVeh]), GetPlayerNameEx(targetid), GetVehicleName(pvData[index][cVeh]));
    SCM(playerid, COLOR_YELLOW, String);
	format(String, sizeof String, "* %s menawarkan trade untuk %s milikmu dengan %s miliknya.", GetPlayerNameEx(playerid), GetVehicleName(pvData[targetindex][cVeh]), GetVehicleName(pvData[index][cVeh]));
    SCM(targetid, COLOR_YELLOW, String);
	SCM(targetid, COLOR_YELLOW, "* Ketik '/accept tradepv' untuk menerima tawaran.");
} */

CMD:handbrake(playerid, params[])
{
	if (!IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "Kamu tidak berada di dalam kendaraan.");

	new vehicleid = Vehicle_Nearest(playerid, 4.5);

    if (vehicleid != -1)
    {
		new String[144];
        if (Vehicle_IsOwner(playerid, vehicleid))
        {
            if (!pvData[vehicleid][vHandbrake])
            {
				if (GetEngineStatus(pvData[vehicleid][cVeh]))
					return Error(playerid, "Kamu harus mematikan mesin terlebih dahulu sebelum menyalakan handbrake.");

				if (IsABike(pvData[vehicleid][cModel]))
					return Error(playerid, "Kendaraan ini tidak dapat menggunakan rem tangan.");

                pvData[vehicleid][vHandbrake] = true;
				pvData[vehicleid][vVehicleUpdate] = false;

				format(String, sizeof(String), "VEHICLE: "WHITE_E"Handbrake "LG_E"ON");
				SendClientMessage(playerid, ARWIN, String);
            }
            else
            {
                pvData[vehicleid][vHandbrake] = false;
				pvData[vehicleid][vVehicleUpdate] = false;

				format(String, sizeof(String), "VEHICLE: "WHITE_E"Handbrake "RED_E"OFF");
				SendClientMessage(playerid, ARWIN, String);
            }
        }
        else
        {
            ErrorMsg(playerid, "Kamu bukan pemilik kendaraan ini.");
        }
    }
    else
    {
        ErrorMsg(playerid, "Kamu tidak berada di dekat kendaraan apapun yang ingin kamu kunci.");
    }
	return 1;
}

task UnoccupieedVehicleUpdate[6000]() {
    foreach (new ii : PVehicles) {
        if (!IsValidVehicle(pvData[ii][cVeh])) {
            continue;
        }

        if (pvData[ii][vHandbrake] && pvData[ii][vVehicleUpdate]) {
            pvData[ii][vVehicleUpdate] = false;

            foreach (new i : Player) {
                if (GetPlayerVehicleID(i) != pvData[ii][cVeh]) {
                    SetVehiclePos(pvData[ii][cVeh], pvData[ii][cPosX], pvData[ii][cPosY], pvData[ii][cPosZ]);
                    SetVehicleZAngle(pvData[ii][cVeh], pvData[ii][cPosA]);
                    break; 
                }
            }
        }
    }
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	foreach(new ii : PVehicles)
	{
		if (pvData[ii][cVeh] == vehicleid)
		{
			if (pvData[ii][vHandbrake] && !pvData[ii][vVehicleUpdate])
			{
				pvData[ii][vVehicleUpdate] = true;
				break;
			}
		}
	}

	return 1;
}
