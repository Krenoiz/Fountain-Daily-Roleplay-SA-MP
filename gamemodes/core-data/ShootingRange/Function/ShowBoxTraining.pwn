ShowBoxTraining(playerid, const message[])
{
	if(IsPlayerConnected(playerid))
	{
		PlayerTextDrawSetString(playerid, BoxTraining[playerid], message);
        PlayerTextDrawShow(playerid, BoxTraining[playerid]);
	}
	return 1;
}