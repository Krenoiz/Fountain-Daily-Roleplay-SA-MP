HideRadialMenu(playerid)
{   
    DeletePVar(playerid, "OpenedRadialMenu");

    PlayerTextDrawHide(playerid, RadialCloseButton[playerid]);
    
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, RadialButton[playerid][i]);
    }

    PlayerTextDrawHide(playerid, RadialCloseIcon[playerid]);

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawHide(playerid, RadialAccessoriesIcon[playerid][i]);
    }

    for(new i = 0; i < 5; i++)
    {
        PlayerTextDrawHide(playerid, RadialPhoneIcon[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawHide(playerid, RadialInvIcon[playerid][i]);
    }

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, RadialCardIcon[playerid][i]);
    }

    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawHide(playerid, RadialVehicleIcon[playerid][i]);
    }

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawHide(playerid, RadialActionIcon[playerid][i]);
    }

    CancelSelectTextDraw(playerid);
}