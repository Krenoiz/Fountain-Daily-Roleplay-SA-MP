forward hook_OnClickLogin(playerid, PlayerText: textid);
public hook_OnClickLogin(playerid, PlayerText: textid)
{
    if (textid == LoginMainButton[playerid])
    {
        if(pData[playerid][pilihkarakter] == 0)
        {
            new lstring[256];
            format(lstring, sizeof lstring, ""LB_E"Masukkan Password Untuk Melanjutkan.");
            HideLoginMenu(playerid);
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Sign Password", lstring, "Next", "Cancel");
        }
        else
        {
            new cQuery[256];
            mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1;", PlayerChar[playerid][pData[playerid][pChar]]);
            mysql_tquery(g_SQL, cQuery, "AssignPlayerData", "d", playerid);
            HideLoginMenu(playerid);
            pData[playerid][pilihkarakter] = 0;
            DestroyLoginTextDraws(playerid);
        }
    }

    if (textid == LoginCharButton[playerid])
    {
        CheckPlayerChar(playerid);
    }
}