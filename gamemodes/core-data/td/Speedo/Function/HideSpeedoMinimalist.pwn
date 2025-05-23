HideSpeedoMinimalist(playerid)
{
    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawHide(playerid, Speedo[playerid][i]);
    }

	PlayerTextDrawHide(playerid, SpeedoSpeedText[playerid]);

    for(new i = 3; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, Speedo[playerid][i]);
    }
    
    PlayerTextDrawHide(playerid, SpeedoHPText[playerid]);
    PlayerTextDrawHide(playerid, SpeedoFuelText[playerid]);
    PlayerTextDrawHide(playerid, SpeedoCompassText[playerid]);

    PlayerTextDrawHide(playerid, Speedo[playerid][6]);

    PlayerTextDrawHide(playerid, SpeedoModelText[playerid]);

}