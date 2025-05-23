DestroyRadialTextDraws(playerid)
{
    PlayerTextDrawDestroy(playerid, RadialCloseButton[playerid]);

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialButton[playerid][i]);
    }

    PlayerTextDrawDestroy(playerid, RadialCloseIcon[playerid]);

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialAccessoriesIcon[playerid][i]);
    }

    for(new i = 0; i < 5; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialPhoneIcon[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialInvIcon[playerid][i]);
    }

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialCardIcon[playerid][i]);
    }

    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialVehicleIcon[playerid][i]);
    }

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawDestroy(playerid, RadialActionIcon[playerid][i]);
    }
}