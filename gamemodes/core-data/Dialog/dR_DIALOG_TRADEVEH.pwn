dR_DIALOG_TRADEVEH(playerid, response, const inputtext[])
{
    if (response)
    {
        new vid = GetPVarInt(playerid, "ClickedVeh");
        new target_id;
        if(sscanf(inputtext, "u", target_id) || !IsPlayerConnected(target_id)) {
            ShowTradeVehicleMenu(playerid, .extra = "{FFFF00}Invalid specified player.");
            return 0;
        }

        if(target_id == playerid) {
            ShowTradeVehicleMenu(playerid, .extra = "{FFFF00}You cannot trade to yourself.");
            return 0;
        }

        if (Vehicle_Nearest(playerid) != vid) {
            ShowTradeVehicleMenu(playerid, .extra = "{FFFF00}You are too far away from the selected vehicle.");
            return 0;
        }

        if(NearPlayer(playerid, target_id, 5.0)) {
            if (HasVehicleStorage(pvData[vid][cVeh]))
                return Error(playerid, "Pickup the items in your vehicle storage first.");

            SetPVarInt(target_id, "OfferedTradePV", 1);
            SetPVarInt(target_id, "TradePVWith", playerid);

            SetPVarInt(playerid, "TradePVIndex", vid);

            new String[144];
            format(String, sizeof String, "* Kamu telah menawarkan %s bertukar kendaraan dengan %s milikmu.", GetPlayerNameEx(target_id), GetVehicleName(pvData[vid][cVeh]));
            SCM(playerid, COLOR_YELLOW, String);
            format(String, sizeof String, "* %s menawarkan bertukar kendaraan dengan kendaraan %s miliknya.", GetPlayerNameEx(playerid), GetVehicleName(pvData[vid][cVeh]));
            SCM(target_id, COLOR_YELLOW, String);
            SCM(target_id, COLOR_YELLOW, "* Ketik '/accept tradepv' untuk menerima tawaran.");
        }
        else ShowTradeVehicleMenu(playerid, .extra = "{FFFF00}You are too far away from that player.");
    }

    return 1;
}