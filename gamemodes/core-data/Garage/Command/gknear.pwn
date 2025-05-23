/*
 * Command: /gknear 
 */

CMD:gknear(playerid, params[])
{
    if(pData[playerid][pAdmin] >= 7)
	{
		SCM(playerid, COLOR_GREEN, "* Listing all garages within 30 meters of you");

		new Float:X, Float:Y, Float:Z;
  		GetPlayerPos(playerid, X, Y, Z);

		for(new i; i < MAX_GARAGES; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 30, GarageInfo[i][gkInX], GarageInfo[i][gkInY], GarageInfo[i][gkInZ]))
			{
				if(GarageInfo[i][gkInX] != 0.0)
				{
				    new string[128];
			    	format(string, sizeof(string), "Garage ID %d (In Position) | %.1f from you", i, GetDistance(GarageInfo[i][gkInX], GarageInfo[i][gkInY], GarageInfo[i][gkInZ], X, Y, Z));
			    	SCM(playerid, COLOR_WHITE, string);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 30, GarageInfo[i][gkOutX], GarageInfo[i][gkOutY], GarageInfo[i][gkOutZ]))
			{
				if(GarageInfo[i][gkOutX] != 0.0)
				{
				    new string[128];
			    	format(string, sizeof(string), "Garage ID %d (Out Position) | %.1f from you", i, GetDistance(GarageInfo[i][gkOutX], GarageInfo[i][gkOutY], GarageInfo[i][gkOutZ], X, Y, Z));
			    	SCM(playerid, COLOR_WHITE, string);
				}
			}
		}
	}
	else Error(playerid, "You don't have any permission to use this command.");

	return 1;
}