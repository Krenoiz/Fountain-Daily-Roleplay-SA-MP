/**
 * Command: /gkedit
 */
 
SSCANF:GKOptions(String[]) 
{
    if (!strcmp(String, "InPos", true)) return 1;
    else if (!strcmp(String, "OutPos", true)) return 2;
    else if (!strcmp(String, "Name", true)) return 3;
    else if (!strcmp(String, "Delete", true)) return 4;
    return 0;
}

CMD:gkedit(playerid, params[])
{
    new String[144];

    if (pData[playerid][pAdmin] >= 7)
    {
        new Choice, Id, Choice2[32];

        if (sscanf(params, "k<GKOptions>iS()[32]", Choice, Id, Choice2))
        {
            SCM(playerid, COLOR_WHITE, "/gkedit [name] [Garage ID]");
            SCM(playerid, COLOR_GREEN, "Available Names:");
            SCM(playerid, COLOR_WHITE, "InPos, OutPos, Name, Delete");
            return 1;
        }

        if (!(0 <= Id < MAX_GARAGES))
            return Error(playerid, "Invalid garage id.");

        switch(Choice)
        {
            case 1: // In Position
            {
                GetPlayerPos(playerid, GarageInfo[Id][gkInX], GarageInfo[Id][gkInY], GarageInfo[Id][gkInZ]);
                GarageInfo[Id][gkInt] = GetPlayerInterior(playerid);
                GarageInfo[Id][gkVW] = GetPlayerVirtualWorld(playerid);

                format(String, sizeof String, "* You have changed the position of Garage (in position) ID %d.", Id);
                SCM(playerid, COLOR_YELLOW, String);
                SyncGarage(Id);
                SaveGarage(Id);
            }
            case 2: // Out Position
            {
                GetPlayerPos(playerid, GarageInfo[Id][gkOutX], GarageInfo[Id][gkOutY], GarageInfo[Id][gkOutZ]);
                GetPlayerFacingAngle(playerid, GarageInfo[Id][gkOutA]);

                format(String, sizeof String, "* You have changed the position of Garage (out position) ID %d.", Id);
                SCM(playerid, COLOR_YELLOW, String);
                SyncGarage(Id);
                SaveGarage(Id);
            }
            case 3: // Name
            {
                new NewName[32];
                if (sscanf(Choice2, "s[32]", NewName))
                    return SyntaxMsg(playerid, "/gkedit Name [garage id] [new name]");

                if (strlen(NewName) > 32)
                    return Error(playerid, "Name is too long. (Max: 32 characters)");

                strcpy(GarageInfo[Id][gkName], NewName);

                SyncGarage(Id);
                SaveGarage(Id);
            }
            case 4: // delete
            {
                GarageInfo[Id][gkInX] = 0.0;
                GarageInfo[Id][gkInY] = 0.0;
                GarageInfo[Id][gkInZ] = 0.0;
                GarageInfo[Id][gkOutX] = 0.0;
                GarageInfo[Id][gkOutY] = 0.0;
                GarageInfo[Id][gkOutZ] = 0.0;
                GarageInfo[Id][gkOutA] = 0.0;
                GarageInfo[Id][gkVW] = 0;
                GarageInfo[Id][gkInt] = 0;

                SyncGarage(Id);
                SaveGarage(Id);

                format(String, sizeof String, "* You have deleted Garage ID %d.", Id);
                SCM(playerid, COLOR_YELLOW, String);
            }
            default: Error(playerid, "Invalid option.");
        }
    }
    else Error(playerid, "You don't have any permission to use this command.");

    return 1;
}