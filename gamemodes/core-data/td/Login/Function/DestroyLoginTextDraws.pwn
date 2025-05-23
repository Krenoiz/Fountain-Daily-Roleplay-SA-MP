DestroyLoginTextDraws(playerid)
{
    for(new i = 0; i < 11; i++)
    {
        PlayerTextDrawDestroy(playerid, LoginTD[playerid][i]);
    }
	PlayerTextDrawDestroy(playerid, LoginCharButton[playerid]);
	PlayerTextDrawDestroy(playerid, LoginMainButton[playerid]);
	PlayerTextDrawDestroy(playerid, LoginCharacter[playerid]);
	PlayerTextDrawDestroy(playerid, LoginUCP[playerid]);
}