/*
 * Save garage
 */

SaveGarage(Index)
{
	if((0 <= Index < MAX_GARAGES)) {
		if(_: GarageInfo[Index][gkORM] != 0) {
			return orm_save(GarageInfo[Index][gkORM], "OnGarageDataSaved", "i", Index);
		}
	}
	return 0;
}