dR_DIALOG_GIVEVEH(playerid, response, const inputtext[])
{
    if (response)
    {
        new vid = GetPVarInt(playerid, "ClickedVeh");
        new target_id;
        if(sscanf(inputtext, "u", target_id) || !IsPlayerConnected(target_id)) {
            ShowGiveVehicleMenu(playerid, .extra = "{FFFF00}Invalid specified player.");
            return 0;
        }

        if(target_id == playerid) {
            ShowGiveVehicleMenu(playerid, .extra = "{FFFF00}You cannot give to yourself.");
            return 0;
        }

        if (Vehicle_Nearest(playerid) != vid) {
            ShowGiveVehicleMenu(playerid, .extra = "{FFFF00}You are too far away from the selected vehicle.");
            return 0;
        }

        new maxAllowed = 3;
        if(pData[target_id][pVip] == 1)
            maxAllowed = 4;
        else if(pData[target_id][pVip] == 2)
            maxAllowed = 5; 
        else if(pData[target_id][pVip] == 3)
            maxAllowed = 6; 
        else if(pData[target_id][pVip] == 4)
            maxAllowed = 10; 

        new ownedCount = CountPlayerVehicles(target_id);

        if(ownedCount >= maxAllowed)
        {
            Error(target_id, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
            Error(playerid, "Slot kendaraan lawan anda sudah penuh, silahkan suruh jual beberapa kendaraannya terlebih dahulu!");
            return 1;
        }

        new vehid = pvData[vid][cVeh];

        if(NearPlayer(playerid, target_id, 5.0)) {
            Info(playerid, "Anda memberikan kendaraan %s(%d) anda kepada %s.", GetVehicleName(vehid), GetVehicleModel(vehid), ReturnName(target_id));
            Info(target_id, "%s telah memberikan kendaraan %s(%d) kepada anda.(/mv)", ReturnName(playerid), GetVehicleName(vehid), GetVehicleModel(vehid));
            new str[150];
            format(str,sizeof(str),"[VEH]: %s memberikan kendaraan model %s(%d) ke %s!", GetRPName(playerid), GetVehicleName(vehid), GetVehicleModel(vehid), GetRPName(target_id));
            LogServer("Property", str);
            pvData[vid][cOwner] = pData[target_id][pID];
            new query[128];
            mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET owner='%d' WHERE id='%d'", pData[target_id][pID], pvData[vid][cID]);
            mysql_tquery(g_SQL, query);
        }
        else ShowGiveVehicleMenu(playerid, .extra = "{FFFF00}You are too far away from that player.");
    }

    return 1;
}