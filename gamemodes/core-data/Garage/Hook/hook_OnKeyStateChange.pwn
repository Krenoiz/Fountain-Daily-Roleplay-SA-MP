/**
 * OnPlayerKeyStateChange
 */

#include <YSI_Coding\y_hooks>

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (PRESSED(KEY_YES))
    {
        new Garage = GetNearbyGarage(playerid);

        if (Garage != INVALID_GARAGE_ID)
        {
            SelectGarage[playerid] = Garage;
            ShowGarageVehicles(playerid, Garage);
        }
    }

    if (PRESSED(KEY_CROUCH))
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            new Index = GetVehicleIndex(playerid, GetPlayerVehicleID(playerid));

            new Garage = GetNearbyGarage(playerid);

            if (Garage != INVALID_GARAGE_ID)
            {
                if (Index != -1)
                {
                    if (pvData[Index][cRent] != 0)
                        return Error(playerid, "You cannot store this rent vehicle into garage.");
                    
                    pvData[Index][vInGarage] = Garage;

                    Vehicle_Save(Index);

                    // Destroy vehicle
                    //DestroyVehicle(pvData[Index][cVeh]);
                    SetVehicleVirtualWorld(pvData[Index][cVeh], random(99999) + 1);
                    //pvData[Index][cVeh] = INVALID_VEHICLE_ID;
                }
                else Error(playerid, "You cannot store this vehicle into garage.");
            }
        } 
    }

    return 1;
}