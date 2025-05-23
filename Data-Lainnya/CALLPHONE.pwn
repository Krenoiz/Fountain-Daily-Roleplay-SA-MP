#define MAX_CALLPHONE 50

enum E_CALLPHONE
{
    //Save Database
    Float:ccPosX,
    Float:ccPosY,
    Float:ccPosZ,
    ccInterior,
    ccWorld,

    //Not Saving Database
    STREAMER_TAG_PICKUP:ccPickup,
    STREAMER_TAG_OBJECT:ccObjectID,
    STREAMER_TAG_3D_TEXT_LABEL:ccLabel
}
new CallPhone[MAX_CALLPHONE][E_CALLPHONE];
new Iterator:CallPhone<MAX_CALLPHONE>;

//------------------Stock In Here------------------//


GRP::LoadCallPhone()
{
    new rows;
	
	cache_get_row_count(rows);
 	if(rows)
  	{
		new bid, i = 0;
		while(i < rows)
		{
            cache_get_value_name_int(i, "ID", bid);
			cache_get_value_name_float(i, "posx", CallPhone[bid][ccPosX]);
			cache_get_value_name_float(i, "posy", CallPhone[bid][ccPosY]);
			cache_get_value_name_float(i, "posz", CallPhone[bid][ccPosZ]);
            cache_get_value_name_int(i, "interior", CallPhone[bid][ccInterior]);
            cache_get_value_name_int(i, "world", CallPhone[bid][ccWorld]);
			new tstr[219];
			format(tstr, sizeof(tstr), ""YELLOW_E"[ID: %d]\n"WHITE_E"Use '/payphone' for call", bid);
			CallPhone[bid][ccLabel] = CreateDynamic3DTextLabel(tstr, COLOR_WHITE, CallPhone[bid][ccPosX], CallPhone[bid][ccPosY], CallPhone[bid][ccPosZ]+0.3, 5.0);
        	//CallPhone[bid][ccObjectID] = CreateDynamicObject(1216, CallPhone[bid][ccPosX], CallPhone[bid][ccPosY], CallPhone[bid][ccPosZ], CallPhone[bid][ccPosRX], CallPhone[bid][ccPosRY], CallPhone[bid][ccPosRZ], CallPhone[bid][ccWorld], CallPhone[bid][ccInterior]);
        	CallPhone[bid][ccPickup] = CreateDynamicPickup(1239, 23, CallPhone[bid][ccPosX], CallPhone[bid][ccPosY], CallPhone[bid][ccPosZ]);
			Iter_Add(CallPhone, bid);
			i++;
		}
		printf("[MySQL Dynamic Payphone] Number of Loaded: %d.", i);
	}
}

Save_Payphone(id)
{
    new cQuery[518];
    format(cQuery, sizeof(cQuery), "UPDATE callphone SET posx='%f', posy='%f', posz='%f', interior='%d', world='%d' WHERE id='%d'",
    CallPhone[id][ccPosX], 
    CallPhone[id][ccPosY], 
    CallPhone[id][ccPosZ],
    CallPhone[id][ccInterior],
    CallPhone[id][ccWorld],
    id
    );
    return mysql_tquery(g_SQL, cQuery);
}

//----------------Function In Here----------------//


//----------------Command Public On Here----------------//
CMD:createphone(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
	
	new query[512], str[218];
	new phoneid = Iter_Free(CallPhone);

	if(phoneid == -1) return Error(playerid, "Can't add any more Park Point.");

    new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);

    CallPhone[phoneid][ccPosX] = x;
	CallPhone[phoneid][ccPosY] = y;
	CallPhone[phoneid][ccPosZ] = z;
	CallPhone[phoneid][ccInterior] = GetPlayerInterior(playerid);
	CallPhone[phoneid][ccWorld] = GetPlayerVirtualWorld(playerid);

	format(str, sizeof(str), ""YELLOW_E"[ID: %d]\n"WHITE_E"Use '/payphone' for call", phoneid);
	CallPhone[phoneid][ccLabel] = CreateDynamic3DTextLabel(str, COLOR_WHITE, CallPhone[phoneid][ccPosX], CallPhone[phoneid][ccPosY], CallPhone[phoneid][ccPosZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, CallPhone[phoneid][ccWorld], CallPhone[phoneid][ccInterior], -1, 10.0);
	//CallPhone[phoneid][ccObjectID] = CreateDynamicObject(1216, CallPhone[phoneid][ccPosX], CallPhone[phoneid][ccPosY], CallPhone[phoneid][ccPosZ]-0.3, CallPhone[phoneid][ccPosRX], CallPhone[phoneid][ccPosRY], CallPhone[phoneid][ccPosRZ], CallPhone[phoneid][ccWorld], CallPhone[phoneid][ccInterior]);
    CallPhone[phoneid][ccPickup] = CreateDynamicPickup(1239, 23, CallPhone[phoneid][ccPosX], CallPhone[phoneid][ccPosY], CallPhone[phoneid][ccPosZ]);

    //CallPhoneRefresh(phoneid);
	
    Iter_Add(CallPhone, phoneid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO callphone SET id='%d', posx='%f', posy='%f', posz='%f', interior='%d', world='%d'", phoneid, CallPhone[phoneid][ccPosX], CallPhone[phoneid][ccPosY], CallPhone[phoneid][ccPosZ], CallPhone[phoneid][ccInterior], CallPhone[phoneid][ccWorld]);
	mysql_tquery(g_SQL, query, "OnCallPhoneCreated", "i", phoneid);
	return 1;
}

GRP::OnCallPhoneCreated(playerid, id)
{
	Save_Payphone(id);
	Servers(playerid, "You has created Phone Point id: %d.", id);
	return 1;
}

CMD:gotophone(playerid, params[])
{
	new id;
	if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", id))
		return Usage(playerid, "/gotophone [id]");
	if(!Iter_Contains(CallPhone, id)) return Error(playerid, "That Phone ID is not exists");
	
	SetPlayerPos(playerid, CallPhone[id][ccPosX], CallPhone[id][ccPosY], CallPhone[id][ccPosZ]);
    SetPlayerInterior(playerid, CallPhone[id][ccInterior]);
    SetPlayerVirtualWorld(playerid, CallPhone[id][ccWorld]);
	Servers(playerid, "You has teleport to Phone ID %d", id);
	return 1;
}

CMD:deletephone(playerid, params[])
{
	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return Usage(playerid, "/deletephone [id]");
	if(!Iter_Contains(CallPhone, id)) return Error(playerid, "Invalid Phone ID.");

    //if(Call_BeingEdited(id)) return Error(playerid, "Can't remove specified phone because its being edited.");
	
	//DestroyDynamicObject(CallPhone[id][ccObjectID]);
	DestroyDynamic3DTextLabel(CallPhone[id][ccLabel]);
    DestroyDynamicPickup(CallPhone[id][ccPickup]);
	
	CallPhone[id][ccInterior] = CallPhone[id][ccWorld] = 0;
	//CallPhone[id][ccObjectID] = -1;
	CallPhone[id][ccLabel] = Text3D: -1;
    CallPhone[id][ccPickup] = -1;
	Iter_Remove(CallPhone, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM callphone WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	SendAdminMessage(COLOR_RED, "Admin %s has deleted Phone ID %d", pData[playerid][pAdminname], id);
	return 1;
}

CMD:editphone(playerid, params[])
{
    static
        did,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 7)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", did, type, string))
    {
        Usage(playerid, "/editphone [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location");
        return 1;
    }
    if((did < 0 || did > MAX_CALLPHONE))
        return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(CallPhone, did)) return Error(playerid, "The payphone you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, CallPhone[did][ccPosX], CallPhone[did][ccPosY], CallPhone[did][ccPosZ]);
		//GetPlayerFacingAngle(playerid, RentalData[did][rentalPosA]);
		DestroyDynamic3DTextLabel(CallPhone[did][ccLabel]);
    	DestroyDynamicPickup(CallPhone[did][ccPickup]);
		new tstr[218];
		format(tstr, sizeof(tstr), ""YELLOW_E"[ID: %d]\n"WHITE_E"Use '/payphone' for call", did);
		CallPhone[did][ccLabel] = CreateDynamic3DTextLabel(tstr, COLOR_WHITE, CallPhone[did][ccPosX], CallPhone[did][ccPosY], CallPhone[did][ccPosZ], 10.0);
    	CallPhone[did][ccPickup] = CreateDynamicPickup(1239, 23, CallPhone[did][ccPosX], CallPhone[did][ccPosY], CallPhone[did][ccPosZ]);
        Save_Payphone(did);

        SendAdminMessage(COLOR_RED, "%s Changes Location pHone ID: %d.", pData[playerid][pAdminname], did);
    }
    return 1;
}

CMD:payphone(playerid, params[])
{
	static
        ph;
	foreach(new wid : CallPhone)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, CallPhone[wid][ccPosX], CallPhone[wid][ccPosY], CallPhone[wid][ccPosZ]))
		{
			if(sscanf(params, "d", ph))
			{
				Usage(playerid, "/payphone [phone number] 955 - GoCar/Pedagang | 911 - SAPD Crime Call | 922 - SAMD Medic Call");
				foreach(new ii : Player)
				{	
					if(pData[ii][pMechDuty] == 1)
					{
						SendClientMessageEx(playerid, COLOR_GREEN, "Mekanik Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
					}
				}
				return 1;
			}
			if(ph == 911)
			{
				GivePlayerMoneyEx(playerid, -1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				Info(playerid, "You are making a payphone, the fee is deducted by $1.0");

				if(pData[playerid][pCallTime] >= gettime())
					return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
				
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				Info(playerid, "Warning: This number for emergency crime only! please wait for SAPD respon!");
				SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
			
				pData[playerid][pCallTime] = gettime() + 60;
			}
			if(ph == 922)
			{
				GivePlayerMoneyEx(playerid, -1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				Info(playerid, "You are making a payphone, the fee is deducted by $1.0");

				if(pData[playerid][pCallTime] >= gettime())
					return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
				
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				Info(playerid, "Warning: This number for emergency medical only! please wait for SAMD respon!");
				SendFactionMessage(3, COLOR_PINK2, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency medical! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
			
				pData[playerid][pCallTime] = gettime() + 60;
			}
			if(ph == pData[playerid][pPhone]) return Error(playerid, "Nomor sedang sibuk!");
			foreach(new ii : Player)
			{
				if(pData[ii][pPhone] == ph)
				{
					if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");

					// if(GetSignalNearest(ii) == 0)
					// 	return Error(playerid, "Nomor yang dituju sedang mengalami gangguan sinyal.");


					if(pData[ii][pCall] == INVALID_PLAYER_ID)
					{
						GivePlayerMoneyEx(playerid, -1);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
						Info(playerid, "You are making a payphone, the fee is deducted by $1.0");

						pData[playerid][pCall] = ii;
						
						SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
						SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE form %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
						PlayerPlaySound(playerid, 3600, 0,0,0);
						PlayerPlaySound(ii, 6003, 0,0,0);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
						SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
						return 1;
					}
					else
					{
						Error(playerid, "Nomor ini sedang sibuk.");
						return 1;
					}
				}
			}
		}
	}
	return 1;
}
