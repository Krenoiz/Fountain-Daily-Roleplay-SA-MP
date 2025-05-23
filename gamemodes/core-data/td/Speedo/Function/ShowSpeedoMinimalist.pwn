ShowSpeedoMinimalist(playerid)
{
    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawShow(playerid, Speedo[playerid][i]);
    }

	PlayerTextDrawShow(playerid, SpeedoSpeedText[playerid]);

    for(new i = 3; i < 6; i++)
    {
        PlayerTextDrawShow(playerid, Speedo[playerid][i]);
    }
    
    PlayerTextDrawShow(playerid, SpeedoHPText[playerid]);
    PlayerTextDrawShow(playerid, SpeedoFuelText[playerid]);
    PlayerTextDrawShow(playerid, SpeedoCompassText[playerid]);

    PlayerTextDrawShow(playerid, Speedo[playerid][6]);

    PlayerTextDrawShow(playerid, SpeedoModelText[playerid]);

}