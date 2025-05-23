HidePhone(playerid)
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
    PlayerTextDrawHide(playerid, PhoneTDTime[playerid][0]);
    PlayerTextDrawHide(playerid, PhoneTDTime[playerid][1]);
    PlayerTextDrawHide(playerid, PhoneTDDate[playerid]);
    PlayerTextDrawHide(playerid, PhoneTDButton[playerid][0]);
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

	PlayerTextDrawHide(playerid, PhoneTD_CallRejectButton[playerid]);
	PlayerTextDrawHide(playerid, PhoneTD_CallRejectIcon[playerid]);
	PlayerTextDrawHide(playerid, PhoneTD_CallPickupButton[playerid]);
	PlayerTextDrawHide(playerid, PhoneTD_CallPickupIcon[playerid]);

    PlayerTextDrawHide(playerid, PhoneTD_CallCloseButton[playerid]);
    PlayerTextDrawHide(playerid, PhoneTD_CallCloseIcon[playerid]);
    PlayerTextDrawHide(playerid, PhoneTD_CallName[playerid]);
    PlayerTextDrawHide(playerid, PhoneTD_CallStatus[playerid]);

    DeletePVar(playerid, "PhoneTD");
    DeletePVar(playerid, "PhoneTD_Mainscreen");
    DeletePVar(playerid, "PhoneTD_Callingscreen");
    DeletePVar(playerid, "PhoneTD_IncomingCallscreen");

    CancelSelectTextDraw(playerid);

    return 1;
}