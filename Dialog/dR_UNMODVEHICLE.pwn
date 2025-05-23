dR_UNMODVEHICLE(playerid, response, listitem)
{
    if (response)
    {
        new String[1024];
        new vehicleid = GetPVarInt(playerid, "Managed");
        new v_id = pvData[vehicleid][cVeh];
        new k = listitem;
        if(0 <= k < 17)
        {
            format(String, sizeof(String), "partList%i", k);
            new partID = GetPVarInt(playerid, String);
            if(partID == 999)
            {
                for(new m = 0 ; m < 17; m++)
                {
                    RemoveVehicleComponent(v_id, GetVehicleComponentInSlot(v_id, m));
                    pvData[vehicleid][cMod][m] = 0;
                }
                SCM(playerid, ARWIN, "VEHICLE:"WHITE_E" All modifications has been removed from vehicle");
                return 1;
            }
            RemoveVehicleComponent(v_id, partID);
            pvData[vehicleid][cMod][GetVehicleComponentType(partID)] = 0;
            SCM(playerid, ARWIN, "VEHICLE:"WHITE_E" The selected modification has been removed");
        }
    }

    return 1;
}