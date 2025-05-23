HidePhoneLockscreen(playerid)
{
    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDBazzle[playerid][i]);
    }

    PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][1]);
    PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][0]);

    for(new i = 2; i < 9; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][i]);
    }

    PlayerTextDrawHide(playerid, PhoneTDDot[playerid]);
    PlayerTextDrawHide(playerid, PhoneTDTime[playerid][0]);
    PlayerTextDrawHide(playerid, PhoneTDDate[playerid]);
    PlayerTextDrawHide(playerid, PhoneTDButton[playerid][0]);

    DeletePVar(playerid, "PhoneTD_Lockscreen");

    return 1;
}