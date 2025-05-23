
#define MAX_VERIFIED 20

enum verifieds
{
	vName[50],
	vLeader[MAX_PLAYER_NAME],
	fMotd[100],
	vColor,
	Float:vExtposX,
	Float:vExtposY,
	Float:vExtposZ,
	Float:vExtposA,
	Float:vIntposX,
	Float:vIntposY,
	Float:vIntposZ,
	Float:vIntposA,
	vInt,
	Float:vSafeposX,
	Float:vSafeposY,
	Float:vSafeposZ,
	Float:vSafeposA,
	vMoney,
	vMarijuana,
	vComponent,
	vMaterial,
	vPoint,
	fGun[15],
	fAmmo[15],
	//Not Save
	Text3D:vLabelext,
	Text3D:vLabelint,
	Text3D:vLabelsafe,
	vPickext,
	vPickint,
	fPicksafe
};

new verData[MAX_VERIFIED][verifieds],
	Iterator:VERIFIED<MAX_VERIFIED>;


Verified_Save(id)
{
	new dquery[2048];
	format(dquery, sizeof(dquery), "UPDATE verified SET name='%s', leader='%s', motd='%s', color='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', intposx='%f', intposy='%f', intposz='%f', intposa='%f', vint='%d'",
	verData[id][vName],
	verData[id][vLeader],
	verData[id][fMotd],
	verData[id][vColor],
	verData[id][vExtposX],
	verData[id][vExtposY],
	verData[id][vExtposZ],
	verData[id][vExtposA],
	verData[id][vIntposX],
	verData[id][vIntposY],
	verData[id][vIntposZ],
	verData[id][vIntposA],
	verData[id][vInt]);
	
	for (new i = 0; i < 15; i ++) 
	{
        format(dquery, sizeof(dquery), "%s, Weapon%d='%d', Ammo%d='%d'", dquery, i + 1, verData[id][fGun][i], i + 1, verData[id][fAmmo][i]);
    }
	
	format(dquery, sizeof(dquery), "%s, safex='%f', safey='%f', safez='%f', money='%d', marijuana='%d', component='%d', material='%d', point='%d' WHERE ID='%d'",
	dquery,
	verData[id][vSafeposX],
	verData[id][vSafeposY],
	verData[id][vSafeposZ],
	verData[id][vMoney],
	verData[id][vMarijuana],
	verData[id][vComponent],
	verData[id][vMaterial],
	verData[id][vPoint],
	id);
	return mysql_tquery(g_SQL, dquery);
}


Verified_Refresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamic3DTextLabel(verData[id][vLabelext]))
            DestroyDynamic3DTextLabel(verData[id][vLabelext]);

        if(IsValidDynamicPickup(verData[id][vPickext]))
            DestroyDynamicPickup(verData[id][vPickext]);

        if(IsValidDynamic3DTextLabel(verData[id][vLabelint]))
            DestroyDynamic3DTextLabel(verData[id][vLabelint]);

        if(IsValidDynamicPickup(verData[id][vPickint]))
            DestroyDynamicPickup(verData[id][vPickint]);
			
		if(IsValidDynamic3DTextLabel(verData[id][vLabelsafe]))
            DestroyDynamic3DTextLabel(verData[id][vLabelsafe]);

        if(IsValidDynamicPickup(verData[id][fPicksafe]))
            DestroyDynamicPickup(verData[id][fPicksafe]);
		
		new mstr[512], tstr[128];
		format(mstr,sizeof(mstr),"[VERIFIED ID: %d]\n{FFFFFF}%s\n{FFFFFF}Press {FF0000}ENTER {FFFFFF}to enter", id, verData[id][vName]);
		verData[id][vPickext] = CreateDynamicPickup(19130, 23, verData[id][vExtposX], verData[id][vExtposY], verData[id][vExtposZ], 0, 0, -1, 50);
		verData[id][vLabelext] = CreateDynamic3DTextLabel(mstr, COLOR_YELLOW, verData[id][vExtposX], verData[id][vExtposY], verData[id][vExtposZ]+0.35, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);

        if(verData[id][vIntposX] != 0.0 && verData[id][vIntposY] != 0.0 && verData[id][vIntposZ] != 0.0)
        {
            format(mstr,sizeof(mstr),"[VERIFIED ID: %d]\n{FFFFFF}%s\n{FFFFFF}Press {FF0000}ENTER {FFFFFF}to exit", id, verData[id][vName]);

            verData[id][vLabelint] = CreateDynamic3DTextLabel(mstr, COLOR_YELLOW, verData[id][vIntposX], verData[id][vIntposY], verData[id][vIntposZ]+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, id, verData[id][vInt]);
            verData[id][vPickint] = CreateDynamicPickup(19130, 23, verData[id][vIntposX], verData[id][vIntposY], verData[id][vIntposZ], id, verData[id][vInt], -1, 50);
        }
		if(verData[id][vSafeposX] != 0.0 && verData[id][vSafeposY] != 0.0 && verData[id][vSafeposZ] != 0.0)
		{
			format(tstr, sizeof(tstr), "[VERIFIED ID: %d]\nSafe Point", id);
			verData[id][vLabelsafe] = CreateDynamic3DTextLabel(tstr, COLOR_YELLOW, verData[id][vSafeposX], verData[id][vSafeposY], verData[id][vSafeposZ]+0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, id, verData[id][vInt]);
            verData[id][fPicksafe] = CreateDynamicPickup(1239, 23, verData[id][vSafeposX], verData[id][vSafeposY], verData[id][vSafeposZ], id, verData[id][vInt], -1, 50);
		}
	}
}

Verified_WeaponStorage(playerid, verid)
{
    if(verid == -1)
        return 0;

    static
        string[320];

    string[0] = 0;

    for (new i = 0; i < 15; i ++)
    {
        if(!verData[verid][fGun][i])
            format(string, sizeof(string), "%sSlot Kosong\n", string);

        else
            format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(verData[verid][fGun][i]), verData[verid][fAmmo][i]);
    }
    ShowPlayerDialog(playerid, VERIFIED_WEAPONS, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
    return 1;
}

Verified_OpenStorage(playerid, verid)
{
    if(verid == -1)
        return 0;

    new
        items[1],
        string[10 * 32];

    for (new i = 0; i < 15; i ++) if(verData[verid][fGun][i]) 
	{
        items[0]++;
    }
    format(string, sizeof(string), "Weapon Storage (%d/15)", items[0]);
    ShowPlayerDialog(playerid, VERIFIED_STORAGE, DIALOG_STYLE_LIST, "Verified Storage", string, "Select", "Cancel");
    return 1;
}

function OnVerifiedCreated(id)
{
	Verified_Save(id);
	Verified_Refresh(id);
	return 1;
}

function LoadVerified()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new verid, name[50], leader[MAX_PLAYER_NAME], motd[100];
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", verid);
	    	cache_get_value_name(i, "name", name);
			format(verData[verid][vName], 50, name);
		    cache_get_value_name(i, "leader", leader);
			format(verData[verid][vLeader], MAX_PLAYER_NAME, leader);
			cache_get_value_name(i, "motd", motd);
			format(verData[verid][fMotd], 100, motd);
		    cache_get_value_name_int(i, "color", verData[verid][vColor]);
		    cache_get_value_name_float(i, "extposx", verData[verid][vExtposX]);
		    cache_get_value_name_float(i, "extposy", verData[verid][vExtposY]);
		    cache_get_value_name_float(i, "extposz", verData[verid][vExtposZ]);
		    cache_get_value_name_float(i, "extposa", verData[verid][vExtposA]);
		    cache_get_value_name_float(i, "intposx", verData[verid][vIntposX]);
		    cache_get_value_name_float(i, "intposy", verData[verid][vIntposY]);
		    cache_get_value_name_float(i, "intposz", verData[verid][vIntposZ]);
		    cache_get_value_name_float(i, "intposa", verData[verid][vIntposA]);
		    cache_get_value_name_int(i, "vInt", verData[verid][vInt]);
			cache_get_value_name_float(i, "safex", verData[verid][vSafeposX]);
			cache_get_value_name_float(i, "safey", verData[verid][vSafeposY]);
			cache_get_value_name_float(i, "safez", verData[verid][vSafeposZ]);
			cache_get_value_name_int(i, "money", verData[verid][vMoney]);
			cache_get_value_name_int(i, "marijuana", verData[verid][vMarijuana]);
			cache_get_value_name_int(i, "point", verData[verid][vPoint]);
			cache_get_value_name_int(i, "component", verData[verid][vComponent]);
			cache_get_value_name_int(i, "material", verData[verid][vMaterial]);
			
			cache_get_value_name_int(i, "Weapon1", verData[verid][fGun][0]);
			cache_get_value_name_int(i, "Weapon2", verData[verid][fGun][1]);
			cache_get_value_name_int(i, "Weapon3", verData[verid][fGun][2]);
			cache_get_value_name_int(i, "Weapon4", verData[verid][fGun][3]);
			cache_get_value_name_int(i, "Weapon5", verData[verid][fGun][4]);
			cache_get_value_name_int(i, "Weapon6", verData[verid][fGun][5]);
			cache_get_value_name_int(i, "Weapon7", verData[verid][fGun][6]);
			cache_get_value_name_int(i, "Weapon8", verData[verid][fGun][7]);
			cache_get_value_name_int(i, "Weapon9", verData[verid][fGun][8]);
			cache_get_value_name_int(i, "Weapon10", verData[verid][fGun][9]);
			cache_get_value_name_int(i, "Weapon11", verData[verid][fGun][10]);
			cache_get_value_name_int(i, "Weapon12", verData[verid][fGun][11]);
			cache_get_value_name_int(i, "Weapon13", verData[verid][fGun][12]);
			cache_get_value_name_int(i, "Weapon14", verData[verid][fGun][13]);
			cache_get_value_name_int(i, "Weapon15", verData[verid][fGun][14]);
			
			cache_get_value_name_int(i, "Ammo1", verData[verid][fAmmo][0]);
			cache_get_value_name_int(i, "Ammo2", verData[verid][fAmmo][1]);
			cache_get_value_name_int(i, "Ammo3", verData[verid][fAmmo][2]);
			cache_get_value_name_int(i, "Ammo4", verData[verid][fAmmo][3]);
			cache_get_value_name_int(i, "Ammo5", verData[verid][fAmmo][4]);
			cache_get_value_name_int(i, "Ammo6", verData[verid][fAmmo][5]);
			cache_get_value_name_int(i, "Ammo7", verData[verid][fAmmo][6]);
			cache_get_value_name_int(i, "Ammo8", verData[verid][fAmmo][7]);
			cache_get_value_name_int(i, "Ammo9", verData[verid][fAmmo][8]);
			cache_get_value_name_int(i, "Ammo10", verData[verid][fAmmo][9]);
			cache_get_value_name_int(i, "Ammo11", verData[verid][fAmmo][10]);
			cache_get_value_name_int(i, "Ammo12", verData[verid][fAmmo][11]);
			cache_get_value_name_int(i, "Ammo13", verData[verid][fAmmo][12]);
			cache_get_value_name_int(i, "Ammo14", verData[verid][fAmmo][13]);
			cache_get_value_name_int(i, "Ammo15", verData[verid][fAmmo][14]);
			/*for (new j = 0; j < 10; j ++)
			{
				format(str, 24, "Weapon%d", j + 1);
				cache_get_value_name_int(i, str, verData[verid][fGun][j]);

				format(str, 24, "Ammo%d", j + 1);
				cache_get_value_name_int(i, str, verData[verid][fAmmo][j]);
			}*/
			
			Iter_Add(VERIFIED, verid);
			Verified_Refresh(verid);
	    }
	    printf("[VERIFIED]: %d Loaded.", rows);
	}
}

//----------[ Family Commands ]-----------


CMD:vcreate(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pFactionModerator] < 1)
			return PermissionError(playerid);
		
	new verid = Iter_Free(VERIFIED);
	if(verid == -1) return Error(playerid, "You cant create more verified slot empty!");
	new name[50], otherid, query[128];
	if(sscanf(params, "s[50]u", name, otherid)) return Usage(playerid, "/vcreate [name] [playerid]");
	if(otherid == INVALID_PLAYER_ID)
		return Error(playerid, "invalid playerid.");
	
	if(pData[otherid][pVerified] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");
		
	if(pData[otherid][pFaction] != 0)
		return Error(playerid, "Player tersebut sudah bergabung faction");
		
	pData[otherid][pVerified] = verid;
	pData[otherid][pVerifiedRank] = 6;
		
	format(verData[verid][vName], 50, name);
	format(verData[verid][vLeader], 50, pData[otherid][pName]);
	format(verData[verid][fMotd], 50, "None");
	verData[verid][vColor] = 0;
	verData[verid][vExtposX] = 0;
	verData[verid][vExtposY] = 0;
	verData[verid][vExtposZ] = 0;
	verData[verid][vExtposA] = 0;
	
	verData[verid][vIntposX] = 0;
	verData[verid][vIntposY] = 0;
	verData[verid][vIntposZ] = 0;
	verData[verid][vIntposA] = 0;
	verData[verid][vInt] = 0;
	
	verData[verid][vMoney] = 0;
	verData[verid][vMarijuana] = 0;
	verData[verid][vPoint] = 0;
	verData[verid][vComponent] = 0;
	verData[verid][vMaterial] = 0;
	verData[verid][vSafeposX] = 0;
	verData[verid][vSafeposY] = 0;
	verData[verid][vSafeposZ] = 0;

	Iter_Add(VERIFIED, verid);
	Servers(playerid, "Anda telah berhasil membuat VERIFIED ID: %d dengan leader: %s", verid, pData[otherid][pName]);
	Servers(otherid, "Admin %s telah menset anda sebagai leader dari VERIFIED ID: %d", pData[playerid][pAdminname], verid);
	SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah membuat VERIFIED ID: %d dengan leader: %s", pData[playerid][pAdminname], verid, pData[otherid][pName]);
	new str[150];
	format(str,sizeof(str),"[Family]: %s membuat VERIFIED ID %d!", GetRPName(playerid), verid);
	LogServer("Admin", str);	

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO verified SET ID=%d, name='%s', leader='%s'", verid, name, pData[otherid][pName]);
	mysql_tquery(g_SQL, query, "OnVerifiedCreated", "i", verid);
	return 1;
}

CMD:vdelete(playerid, params[])
{
 	if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pFactionModerator] < 1)
			return PermissionError(playerid);

    new verid, query[128];
	if(sscanf(params, "i", verid)) return Usage(playerid, "/vdelete [verid]");
	if(!Iter_Contains(VERIFIED, verid)) return Error(playerid, "The you specified ID of doesn't exist.");
	
    format(verData[verid][vName], 50, "None");
	format(verData[verid][vLeader], 50, "None");
	format(verData[verid][fMotd], 50, "None");
	verData[verid][vColor] = 0;
	verData[verid][vExtposX] = 0;
	verData[verid][vExtposY] = 0;
	verData[verid][vExtposZ] = 0;
	verData[verid][vExtposA] = 0;
	
	verData[verid][vIntposX] = 0;
	verData[verid][vIntposY] = 0;
	verData[verid][vIntposZ] = 0;
	verData[verid][vIntposA] = 0;
	verData[verid][vInt] = 0;
	
	verData[verid][vMoney] = 0;
	verData[verid][vMarijuana] = 0;
	verData[verid][vPoint] = 0;
	verData[verid][vComponent] = 0;
	verData[verid][vMaterial] = 0;
	verData[verid][vSafeposX] = 0;
	verData[verid][vSafeposY] = 0;
	verData[verid][vSafeposZ] = 0;
	
	DestroyDynamic3DTextLabel(verData[verid][vLabelext]);
	DestroyDynamicPickup(verData[verid][vPickext]);
	DestroyDynamic3DTextLabel(verData[verid][vLabelint]);
	DestroyDynamicPickup(verData[verid][vPickint]);
	DestroyDynamic3DTextLabel(verData[verid][vLabelsafe]);
	DestroyDynamicPickup(verData[verid][fPicksafe]);
	Iter_Remove(VERIFIED, verid);
	
	mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET verified=-1,verifiedrank=0 WHERE verified=%d", verid);
	mysql_tquery(g_SQL, query);
	
	foreach(new ii : Player)
	{
 		if(pData[ii][pVerified] == verid)
   		{
			pData[ii][pVerified]= -1;
			pData[ii][pVerifiedRank] = 0;
		}
	}

	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM verified WHERE ID=%d", verid);
	mysql_tquery(g_SQL, query);
    SendStaffMessage(COLOR_LIGHTRED, "Admin %s telah menghapus VERIFIED ID: %d.", pData[playerid][pAdminname], verid);
	new str[150];
	format(str,sizeof(str),"[Family]: %s menghapus VERIFIED ID %d!", GetRPName(playerid), verid);
	LogServer("Admin", str);	
	return 1;
}

CMD:vedit(playerid, params[])
{
    static
        verid,
        type[24],
        string[128],
		otherid;

    if(pData[playerid][pAdmin] < 201)
		if(pData[playerid][pFactionModerator] < 1)
			return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", verid, type, string))
    {
        Usage(playerid, "/vedit [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, name, leader, safe, money, marijuana, point");
        return 1;
    }
    if((verid < 0 || verid >= MAX_VERIFIED))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(VERIFIED, verid)) return Error(playerid, "The you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, verData[verid][vExtposX], verData[verid][vExtposY], verData[verid][vExtposZ]);
		GetPlayerFacingAngle(playerid, verData[verid][vExtposA]);

        Verified_Save(verid);
		Verified_Refresh(verid);

        SendStaffMessage(COLOR_LIGHTRED, "%s has adjusted the location of entrance ID: %d.", pData[playerid][pAdminname], verid);
    }
    else if(!strcmp(type, "interior", true))
    {
        GetPlayerPos(playerid, verData[verid][vIntposX], verData[verid][vIntposY], verData[verid][vIntposZ]);
		GetPlayerFacingAngle(playerid, verData[verid][vIntposA]);

		verData[verid][vInt] = GetPlayerInterior(playerid);
        Verified_Save(verid);
		Verified_Refresh(verid);

        SendStaffMessage(COLOR_LIGHTRED, "%s has adjusted the interior spawn of entrance ID: %d.", pData[playerid][pAdminname], verid);
    }
    else if(!strcmp(type, "name", true))
    {
        new name[50];

        if(sscanf(string, "s[50]", name))
            return Usage(playerid, "/vedit [id] [name] [vname]");

        format(verData[verid][vName], 50, name);
		Verified_Save(verid);
		Verified_Refresh(verid);

        SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the Verified Name ID: %d to: %s.", pData[playerid][pAdminname], verid, name);
    }
    else if(!strcmp(type, "leader", true))
    {
        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/vedit [id] [leader] [playerid]");
		
		if(otherid == INVALID_PLAYER_ID)
			return Error(playerid, "invalid player verid");

        format(verData[verid][vLeader], 50, pData[otherid][pName]);
		Verified_Save(verid);
		Verified_Refresh(verid);

        SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family leader ID: %d to: %s.", pData[playerid][pAdminname], verid, pData[otherid][pName]);
    }
    else if(!strcmp(type, "safe", true))
    {
        GetPlayerPos(playerid, verData[verid][vSafeposX], verData[verid][vSafeposY], verData[verid][vSafeposZ]);

        Verified_Save(verid);
		Verified_Refresh(verid);
		
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family safepos ID: %d.", pData[playerid][pAdminname], verid);
    }
    else if(!strcmp(type, "money", true))
    {
        new money;

        if(sscanf(string, "d", money))
            return Usage(playerid, "/vedit [id] [money] [ammount]");

        verData[verid][vMoney] = money;
		
        Verified_Save(verid);
		Verified_Refresh(verid);
		
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family money ID: %d to %s.", pData[playerid][pAdminname], verid, FormatMoney(money));
    }
    else if(!strcmp(type, "marijuana", true))
    {
        new marijuana;

        if(sscanf(string, "d", marijuana))
            return Usage(playerid, "/vedit [id] [marijuana] [ammount]");

        verData[verid][vMarijuana] = marijuana;
		
        Verified_Save(verid);
		Verified_Refresh(verid);
		
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family marijuana ID: %d to %d.", pData[playerid][pAdminname], verid, marijuana);
    }
	else if(!strcmp(type, "component", true))
    {
        new comp;

        if(sscanf(string, "d", comp))
            return Usage(playerid, "/vedit [id] [component] [ammount]");

        verData[verid][vComponent] = comp;
		
        Verified_Save(verid);
		Verified_Refresh(verid);
		
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family component ID: %d to %d.", pData[playerid][pAdminname], verid, comp);
    }
	else if(!strcmp(type, "material", true))
    {
        new mat;

        if(sscanf(string, "d", mat))
            return Usage(playerid, "/vedit [id] [material] [ammount]");

        verData[verid][vMaterial] = mat;
		
        Verified_Save(verid);
		Verified_Refresh(verid);
		
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family material ID: %d to %d.", pData[playerid][pAdminname], verid, mat);
    }
	else if(!strcmp(type, "point", true))
    {
        new point;

        if(sscanf(string, "d", point))
            return Usage(playerid, "/vedit [id] [point] [ammount]");

        verData[verid][vPoint] = point;
		
        Verified_Save(verid);
		Verified_Refresh(verid);
		
		SendStaffMessage(COLOR_LIGHTRED, "Admin %s has changed the family point ID: %d to %d.", pData[playerid][pAdminname], verid, point);
    }
    return 1;
}

CMD:vsafe(playerid)
{
	if(pData[playerid][pVerified] == -1)
		return Error(playerid, "Anda bukan anggota family");
		
	new verid = pData[playerid][pVerified];
	if(IsPlayerInRangeOfPoint(playerid, 3.0, verData[verid][vSafeposX], verData[verid][vSafeposY], verData[verid][vSafeposZ]))
    {
     	ShowPlayerDialog(playerid, VERIFIED_SAFE, DIALOG_STYLE_LIST, "Family SAFE", "Storage\nMarijuana\nComponent\nMaterial\nMoney", "Select", "Cancel");
    }
 	else
   	{
     	Error(playerid, "You aren't in range in area family safe.");
    }
	return 1;
}

CMD:vinvite(playerid, params[])
{
	if(pData[playerid][pVerified] == -1)
		return Error(playerid, "You are not in family!");
		
	if(pData[playerid][pVerifiedRank] < 5)
		return Error(playerid, "You must family rank 5 - 6!");
	
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/invite [playerid/PartOvname]");
		
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");
		
	if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");
	
	if(pData[otherid][pVerified] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family!");
	
	if(pData[otherid][pFaction] != 0)
		return Error(playerid, "Player tersebut sudah bergabung faction!");
	
	new verified = pData[playerid][pVerified];
	Servers(playerid, "Anda telah menginvite %s untuk menjadi anggota family.", pData[otherid][pName]);
	Servers(otherid, "%s telah menginvite anda untuk menjadi anggota family. Type: /accept verified !", pData[playerid][pName]);
    // Query untuk menghitung jumlah anggota keluarga
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `verified` = '%d'", verified); 
    mysql_query(g_SQL, query);
    
    new rows = cache_num_rows();
    if(rows >= 7)
    {
        SendClientMessage(playerid, COLOR_RED, "Family mu sudah maximal 8 member."); 
        return 1; 
    }
	pData[otherid][pVerInvite] = pData[playerid][pVerified];
	pData[otherid][pVerOffer] = playerid;
	return 1;
}

CMD:vuninvite(playerid, params[])
{
	if(pData[playerid][pVerified] == -1)
		return Error(playerid, "You are not in family!");
		
	if(pData[playerid][pVerifiedRank] < 5)
		return Error(playerid, "You must family level 5 - 6!");
	
	new otherid;
    if(sscanf(params, "u", otherid))
        return SyntaxMsg(playerid, "/uninvite [playerid/PartOvname]");

	if(pData[otherid][pVerified] != pData[playerid][pVerified])
		return Error(playerid, "This player is not in your family!");
		
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");
	
	if(pData[otherid][pVerifiedRank] > pData[playerid][pVerifiedRank])
		return Error(playerid, "You cant kick him.");
		
	pData[otherid][pVerifiedRank] = 0;
	pData[otherid][pVerified] = -1;
	Servers(playerid, "Anda telah mengeluarkan %s dari anggota family.", pData[otherid][pName]);
	Servers(otherid, "%s telah mengeluarkan anda dari anggota family.", pData[playerid][pName]);
	return 1;
}

CMD:voffkick(playerid, params[])
{
	if(pData[playerid][pVerified] == -1)
		return Error(playerid, "You are not in family!");
		
	if(pData[playerid][pVerifiedRank] < 5)
		return Error(playerid, "You must family level 5 - 6!");
	
	new username[MAX_PLAYER_NAME];
    if(sscanf(params, "s[24]", username))
        return Usage(playerid, "/voffkick [PartOvname]");
		
	if(IsPlayerOnline(username))
		return Error(playerid, "Player tersebut online.");
		
	new query[200];	
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `username`='%s'", username);
	mysql_tquery(g_SQL, query, "VerKickOffline", "is", playerid, username);
	return 1;
}

CMD:vsetrank(playerid, params[])
{
	new rank, otherid;
	if(pData[playerid][pVerifiedRank] < 6)
		return Error(playerid, "You must family leader!");
		
	if(sscanf(params, "ud", otherid, rank))
        return SyntaxMsg(playerid, "/vsetrank [playerid/PartOvname] [rank 1-6]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Invalid ID.");
	
	if(otherid == playerid)
		return Error(playerid, "Invalid ID.");
	
	if(pData[otherid][pVerified] != pData[playerid][pVerified])
		return Error(playerid, "This player is not in your family!");
	
	if(rank < 1 || rank > 6)
		return Error(playerid, "rank must 1 - 6 only");
	
	pData[otherid][pVerifiedRank] = rank;
	Servers(playerid, "You has set %s family rank to level %d", pData[otherid][pName], rank);
	Servers(otherid, "%s has set your family rank to level %d", pData[playerid][pName], rank);
	return 1;
}

CMD:v(playerid, params[])
{
    new text[128];
    
    if(pData[playerid][pVerified] == -1)
        return Error(playerid, "You must in Verified Member to use this command");

	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "Turu gausah /f Dekkk..!!!");	  

    if(sscanf(params,"s[128]",text))
        return SyntaxMsg(playerid, "/f(family) [text]");

    if(strval(text) > 128)
        return Error(playerid,"Text too long.");
	
	SendVerifiedMessage(pData[playerid][pVerified], COLOR_FAMILY, ""VERIFIED_E"* %s %s: %s *", GetVerifiedRank(playerid), pData[playerid][pName], params);
    return 1;
}

alias:vinfo("fstat", "fstats")
CMD:vinfo(playerid, params[])
{
	if(pData[playerid][pVerified] == -1)
        return Error(playerid, "You must in Verified Member to use this command!");
	
	ShowPlayerDialog(playerid, VERIFIED_INFO, DIALOG_STYLE_LIST, "Verified Info", "Verified Info\nVerified Online\nVerified Member", "Select", "Cancel");
	return 1;
}
CMD:families(playerid, params[])
{
	new string[400];
	string =  "Name\tType\tStatus\n";
	format(string, sizeof(string), "%s198th Exalt Outlaws\tStreetGang\tOfficial\n", string);
	format(string, sizeof(string), "%sHoover Boyz Crips\tStreetGang\tVerified\n", string);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Family List", string, "Ok","");

	return 1;
}
function ShowVerifiedInfo(playerid)
{
	new rows = cache_num_rows();
 	if(rows)
  	{
 		new vname[50],
 			vleader[50],
			vmarijuana,
			vcomponent,
			vmaterial,
			vmoney,
			vpoint,
			string[512];
			
		cache_get_value_index(0, 0, vname);
		cache_get_value_index(0, 1, vleader);
		cache_get_value_index_int(0, 2, vmarijuana);
		cache_get_value_index_int(0, 3, vcomponent);
		cache_get_value_index_int(0, 4, vmaterial);
		cache_get_value_index_int(0, 5, vmoney);
		cache_get_value_index_int(0, 6, vpoint);

		format(string, sizeof(string), "VERIFIED ID: %d\nVerified Name: %s\nFamily Leader: %s\nFamily Marijuana: %d\nFamily Component: %d\nFamily Material: %d\nFamily Money: %s\nFamily Point: %d",
		pData[playerid][pVerified], vname, vleader, vmarijuana, vcomponent, vmaterial, FormatMoney(vmoney), vpoint);
		
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Verified Info", string, "Okay", "");
	}
}

function ShowVerieidMember(playerid)
{
	new rows = cache_num_rows(), pid, username[50], frank, query[1048];
 	if(rows)
  	{
		for(new i = 0; i != rows; i++)
		{
			cache_get_value_index(i, 0, username);
			pid = GetID(username);
			
			format(query, sizeof(query), "%s"WHITE_E"%d. %s ", query, (i+1), username);
			
			if(IsPlayerConnected(pid))
				strcat(query, ""GREEN_E"(ONLINE) ");
			else
				strcat(query, ""RED_E"(OFFLINE) ");
			
			cache_get_value_index_int(i, 1, frank);
			if(frank == 1)
			{
				strcat(query, ""VERIFIED_E"Outsider(1)");
			}
			else if(frank == 2)
			{
				strcat(query, ""VERIFIED_E"Associate(2)");
			}
			else if(frank == 3)
			{
				strcat(query, ""VERIFIED_E"Soldier(3)");
			}
			else if(frank == 4)
			{
				strcat(query, ""VERIFIED_E"Advisor(4)");
			}
			else if(frank == 5)
			{
				strcat(query, ""VERIFIED_E"UnderBoss(5)");
			}
			else if(frank == 6)
			{
				strcat(query, ""VERIFIED_E"GodFather(6)");
			}
			else
			{
				strcat(query, ""VERIFIED_E"None(0)");
			}
			strcat(query, "\n{FFFFFF}");
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Verified Member", query, "Okay", "");
	}
}


forward VerKickOffline(playerid, username[]);
public VerKickOffline(playerid, username[])
{
	new rows = cache_num_rows(), fam, famrank, id;
	
	cache_get_value_name_int(0, "verified", fam);
	cache_get_value_name_int(0, "verifiedrank", famrank);
	cache_get_value_name_int(0, "reg_id", id);
	if(rows > 0)
	{
		if(fam != pData[playerid][pVerified])
		{
			return Error(playerid, "Player tersebut tidak gabung dengan family kamu!");
		}
		else if(famrank > pData[playerid][pVerifiedRank])
		{
			return Error(playerid, "Player tersebut memiliki peringkat/rank lebih tinggi dari kamu!");
		}	
		else
		{
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET verified=-1,verifiedrank=0 WHERE reg_id=%d", id);
			mysql_tquery(g_SQL, query);
		
			Info(playerid, "Kamu berhasil kick %s dari family", username);
		}
	}
	else
	{
		Error(playerid, "Nama tersebut tidak ada difamily kamu");
	}
	return 1;
}
