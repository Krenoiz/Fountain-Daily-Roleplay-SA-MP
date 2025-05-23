/**
 * Dialog ID: WEAPON_TRAINING
 */

dR_TRAINING(playerid, response, listitem)
{
    if(response) {

        if(listitem == 0 && pData[playerid][pWeaponSkill][0] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 1 && pData[playerid][pWeaponSkill][1] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 2 && pData[playerid][pWeaponSkill][2] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 3 && pData[playerid][pWeaponSkill][3] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 4 && pData[playerid][pWeaponSkill][5] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 5 && pData[playerid][pWeaponSkill][6] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 6 && pData[playerid][pWeaponSkill][7] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 7 && pData[playerid][pWeaponSkill][8] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 8 && pData[playerid][pWeaponSkill][9] >= 999) return Error(playerid, "You already have full skill point.");
        if(listitem == 9 && pData[playerid][pWeaponSkill][10] >= 999) return Error(playerid, "You already have full skill point.");

        ResetPlayerWeapons(playerid);
        
        new Price = 0;
        switch(listitem)
        {
            case 0: Price = 700;
            case 1: Price = 800;
            case 2: Price = 1500;
            case 3: Price = 1000;
            case 4: Price = 2500;
            case 5: Price = 5000;
            case 6: Price = 8000;
            case 7: Price = 10000;
            case 8: Price = 10000;
            case 9: Price = 15000;
        }

        if(pData[playerid][pMoney] < Price)
        {
            Error(playerid, "You don't have %s.", FormatMoney(Price));
            return 1;
        }
        GivePlayerMoneyEx(playerid, -Price);

        SetPlayerPosition(playerid, 295.2575, -24.8822, 1001.5156, 0.0);

        SetPVarInt(playerid, "Training_Point", 0);
        SetPlayerFacingAngle(playerid, 0);
        SetPlayerVirtualWorld(playerid, (playerid+1));
        SetPlayerInterior(playerid, 1);

        TrainingTimer[playerid] = 150;
        
        InEvent[playerid] = EVENT_TRAINING;
        new randid = random((sizeof(TrainingObjectPos)-1));
        CreateTrainingObject(playerid, randid);

        SetPVarInt(playerid, "Training_Weapon", listitem);
        switch(listitem)
        {
            case 0: GivePlayerWeapon(playerid, 22, 136);
            case 1: GivePlayerWeapon(playerid, 23, 136);
            case 2: GivePlayerWeapon(playerid, 24, 56);
            case 3: GivePlayerWeapon(playerid, 25, 100);
            case 4: GivePlayerWeapon(playerid, 27, 112);
            case 5: GivePlayerWeapon(playerid, 28, 1000);
            case 6: GivePlayerWeapon(playerid, 29, 600);
            case 7: GivePlayerWeapon(playerid, 30, 600);
            case 8: GivePlayerWeapon(playerid, 31, 1000);
            case 9: GivePlayerWeapon(playerid, 34, 100);
        }

        if(GetPVarInt(playerid, "TakeTraining") == 1) {
            TrainingUsed[0] = 1;
        }
        else {
            TrainingUsed[1] = 1;
        }

        CreateTrainingTextDraw(playerid);
    }

    return 1;
}