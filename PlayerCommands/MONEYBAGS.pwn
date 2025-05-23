stock DeleteClosestBag(playerid)
{
    for(new i = 0; i < sizeof(MoneyInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 4.0, MoneyInfo[i][mbX], MoneyInfo[i][mbY], MoneyInfo[i][mbZ]))
        {
  	        if(MoneyInfo[i][mCreated] == 1)
            {
                new sendername[MAX_PLAYER_NAME];
                new string[128];
                new location[MAX_ZONE_NAME];
                GetPlayerName(playerid, sendername, sizeof(sendername));
				GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
                format(string, sizeof(string), "INFO: %s has destroyed a money bag in %s (%0.2f, %0.2f, %0.2f).", sendername, location, MoneyInfo[i][mbX], MoneyInfo[i][mbY], MoneyInfo[i][mbZ]);
	            SendClientMessageToAll(COLOR_LIGHTRED, string);
                MoneyInfo[i][mCreated]=0;
            	MoneyInfo[i][mbX]=0.0;
            	MoneyInfo[i][mbY]=0.0;
            	MoneyInfo[i][mbZ]=0.0;
            	MoneyInfo[i][mAmount] = 0;
            	MoneyInfo[i][mMoneybag] = 0;
            	DestroyDynamicPickup(MoneyInfo[i][mPickup]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

stock DeleteAllBags()
{
    for(new i = 0; i < sizeof(MoneyInfo); i++)
  	{
  	    if(MoneyInfo[i][mCreated] == 1)
  	    {
  	        MoneyInfo[i][mCreated]=0;
            MoneyInfo[i][mbX]=0.0;
            MoneyInfo[i][mbY]=0.0;
            MoneyInfo[i][mbZ]=0.0;
            MoneyInfo[i][mAmount] = 0;
            MoneyInfo[i][mMoneybag] = 0;
            DestroyDynamicPickup(MoneyInfo[i][mPickup]);
  	    }
	}
    return 0;
}


stock CreateMoney(Float:x,Float:y,Float:z,amount) 
{
    for(new i = 0; i < sizeof(MoneyInfo); i++)
  	{
  	    if(MoneyInfo[i][mCreated] == 0)
  	    {
            MoneyInfo[i][mCreated]=1;
            MoneyInfo[i][mbX]=x;
            MoneyInfo[i][mbY]=y;
            MoneyInfo[i][mbZ]=z;
            MoneyInfo[i][mPickup] = CreateDynamicPickup(1550, 23, x, y, z);
			MoneyInfo[i][mAmount] = amount;
			MoneyInfo[i][mMoneybag] = 1;
			return 1;
  	    }
  	}
  	return 0;
}
stock SetPlayerPosEx(playerid, Float:posx, Float:posy, Float:posz)
{
	Streamer_UpdateEx(playerid, posx, posy, posz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	SetPlayerPos(playerid, posx, posy, posz);
	warped[playerid] = 2;
	return 1;
}



CMD:cariuang(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 7)
        return SendClientMessage(playerid, COLOR_GREY, "You don't have permission to use this command.");

    new amount;
    if(strlen(params) == 0 || sscanf(params, "%d", amount) > 1) 
    {
        return SendClientMessage(playerid, COLOR_GREY, "Usage: /cariuang [amount]");
    }

    if(amount < 1)
        return SendClientMessage(playerid, COLOR_GREY, "Cannot create a money bag with less than $1.");

    new Float:X, Float:Y, Float:Z;
    new location[MAX_ZONE_NAME];

    GetPlayerPos(playerid, X, Y, Z);
    CreateMoney(X, Y, Z, amount);

    if(!IsPlayerInAnyVehicle(playerid))
        SetPlayerPosEx(playerid, X, Y - 2.0, Z);

    SendStaffMessage(COLOR_LIGHTRED, "%s Money bag created", pData[playerid][pAdminname]);

    GetPlayer2DZone(playerid, location, sizeof(location));

    SendClientMessageToAllEx(COLOR_LIGHTRED, "[FIND NOW]: %s has hidden a money bag in %s worth {ffff00}$%d.", pData[playerid][pAdminname], location, amount);
    return 1;
}


CMD:deluang(playerid, params[])
{
    if(pData[playerid][pAdmin] < 7)
        return Error(playerid, "You don't have permission to use this command.");

    DeleteClosestBag(playerid); 
    return 1;
}

CMD:deluangs(playerid, params[])
{
    if(pData[playerid][pAdmin] < 7)
        return Error(playerid, "You don't have permission to use this command.");

    DeleteAllBags(); 
    SendStaffMessage(COLOR_LIGHTRED, "* Money bags destroyed."); 

    new pAdminName[MAX_PLAYER_NAME], string[256];

    GetPlayerName(playerid, pAdminName, sizeof(pAdminName));

    format(string, sizeof(string), "INFO: %s has destroyed all money bags.", pAdminName);
    SendClientMessageToAll(COLOR_LIGHTRED, string);

    return 1;
}