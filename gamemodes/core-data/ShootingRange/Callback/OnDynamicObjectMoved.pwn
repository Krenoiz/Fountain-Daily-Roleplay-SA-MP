public OnDynamicObjectMoved(objectid)
{
    for(new playerid = 0; playerid <= GetPlayerPoolSize(); playerid++)
	{
	    for(new i = 0; i < 5; i++)
		{
  		  	if(TrainingObject[playerid][i][0] == objectid)
  		  	{
  		  	    if(FaseTrainingObject[playerid][i] == 1)
  		  	    {
  		  	        for(new j = 0; j < 8; j++)
  		  	        {
  		  	            if(IsValidDynamicObject(TrainingObject[playerid][i][j]))
  		  	            {
  		  	                DestroyDynamicObject(TrainingObject[playerid][i][j]);
  		  	                TrainingObject[playerid][i][j] = INVALID_OBJECT_ID;
  		  	            }
					}
					new highest = random((sizeof(TrainingObjectPos)-1));
                    if(0 <= highest < sizeof(TrainingObjectPos)) CreateTrainingObject(playerid, highest);
  		  	    }
			}
		}
	}

    return 1;
}