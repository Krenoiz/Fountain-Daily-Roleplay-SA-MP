HideHBEMinimalist(playerid)
{
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, HBE[playerid][i]);
    }

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawHide(playerid, HBEIconHunger[playerid][i]);
        PlayerTextDrawHide(playerid, HBEIconThirst[playerid][i]);
        PlayerTextDrawHide(playerid, HBEIconStress[playerid][i]);
    }

	PlayerTextDrawHide(playerid, HBEProgressHunger[playerid]);
	PlayerTextDrawHide(playerid, HBEProgressThirst[playerid]);
	PlayerTextDrawHide(playerid, HBEProgressStress[playerid]);
}