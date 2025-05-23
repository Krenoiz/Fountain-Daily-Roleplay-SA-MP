
/* CMD:su(playerid, params[])
{
	new targetid, crime[128];

    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "You must be a police officer.");

	if(sscanf(params, "us[128]", targetid, crime))
	{
	    Usage(playerid, "/su [playerid] [crime]");
	    return 1;
	}
	if (!IsPlayerConnected(targetid)) return Error(playerid, "The specified player is not connected!");
	else
	{
	    if(pData[targetid][pWanted] < 7)
	    {
			SetPlayerCriminal(playerid, targetid, crime);
		}
		else
		{
		    return Error(playerid, "That player has reached the maximum amount of warants!");
		}
	}
	return 1;
} 

SetPlayerCriminal(playerid, targetid, string[])
{
	new astring[128];
	switch(pData[targetid][pWanted])
	{
	    case 0:
	    {
	        pData[targetid][pWanted] ++;
	        format(astring, 156, "** %s %s has placed a warrant on %s(%s) **", GetFactionRank(playerid), pData[playerid][pName], pData[targetid][pName], string);
			SendFactionMessage(1, COLOR_RADIO, astring);
			format(astring, 156, "** %s %s has placed a warrant on you for %s **", GetFactionRank(playerid), pData[playerid][pName] , string);
			SendClientMessageEx(targetid, COLOR_RADIO, astring);
			format(pData[targetid][pWarrant1], 72, "%s", string);
			SetPlayerWantedLevel(targetid, pData[targetid][pWanted]);
	    }
	    case 1:
	    {
	        pData[targetid][pWanted] ++;
	        format(astring, 156, "** %s %s has placed a warrant on %s(%s) **", GetFactionRank(playerid), pData[playerid][pName], pData[targetid][pName], string);
			SendFactionMessage(1, COLOR_RADIO, astring);
			format(astring, 156, "** %s %s has placed a warrant on you for %s **", GetFactionRank(playerid), pData[playerid][pName] , string);
			SendClientMessageEx(targetid, COLOR_RADIO, astring);
			format(pData[targetid][pWarrant2], 72, "%s", string);
			SetPlayerWantedLevel(targetid, pData[targetid][pWanted]);
	    }
	    case 2:
	    {
	        pData[targetid][pWanted] ++;
	        format(astring, 156, "** %s %s has placed a warrant on %s(%s) **", GetFactionRank(playerid), pData[playerid][pName], pData[targetid][pName], string);
			SendFactionMessage(1, COLOR_RADIO, astring);
			format(astring, 156, "** %s %s has placed a warrant on you for %s **", GetFactionRank(playerid), pData[playerid][pName] , string);
			SendClientMessageEx(targetid, COLOR_RADIO, astring);
			format(pData[targetid][pWarrant3], 72, "%s", string);
			SetPlayerWantedLevel(targetid, pData[targetid][pWanted]);
	    }
	    case 3:
	    {
	        pData[targetid][pWanted] ++;
	        format(astring, 156, "** %s %s has placed a warrant on %s(%s) **", GetFactionRank(playerid), pData[playerid][pName], pData[targetid][pName], string);
			SendFactionMessage(1, COLOR_RADIO, astring);
			format(astring, 156, "** %s %s has placed a warrant on you for %s **", GetFactionRank(playerid), pData[playerid][pName] , string);
			SendClientMessageEx(targetid, COLOR_RADIO, astring);
			format(pData[targetid][pWarrant4], 72, "%s", string);
			SetPlayerWantedLevel(targetid, pData[targetid][pWanted]);
	    }
	    case 4:
	    {
	        pData[targetid][pWanted] ++;
	        format(astring, 156, "** %s %s has placed a warrant on %s(%s) **", GetFactionRank(playerid), pData[playerid][pName], pData[targetid][pName], string);
			SendFactionMessage(1, COLOR_RADIO, astring);
			format(astring, 156, "** %s %s has placed a warrant on you for %s **", GetFactionRank(playerid), pData[playerid][pName] , string);
			SendClientMessageEx(targetid, COLOR_RADIO, astring);
			format(pData[targetid][pWarrant5], 72, "%s", string);
			SetPlayerWantedLevel(targetid, pData[targetid][pWanted]);
	    }
	    case 5:
	    {
	        pData[targetid][pWanted] ++;
	        format(astring, 156, "** %s %s has placed a warrant on %s(%s) **", GetFactionRank(playerid), pData[playerid][pName], pData[targetid][pName], string);
			SendFactionMessage(1, COLOR_RADIO, astring);
			format(astring, 156, "** %s %s has placed a warrant on you for %s **", GetFactionRank(playerid), pData[playerid][pName] , string);
			SendClientMessageEx(targetid, COLOR_RADIO, astring);
			format(pData[targetid][pWarrant6], 72, "%s", string);
			SetPlayerWantedLevel(targetid, pData[targetid][pWanted]);
	    }
	}
	return 1;
}

CMD:mycrimerecord(playerid, params[])
{
    if(pData[playerid][pWanted] > 0)
    {
		new irwan[500];
        SendClientMessageEx(playerid, COLOR_BLUE, "|==================| Criminal Record |==================|");
	    format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[playerid][pWarrant1]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s",pData[playerid][pWarrant2]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[playerid][pWarrant3]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[playerid][pWarrant4]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[playerid][pWarrant5]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[playerid][pWarrant6]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
        SendClientMessageEx(playerid, COLOR_BLUE, "-----------------------------------------------------------");
    }
    else 
    {
        Error(playerid, "Anda tidak mempunyai catatan kriminal");
    }
    return 1;
}

CMD:wanted(playerid, params[])
{
	new string[128], totalcriminals = 0;
	if(pData[playerid][pFaction] == 1)
	{
	    foreach(new i : Player)
		{
			if(pData[i][pWanted] > 0)
			{
			    SendClientMessageEx(playerid, COLOR_BLUE, "|==================| Criminal Report |==================|");
			    format(string, sizeof(string), "%s (%d warrants).", pData[i][pName], pData[i][pWanted]);
			    SendClientMessageEx(playerid, COLOR_WHITE, string);
	            totalcriminals++;
			}
		}
		if(totalcriminals == 0)   return Error(playerid, "There are no criminals in town!");
	}
	else return Error(playerid, "You are not authorized to use this command!");
	return 1;
}

CMD:cekcrimerecord(playerid, params[])
{
    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "You must be a police officer.");
    new targetid;
	if(sscanf(params, "u", targetid))
	{
	    Usage(playerid, "/cekcrimerecord [playerid]");
	    return 1;
	}
	if (!IsPlayerConnected(targetid)) return Error(playerid, "The specified player is not connected!");
    if(pData[targetid][pWanted] > 0)
    {
		new irwan[500];
        SendClientMessageEx(playerid, COLOR_BLUE, "|==================| Criminal Record |==================|");
	    format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[targetid][pWarrant1]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s",pData[targetid][pWarrant2]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[targetid][pWarrant3]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[targetid][pWarrant4]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[targetid][pWarrant5]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
		format(irwan, sizeof(irwan), "Crime Record - "YELLOW_E"%s", pData[targetid][pWarrant6]);
		SendClientMessageEx(playerid, COLOR_BLUE, irwan);
        SendClientMessageEx(playerid, COLOR_BLUE, "-----------------------------------------------------------");
    }
    else 
    {
        Error(playerid, "Player tidak mempunyai catatan kriminal");
    }
    return 1;
}

CMD:clearcrimerecord(playerid, params[])
{
    if(pData[playerid][pFaction] != 1)
        return Error(playerid, "You must be a police officer.");

	if(pData[playerid][pFactionRank] < 4)
		return Error(playerid, "Only faction level 4-6");

    new targetid, string[212];
	if(sscanf(params, "u", targetid))
	{
	    Usage(playerid, "/clearcrimerecord [playerid]");
	    return 1;
	}
	if (!IsPlayerConnected(targetid)) return Error(playerid, "The specified player is not connected!");
    if(pData[targetid][pWanted] == 0)
        return Error(playerid, "That player is not wanted!");

    pData[targetid][pWanted] = 0;
    format(pData[targetid][pWarrant1], 10, "");
    format(pData[targetid][pWarrant2], 10, "");
    format(pData[targetid][pWarrant3], 10, "");
    format(pData[targetid][pWarrant4], 10, "");
    format(pData[targetid][pWarrant5], 10, "");
    format(pData[targetid][pWarrant6], 10, "");

    SetPlayerWantedLevel(targetid, 0);

    format(string, sizeof(string), "CRIME: "WHITE_E"You have cleared %s's crimnal record.", pData[targetid][pName]);
    SendClientMessageEx(playerid, COLOR_BLUE, string);

    format(string, sizeof(string), "CRIME: "WHITE_E"Your criminal record was cleared by %s", pData[playerid][pName]);
    SendClientMessageEx(targetid, COLOR_BLUE, string);
    return 1;
}*/