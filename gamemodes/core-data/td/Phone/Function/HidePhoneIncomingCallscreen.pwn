HidePhoneIncomingCallscreen(playerid)
{
    if (GetPVarInt(playerid, "PhoneTD_Mainscreen"))
        HidePhoneMainscreen(playerid);
        
    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDBazzle[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawColor(playerid, PhoneTDScreen[playerid][i], CallBackground);
    }

    PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][1]);
    PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][0]);

    for(new i = 2; i < 9; i++)
    {
        PlayerTextDrawHide(playerid, PhoneTDScreen[playerid][i]);
    }

    PlayerTextDrawHide(playerid, PhoneTDDot[playerid]);

    PlayerTextDrawHide(playerid, PhoneTD_CallName[playerid]);
    PlayerTextDrawHide(playerid, PhoneTD_CallStatus[playerid]);

	PlayerTextDrawHide(playerid, PhoneTD_CallRejectButton[playerid]);
	PlayerTextDrawHide(playerid, PhoneTD_CallRejectIcon[playerid]);
	PlayerTextDrawHide(playerid, PhoneTD_CallPickupButton[playerid]);
	PlayerTextDrawHide(playerid, PhoneTD_CallPickupIcon[playerid]);

    DeletePVar(playerid, "PhoneTD_IncomingCallscreen");
}