#define COLOR_LOGS 0xC6E2FFFF

new taked = 0;
new pCPPacket = INVALID_PLAYER_ID;
new CheckpointPacket[MAX_PLAYERS] = 0;
new packet = 1;
new CheckpointLast[MAX_PLAYERS] = 0;
new objectpacket;

CreateJoinSmugglerPoint()
{
	new strings[128];
	CreateDynamicPickup(1239, 23, 1273.66, 392.261, 19.8547, -1);
	format(strings, sizeof(strings), "[DRUG SMUGGLER]\n"RED_E"Ilegal Jobs\n{FFFFFF}/getjob to join");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1273.66, 392.261, 19.8547, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // truck
}

CMD:findpacket(playerid, params[])
{
	if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
	{
		if(pData[playerid][pPacket] == 1) return Error(playerid, "You already take the packet");
		if(pCPPacket == playerid) return Error(playerid, "You are the taker!");

		//if(IsAtJob(playerid)) return Error(playerid, "Harap selesaikan Tugas mu untuk ke Checkpoint terlebih dahulu");
	
		if(packet == 0)
		{
			SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}There is no packet");
		}
		if(packet == 1 && taked == 0)
		{
			CheckpointPacket[playerid] = 1;
        	new Float:X, Float:Y, Float:Z;
        	GetDynamicObjectPos(objectpacket, X, Y, Z);
        	SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, X, Y, Z, 5.0);
        	SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Target is "GREEN_E"Standing Still.");
		}
		if(packet == 2 && taked == 0)
		{
	    	CheckpointPacket[playerid] = 1;
        	new Float:X, Float:Y, Float:Z;
        	GetDynamicObjectPos(objectpacket, X, Y, Z);
        	SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, X, Y, Z, 5.0);
        	SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Target is "GREEN_E"Standing Still.");
		}
		if(taked == 1)
		{
	    	new Float:X, Float:Y, Float:Z;
	    	CheckpointPacket[playerid] = 1;
	    	GetPlayerPos(pCPPacket, X, Y, Z);
	    	SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, X, Y, Z, 5.0);
			SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Target is "RED_E"Moving.");
		}
	}
	else return Error(playerid, "You are not Smuggler Jobs.");
	return 1;
}
CMD:atrack(playerid)
{
    if(pData[playerid][pAdmin] < 5) return PermissionError(playerid);
	{
		if(pData[playerid][pPacket] == 1) return Error(playerid, "You already take the packet");
		if(pCPPacket == playerid) return Error(playerid, "You are the taker!");

		//if(IsAtJob(playerid)) return Error(playerid, "Harap selesaikan Tugas mu untuk ke Checkpoint terlebih dahulu");
	
		if(packet == 0)
		{
			SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}There is no packet");
		}
		if(packet == 1 && taked == 0)
		{
			CheckpointPacket[playerid] = 1;
        	new Float:X, Float:Y, Float:Z;
        	GetDynamicObjectPos(objectpacket, X, Y, Z);
        	SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, X, Y, Z, 5.0);
        	SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Target is "GREEN_E"Standing Still.");
		}
		if(packet == 2 && taked == 0)
		{
	    	CheckpointPacket[playerid] = 1;
        	new Float:X, Float:Y, Float:Z;
        	GetDynamicObjectPos(objectpacket, X, Y, Z);
        	SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, X, Y, Z, 5.0);
        	SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Target is "GREEN_E"Standing Still.");
		}
		if(taked == 1)
		{
	    	new Float:X, Float:Y, Float:Z;
	    	CheckpointPacket[playerid] = 1;
	    	GetPlayerPos(pCPPacket, X, Y, Z);
	    	SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, X, Y, Z, 5.0);
			SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Target is "RED_E"Moving.");
		}
	}
	return 1;
}
CMD:takepacket(playerid, params[])
{
    if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
	{
    	new Float:X, Float:Y, Float:Z;
    	GetDynamicObjectPos(objectpacket, X, Y, Z);
    	if(!IsPlayerInRangeOfPoint(playerid, 15.0, X, Y, Z)) return Error(playerid, "There are no packets near you");
    
    	if(pData[playerid][pPacket] == 1) return Error(playerid, "You already take a packet");
    
    	pData[playerid][pPacket]++;
    	TogglePlayerControllable(playerid, 0);
		SetPlayerAttachedObject(playerid, 3, 11745, 6, 0.129999, 0.051000, 0.000000, 103.700004, -64.600059, 0.000000, 0.501999, 1.0, 1.0);
		pData[playerid][pActivity] = SetTimerEx("TakePacket", 400, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengambil Packet...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	}
	else return Error(playerid, "You are not Smuggler Jobs.");
	return 1;
}

CMD:enablecp(playerid, params[])
{
    if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
	{
    	if(pData[playerid][pPacket] == 0) return Error(playerid, "You must have a packet");
    
    	DisablePlayerRaceCheckpoint(playerid);
		CheckpointLast[playerid] = 1;
		SetPlayerRaceCheckpoint(playerid, 1, 1568.997192, 30.751678, 24.164062, 1568.997192, 30.751678, 24.164062, 5.0);
 		SendClientMessage(playerid, COLOR_RIKO, "GPS: {FFFFFF}Checkpoint enabled");
 	}
	else return Error(playerid, "You are not Smuggler Jobs.");
	return 1;
}

CMD:droppacket(playerid, params[])
{
	if(pData[playerid][pPacket] == 1)
	{
	    taked = 0;
		RemovePlayerAttachedObject(playerid, 3);
        DisablePlayerRaceCheckpoint(playerid);
        CheckpointLast[playerid] = 0;
        pData[playerid][pPacket]--;
        pCPPacket = INVALID_PLAYER_ID;
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        objectpacket = CreateDynamicObject(11745, X, Y, Z-1, 0.0, 0.0, 0.0, 0);
	}
	else Error(playerid, "You didnt have a packet");
	return 1;
}

function TakePacket(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 5;
			TogglePlayerControllable(playerid, 1);
			InfoTD_MSG(playerid, 8000, "Packet Taked!");
			CheckpointLast[playerid] = 1;
			SendClientMessage(playerid, COLOR_RIKO, "SMUGGLER: {FFFFFF}You have taked the packet go to the checkpoint");
			SetPlayerRaceCheckpoint(playerid, 1, 860.8442,-17.8314,63.2484, 860.8442,-17.8314,63.2484, 5.0);
			taked = 1;
			pCPPacket = playerid;
			DestroyDynamicObject(objectpacket);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
