CMD:fixme(playerid, params[])
{
    new fixsme[1024];
    format(fixsme, sizeof(fixsme), "Complaint\tDescription\n{ffffff}Visual Bug (WWID)\tIf you can't see any objects/players (in the ghost world).\n{BABABA}Character Stuck\tIf you are stuck (crushed) by an object/vehicle and can't move.\n{ffffff}Cannot Move\tIf you can't move your character (freeze).");
    ShowPlayerDialog(playerid, DIALOG_PISSUE, DIALOG_STYLE_TABLIST_HEADERS, "{FFB6C1}Fountain Daily{FFFFFF} - Fix Me", fixsme, "Select", "Cancel");
    return 1;
}

CMD:fixes(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

	new count = 0;
	new fixestr[4080], lstr[596];
    foreach (new i : Player)
	{
		strcat(fixestr,"Player\tIssue\n",sizeof(fixestr));
	
        if(pData[i][pIssueText])
        {
            count++;
        }

		if(count)
		{
			format(lstr,sizeof(lstr), "{FFFF00}PO: {FFFFFF}%s\t%s", pData[i][pName], pData[i][pIssueText]);
		}
		else format(lstr,sizeof(lstr), "{FFFF00}PO: {FFFFFF}%s\t%s", pData[i][pName], pData[i][pIssueText]);
		strcat(fixestr,lstr,sizeof(fixestr));
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS,"{FFB6C1}Fountain Daily{FFFFFF} - Fix Request", fixestr,"Pilih","Batal");
	return 1;
}