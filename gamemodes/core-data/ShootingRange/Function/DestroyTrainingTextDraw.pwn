DestroyTrainingTextDraw(playerid)
{
	PlayerTextDrawHide(playerid, BoxTraining[playerid]);
	PlayerTextDrawDestroy(playerid, BoxTraining[playerid]);
	return 1;
}