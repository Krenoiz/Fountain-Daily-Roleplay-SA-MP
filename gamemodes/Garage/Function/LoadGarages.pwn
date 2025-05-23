/**
 * Load garages
 */

LoadGarages()
{
	for(new i = 0; i < MAX_GARAGES; i++) {
		GarageInfo[i][gkID] = i;
		new ORM: ormid = GarageInfo[i][gkORM] = orm_create("garages", g_SQL);
		orm_addvar_int(ormid, GarageInfo[i][gkIdx], "gkIdx");
		orm_addvar_int(ormid, GarageInfo[i][gkID], "gkID");
        orm_addvar_string(ormid, GarageInfo[i][gkName], 32, "gkName");
		orm_addvar_float(ormid, GarageInfo[i][gkInX], "gkInX");
		orm_addvar_float(ormid, GarageInfo[i][gkInY], "gkInY");
		orm_addvar_float(ormid, GarageInfo[i][gkInZ], "gkInZ");
		orm_addvar_float(ormid, GarageInfo[i][gkOutX], "gkOutX");
		orm_addvar_float(ormid, GarageInfo[i][gkOutY], "gkOutY");
		orm_addvar_float(ormid, GarageInfo[i][gkOutZ], "gkOutZ");
		orm_addvar_float(ormid, GarageInfo[i][gkOutA], "gkOutA");
		orm_addvar_int(ormid, GarageInfo[i][gkVW], "gkVW");
		orm_addvar_int(ormid, GarageInfo[i][gkInt], "gkInt");
		orm_setkey(ormid, "gkID");
		orm_load(ormid, "OnGarageDataLoaded", "i", i);
	}
	print("[MySQL]: Garages has been loaded!");
    return 1;
}