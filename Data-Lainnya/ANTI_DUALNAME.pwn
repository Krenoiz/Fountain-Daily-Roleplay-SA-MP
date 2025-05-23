function CheckPlayerOnline(playerid)
{
	if(pData[playerid][pUCP] != 0)
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Accoun Informasi", "Akun ini sedang online", "", "Close");
		KickEx(playerid);
		pData[playerid][pUCP] = 1;
	}
	else
	{
		pData[playerid][pUCP] = 1;
	}
	return 1;
}
