ShowPhoneLockscreen(playerid)
{
    HidePhoneMainscreen(playerid);

    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDBazzle[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawColor(playerid, PhoneTDScreen[playerid][i], DefaultBackground);
    }

    PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][1]);
    PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][0]);

    for(new i = 2; i < 9; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][i]);
    }

    PlayerTextDrawShow(playerid, PhoneTDDot[playerid]);
    PlayerTextDrawShow(playerid, PhoneTDTime[playerid][0]);
    PlayerTextDrawShow(playerid, PhoneTDDate[playerid]);
    PlayerTextDrawShow(playerid, PhoneTDButton[playerid][0]);

    SetPVarInt(playerid, "JustOpenedPhone", 3);
    SetPVarInt(playerid, "PhoneTD", 1);
    SetPVarInt(playerid, "PhoneTD_Lockscreen", 1);

    SelectTextDraw(playerid, 0xFFFF00FF);

    return 1;
}