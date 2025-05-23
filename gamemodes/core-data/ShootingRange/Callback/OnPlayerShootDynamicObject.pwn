public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float: x, Float: y, Float: z)
{
    for(new i = 0; i < 5; i++)
	{
		for(new j = 1; j < 8; j++)
		{
			if(IsValidDynamicObject(TrainingObject[playerid][i][j]) && objectid == TrainingObject[playerid][i][j])
			{
				PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
				DestroyDynamicObject(TrainingObject[playerid][i][j]);
				TrainingObject[playerid][i][j] = INVALID_OBJECT_ID;
				SetPVarInt(playerid, "Training_Point", GetPVarInt(playerid, "Training_Point") + 1);
				new newpoint = GetPVarInt(playerid, "Training_Point");

				if(newpoint == 30 || newpoint == 60 || newpoint == 90 || newpoint == 120)
				{
					new randid = random((sizeof(TrainingObjectPos)-1));
					CreateTrainingObject(playerid, randid);
				}
				new bool: getnewone = true;
				for(new k = 1; k < 8; k++)
				{
					if(IsValidDynamicObject(TrainingObject[playerid][i][k]))
					{
						getnewone = false;
						break;
					}
				}
				if(getnewone == true)
				{
					FaseTrainingObject[playerid][i] = 1;
					new Float: o_PosX, Float: o_PosY, Float: o_PosZ;
					GetDynamicObjectPos(TrainingObject[playerid][i][0], o_PosX, o_PosY, o_PosZ);
					MoveDynamicObject(TrainingObject[playerid][i][0], o_PosX, o_PosY, o_PosZ-0.1, 0.2, 90, 0, 0);
				}
			}
		}
	}

	return 1;
}