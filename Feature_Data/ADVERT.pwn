#define MAX_ADVERT 100

enum adData
{
	advertID,
	advertExists,
	advertOwner,
	advertText[64],
	advertNumber,
	advertName[32],
	advertTime,
};
new AdvertData[MAX_ADVERT][adData];

Advert_Show(playerid)
{
	new list[2012];
	format(list, sizeof(list), "Owner\tAdvertisement\n");
	for(new i; i < MAX_ADVERT; i++) if(AdvertData[i][advertExists])
	{
	    format(list, sizeof(list), "%s%s[#%d]\t%s\n", list, AdvertData[i][advertName], AdvertData[i][advertNumber], AdvertData[i][advertText]);
	}
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Advertisement List", list, "Close", "");
	return 1;
}

Advert_Count()
{
	new count = 0;
	for(new i = 0; i < MAX_ADVERT; i ++) if(AdvertData[i][advertExists])
	{
	    count++;
	}
	return count;
}

Advert_CountPlayer(playerid)
{
	new count = 0;
	for(new i = 0; i < MAX_ADVERT; i ++) if(AdvertData[i][advertExists])
	{
	    if(AdvertData[i][advertOwner] == pData[playerid][pID])
	    {
	        count++;
		}
	}
	return count;
}

Advert_Create(playerid, text[])
{
	for(new i = 0; i < MAX_ADVERT; i ++) if(!AdvertData[i][advertExists])
	{
	    AdvertData[i][advertExists] = true;
	    AdvertData[i][advertOwner] = pData[playerid][pID];
	    format(AdvertData[i][advertText], 64, text);
	    format(AdvertData[i][advertName], 32, GetName(playerid));
	    AdvertData[i][advertNumber] = pData[playerid][pPhone];
	    AdvertData[i][advertTime] = 60;
	    return i;
	}
	return -1;
}

Advert_Delete(adid)
{
	if (adid != -1 && AdvertData[adid][advertExists])
	{
	    AdvertData[adid][advertExists] = false;
	    AdvertData[adid][advertOwner] = -1;
	}
	return 1;
}

CMD:ads(playerid, params[])
{
	Advert_Show(playerid);
	return 1;
}