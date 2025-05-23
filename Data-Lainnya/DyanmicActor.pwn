// Actor system module

// Definition
#define MAX_ACTOR (1000)





// Hooks
#include <YSI\y_hooks>
hook OnGameModeInitEx() {
  mysql_pquery(g_SQL, "SELECT * FROM `actor`", "Actor_Load", "");
  return 1;
}

// Callback
function Actor_Load()
{
    new rows = cache_num_rows();

    for (new id = 0; id < rows; id ++)
    {
        cache_get_value_int(id, "actorID", ActorData[id][actorID]);
        cache_get_value_int(id, "actorSkin", ActorData[id][actorSkin]);
        cache_get_value_int(id, "actorVw", ActorData[id][actorVirtualWorld]);
        cache_get_value_int(id, "actorInt", ActorData[id][actorInterior]);
        
        cache_get_value(id, "actorName", ActorData[id][actorName], 24);
        cache_get_value(id, "animlib", ActorData[id][actorAnimlib], 32);
        cache_get_value(id, "animname", ActorData[id][actorAnimname], 32);

        cache_get_value_float(id, "actorX", ActorData[id][actorPos][0]);
        cache_get_value_float(id, "actorY", ActorData[id][actorPos][1]);
        cache_get_value_float(id, "actorZ", ActorData[id][actorPos][2]);
        cache_get_value_float(id, "actorA", ActorData[id][actorPos][3]);

        Iter_Add(Actors, id);
        Actor_Refresh(id);
    }
    printf("*** [Database: Loaded] actor data (%d count).", rows);
    return 1;
}

function OnActorCreated(id)
{
    if (!Iter_Contains(Actors, id))
        return 0;
    
    ActorData[id][actorID] = cache_insert_id();
    Actor_Save(id);
    return 1;
}

// Function
Actor_Create(name[], skin, Float:x, Float:y, Float:z, Float:angle, vw, interior)
{
    new id = INVALID_ITERATOR_SLOT;

    if ((id = Iter_Free(Actors)) != INVALID_ITERATOR_SLOT) {
        new string[225];
        format(ActorData[id][actorName],24,ColouredText(name));
        format(ActorData[id][actorAnimlib],32,"GRAVEYARD");
        format(ActorData[id][actorAnimname],32,"prst_loopa");

        ActorData[id][actorSkin] = skin;
        ActorData[id][actorPos][0] = x;
        ActorData[id][actorPos][1] = y;
        ActorData[id][actorPos][2] = z;
        ActorData[id][actorPos][3] = angle;
        ActorData[id][actorVirtualWorld] = vw;
        ActorData[id][actorInterior] = interior;

        Iter_Add(Actors, id);
        Actor_Refresh(id);

        format(string,sizeof(string),"INSERT INTO `actor` (`actorVw`) VALUES ('%d')",vw);
        mysql_tquery(g_SQL, string, "OnActorCreated", "d", id);
        return id;
    }
    return INVALID_ITERATOR_SLOT;
}

Actor_Refresh(id)
{
    if(!Iter_Contains(Actors, id))
        return 0;

    new string[225];
    
    if(IsValidDynamic3DTextLabel(ActorData[id][actorLabel]))
        DestroyDynamic3DTextLabel(ActorData[id][actorLabel]);

    if (IsValidDynamicActor(ActorData[id][actorDisplay]))
        DestroyDynamicActor(ActorData[id][actorDisplay]);

    ActorData[id][actorDisplay] = CreateDynamicActor(ActorData[id][actorSkin],ActorData[id][actorPos][0],ActorData[id][actorPos][1],ActorData[id][actorPos][2],ActorData[id][actorPos][3], 1, 100.0, ActorData[id][actorVirtualWorld], ActorData[id][actorInterior]);

    format(string,sizeof(string),"[Actor ID: %d]\n"WHITE_E"%s", id, ActorData[id][actorName]);
    ActorData[id][actorLabel] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, ActorData[id][actorPos][0],ActorData[id][actorPos][1],ActorData[id][actorPos][2] + 1.2, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0, ActorData[id][actorVirtualWorld],ActorData[id][actorInterior]);

    ApplyDynamicActorAnimation(ActorData[id][actorDisplay], ActorData[id][actorAnimlib], ActorData[id][actorAnimname], 4.1, 1, 0, 0, 1, 0);
    return 1;
}

Actor_Save(id)
{
    static
        query[1024];

    format(query,sizeof(query),"UPDATE `actor` SET `actorName`='%s', `actorSkin`='%d', `actorX`='%f', `actorY`='%f', `actorZ`='%f', `actorA`='%f',`actorVw`='%d',`actorInt`='%d',`animlib`='%s', `animname`='%s' WHERE `actorID` = '%d'",
        ActorData[id][actorName],
        ActorData[id][actorSkin],
        ActorData[id][actorPos][0],
        ActorData[id][actorPos][1],
        ActorData[id][actorPos][2],
        ActorData[id][actorPos][3],
        ActorData[id][actorVirtualWorld],
        ActorData[id][actorInterior],
        ActorData[id][actorAnimlib],
        ActorData[id][actorAnimname],
        ActorData[id][actorID]
    );
    return mysql_tquery(g_SQL, query);
}

Actor_Delete(actorid)
{
    if (!Iter_Contains(Actors, actorid))
        return 0;

    new
        string[64];

    format(string, sizeof(string), "DELETE FROM `actor` WHERE `actorID` = '%d'", ActorData[actorid][actorID]);
    mysql_tquery(g_SQL, string);

    if(IsValidDynamic3DTextLabel(ActorData[actorid][actorLabel]))
        DestroyDynamic3DTextLabel(ActorData[actorid][actorLabel]);

    if(IsValidDynamicActor(ActorData[actorid][actorDisplay]))
        DestroyDynamicActor(ActorData[actorid][actorDisplay]);
    
    ActorData[actorid][actorID] = INVALID_ITERATOR_SLOT;
    ActorData[actorid][actorLabel] = Text3D:INVALID_STREAMER_ID;
    Iter_Remove(Actors, actorid);
    return 1;
}

// Commands
CMD:createac(playerid, params[])
{
    
    static
        skin,
        name[24],
        id,
        Float:location[4];
        
   	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");    
    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
        
    if(sscanf(params,"ds[24]",skin, name))
        return Usage(playerid, "/createac [skin] [name]");
        
    if(strlen(name) > 24)
        return Error(playerid, "The name to long, maximum character is 24.");

    GetPlayerPos(playerid, location[0], location[1], location[2]);
    GetPlayerFacingAngle(playerid, location[3]);

    id = Actor_Create(name, skin, location[0], location[1], location[2], location[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    SetPlayerPos(playerid, location[0], location[1], location[2]+2);
    
    if(id == INVALID_ITERATOR_SLOT)
        return Error(playerid, "The server has reached the limit for actor.");

    Servers(playerid, "You have successfully created actor ID: %d (total actors: %d).", id, Iter_Count(Actors));
    return 1;
}

CMD:editac(playerid, params[])
{
   	if (pData[playerid][pAlogin] == 0)
		return Error(playerid, "Anda harus login sebagai admin terlebih dahulu");
	if(pData[playerid][pAdminDuty] != 1) return Error(playerid, "Kamu harus on duty sebagai admin!");
    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    new opsi[15], id, string[128];

    if(sscanf(params, "ds[15]S()[24]", id, opsi, string))
        return Usage(playerid, "/editac [actorid] [location/name/skin/animation]");

    if(!Iter_Contains(Actors, id))
        return Error(playerid, "Actor id does not exists.");

    if(!strcmp(opsi, "location", true))
    {
        GetPlayerPos(playerid, ActorData[id][actorPos][0],ActorData[id][actorPos][1],ActorData[id][actorPos][2]);
        GetPlayerFacingAngle(playerid, ActorData[id][actorPos][3]);
        ActorData[id][actorVirtualWorld] = GetPlayerVirtualWorld(playerid);
        ActorData[id][actorInterior] = GetPlayerInterior(playerid);

        Servers(playerid, "You've changed actor location for id %d.", id);
        Actor_Refresh(id);
        Actor_Save(id);
    }
    else if(!strcmp(opsi, "name", true))
    {
        new name[24];

        if(sscanf(string, "s[24]", name))
            return Usage(playerid, "/editactor id name [actor name]");

        if(strval(name) > 24)
            return Error(playerid, "Name is too long.");

        ActorData[id][actorName] = EOS;
        format(ActorData[id][actorName], 24, ColouredText(name));
        Servers(playerid, "You've changed actor name for id %d to %s.", id, ActorData[id][actorName]);
        Actor_Refresh(id);
        Actor_Save(id);
    }
    else if(!strcmp(opsi, "skin", true))
    {
        new skin;

        if(sscanf(string, "d", skin))
            return Usage(playerid, "/editactor id skin [actor skin id]");

        if(skin < 1 || skin > 311)
            return Error(playerid, "Invalid skin id.");

        ActorData[id][actorSkin] = skin;

        Servers(playerid, "You've changed actor skin for id %d to skin id %d.", id, ActorData[id][actorSkin], skin);
        Actor_Refresh(id);
        Actor_Save(id);
    }
    else if(!strcmp(opsi, "animation", true))
    {
        new animlib[32],
            animname[32];

        if(!GetPlayerAnimationIndex(playerid)) return Error(playerid, "You're not play animation on you.");

        GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, sizeof(animlib), animname, sizeof(animname));
        format(ActorData[id][actorAnimlib], 32, animlib);
        format(ActorData[id][actorAnimname], 32, animname);
        Servers(playerid, "You've changed animation for actor id %d (animlib: %s | animname: %s)", id, ActorData[id][actorAnimlib], ActorData[id][actorAnimname]);
        Actor_Refresh(id);
        Actor_Save(id);
    }
    else
        return Usage(playerid, "/editactor [actorid] [location/name/skin/animation]");

    return 1;
}

CMD:destroyac(playerid, params[])
{
    static
        id = 0;

    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "d", id))
        return Usage(playerid, "/destroyactor [actor id]");

    if(!Iter_Contains(Actors, id))
        return Error(playerid, "You have specified an invalid actor ID.");

    Actor_Delete(id);
    Servers(playerid, "You have successfully destroyed actor ID: %d.", id);
    return 1;
}