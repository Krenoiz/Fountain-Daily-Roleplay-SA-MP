DestroySpeedoTextDraws(playerid)
{
    for(new i = 0; i < 7; i++)
    {
        PlayerTextDrawDestroy(playerid, Speedo[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, SpeedoSpeedText[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedoHPText[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedoFuelText[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedoCompassText[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedoModelText[playerid]);
}