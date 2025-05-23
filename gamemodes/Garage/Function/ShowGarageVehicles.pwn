ShowGarageVehicles(playerid, Garage)
{
    new String[512], count = 0;

    format(String, sizeof String, "{FFFFFF}Please select the vehicle to load:\n");
    foreach(new i : PVehicles)
    {
        if (IsPlayerVehicleAtGarage(playerid, i, Garage))
        {
            count++;
            format(String, sizeof String, "%s%s\n", String, g_arrVehicleNames[pvData[i][cModel]-400]);
        }
    }

    if (count == 0) return Error(playerid, "You don't have any vehicles on this garage.");

    new header[64];
    format(header, sizeof header, "{FFFFFF}%s", GarageInfo[Garage][gkName]);

    ShowPlayerDialog(playerid, DIALOG_GARAGEMENU, DIALOG_STYLE_TABLIST_HEADERS, header, String, "Load", "Close");

    return 1;
}