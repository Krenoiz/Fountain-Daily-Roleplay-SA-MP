#define MAX_BILLS 50000

enum billing
{
    bilType,
    bilName[230],
    bilTarget,
    bilammount
}

new bilData[MAX_BILLS][billing],
    Iterator:tagihan<MAX_BILLS>;

/*Billing_Save(id)
{
    new bQuery[3400];
    mysql_format(g_SQL, bQuery, sizeof(bQuery), "UPDATE `bill` SET `type`='%d', `name`='%s', `target`='%d', `ammount='%d' WHERE `bid`='%d'", 
    bilData[id][bilType], 
    bilData[id][bilName],
    bilData[id][bilTarget],
    bilData[id][bilammount],
    id);
    return mysql_tquery(g_SQL, bQuery);
}*/
//callback
function LoadBill()
{
    new rows = cache_num_rows();
    if(rows)
    {
        new tagid;
        for(new i; i < rows; i++)
        {
            cache_get_value_name_int(i, "bid", tagid);
            cache_get_value_name_int(i, "type", bilData[tagid][bilType]);
            cache_get_value_name(i, "name", bilData[tagid][bilName], 230);
            cache_get_value_name_int(i, "target", bilData[tagid][bilTarget]);
            cache_get_value_name_int(i, "ammount", bilData[tagid][bilammount]);

            Iter_Add(tagihan, tagid);
        }
        printf("[BILL] Number of billing loaded: %d", rows);
    }
    if(!rows)
    {
        print("Nothing billing Loaded");
    }
}

CMD:givebill(playerid, params[])
{
    if(pData[playerid][pFaction] != 3)
        return Error(playerid, "Kamu harus menjadi samd officer.");
    new biid = Iter_Free(tagihan);
    new id, ammount, namebil[128];
    if(biid == -1) return Error(playerid, "Kamu tidak bisa memberi tagihan lagi");
    if(sscanf(params, "dds[128]", id, ammount, namebil)) return Usage(playerid, "/givebill <playerid><ammount><Nama Bill>");
    if(ammount < 1 || ammount > 10000) return Error(playerid, "Ammount is only can $1-$1000");
    if(1 > strlen(namebil) < 128) return Error(playerid, "Tidak bisa kuarng dari 1 dan lebih dari 128 karakter");

    new bill[3400];
    bilData[biid][bilType] = pData[playerid][pFaction];
    format(bilData[biid][bilName], 128, namebil);
    bilData[biid][bilTarget] = pData[id][pID];
    bilData[biid][bilammount] = ammount;
    Iter_Add(tagihan, biid);
    mysql_format(g_SQL, bill, sizeof(bill), "INSERT INTO `bill` (`bid`,`type`,`name`,`target`,`ammount`) VALUES ('%d','%d','%s','%d','%d')",
    biid,
    bilData[biid][bilType],
    bilData[biid][bilName],
    bilData[biid][bilTarget],
    bilData[biid][bilammount]);
    mysql_tquery(g_SQL, bill);

    new senderName[128], receiverName[128];
    GetPlayerName(playerid, senderName, sizeof(senderName));
    GetPlayerName(id, receiverName, sizeof(receiverName));

    Info(playerid, "Kamu memberikan invoice sebesar {00ff00}%s kepada %s", FormatMoney(bilData[biid][bilammount]), receiverName);
    Info(id, "Kamu menerima invoice sebesar {00ff00}%s dari %s", FormatMoney(bilData[biid][bilammount]), senderName);

    return 1;
}
CMD:mybill(playerid)
{
    HideRadialMenu(playerid);
    new header[256], count = 0;
    new bool:status = false;
    format(header, sizeof(header), "No.\tNama Bill\tJumlah\n");
    foreach(new i: tagihan)
    {
        if(i != -1)
        {
            if(bilData[i][bilTarget] == pData[playerid][pID])
            {
                format(header, sizeof(header), "%s%d.\t%s\t{00ff00}%s\n", header, count, bilData[i][bilName], FormatMoney(bilData[i][bilammount]));
                count++;
                status = true;
            }
        }
    }
    if(status)
    {
        ShowPlayerDialog(playerid, DIALOG_PAYBILL, DIALOG_STYLE_TABLIST_HEADERS, "My invoice", header, "OK", "Exit");
    }
    else
    {
        Error(playerid, "Kamu tidak punya tagihan");
    }

    return 1;
}
/*CMD:paybill(playerid, params[])
{
    new bilid;
    if(sscanf(params, "d", bilid)) return Usage(playerid, "/paybill <Id Billing> | Check /mybill");
    mysql_format(g_SQL, pbill, sizeof(pbill), "SELECT * FROM `bill` WHERE `bid`='%d'", bilid);
    mysql_tquery(g_SQL, pbill, "CheckBill1", "dd", playerid, bilid);
    GivePlayerMoneyEx(playerid, -bilData[bilid][bilammount]);
    SendClientMessageEx(playerid, -1, "{800080}[SUCCESS] {ffffff}You paid bill %s for %s", bilData[bilid][bilName], FormatMoney(bilData[bilid][bilammount]));
    new billdel[256];
    mysql_format(g_SQL, billdel, sizeof(billdel), "DELETE FROM `bill` WHERE `bid`='%d'", bilData[bilid][bilID]);
    mysql_tquery(g_SQL, billdel);
    return 1;
}*/
