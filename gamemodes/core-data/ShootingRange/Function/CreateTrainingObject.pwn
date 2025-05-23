CreateTrainingObject(playerid, id)
{
	if(IsPlayerConnected(playerid))
	{
		if(0 <= id < sizeof(TrainingObjectPos))
		{
		    for(new trid = 0; trid < 5; trid++)
		    {
		        if(!IsValidDynamicObject(TrainingObject[playerid][trid][0]))
		        {
				    FaseTrainingObject[playerid][trid] = 0;
				    for(new j = 0; j < 8; j++)
				    {
					    if(IsValidDynamicObject(TrainingObject[playerid][trid][j]))
						{
							DestroyDynamicObject(TrainingObject[playerid][trid][j]);
							TrainingObject[playerid][trid][j] = INVALID_OBJECT_ID;
						}
					}

				    TrainingObject[playerid][trid][0] = CreateDynamicObject(3025, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
				    TrainingObject[playerid][trid][1] = CreateDynamicObject(3018, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					TrainingObject[playerid][trid][2] = CreateDynamicObject(3019, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					TrainingObject[playerid][trid][3] = CreateDynamicObject(3020, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					TrainingObject[playerid][trid][4] = CreateDynamicObject(3021, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					TrainingObject[playerid][trid][5] = CreateDynamicObject(3022, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					TrainingObject[playerid][trid][6] = CreateDynamicObject(3023, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					TrainingObject[playerid][trid][7] = CreateDynamicObject(3024, TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2],   90.00000, 0.00000, 0.00000, .playerid = playerid);
					for(new i = 0; i < 8; i++)
					{
					    MoveDynamicObject(TrainingObject[playerid][trid][i], TrainingObjectPos[id][0], TrainingObjectPos[id][1], TrainingObjectPos[id][2]+0.1, 0.2, 0, 0, 0);
					}
					break;
				}
			}
		}
	}
	return 1;
}