#define MAX_ROADBLOCKSTRIPS 200
enum rInfo
{
	rCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    rObject,
};
new RoadBlockInfo[MAX_ROADBLOCKSTRIPS][rInfo];

GetXYZBehindPoint (Float:x,Float:y,&Float:x2,&Float:y2,Float:angle,Float:distance)
{
    x2 = x - (distance * floatsin(-angle,degrees));
	y2 = y - (distance * floatcos(-angle,degrees));
	return 1;
}

/*encode_tires(tires1, tires2, tires3, tires4) {

	return tires1 | (tires2 << 1) | (tires3 << 2) | (tires4 << 3);

}*/

CreateRoadBlock(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(RoadBlockInfo); i++)
  	{
  	    if(RoadBlockInfo[i][rCreated] == 0)
  	    {
            RoadBlockInfo[i][rCreated]=1;
            RoadBlockInfo[i][sX]=x;
            RoadBlockInfo[i][sY]=y;
            RoadBlockInfo[i][sZ]=z;
            RoadBlockInfo[i][rObject] = CreateDynamicObject(981, x+3.0, y+3.0, z, 0, 0, Angle);
			
	        return 1;
  	    }
  	}
  	return 0;
}


DeleteAllRoadBlock()
{
    for(new i = 0; i < sizeof(RoadBlockInfo); i++)
  	{
  	    if(RoadBlockInfo[i][rCreated] == 1)
  	    {
  	        RoadBlockInfo[i][rCreated]=0;
            RoadBlockInfo[i][sX]=0.0;
            RoadBlockInfo[i][sY]=0.0;
            RoadBlockInfo[i][sZ]=0.0;
            DestroyDynamicObject(RoadBlockInfo[i][rObject]);
  	    }
	}
    return 1;
}

DeleteClosestRoadBlock(playerid)
{
	new done;
    for(new i = 0; i < sizeof(RoadBlockInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 10.0, RoadBlockInfo[i][sX], RoadBlockInfo[i][sY], RoadBlockInfo[i][sZ]))
        {
  	        if(RoadBlockInfo[i][rCreated] == 1)
            {
                RoadBlockInfo[i][rCreated]=0;
                RoadBlockInfo[i][sX]=0.0;
                RoadBlockInfo[i][sY]=0.0;
                RoadBlockInfo[i][sZ]=0.0;
                DestroyDynamicObject(RoadBlockInfo[i][rObject]);
 				done = 1;
				Info(playerid, "Kamu berhasil menghapus 1 road block!");
  	        }
  	    }
  	}
  	if(!done) Error(playerid, "Kamu tidak berada di sekitar road block.");
    return 1;
}


function destroyThirObject(objid) 
{
	DestroyDynamicObject(objid);
}

/*CheckPlayerInRoadBlock(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		for(new i = 0; i < sizeof(RoadBlockInfo); i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, RoadBlockInfo[i][sX], RoadBlockInfo[i][sY], RoadBlockInfo[i][sZ]))
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(RoadBlockInfo[i][rCreated] == 1)
					{
						new panels, doors, lights, tires;
						new carid = GetPlayerVehicleID(playerid);
						GetVehicleDamageStatus(carid, panels, doors, lights, tires);
						tires = encode_tires(1, 1, 1, 1);
						UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
					}
				}
			}
	  	}
	}
}*/

CMD:roadblock(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
		if(pData[playerid][pFaction] != 1)
			return Error(playerid, "Kamu bukan Anggota SAPD.");
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Error(playerid, "Kamu harus berada di dalam kendaraan.");
	new Float:X, Float:Y, Float:Z, Float:A, Float:Ang;

    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, A);

    new currentveh = GetPlayerVehicleID(playerid);
	new Float:vehx, Float:vehy, Float:vehz, Float:angle, Float:x2, Float:y2;

	GetVehiclePos(currentveh, vehx, vehy, vehz);
	GetVehicleDistanceFromPoint(currentveh, vehx, vehy, vehz);
	GetVehicleZAngle(currentveh, angle);
	GetVehicleZAngle(currentveh, Ang);
	GetXYZBehindPoint(vehx, vehy, x2, y2, angle, 5);

    CreateRoadBlock(x2,y2,vehz+0.3,Ang);

    Info(playerid, "Kamu berhasil menaruh road block!");
	return 1;
}

CMD:destroyroadblock(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
		if(pData[playerid][pFaction] != 1)
			return Error(playerid, "Kamu Bukan police Officer.");
		
	DeleteClosestRoadBlock(playerid);
	return 1;
}

CMD:destroyallroadblock(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
		if(pData[playerid][pFaction] != 1)
			return Error(playerid, "kamu Bukan police officer.");
		
	DeleteAllRoadBlock();
	Info(playerid, "Kamu Berhasil Menghapus Semua Road Block");
	return 1;
}