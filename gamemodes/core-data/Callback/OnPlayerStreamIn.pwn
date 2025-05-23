public OnPlayerStreamIn(playerid, forplayerid)
{
    if(pData[playerid][pMaskOn])
	{
     	ShowPlayerNameTagForPlayer(forplayerid, playerid, false);
	}
	return 1;
}