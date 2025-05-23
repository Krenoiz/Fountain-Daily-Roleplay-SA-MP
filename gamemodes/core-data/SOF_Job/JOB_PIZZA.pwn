//======== Pizza ===========
new SedangAnterPizza[MAX_PLAYERS];

new PizzaVeh[4];

AddPizzaVehicle()
{
	PizzaVeh[0] = CreateVehicle(448, 2113.4700,-1784.5083,12.9872, 355.4538, 3, 3, VEHICLE_RESPAWN);
	PizzaVeh[1] = CreateVehicle(448, 2117.5247,-1784.9316,12.9872, 1.1392, 3, 3, VEHICLE_RESPAWN);
	PizzaVeh[2] = CreateVehicle(448, 2120.4673,-1784.8541,12.9858, 358.8643,3, 3, VEHICLE_RESPAWN);
	PizzaVeh[3] = CreateVehicle(448, 2123.2676,-1784.8853,12.9871, 356.8564,-3, 3, VEHICLE_RESPAWN);
}

IsAPizzaVeh(carid)
{
	for(new v = 0; v < sizeof(PizzaVeh); v++) {
	    if(carid == PizzaVeh[v]) return 1;
	}
	return 0;
}

CMD:getpizza(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(!IsPlayerInRangeOfPoint(playerid,3, 2108.7407,-1785.5049,13.3868)) return SendClientMessage(playerid, COLOR_RED, "ERROR: {FFFFFF}Kamu Tidak Di Tempat Ambil Pizza");
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAPizzaVeh(vehicleid)) return Error(playerid, "Anda harus mengendarai pizzaboy.");
	    if(SedangAnterPizza[playerid] == 1)
	        return Error(playerid, "Kamu sedang membawa pizza!");

	    if(pData[playerid][pPizzaTime] > 0)
		{
	    	Error(playerid, "Anda harus menunggu "YELLOW_E"%d "WHITE_E"detik lagi.", pData[playerid][pPizzaTime]);
	    	return 1;
		}

		new houseid = random(100);
		houseid += 25;
		SetPlayerCheckpoint(playerid, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ], 4.0);

		SendClientMessageEx(playerid,COLOR_GREEN,"PIZZA JOB: {FFFFFF}Pergi ke rumah no. %d (checkpoint ditandai di map)",houseid);
		SetPlayerAttachedObject(playerid, 1 , 2814, 1,0.11,0.36,0.0,0.0,90.0);
		SedangAnterPizza[playerid] =1;
		return 1;
	}
}
