dR_DIALOG_TRADEVEH2(playerid, response, listitem)
{
    if (response)
    {
        new Target = GetPVarInt(playerid, "TradePVWith");

        if (pData[Target][IsLoggedIn] == false)
            return Error(playerid, "The player who is offering you a trade has disconnected.");

        new index = GetPVarInt(Target, "TradePVIndex");

        new count = 0;
        foreach(new vid : PVehicles)
        {
            if(pvData[vid][cOwner] == pData[playerid][pID])
            {
                if (count == listitem)
                {
                    if (HasVehicleStorage(pvData[vid][cVeh]))
                        return Error(playerid, "Pickup the items in your vehicle storage first.");

                    if (Vehicle_Nearest(Target) != index)
                        return Error(playerid, "Kendaraan yang ditawarkan tidak berada di sekitar pemiliknya.");

                    if (Vehicle_Nearest(playerid) != vid)
                        return Error(playerid, "Kendaraan yang ditawarkan tidak berada di sekitarmu.");

                    pvData[index][cOwner] = pData[playerid][pID];
                    pvData[vid][cOwner] = pData[Target][pID];

                    new query[128];
                    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[playerid][pID], pvData[index][cID]);
                    mysql_tquery(g_SQL, query);

                    mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[Target][pID], pvData[vid][cID]);
                    mysql_tquery(g_SQL, query);

                    new str[150];
                    format(str,sizeof(str),"[VEH]: %s bertukar kendaraan model %s(%d) dengan %s(%d) milik %s!", GetRPName(playerid), GetVehicleName(pvData[vid][cVeh]), GetVehicleModel(pvData[vid][cVeh]), GetVehicleName(pvData[index][cVeh]), GetVehicleModel(pvData[index][cVeh]), GetRPName(Target));
                    LogServer("Property", str);

                    format(str, sizeof str, "* Kamu telah menukarkan kendaraan %s milikmu dengan %s milik %s", GetVehicleName(pvData[vid][cVeh]), GetVehicleName(pvData[index][cVeh]), GetRPName(Target));
                    SCM(playerid, COLOR_YELLOW, str);
                    format(str, sizeof str, "* Kamu telah menukarkan kendaraan %s milikmu dengan %s milik %s", GetVehicleName(pvData[index][cVeh]), GetVehicleName(pvData[vid][cVeh]), GetRPName(playerid));
                    SCM(Target, COLOR_YELLOW, str);
                    break;
                }
                else count++;
            }
        }
    }

    return 1;
}