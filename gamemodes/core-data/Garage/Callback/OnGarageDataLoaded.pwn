/**
 * OnGarageDataLoaded
 */

function OnGarageDataLoaded(i)
{
    new ORM: ormid = GarageInfo[i][gkORM];
    orm_setkey(ormid, "gkIdx");
    switch (orm_errno(ormid))
	{
		case ERROR_OK:
		{
            SyncGarage(i);
		}
        case ERROR_INVALID: 
        {
            // empty
        }
        case ERROR_NO_DATA:
        {
            // empty
        }
	}
	return 1;
}