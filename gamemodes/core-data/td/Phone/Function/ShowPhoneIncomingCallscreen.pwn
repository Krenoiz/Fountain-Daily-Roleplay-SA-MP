ShowPhoneIncomingCallscreen(playerid)
{
    RemovePlayerAttachedObject(playerid, 9);
    HidePhoneLockscreen(playerid);
    HidePhoneMainscreen(playerid);
    HidePhoneCallingscreen(playerid);

    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDBazzle[playerid][i]);
    }

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawColor(playerid, PhoneTDScreen[playerid][i], CallBackground);
    }

    PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][1]);
    PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][0]);

    for(new i = 2; i < 9; i++)
    {
        PlayerTextDrawShow(playerid, PhoneTDScreen[playerid][i]);
    }

    PlayerTextDrawShow(playerid, PhoneTDDot[playerid]);

    PlayerTextDrawShow(playerid, PhoneTD_CallName[playerid]);
    PlayerTextDrawShow(playerid, PhoneTD_CallStatus[playerid]);

	PlayerTextDrawShow(playerid, PhoneTD_CallRejectButton[playerid]);
	PlayerTextDrawShow(playerid, PhoneTD_CallRejectIcon[playerid]);
	PlayerTextDrawShow(playerid, PhoneTD_CallPickupButton[playerid]);
	PlayerTextDrawShow(playerid, PhoneTD_CallPickupIcon[playerid]);

    SetPVarInt(playerid, "JustOpenedPhone", 3);
    SetPVarInt(playerid, "PhoneTD", 1);
    SetPVarInt(playerid, "PhoneTD_IncomingCallscreen", 1);

    CancelSelectTextDraw(playerid);
}