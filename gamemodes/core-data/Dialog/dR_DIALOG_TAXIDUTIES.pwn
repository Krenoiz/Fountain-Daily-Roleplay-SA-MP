dR_DIALOG_TAXIDUTIES(playerid, response, listitem)
{
    if (response)
    {
        new count = 0, tmp[32];
        foreach(new i : Player)
        {
            if (pData[i][pTaxiDuty] == 1)
            {
                if (count == listitem)
                {
                    format(tmp, sizeof tmp, "%d", pData[i][pPhone]);
                    callcmd::call(playerid, tmp);
                    break;
                }
                else count++;
            }
        }
    }
}