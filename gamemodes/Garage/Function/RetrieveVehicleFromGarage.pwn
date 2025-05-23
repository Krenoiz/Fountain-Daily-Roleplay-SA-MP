RetrieveVehicleFromGarage(Index, Garage)
{
    //if (!IsValidVehicle(pvData[Index][cVeh]))
        //return 0;
    
    pvData[Index][vInGarage] = INVALID_GARAGE_ID;

    pvData[Index][cPosX] = GarageInfo[Garage][gkOutX];
    pvData[Index][cPosY] = GarageInfo[Garage][gkOutY];
    pvData[Index][cPosZ] = GarageInfo[Garage][gkOutZ];
    pvData[Index][cPosA] = GarageInfo[Garage][gkOutA];

    pvData[Index][cVw] = GarageInfo[Garage][gkVW];
    pvData[Index][cInt] = GarageInfo[Garage][gkInt];
    
    new vehicleid = OnPlayerVehicleRespawn(Index);
    SetVehicleVirtualWorld(pvData[Index][cVeh], 0); 
    
    OnLoadVehicleStorage(Index);
	MySQL_LoadVehicleStorage(Index);

    Vehicle_Save(Index);

    return vehicleid;
}