dR_DIALOG_SELLVEH(playerid, response, const inputtext[])
{
    if (response)
    {
        new vid = GetPVarInt(playerid, "ClickedVeh");
        new target_id;
        if(sscanf(inputtext, "u", target_id) || !IsPlayerConnected(target_id)) {
            ShowSellVehicleMenu(playerid, .extra = "{FFFF00}Invalid specified player.");
            return 0;
        }

        if(target_id == playerid) {
            ShowSellVehicleMenu(playerid, .extra = "{FFFF00}You cannot sell to yourself.");
            return 0;
        }

        if (Vehicle_Nearest(playerid) != vid) {
            ShowSellVehiclePriceMenu(playerid, .extra = "{FFFF00}You are too far away from the selected vehicle.");
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

        if(NearPlayer(playerid, target_id, 5.0)) {
            SetPVarInt(target_id, "OfferedSellPV", 1);
            SetPVarInt(target_id, "SellPVWith", playerid);

            SetPVarInt(playerid, "SellPVIndex", vid);
            ShowSellVehiclePriceMenu(playerid);
        }
        else ShowSellVehicleMenu(playerid, .extra = "{FFFF00}You are too far away from that player.");
    }

    return 1;
}