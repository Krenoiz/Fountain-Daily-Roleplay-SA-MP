// Vehicle attach update types
const FloatX =  1;
const FloatY =  2;
const FloatZ =  3;
const FloatRX = 4;
const FloatRY = 5;
const FloatRZ = 6;

new Float:NudgeVal[MAX_PLAYERS];

MySQL_LoadVehicleToys(vehicleid)
{
	new tstr[512];
	mysql_format(g_SQL, tstr, sizeof(tstr), "SELECT * FROM vtoys WHERE Owner='%d' LIMIT 1", pvData[vehicleid][cID]);
	mysql_tquery(g_SQL, tstr, "LoadVehicleToys", "i", vehicleid);
}

function LoadVehicleToys(vehicleid)
{
	new rows = cache_num_rows(), vehid = pvData[vehicleid][cVeh];
 	if(rows)
  	{
		pvData[vehid][PurchasedvToy] = true;
		cache_get_value_name_int(0, "Slot0_Modelid", vtData[vehid][0][vtoy_modelid]);
  		cache_get_value_name_float(0, "Slot0_XPos", vtData[vehid][0][vtoy_x]);
  		cache_get_value_name_float(0, "Slot0_YPos", vtData[vehid][0][vtoy_y]);
  		cache_get_value_name_float(0, "Slot0_ZPos", vtData[vehid][0][vtoy_z]);
  		cache_get_value_name_float(0, "Slot0_XRot", vtData[vehid][0][vtoy_rx]);
  		cache_get_value_name_float(0, "Slot0_YRot", vtData[vehid][0][vtoy_ry]);
  		cache_get_value_name_float(0, "Slot0_ZRot", vtData[vehid][0][vtoy_rz]);

		cache_get_value_name_int(0, "Slot1_Modelid", vtData[vehid][1][vtoy_modelid]);
  		cache_get_value_name_float(0, "Slot1_XPos", vtData[vehid][1][vtoy_x]);
  		cache_get_value_name_float(0, "Slot1_YPos", vtData[vehid][1][vtoy_y]);
  		cache_get_value_name_float(0, "Slot1_ZPos", vtData[vehid][1][vtoy_z]);
  		cache_get_value_name_float(0, "Slot1_XRot", vtData[vehid][1][vtoy_rx]);
  		cache_get_value_name_float(0, "Slot1_YRot", vtData[vehid][1][vtoy_ry]);
  		cache_get_value_name_float(0, "Slot1_ZRot", vtData[vehid][1][vtoy_rz]);
		
		cache_get_value_name_int(0, "Slot2_Modelid", vtData[vehid][2][vtoy_modelid]);
  		cache_get_value_name_float(0, "Slot2_XPos", vtData[vehid][2][vtoy_x]);
  		cache_get_value_name_float(0, "Slot2_YPos", vtData[vehid][2][vtoy_y]);
  		cache_get_value_name_float(0, "Slot2_ZPos", vtData[vehid][2][vtoy_z]);
  		cache_get_value_name_float(0, "Slot2_XRot", vtData[vehid][2][vtoy_rx]);
  		cache_get_value_name_float(0, "Slot2_YRot", vtData[vehid][2][vtoy_ry]);
  		cache_get_value_name_float(0, "Slot2_ZRot", vtData[vehid][2][vtoy_rz]);
		
		cache_get_value_name_int(0, "Slot3_Modelid", vtData[vehid][3][vtoy_modelid]);
  		cache_get_value_name_float(0, "Slot3_XPos", vtData[vehid][3][vtoy_x]);
  		cache_get_value_name_float(0, "Slot3_YPos", vtData[vehid][3][vtoy_y]);
  		cache_get_value_name_float(0, "Slot3_ZPos", vtData[vehid][3][vtoy_z]);
  		cache_get_value_name_float(0, "Slot3_XRot", vtData[vehid][3][vtoy_rx]);
  		cache_get_value_name_float(0, "Slot3_YRot", vtData[vehid][3][vtoy_ry]);
  		cache_get_value_name_float(0, "Slot3_ZRot", vtData[vehid][3][vtoy_rz]);

		AttachVehicleToys(vehid);
	}
}

MySQL_SaveVehicleToys(vehicleid)
{
	new line4[1600], lstr[1024], x = pvData[vehicleid][cVeh];

	//if(pvData[x][PurchasedvToy] == false) return true;

	mysql_format(g_SQL, lstr, sizeof(lstr),
	"UPDATE `vtoys` SET \
	`Slot0_Modelid` = %d, `Slot0_XPos` = %.3f, `Slot0_YPos` = %.3f, `Slot0_ZPos` = %.3f, `Slot0_XRot` = %.3f, `Slot0_YRot` = %.3f, `Slot0_ZRot` = %.3f,",
		vtData[x][0][vtoy_modelid],
        vtData[x][0][vtoy_x],
        vtData[x][0][vtoy_y],
        vtData[x][0][vtoy_z],
        vtData[x][0][vtoy_rx],
        vtData[x][0][vtoy_ry],
        vtData[x][0][vtoy_rz]);
	strcat(line4, lstr);

	mysql_format(g_SQL, lstr, sizeof(lstr),
	" `Slot1_Modelid` = %d, `Slot1_XPos` = %.3f, `Slot1_YPos` = %.3f, `Slot1_ZPos` = %.3f, `Slot1_XRot` = %.3f, `Slot1_YRot` = %.3f, `Slot1_ZRot` = %.3f,",
		vtData[x][1][vtoy_modelid],
        vtData[x][1][vtoy_x],
        vtData[x][1][vtoy_y],
        vtData[x][1][vtoy_z],
        vtData[x][1][vtoy_rx],
        vtData[x][1][vtoy_ry],
        vtData[x][1][vtoy_rz]);
  	strcat(line4, lstr);

    mysql_format(g_SQL, lstr, sizeof(lstr),
	" `Slot2_Modelid` = %d, `Slot2_XPos` = %.3f, `Slot2_YPos` = %.3f, `Slot2_ZPos` = %.3f, `Slot2_XRot` = %.3f, `Slot2_YRot` = %.3f, `Slot2_ZRot` = %.3f,",
		vtData[x][2][vtoy_modelid],
	    vtData[x][2][vtoy_x],
	    vtData[x][2][vtoy_y],
	    vtData[x][2][vtoy_z],
	    vtData[x][2][vtoy_rx],
	    vtData[x][2][vtoy_ry],
	    vtData[x][2][vtoy_rz]);
  	strcat(line4, lstr);

    mysql_format(g_SQL, lstr, sizeof(lstr),
	" `Slot3_Modelid` = %d, `Slot3_XPos` = %.3f, `Slot3_YPos` = %.3f, `Slot3_ZPos` = %.3f, `Slot3_XRot` = %.3f, `Slot3_YRot` = %.3f, `Slot3_ZRot` = %.3f WHERE `Owner` = '%d'",
		vtData[x][3][vtoy_modelid],
	    vtData[x][3][vtoy_x],
	    vtData[x][3][vtoy_y],
	    vtData[x][3][vtoy_z],
	    vtData[x][3][vtoy_rx],
	    vtData[x][3][vtoy_ry],
	    vtData[x][3][vtoy_rz],
	    pvData[vehicleid][cID]);
  	strcat(line4, lstr);

    mysql_tquery(g_SQL, line4);
    return 1;
}

MySQL_CreateVehicleToy(vehicleid)
{
	new query[512];

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `vtoys` (`Owner`) VALUES ('%d')", pvData[vehicleid][cID]);
	mysql_tquery(g_SQL, query);
	pvData[vehicleid][PurchasedvToy] = true;

	for(new i = 0; i < 4; i++)
	{
		vtData[vehicleid][i][vtoy_modelid] = 0;
		vtData[vehicleid][i][vtoy_x] = 0.0;
		vtData[vehicleid][i][vtoy_y] = 0.0;
		vtData[vehicleid][i][vtoy_z] = 0.0;
		vtData[vehicleid][i][vtoy_rx] = 0.0;
		vtData[vehicleid][i][vtoy_ry] = 0.0;
		vtData[vehicleid][i][vtoy_rz] = 0.0;
	}
}

AttachVehicleToys(vehicleid)
{
	if(pvData[vehicleid][PurchasedvToy] == false) return 1;

	if(vtData[vehicleid][0][vtoy_model] == 0)
	{
		vtData[vehicleid][0][vtoy_model] = CreateDynamicObject(vtData[vehicleid][0][vtoy_modelid],
 	 	vtData[vehicleid][0][vtoy_x],
		vtData[vehicleid][0][vtoy_y],
		vtData[vehicleid][0][vtoy_z],
		vtData[vehicleid][0][vtoy_rx],
		vtData[vehicleid][0][vtoy_ry],
		vtData[vehicleid][0][vtoy_rz]);

		AttachDynamicObjectToVehicle(vtData[vehicleid][0][vtoy_model],
		vehicleid,
		vtData[vehicleid][0][vtoy_x],
		vtData[vehicleid][0][vtoy_y],
		vtData[vehicleid][0][vtoy_z],
		vtData[vehicleid][0][vtoy_rx],
		vtData[vehicleid][0][vtoy_ry],
		vtData[vehicleid][0][vtoy_rz]);
	}
	if(vtData[vehicleid][1][vtoy_model] == 0)
	{
		vtData[vehicleid][1][vtoy_model] = CreateDynamicObject(vtData[vehicleid][1][vtoy_modelid],
 	 	vtData[vehicleid][1][vtoy_x],
		vtData[vehicleid][1][vtoy_y],
		vtData[vehicleid][1][vtoy_z],
		vtData[vehicleid][1][vtoy_rx],
		vtData[vehicleid][1][vtoy_ry],
		vtData[vehicleid][1][vtoy_rz]);

		AttachDynamicObjectToVehicle(vtData[vehicleid][1][vtoy_model],
		vehicleid,
		vtData[vehicleid][1][vtoy_x],
		vtData[vehicleid][1][vtoy_y],
		vtData[vehicleid][1][vtoy_z],
		vtData[vehicleid][1][vtoy_rx],
		vtData[vehicleid][1][vtoy_ry],
		vtData[vehicleid][1][vtoy_rz]);
	}
	if(vtData[vehicleid][2][vtoy_model] == 0)
	{
		vtData[vehicleid][2][vtoy_model] = CreateDynamicObject(vtData[vehicleid][2][vtoy_modelid],
 	 	vtData[vehicleid][2][vtoy_x],
		vtData[vehicleid][2][vtoy_y],
		vtData[vehicleid][2][vtoy_z],
		vtData[vehicleid][2][vtoy_rx],
		vtData[vehicleid][2][vtoy_ry],
		vtData[vehicleid][2][vtoy_rz]);

		AttachDynamicObjectToVehicle(vtData[vehicleid][2][vtoy_model],
		vehicleid,
		vtData[vehicleid][2][vtoy_x],
		vtData[vehicleid][2][vtoy_y],
		vtData[vehicleid][2][vtoy_z],
		vtData[vehicleid][2][vtoy_rx],
		vtData[vehicleid][2][vtoy_ry],
		vtData[vehicleid][2][vtoy_rz]);
	}
	if(vtData[vehicleid][3][vtoy_model] == 0)
	{
		vtData[vehicleid][3][vtoy_model] = CreateDynamicObject(vtData[vehicleid][3][vtoy_modelid],
 	 	vtData[vehicleid][3][vtoy_x],
		vtData[vehicleid][3][vtoy_y],
		vtData[vehicleid][3][vtoy_z],
		vtData[vehicleid][3][vtoy_rx],
		vtData[vehicleid][3][vtoy_ry],
		vtData[vehicleid][3][vtoy_rz]);

		AttachDynamicObjectToVehicle(vtData[vehicleid][3][vtoy_model],
		vehicleid,
		vtData[vehicleid][3][vtoy_x],
		vtData[vehicleid][3][vtoy_y],
		vtData[vehicleid][3][vtoy_z],
		vtData[vehicleid][3][vtoy_rx],
		vtData[vehicleid][3][vtoy_ry],
		vtData[vehicleid][3][vtoy_rz]);
	}
	return 1;
}

stock ShowEditVehicleTD(pid)
{
    TextDrawShowForPlayer(pid, TD_EDITINGVeh[0]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[1]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[2]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[3]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[4]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[5]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[6]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[7]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[8]);
	TextDrawShowForPlayer(pid, TD_EDITINGVeh[9]);
	PlayerTextDrawShow(pid, MinPosXVeh[pid]);
	PlayerTextDrawShow(pid, MinPosYVeh[pid]);
	PlayerTextDrawShow(pid, MinPosZVeh[pid]);
	PlayerTextDrawShow(pid, MinRotXVeh[pid]);
	PlayerTextDrawShow(pid, MinRotYVeh[pid]);
	PlayerTextDrawShow(pid, MinRotZVeh[pid]);
	PlayerTextDrawShow(pid, PlusPosXVeh[pid]);
	PlayerTextDrawShow(pid, PlusPosYVeh[pid]);
	PlayerTextDrawShow(pid, PlusPosZVeh[pid]);
	PlayerTextDrawShow(pid, PlusRotXVeh[pid]);
	PlayerTextDrawShow(pid, PlusRotYVeh[pid]);
	PlayerTextDrawShow(pid, PlusRotZVeh[pid]);
	PlayerTextDrawShow(pid, TD_VALUEVeh[pid]);
	PlayerTextDrawShow(pid, TD_SAVEVeh[pid]);
	new string[128];
	format(string, sizeof(string), "%f", NudgeVal[pid]);
	PlayerTextDrawSetString(pid, TD_VALUEVeh[pid], string); 
	SelectTextDraw(pid, 0xFF0000FF);
    HideTextdrawForVToy(pid);
}
stock HideEditVehicleTD(pid)
{
    TextDrawHideForPlayer(pid, TD_EDITINGVeh[0]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[1]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[2]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[3]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[4]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[5]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[6]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[7]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[8]);
	TextDrawHideForPlayer(pid, TD_EDITINGVeh[9]);
	PlayerTextDrawHide(pid, MinPosXVeh[pid]);
	PlayerTextDrawHide(pid, MinPosYVeh[pid]);
	PlayerTextDrawHide(pid, MinPosZVeh[pid]);
	PlayerTextDrawHide(pid, MinRotXVeh[pid]);
	PlayerTextDrawHide(pid, MinRotYVeh[pid]);
	PlayerTextDrawHide(pid, MinRotZVeh[pid]);
	PlayerTextDrawHide(pid, PlusPosXVeh[pid]);
	PlayerTextDrawHide(pid, PlusPosYVeh[pid]);
	PlayerTextDrawHide(pid, PlusPosZVeh[pid]);
	PlayerTextDrawHide(pid, PlusRotXVeh[pid]);
	PlayerTextDrawHide(pid, PlusRotYVeh[pid]);
	PlayerTextDrawHide(pid, PlusRotZVeh[pid]);
	PlayerTextDrawHide(pid, TD_VALUEVeh[pid]);
	PlayerTextDrawHide(pid, TD_SAVEVeh[pid]);
	CancelSelectTextDraw(pid);
    ShowTextdrawForVToy(pid);
}

stock HideTextdrawForVToy(playerid)
{
    pData[playerid][pHBEMode] = 0;
    return 1;
}

stock ShowTextdrawForVToy(playerid)
{
	pData[playerid][pHBEMode] = 1;
	return 1;
}

CMD:vacc(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		new string[350];
		new x = GetPlayerVehicleID(playerid);
		foreach(new i: PVehicles)
		{
			if(x == pvData[i][cVeh])
			{
				pData[playerid][VehicleID] = pvData[i][cVeh];
				if(vtData[pvData[i][cVeh]][0][vtoy_modelid] == 0)
				{
				    strcat(string, ""dot"Slot 1\n");
				}
				else strcat(string, ""dot"Slot 1 "RED_E"(Used)\n");

				if(vtData[pvData[i][cVeh]][1][vtoy_modelid] == 0)
				{
				    strcat(string, ""dot"Slot 2\n");
				}
				else strcat(string, ""dot"Slot 2 "RED_E"(Used)\n");

				if(vtData[pvData[i][cVeh]][2][vtoy_modelid] == 0)
				{
				    strcat(string, ""dot"Slot 3\n");
				}
				else strcat(string, ""dot"Slot 3 "RED_E"(Used)\n");

				if(vtData[pvData[i][cVeh]][3][vtoy_modelid] == 0)
				{
				    strcat(string, ""dot"Slot 4\n");
				}
				else strcat(string, ""dot"Slot 4 "RED_E"(Used)\n");
				
				ShowPlayerDialog(playerid, DIALOG_VTOYBUY, DIALOG_STYLE_LIST, ""RED_E"Fountain Daily "WHITE_E"Vehicle Toys", string, "Select", "Cancel");
			}
		}
	}
	else return Error(playerid, "Anda harus mengendarai kendaraan!");
	
	return 1;
}

CMD:vtoys(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{	
		new string[350];
		new x = GetPlayerVehicleID(playerid);
		foreach(new i: PVehicles)
		if(x == pvData[i][cVeh])
		{
			pData[playerid][VehicleID] = pvData[i][cVeh];
			if(vtData[pvData[i][cVeh]][0][vtoy_modelid] == 0)
			{
			    strcat(string, ""dot"Slot 1\n");
			}
			else strcat(string, ""dot"Slot 1 "RED_E"(Used)\n");

			if(vtData[pvData[i][cVeh]][1][vtoy_modelid] == 0)
			{
			    strcat(string, ""dot"Slot 2\n");
			}
			else strcat(string, ""dot"Slot 2 "RED_E"(Used)\n");

			if(vtData[pvData[i][cVeh]][2][vtoy_modelid] == 0)
			{
			    strcat(string, ""dot"Slot 3\n");
			}
			else strcat(string, ""dot"Slot 3 "RED_E"(Used)\n");

			if(vtData[pvData[i][cVeh]][3][vtoy_modelid] == 0)
			{
			    strcat(string, ""dot"Slot 4\n");
			}
			else strcat(string, ""dot"Slot 4 "RED_E"(Used)\n");
			
			strcat(string, ""dot""RED_E"Reset All Object\n");
			strcat(string, ""dot""RED_E"Refresh All Object");
			ShowPlayerDialog(playerid, DIALOG_VTOY, DIALOG_STYLE_LIST, ""RED_E"Fountain Daily "WHITE_E"Vehicle Toys", string, "Select", "Cancel");
		}
	}
	else return Error(playerid, "Anda harus mengendarai kendaraan!");
	
	return 1;
}



// Textdraw
stock ShowTDVeh(playerid)
{
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[0]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[1]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[2]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[3]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[4]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[5]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[6]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[7]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[8]);
	TextDrawShowForPlayer(playerid, TD_EDITINGVeh[9]);
	PlayerTextDrawShow(playerid, MinPosXVeh[playerid]);
	PlayerTextDrawShow(playerid, MinPosYVeh[playerid]);
	PlayerTextDrawShow(playerid, MinPosZVeh[playerid]);
	PlayerTextDrawShow(playerid, MinRotXVeh[playerid]);
	PlayerTextDrawShow(playerid, MinRotYVeh[playerid]);
	PlayerTextDrawShow(playerid, MinRotZVeh[playerid]);
	PlayerTextDrawShow(playerid, PlusPosXVeh[playerid]);
	PlayerTextDrawShow(playerid, PlusPosYVeh[playerid]);
	PlayerTextDrawShow(playerid, PlusPosZVeh[playerid]);
	PlayerTextDrawShow(playerid, PlusRotXVeh[playerid]);
	PlayerTextDrawShow(playerid, PlusRotYVeh[playerid]);
	PlayerTextDrawShow(playerid, PlusRotZVeh[playerid]);
	PlayerTextDrawShow(playerid, TD_VALUEVeh[playerid]);
	PlayerTextDrawShow(playerid, TD_SAVEVeh[playerid]);
	new string[128];
	format(string, sizeof(string), "%f", pData[playerid][pValue]);
	PlayerTextDrawSetString(playerid, TD_VALUEVeh[playerid], string);
	SelectTextDraw(playerid, 0xFF0000FF);
}

stock HideTDVeh(playerid)
{
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[0]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[1]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[2]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[3]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[4]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[5]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[6]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[7]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[8]);
	TextDrawHideForPlayer(playerid, TD_EDITINGVeh[9]);
	PlayerTextDrawHide(playerid, MinPosXVeh[playerid]);
	PlayerTextDrawHide(playerid, MinPosYVeh[playerid]);
	PlayerTextDrawHide(playerid, MinPosZVeh[playerid]);
	PlayerTextDrawHide(playerid, MinRotXVeh[playerid]);
	PlayerTextDrawHide(playerid, MinRotYVeh[playerid]);
	PlayerTextDrawHide(playerid, MinRotZVeh[playerid]);
	PlayerTextDrawHide(playerid, PlusPosXVeh[playerid]);
	PlayerTextDrawHide(playerid, PlusPosYVeh[playerid]);
	PlayerTextDrawHide(playerid, PlusPosZVeh[playerid]);
	PlayerTextDrawHide(playerid, PlusRotXVeh[playerid]);
	PlayerTextDrawHide(playerid, PlusRotYVeh[playerid]);
	PlayerTextDrawHide(playerid, PlusRotZVeh[playerid]);
	PlayerTextDrawHide(playerid, TD_VALUEVeh[playerid]);
	PlayerTextDrawHide(playerid, TD_SAVEVeh[playerid]);
	CancelSelectTextDraw(playerid);
}
