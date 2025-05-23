ShowPhoneMainscreen(playerid)
{
    HidePhoneLockscreen(playerid);

    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDBazzle[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawColor(playerid, PhoneTDScreen[playerid][i], DefaultBackground);
    }

    PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][1]);
    PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][0]);

    for(new i = 2; i < 9; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][i]);
    }

    PlayerTextDrawShow(playerid, PhoneTDDot[playerid]);
    PlayerTextDrawShow(playerid, PhoneTDTime[playerid][1]);
    PlayerTextDrawShow(playerid, PhoneTDButton[playerid][1]);

    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDApkButton[playerid][i]);
        PlayerTextDrawShow(playerid, PhoneTDApkText[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
	    PlayerTextDrawShow(playerid, PhoneTDMusicLogo[playerid][i]);
    }

	PlayerTextDrawShow(playerid, PhoneTDJobLogo[playerid]);

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDAdsLogo[playerid][i]);
    }

	PlayerTextDrawShow(playerid, PhoneTDBankLogo[playerid]);

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDTaxiLogo[playerid][i]);
    }

	PlayerTextDrawShow(playerid, PhoneTDAirDropLogo[playerid]);
	PlayerTextDrawShow(playerid, PhoneTDSettingsLogo[playerid]);

    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDMapsLogo[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDXLogo[playerid][i]);
    }

	PlayerTextDrawShow(playerid, PhoneTDContactsLogo[playerid]);

    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDCamLogo[playerid][i]);
    }

	PlayerTextDrawShow(playerid, PhoneTDCallLogo[playerid]);

    SetPVarInt(playerid, "PhoneTD_Mainscreen", 1);
}