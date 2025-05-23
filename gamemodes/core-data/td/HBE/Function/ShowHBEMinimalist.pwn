ShowHBEMinimalist(playerid)
{
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawShow(playerid, HBE[playerid][i]);
    }

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawShow(playerid, HBEIconHunger[playerid][i]);
        PlayerTextDrawShow(playerid, HBEIconThirst[playerid][i]);
        PlayerTextDrawShow(playerid, HBEIconStress[playerid][i]);
    }
    new
			_pHunger,
			_pEnergy,
			_pBladder;

    _pHunger = pData[playerid][pHunger];
    _pEnergy = pData[playerid][pEnergy];
    _pBladder = pData[playerid][pBladder];

    PlayerTextDrawTextSize(playerid, HBEProgressHunger[playerid], ((_pHunger > 100) ? 100 : _pHunger) * 0.41, 13.000000);
    PlayerTextDrawTextSize(playerid, HBEProgressThirst[playerid], ((_pEnergy > 100) ? 100 : _pEnergy) * 0.41, 13.000000);
    PlayerTextDrawTextSize(playerid, HBEProgressStress[playerid], ((_pBladder > 100) ? 100 : _pBladder) * 0.41, 13.000000);

	PlayerTextDrawShow(playerid, HBEProgressHunger[playerid]);
	PlayerTextDrawShow(playerid, HBEProgressThirst[playerid]);
	PlayerTextDrawShow(playerid, HBEProgressStress[playerid]);
}