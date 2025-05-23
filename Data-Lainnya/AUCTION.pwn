//AUCTION
#include <YSI_Coding\y_hooks>
new aucQueue[MAX_PLAYERS],


Dialog:AuctionQueue(playerid, response, listitem, inputtext[]) {
	if (response) {
        new
            Cache:query,
            str[650];

        aucQueue[playerid]++;
        query = mysql_query(g_iHandle, sprintf("SELECT * FROM `auction_queue` LIMIT %d, 10", aucQueue[playerid] * 10));

        new rows = cache_num_rows(), location[32], id, type, misc;

        if (rows) {
            format(str,sizeof(str),"ID\tName\tLocation\n");
            for (new i = 0; i < rows; i ++) {
                cache_get_value(i, "Location", location);
                cache_get_value_int(i, "ID", id);
                cache_get_value_int(i, "Property", type);
                cache_get_value_int(i, "Type", misc);

                format(str,sizeof(str),"%s%d\t%s\t%s\n",str,id,Auction_GetType(id, type, misc),location);
            }
            Dialog_Show(playerid, AuctionQueue, DIALOG_STYLE_TABLIST_HEADERS, "Auction Queue", str, "Next", "Close");
        } else SendErrorMessage(playerid, "There is no auction on the queue!");

        cache_delete(query);
    }
    else aucQueue[playerid] = 0;
    return 1;
}

IsPlayerInNewbieSchool(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 4.0,986.6007,-2014.6785,5.3146))
        return 1;

    return 0;
}

CMD:auction(playerid, params[])
{
    new option[32], string[128], property[128];

    if(!IsPlayerInNewbieSchool(playerid))
        return SendErrorMessage(playerid, "You're not in newbie school.");

    if(sscanf(params, "s[32]S()[128]", option, string))
        return SendSyntaxMessage(playerid, "/auction [create/join/bid/cancel/queue]");

    if(!strcmp(option,"create", true))
    {
        new lelang[128], start, bid;

        if (PlayerData[playerid][pAdmin] < 7)
            return PermissionError(playerid);

        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) != 0)
            return SendErrorMessage(playerid, "Auction sedang berjalan, /auction cancel tuntuk menunda.");

        if(sscanf(string, "dds[128]", start, bid, lelang))
            return SendSyntaxMessage(playerid, "/auction create [start money] [diff] [property name]");

        if(start < 0)
            return SendErrorMessage(playerid, "Jangan memasukkan uang awal di bawah 0.");

        if(bid < 0)
        return SendErrorMessage(playerid, "Jangan memasukkan jumlah diff di bawah 0.");

        SetGVarInt("AuctionType", 1, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionTime", 15, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionCount", 0, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionStart", start, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionDiff", bid, GLOBAL_VARTYPE_INT);
        SetGVarString("AuctionLelang", lelang, GLOBAL_VARTYPE_STRING);
        SetGVarString("AuctionHighest", "none", GLOBAL_VARTYPE_STRING);

        foreach(new id : Player) if(IsPlayerInNewbieSchool(id))
        {
            SendClientMessageEx(id, COLOR_LBLUE, "AUCTION: "YELLOW_E"Item: "WHITE_E"%s | "YELLOW_E"Start price: "GREEN_E"%s | "YELLOW_E"Diff: "GREEN_E"%s", lelang, FormatMoney(start), FormatMoney(bid));
            SendClientMessageEx(id, COLOR_LBLUE, "AUCTION: "WHITE_E"Use command "YELLOW_E"'/auction join' "WHITE_E"to join auction.");
        }
        Auction = SetTimer("AuctionTime", 1000, true);
        new text[255];
        format(text,sizeof(text),"{00FFFF}%s\n"GREEN_E"Start: "WHITE_E"%s\n"GREEN_E"Diff: "WHITE_E"%s\n"GREEN_E"Participants: "WHITE_E"%d\nSeart in: %d", lelang, FormatMoney(start), FormatMoney(bid), GetGVarInt("AuctionCount", GLOBAL_VARTYPE_INT), GetGVarInt("AuctionTime", GLOBAL_VARTYPE_INT));
        SetDynamicObjectMaterialText(newbieschool, 0, text, 130, "Ariel", 27, 1, -1, -16777216, 1);

        SendStaffMessage(COLOR_LIGHTRED, "AdmWarn: %s start the auction, start: [%s] diff: [%s]", pData[playerid][pName], FormatMoney(start), FormatMoney(bid));
    }
    else if(!strcmp(option, "join", true))
    {
        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) != 1) return SendErrorMessage(playerid, "Auction belum di mulai.");
        if(GetPVarInt(playerid, "IkutLelang")) return SendErrorMessage(playerid, "Anda sedang mengikuti auction ini.!");
        if(pData[playerid][pMoney] < 100) return SendErrorMessage(playerid, "Anda tidak memiliki modal uang $100 untuk mengikuti auction ini.");

        GetGVarString("AuctionLelang", property, sizeof(property), GLOBAL_VARTYPE_STRING);

        GivePlayerMoneyEx(playerid, -100);
        SendClientMessageEx(playerid, COLOR_LBLUE, "AUCTION: "WHITE_E"Gunakan perintah "YELLOW_E"'/auction bid' "WHITE_E"untuk memenangkan auction.");

        // for(new i = 0; i != MAX_PLAYERS; i++) if(FactionData[i][factionExists] && FactionData[i][factionType] == FACTION_GOV) {
        //     FactionData[i][factionMoney] += 5;
        // }
        SetPVarInt(playerid, "IkutLelang", 1);
        SetGVarInt("AuctionCount", GetGVarInt("AuctionCount", GLOBAL_VARTYPE_INT)+1, GLOBAL_VARTYPE_INT);

    }
    else if(!strcmp(option, "bid", true))
    {
        new money = (GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)+GetGVarInt("AuctionDiff", GLOBAL_VARTYPE_INT)),
            name[MAX_PLAYER_NAME];

        GetGVarString("AuctionHighest", name, sizeof(name), GLOBAL_VARTYPE_STRING);

        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) == 1)
        return SendErrorMessage(playerid, "Auction belum di mulai.");

        if(!strcmp(name, ReturnName(playerid), true))
        return SendErrorMessage(playerid, "Anda masih berada di peringkat teratas auction ini!.");

        if(!GetPVarInt(playerid, "IkutLelang"))
        return SendErrorMessage(playerid, "Anda tidak mengikuti auction ini.");

        if(pData[playerid][pMoney] < money)
        return SendErrorMessage(playerid, "Anda tidak memiliki uang sebesar %s untuk mengikuti auction ini.", FormatMoney(money));

        SetGVarInt("AuctionStart", money, GLOBAL_VARTYPE_INT);
        SetGVarString("AuctionHighest", ReturnName(playerid), GLOBAL_VARTYPE_STRING);
        SetGVarInt("AuctionTime", 10, GLOBAL_VARTYPE_INT);
    }
    else if(!strcmp(option, "cancel", true))
    {
        if (PlayerData[playerid][pAdmin] < 7)
            return PermissionError(playerid);
        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) == 0)
        return SendErrorMessage(playerid, "Auction sedang tidak berlangsung!.");

        foreach(new id : Player) if(IsPlayerInNewbieSchool(id))
        {
            SendClientMessageEx(id, COLOR_LIGHTRED, "AUCTION: "YELLOW_E"%s "WHITE_E"menunda auction.", ReturnName(playerid));
        }
        Auction_Reset();
        SetDynamicObjectMaterialText(newbieschool, 0, "Auction di tunda.", 130, "Ariel", 27, 1, -1, -16777216, 1);
    } else if (!strcmp(option, "queue", true)) {
        new Cache:check, str[650];
        
        aucQueue[playerid] = 0;

        check = mysql_query(g_iHandle, sprintf("SELECT * FROM `auction_queue` LIMIT %d, 10", aucQueue[playerid] * 10));

        new rows = cache_num_rows(), location[32], id, type, misc;

        if (rows) {
            format(str,sizeof(str),"ID\tName\tLocation\n");
            for (new i = 0; i < rows; i ++) {
                cache_get_value(i, "Location", location);
                cache_get_value_int(i, "ID", id);
                cache_get_value_int(i, "Property", type);
                cache_get_value_int(i, "Type", misc);

                format(str,sizeof(str),"%s%d\t%s\t%s\n",str,id,Auction_GetType(id, type, misc),location);
            }
            Dialog_Show(playerid, AuctionQueue, DIALOG_STYLE_TABLIST_HEADERS, "Auction Queue", str, "Next", "Close");
        } else SendErrorMessage(playerid, "There is no auction on the queue!");

        cache_delete(check);
    }
    else 
        SendSyntaxMessage(playerid, "/auction [create/join/bid/cancel]");

    return 1;
}

Auction_GetType(id, type, misc) {
    new output[128], typeName[24];

    switch (type) {
        case 1: format(output,sizeof(output),"%s",Business_Type(id));
        case 2: {
            if (misc) format(output,sizeof(output),"House with %d garage",misc);
            else format(output,sizeof(output),"House with no garage");
        }
        case 3: format(output,sizeof(output),"%s Garage", Garage_GetType(id));
        case 4: format(output,sizeof(output),"Workshop");
        case 5: format(output,sizeof(output),"Private Farm");
        case 6: {
            Flat_GetType2(misc, typeName);
            format(output,sizeof(output),"Flat %s", typeName);
        }
    }

    return output;
}

CMD:changeboard(playerid, params[])
{
    new text[128],string[128];

    if (PlayerData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    if(!IsPlayerInNewbieSchool(playerid))
        return SendErrorMessage(playerid, "You're not in newbie school.");

    if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) != 0)
        return SendErrorMessage(playerid, "Auction telah berlangsung, jangan di ubah dahulu sebelum selesai.");

    if(sscanf(params, "s[128]", text))
        return SendSyntaxMessage(playerid, "/changeboard [text]");

    if(strlen(text) > 128)
        return SendErrorMessage(playerid, "Text terlalu panjang.");

    FixText(text);
    format(string,sizeof(string),"%s",ColouredText(text));
    SetDynamicObjectMaterialText(newbieschool, 0, string, 130, "Ariel", 27, 1, -1, -16777216, 1);
    return 1;
}