#include <YSI\y_hooks>

new lotteryTickets[MAX_PLAYERS][2]; 
new saveTimer;
new lottime;


hook OnGameModeInit()
{
    lottime = SetTimer("lottery", 3600000, true);
    saveTimer = SetTimer("SaveAllPlayerData", 3600000, true); 
    SetTimer("GStation_Refresh", 3600000, true); 
    SetTimer("House_Refresh", 3600000, true); 
    SetTimer("Workshop_Refresh", 3600000, true); 
    SetTimer("Ladang_Refresh", 3600000, true); 
    SetTimer("DealerPointRefresh", 3600000, true); 
    return 1;
}
hook OnGameModeExit()
{
    KillTimer(saveTimer);
    KillTimer(lottime);
    return 1;
}
function lottery()
{
    new lotte = random(25) + 1; 
    SendClientMessageToAllEx(-1, "{FF9999}[Lottery]{FFFFFF} Sayangnya tidak ada pemenang dalam lottery kali ini.");
    SendClientMessageToAllEx(-1, "~> Nomor Lottery yang keluar hari ini: {FFFF00}%d", lotte);
    SendClientMessageToAllEx(-1, "~> Nomor Lottery Selanjutnya akan keluar dalam 1 Jam kedepan");
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && lotteryTickets[i][1] == lotte)
        {
            new playerName[32];
            new message[256];
            GetPlayerName(i, playerName, sizeof(playerName));
            GivePlayerMoney(i, 1500);
            pData[i][pMoney] += 1500;
            SendClientMessage(i, -1, "{FFFF00}[Lottery]{FFFFFF} Selamat! Anda memenangkan lottery hari ini!");
            format(message, sizeof(message), "{FFFF00}[Lottery]{FF0000}%s{FFFFFF} memenangkan lottery dengan nomor {FFFF00}%d{FFFFFF}!", playerName, lotte);
            SendClientMessageToAllEx(-1, message);
        }
    }
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            lotteryTickets[i][1] = 0;
            pData[i][pHasBoughtLottery] = false;
        }
    }
    
    return 1;
}
CMD:resetlottery(playerid)
{
    if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

    new lotte = random(25) + 1;
    SendClientMessageToAllEx(-1, "{FF9999}[Lottery]{FFFFFF} Sayangnya tidak ada pemenang dalam lottery kali ini.");
    SendClientMessageToAllEx(-1, "~> Nomor Lottery yang keluar hari ini: {FFFF00}%d", lotte);
    SendClientMessageToAllEx(-1, "~> Nomor Lottery Selanjutnya akan keluar dalam 1 Jam kedepan");

    new winnerFound = false;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && lotteryTickets[i][1] == lotte)
        {
            new playerName[32];
            new message[256];
            GetPlayerName(i, playerName, sizeof(playerName));
            GivePlayerMoney(i, 1500);
            pData[i][pMoney] += 1500;
            SendClientMessage(i, -1, "{FFFF00}[Lottery]{FFFFFF} Selamat! Anda memenangkan lottery hari ini!");
            format(message, sizeof(message), "{FFFF00}[Lottery]{FF0000}%s{FFFFFF} memenangkan lottery dengan nomor {FFFF00}%d{FFFFFF}!", playerName, lotte);
            SendClientMessageToAllEx(-1, message);
            winnerFound = true;
        }
    }

    if (!winnerFound)
    {
        SendClientMessageToAllEx(-1, "{FF9999}[Lottery]{FFFFFF} Sayangnya tidak ada pemenang dalam lottery kali ini.");
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            lotteryTickets[i][1] = 0;
            pData[i][pHasBoughtLottery] = false;
        }
    }

    return 1;
}
// CMD:buylottery(playerid)
// {
//     if(!IsPlayerInRangeOfPoint(playerid, 3.5, -788.2568,2256.4429,59.6373)) 
//         return Error(playerid, "Kamu harus berada di area lottery untuk membeli tiket.");
//     if(pData[playerid][pLevel] < 5) 
//         return Error(playerid, "Anda Belum Mencapai Level 5.");
    
//     if(pData[playerid][pHasBoughtLottery])
//         return Error(playerid, "Anda sudah membeli tiket lotere dan tidak bisa membelinya lagi.");

//     pData[playerid][pHasBoughtLottery] = true;
//     ShowPlayerDialog(playerid, DIALOG_LOTTERY, DIALOG_STYLE_INPUT, "LOTTERY PURCHASE", "Masukkan nomor tiket (1-99):", "Buy", "Cancel");
//     return 1;
// }

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_LOTTERY)
    {
        if (response) 
        {
            new ticketNumber = strval(inputtext);

            if (ticketNumber < 1 || ticketNumber > 25)
            {
                SendClientMessage(playerid, -1, "{FF0000}Nomor tiket harus berada dalam rentang 1 hingga 25.");
                return 1;
            }

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (IsPlayerConnected(i) && lotteryTickets[i][1] == ticketNumber)
                {
                    SendClientMessageEx(playerid, -1, "{FF0000}Nomor tiket {FFFF00}%d{FF0000} sudah dibeli oleh pemain lain.", ticketNumber);
                    ShowPlayerDialog(playerid, DIALOG_LOTTERY, DIALOG_STYLE_INPUT, "LOTTERY PURCHASE", "Masukkan nomor tiket (1-25):", "Buy", "Cancel");
                    return 1;
                }
            }
            
            // new ticketPrice = 100; 

            // if (GetPlayerMoney(playerid) < ticketPrice)
            // {
            //     SendClientMessage(playerid, -1, "{FF0000}Anda tidak memiliki cukup uang untuk membeli tiket lottery.");
            //     return 1;
            // }

            // GivePlayerMoney(playerid, -ticketPrice);
            pData[playerid][pHasBoughtLottery] = true; 

            lotteryTickets[playerid][0] = playerid;
            lotteryTickets[playerid][1] = ticketNumber;

            SendClientMessageEx(playerid, -1, "{FFFF00}[Lottery]{FFFFFF} Anda telah membeli tiket lottery dengan nomor {FFFF00}%d{FFFFFF}.", ticketNumber);
        }
        else 
        {
            SendClientMessage(playerid, -1, "{FFFF00}[Lottery]{FFFFFF} Pembelian tiket lotere dibatalkan.");
        }
    }
    return 1;
}
function SaveAllPlayerData()
{
    SendClientMessageToAllEx(-1, "{FF9999}Server says: {56A4E4}All player statistics successfully saved into Database! ");
    for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        if (IsPlayerConnected(playerid))
        {
            UpdatePlayerData(playerid);
            UpdateWeapons(playerid);
        }
    }
}
