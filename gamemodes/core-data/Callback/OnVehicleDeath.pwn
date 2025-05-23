public OnVehicleRequestDeath(vehicleid, killerid)
{
    printf("[Callback OnVehicleRequestDeath]: vehicleid %d, killerid %d", vehicleid, killerid);

    new Float: hp;
    GetVehicleHealth(vehicleid, hp);

    foreach(new p : Player)
    {
        if (IsPlayerConnected(p))
        {
            foreach(new i : PVehicles)
            {
                if(pvData[i][cVeh] == vehicleid && pvData[i][cSpawn] == 0)
                {
                    if (GetPlayerState(killerid) == PLAYER_STATE_SPECTATING)
                        SetPVarInt(p, "VehicleKiller", gLastDriver[vehicleid]);
                    else
                    {
                        SetPVarInt(p, "VehicleKiller", pData[killerid][pID]);

                        new
                            Float: _kPosX,
                            Float: _kPosY,
                            Float: _kPosZ,
                            Float: vx, Float: vy, Float: vz
                        ;

                        GetVehiclePos(vehicleid, vx, vy, vz);
                        GetVehicleHealth(vehicleid, hp);

                        if (hp <= 0.0 || vx == 0.0) return 0;
                        if (hp >= 500.0) return 0;

                        GetPlayerPos(killerid, _kPosX, _kPosY, _kPosZ);

                        new Float: distance = GetDistance2D(_kPosX, _kPosY, vx, vy);

                        if (distance >= 30.0) return 0;
                        if (GetPlayerVirtualWorld(killerid) != GetVehicleVirtualWorld(vehicleid)) return 0;

                        break;
                    }
                }
            }
        }
    }

    return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    printf("[Callback OnVehicleDeath]: vehicleid %d, killerid %d", vehicleid, killerid);

    gLastDriver[vehicleid] = -1;

    foreach(new i : PVehicles)
    {
        if(pvData[i][cVeh] == vehicleid && pvData[i][cRent] == 0)
        {
            foreach(new p : Player)
            {
                new ownerID = pvData[i][cOwner];

                if (ownerID == pData[p][pID])
                {   
                    SetPVarInt(p, "VehicleKilled", 1);
                    /* Info(p, "Your vehicle %s was destroyed by {ff0000}%s {ffffff}[ID:%d]", GetVehicleModelName(pvData[i][cModel]), ReturnPlayerName(killerid), killerid);
                    
                    if(pvData[i][cInsu] == 0)
                    {
                        new query[128];
                        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
                        mysql_tquery(g_SQL, query);

                        new xuery[128];
                        mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[i][cOwner]);
                        mysql_tquery(g_SQL, xuery);
                        pvData[pvData[i][cVeh]][LoadedStorage] = false;

                        if(IsValidVehicle(vehicleid)) DestroyVehicle(vehicleid);
                        pvData[i][cVeh] = INVALID_VEHICLE_ID;

                        new line3[500];
                        format(line3, sizeof(line3), "Your vehicle has been deleted because it has no insurance.");
                        ShowPlayerDialog(p, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, SBLUE_E "Fountain Daily:RP: " WHITE_E "Claim Insurance", line3, "OK", "");
                        SendClientMessage(p, COLOR_GREY, "Your vehicle has been deleted because it has no insurance.");
                    } */
                }
            
            }
        }
    }

    return 1;
}