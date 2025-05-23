dR_DIALOG_SELLVEHPRICE(playerid, response, const inputtext[])
{
    if (response)
    {
        new vid = GetPVarInt(playerid, "ClickedVeh");
        new target_id = GetPVarInt(playerid, "OfferedSellPV");

        if (isnull(inputtext)) {
            ShowSellVehiclePriceMenu(playerid);
            return 0;
        }

        new price = strval(inputtext);

        if (!(1000 <= price <= 100000)) {
            ShowSellVehiclePriceMenu(playerid, .extra = "{FFFF00}Invalid price amount. (Min: $1000 & Max: $100.000)");
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
            SetPVarInt(playerid, "SellPVPrice", price);

            new String[144];
            format(String, sizeof String, "* Kamu telah menawarkan kendaraan %s milikmu ke %s dengan harga {00FF00}%s{FFFF00}.", GetVehicleName(pvData[vid][cVeh]), GetPlayerNameEx(target_id), FormatMoney(price));
            SCM(playerid, COLOR_YELLOW, String);
            format(String, sizeof String, "* %s menawarkan kendaraan %s miliknya dengan harga {00FF00}%s{FFFF00}.", GetPlayerNameEx(playerid), GetVehicleName(pvData[vid][cVeh]), FormatMoney(price));
            SCM(target_id, COLOR_YELLOW, String);
            SCM(target_id, COLOR_YELLOW, "* Ketik '/accept buypv' untuk menerima tawaran.");
        }
        else ShowSellVehicleMenu(playerid, .extra = "{FFFF00}You are too far away from that player.");
    }

    return 1;
}