DestroyPhoneTextDraws(playerid)
{
    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDBazzle[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDScreen[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, PhoneTDDot[playerid]);

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDTime[playerid][i]);
        PlayerTextDrawDestroy(playerid, PhoneTDButton[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, PhoneTDDate[playerid]);

    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDApkButton[playerid][i]);
        PlayerTextDrawDestroy(playerid, PhoneTDApkText[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDMusicLogo[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, PhoneTDJobLogo[playerid]);

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDAdsLogo[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDTaxiLogo[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, PhoneTDBankLogo[playerid]);

	PlayerTextDrawDestroy(playerid, PhoneTDAirDropLogo[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTDSettingsLogo[playerid]);

    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDMapsLogo[playerid][i]);
    }

    for(new i = 0; i < 2; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDXLogo[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, PhoneTDContactsLogo[playerid]);

    for(new i = 0; i < 3; i++)
    {
        PlayerTextDrawDestroy(playerid, PhoneTDCamLogo[playerid][i]);
    }

	PlayerTextDrawDestroy(playerid, PhoneTDCallLogo[playerid]);

    // Call screen
	PlayerTextDrawDestroy(playerid, PhoneTD_CallCloseButton[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTD_CallCloseIcon[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTD_CallName[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTD_CallStatus[playerid]);

	PlayerTextDrawDestroy(playerid, PhoneTD_CallRejectButton[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTD_CallRejectIcon[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTD_CallPickupButton[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTD_CallPickupIcon[playerid]);
}