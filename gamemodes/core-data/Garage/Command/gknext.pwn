/**
 * Command: /gknext
 */

CMD:gknext(playerid, params[])
{
    new tmp[144];

	if(pData[playerid][pAdmin] >= 7) {
		SCM(playerid, COLOR_GREEN, "* Listing next available garages...");
		for(new x = 0; x < MAX_GARAGES; x++)
		{
			if(GarageInfo[x][gkInX] == 0)
			{
				format(tmp, sizeof(tmp), "ID %d is available to use.", x);
				SCM(playerid, COLOR_WHITE, tmp);
                break;
			}
		}
	}
	else Error(playerid, "You don't have any permission to use this command.");

	return 1;
}