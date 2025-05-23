forward StopTraining(playerid);
public StopTraining(playerid)
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	SetWeapons(playerid);
	
	for(new i = 0; i < 5; i++)
	{
	    for(new j = 0; j < 8; j++)
	    {
		    if(IsValidDynamicObject(TrainingObject[playerid][i][j]))
			{
				DestroyDynamicObject(TrainingObject[playerid][i][j]);
				TrainingObject[playerid][i][j] = INVALID_OBJECT_ID;
			}
		}
		FaseTrainingObject[playerid][i] = 0;
	}

	SetPlayerInterior(playerid, 1);
	if(GetPVarInt(playerid, "TakeTraining") == 1) {
		SetPlayerPositionEx(playerid, 295.517089, -37.889026, 1001.515625);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerFacingAngle(playerid, 180);
		TrainingUsed[0] = 0;
	}
	else {
		SetPlayerPositionEx(playerid, 295.517089, -37.889026, 1001.515625);
		SetPlayerVirtualWorld(playerid, 2);
		SetPlayerFacingAngle(playerid, 180);
		TrainingUsed[1] = 0;
	}
	DeletePVar(playerid, "TakeTraining");

	switch(GetPVarInt(playerid, "Training_Weapon"))
    {
        case 0:
        {
            pData[playerid][pWeaponSkill][0] = pData[playerid][pWeaponSkill][0] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata 9mm (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 1:
        {
            pData[playerid][pWeaponSkill][1] = pData[playerid][pWeaponSkill][1] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata silenced pistol (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 2:
        {
            pData[playerid][pWeaponSkill][2] = pData[playerid][pWeaponSkill][2] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata desert eagle (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 3:
        {
            pData[playerid][pWeaponSkill][3] = pData[playerid][pWeaponSkill][3] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata shotgun (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        
        case 4:
        {
            pData[playerid][pWeaponSkill][5] = pData[playerid][pWeaponSkill][5] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata SPAS-12 (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 5:
        {
            pData[playerid][pWeaponSkill][6] = pData[playerid][pWeaponSkill][6] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata Micro Uzi (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 6:
        {
            pData[playerid][pWeaponSkill][7] = pData[playerid][pWeaponSkill][7] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata MP5 (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 7:
        {
            pData[playerid][pWeaponSkill][8] = pData[playerid][pWeaponSkill][8] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata AK47 (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 8:
        {
            pData[playerid][pWeaponSkill][9] = pData[playerid][pWeaponSkill][9] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata M4 (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
        case 9:
        {
            pData[playerid][pWeaponSkill][10] = pData[playerid][pWeaponSkill][10] + GetPVarInt(playerid, "Training_Point");
            Info(playerid, "Kamu mendapatkan exp %d weapon skill untuk senjata sniper rifle (/gunskill)", GetPVarInt(playerid, "Training_Point"));
        }
    }
	
	if(pData[playerid][pWeaponSkill][0] >= 999) pData[playerid][pWeaponSkill][0] = 999;
	if(pData[playerid][pWeaponSkill][1] >= 999) pData[playerid][pWeaponSkill][1] = 999;
	if(pData[playerid][pWeaponSkill][2] >= 999) pData[playerid][pWeaponSkill][2] = 999;
	if(pData[playerid][pWeaponSkill][3] >= 999) pData[playerid][pWeaponSkill][3] = 999;
	if(pData[playerid][pWeaponSkill][4] >= 999) pData[playerid][pWeaponSkill][4] = 999;
	if(pData[playerid][pWeaponSkill][5] >= 999) pData[playerid][pWeaponSkill][5] = 999;
	if(pData[playerid][pWeaponSkill][6] >= 999) pData[playerid][pWeaponSkill][6] = 999;
	if(pData[playerid][pWeaponSkill][7] >= 999) pData[playerid][pWeaponSkill][7] = 999;
	if(pData[playerid][pWeaponSkill][8] >= 999) pData[playerid][pWeaponSkill][8] = 999;
	if(pData[playerid][pWeaponSkill][9] >= 999) pData[playerid][pWeaponSkill][9] = 999;
	if(pData[playerid][pWeaponSkill][10] >= 999) pData[playerid][pWeaponSkill][10] = 999;

	SyncWeaponSkill(playerid);

	InEvent[playerid] = 0;

	TrainingTimer[playerid] = 0;
	TogglePlayerControllable(playerid, true);

    DestroyTrainingTextDraw(playerid);
}