CMD:unmodveh(playerid, const params[])
{
    new count = 0;
    new modList[512], string[128];

    new vehicleid = Vehicle_Nearest(playerid, 4.5);

    if (vehicleid != -1)
    {
        if (Vehicle_IsOwner(playerid, vehicleid))
        {
            SetPVarInt(playerid, "Managed", vehicleid);
            for(new f = 0 ; f < 17; f++)
            {
                if(GetVehicleComponentInSlot(pvData[vehicleid][cVeh], f) != 0)
                {
                    if (f != 9 && f != 7 && f != 8)
                    {
                        format(modList, sizeof(modList), "%s\n%s - %s", modList, partType(f), partName(GetVehicleComponentInSlot(pvData[vehicleid][cVeh], f)));
                    }
                    else
                    {
                        format(modList, sizeof(modList), "%s\n%s", modList, partType(f));
                    }
                    format(string, sizeof(string), "partList%d", count);
                    SetPVarInt(playerid, string, GetVehicleComponentInSlot(pvData[vehicleid][cVeh], f));
                    count++;
                }
            }
            if (count == 0)
            {
                SendErrorMessage(playerid, "This vehicle does not have any modifications.");
                return 1;
            }
            format(modList, sizeof(modList), "%s\nAll", modList);
            format(string, sizeof(string), "partList%d", count);
            SetPVarInt(playerid, string, 999);
            count++;
            SetPVarInt(playerid, "modCount", count);
            ShowPlayerDialog(playerid, UNMODVEHICLE, DIALOG_STYLE_LIST, ""WHITE_E"Unmodification Parts", modList, "Select", "Cancel");
        }
        else SendErrorMessage(playerid, "Kamu bukan pemilik dari kendaraan ini.");
    }
    else SendErrorMessage(playerid, "Kamu tidak berada di dekat kendaraan apapun.");

	return 1;
}