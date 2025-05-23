ShowLoginMenu(playerid, const type = 1)
{
    SetPVarInt(playerid, "OpenedLoginMenu", 1);

    for (new i = 0; i < 3; i++)
    {
        PlayerTextDrawShow(playerid, LoginTD[playerid][i]);
    }
    if (type == 1)
        PlayerTextDrawSetSelectable(playerid, LoginCharButton[playerid], 0);
    else
        PlayerTextDrawSetSelectable(playerid, LoginCharButton[playerid], 1);

    PlayerTextDrawShow(playerid, LoginCharButton[playerid]);

    for (new i = 3; i < 10; i++)
    {
        PlayerTextDrawShow(playerid, LoginTD[playerid][i]);
    }

    PlayerTextDrawShow(playerid, LoginMainButton[playerid]);

    PlayerTextDrawShow(playerid, LoginTD[playerid][10]);

    PlayerTextDrawShow(playerid, LoginCharacter[playerid]);

    new _UCP[MAX_PLAYER_NAME+1];
    format(_UCP, sizeof _UCP, "%s", pData[playerid][pUCP]);
    PlayerTextDrawSetString(playerid, LoginUCP[playerid], _UCP);   
    PlayerTextDrawShow(playerid, LoginUCP[playerid]);

    SelectTextDraw(playerid, 0xFFFF00FF);
}