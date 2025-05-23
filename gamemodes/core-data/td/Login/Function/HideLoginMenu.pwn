HideLoginMenu(playerid)
{
    DeletePVar(playerid, "OpenedLoginMenu");

    for (new i = 0; i < 3; i++)
    {
        PlayerTextDrawHide(playerid, LoginTD[playerid][i]);
    }

    PlayerTextDrawHide(playerid, LoginCharButton[playerid]);

    for (new i = 3; i < 10; i++)
    {
        PlayerTextDrawHide(playerid, LoginTD[playerid][i]);
    }

    PlayerTextDrawHide(playerid, LoginMainButton[playerid]);

    PlayerTextDrawHide(playerid, LoginTD[playerid][10]);

    PlayerTextDrawHide(playerid, LoginCharacter[playerid]);
    PlayerTextDrawHide(playerid, LoginUCP[playerid]);
    CancelSelectTextDraw(playerid);
}