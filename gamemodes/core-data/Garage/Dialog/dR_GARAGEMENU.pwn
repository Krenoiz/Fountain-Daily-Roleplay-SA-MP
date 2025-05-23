dR_GARAGEMENU(playerid, response, listitem)
{
    new Garage = SelectGarage[playerid];
    if (response) {
        new count = 0;

        foreach(new i : PVehicles)
        {
            if (IsPlayerVehicleAtGarage(playerid, i, Garage))
            {
                if (count == listitem)
                {
                    if (GarageInfo[Garage][gkOutX] == 0.0)
                    {
                        Error(playerid, "This parking lot is not ready to use, please contact an Administrator.");
                        return;
                    }

                    new vehicleid = RetrieveVehicleFromGarage(i, Garage);

                    if (!IsValidVehicle(vehicleid))
                    {
                        SetVehicleVirtualWorld(pvData[vehicleid][cVeh], 0);
                        OnLoadVehicleStorage(vehicleid);
	                    MySQL_LoadVehicleStorage(vehicleid);
                        Vehicle_Save(vehicleid);
    
                        //PutPlayerInVehicle(playerid, vehicleid, 0);
                    }
                    break;
                }
                else count++;
            }
        }
    }
}