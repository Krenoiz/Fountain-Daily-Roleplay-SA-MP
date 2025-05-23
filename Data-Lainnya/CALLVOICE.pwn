#define MAX_CALL 50

enum Calls
{	
	Float:callX,
	Float:callY,
	Float:callZ,
	Float:callA,

	callWorld,
	callObject,
	Text3D:callText
};

new CallData[MAX_CALL][Calls],
	Iterator:Calls<MAX_CALL>;

Callvoice_Save(cid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE callvoice SET posx = '%f', posy = '%f', posz = '%f', posa = '%f' WHERE ID = '%d'",
	CallData[cid][callX],
	CallData[cid][callY],
	CallData[cid][callZ],
    CallData[cid][callA],
	cid
	);
	return mysql_tquery(g_SQL, cQuery);
}

function OnCAllVoiceCreated(playerid, cid)
{
	Callvoice_Save(cid);
	Servers(playerid, "call [%d] berhasil di buat!", cid);
	new str[150];
	format(str,sizeof(str),"[call] %s membuat call id %d!", GetRPName(playerid), cid);
	LogServer("Admin", str);
}


function Loadcallvoice()
{
    static cid;

    new rows = cache_num_rows();
	if(rows)
	{
	    for(new i; i < rows; i++)
	    {
	    	cache_get_value_name_int(i, "ID", cid);
	    	cache_get_value_name_float(i, "posx", CallData[cid][callX]);
			cache_get_value_name_float(i, "posy", CallData[cid][callY]);
			cache_get_value_name_float(i, "posz", CallData[cid][callZ]);
			cache_get_value_name_float(i, "posa", CallData[cid][callA]);

			Iter_Add(Calls, cid);
			Calls_RefreshObject(cid);
			Calls_RefreshText(cid);
		}
		printf("[CALLVOICE] %d Loaded.", rows);
	}
}

Calls_RefreshText(cid)
{
	if(cid != -1)
	{		
		if(IsValidDynamic3DTextLabel(CallData[cid][callText]))
            DestroyDynamic3DTextLabel(CallData[cid][callText]);
		
		new tstr[218];
		if(CallData[cid][callX] != 0 && CallData[cid][callY] != 0 && CallData[cid][callZ] != 0)
		{
			format(tstr, sizeof(tstr), "[ID: %d]\n/telpon", cid);
			CallData[cid][callText] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, CallData[cid][callX], CallData[cid][callY], CallData[cid][callZ]+1.0, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, CallData[cid][callWorld], -1, -1, 10.0);
		}
	}
}

Calls_RefreshObject(cid)
{
	if(cid != -1)
	{		
		if(IsValidDynamicObject(CallData[cid][callObject]))
			DestroyDynamicObject(CallData[cid][callObject]);

		//CallData[cid][callObject] = CreateDynamicObject(1216, CallData[cid][callX], CallData[cid][callY], CallData[cid][callZ], CallData[cid][callWorld], -1);
	}
}
