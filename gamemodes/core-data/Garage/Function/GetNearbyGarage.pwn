/**
 * Get nearby garage
 */

GetNearbyGarage(playerid) {
	for(new i = 0; i < MAX_GARAGES; i++) {
		if(GarageInfo[i][gkInX] == 0.0)
			continue;

		if(!IsPlayerInRangeOfPoint(playerid, 5.0, GarageInfo[i][gkInX], GarageInfo[i][gkInY], GarageInfo[i][gkInZ])) 
			continue;

		return i;
	}
	return INVALID_GARAGE_ID;
}