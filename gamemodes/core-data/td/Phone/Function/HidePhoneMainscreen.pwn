HidePhoneMainscreen(playerid)
{
    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDBazzle[playerid][i]);
    }

    PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][1]);
    PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][0]);

    for(new i = 2; i < 9; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][i]);
    }

    PlayerTextDrawHide(playerid, PhoneTDDot[playerid]);
    PlayerTextDrawHide(playerid, PhoneTDTime[playerid][1]);
    PlayerTextDrawHide(playerid, PhoneTDDate[playerid]);
    PlayerTextDrawHide(playerid, PhoneTDButton[playerid][1]);

    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDApkButton[playerid][i]);
        PlayerTextDrawHide(playerid, PhoneTDApkText[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
	    PlayerTextDrawHide(playerid, PhoneTDMusicLogo[playerid][i]);
    }

	PlayerTextDrawHide(playerid, PhoneTDJobLogo[playerid]);

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDAdsLogo[playerid][i]);
    }

	PlayerTextDrawHide(playerid, PhoneTDBankLogo[playerid]);

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDTaxiLogo[playerid][i]);
    }

	PlayerTextDrawHide(playerid, PhoneTDAirDropLogo[playerid]);
	PlayerTextDrawHide(playerid, PhoneTDSettingsLogo[playerid]);

    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDMapsLogo[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDXLogo[playerid][i]);
    }

	PlayerTextDrawHide(playerid, PhoneTDContactsLogo[playerid]);

    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDCamLogo[playerid][i]);
    }

	PlayerTextDrawHide(playerid, PhoneTDCallLogo[playerid]);

    DeletePVar(playerid, "PhoneTD_Mainscreen");
}