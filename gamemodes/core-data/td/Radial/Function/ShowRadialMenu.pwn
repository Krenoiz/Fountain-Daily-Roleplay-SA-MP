ShowRadialMenu(playerid)
{   
    SetPVarInt(playerid, "OpenedRadialMenu", 1);

    PlayerTextDrawShow(playerid, RadialCloseButton[playerid]);
    
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawShow(playerid, RadialButton[playerid][i]);
    }

    PlayerTextDrawShow(playerid, RadialCloseIcon[playerid]);

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawShow(playerid, RadialAccessoriesIcon[playerid][i]);
    }

    for(new i = 0; i < 5; i++)
    {
        PlayerTextDrawShow(playerid, RadialPhoneIcon[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawShow(playerid, RadialInvIcon[playerid][i]);
    }

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawShow(playerid, RadialCardIcon[playerid][i]);
    }

    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawShow(playerid, RadialVehicleIcon[playerid][i]);
    }

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawShow(playerid, RadialActionIcon[playerid][i]);
    }

    SelectTextDraw(playerid, 0xFFFF00FF);
}