CreateTrainingTextDraw(playerid)
{
	BoxTraining[playerid] = CreatePlayerTextDraw(playerid, 77.000000, 165.000000, "~b~Time Left~n~~w~02:51~n~~b~Point~n~~w~10");
	PlayerTextDrawFont(playerid, BoxTraining[playerid], 3);
	PlayerTextDrawLetterSize(playerid, BoxTraining[playerid], 0.500000, 1.700000);
	PlayerTextDrawTextSize(playerid, BoxTraining[playerid], 178.500000, 108.500000);
	PlayerTextDrawSetOutline(playerid, BoxTraining[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BoxTraining[playerid], 0);
	PlayerTextDrawAlignment(playerid, BoxTraining[playerid], 2);
	PlayerTextDrawColor(playerid, BoxTraining[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BoxTraining[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BoxTraining[playerid], 83);
	PlayerTextDrawUseBox(playerid, BoxTraining[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BoxTraining[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BoxTraining[playerid], 0);

	return 1;
}