DestroyHBETextDraws(playerid)
{
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawDestroy(playerid, HBE[playerid][i]);
    }

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawDestroy(playerid, HBEIconHunger[playerid][i]);
        PlayerTextDrawDestroy(playerid, HBEIconThirst[playerid][i]);
        PlayerTextDrawDestroy(playerid, HBEIconStress[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, HBEProgressHunger[playerid]);
	PlayerTextDrawDestroy(playerid, HBEProgressThirst[playerid]);
	PlayerTextDrawDestroy(playerid, HBEProgressStress[playerid]);
}