CMD:tags(playerid, params[])
{
	new options[7];

	if (sscanf(params, "s[7]", options))
		return Usage(playerid, "/tag [create/track/clean/info]");

	if(!strcmp(options, "create", true))
	{
		if(pData[playerid][pLevel] < 5)
			return Error(playerid, "Harus level 5 untuk menggunakan perintah ini!");

		if(GetPlayerVirtualWorld(playerid) > 0 || GetPlayerInterior(playerid) > 0)
			return Error(playerid, "Tidak bisa menggunakan perintah ini didalam interior!");

		if(Tags_GetCount(playerid) >= 3)
			return Error(playerid, "Kamu sudah memiliki 3 tags!");

		new Float:x, Float:y, Float:z, Float:angle;

		if(IsPlayerEditingTags(playerid))
			return Usage(playerid, "Selesaikan proses pembuatan tag terlebih dahulu!");

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		x += 0.5 * floatsin(-angle, degrees);
		y += 0.5 * floatcos(-angle, degrees);
		z += 0.5;
		angle += 90;

		Tags_Menu(playerid);
		SetPlayerEditingTags(playerid, true);
		Tags_DefaultVar(playerid, x, y, z, angle);

		editing_object[playerid] = CreateDynamicObject(18661, x, y, z, 0, 0, angle, 0, 0);
		SetDynamicObjectMaterialText(editing_object[playerid], 0, "TEXT", OBJECT_MATERIAL_SIZE_512x512, "Arial", TAGS_DEFAULT_SIZE, 1, RGBAToARGB(ColorList[1]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	}
	else if (!strcmp(options, "clean", true))
	{
		new index;

		if((index = Tags_Nearest(playerid)) != -1)
		{
			if((pData[playerid][pFaction] != 1) && (TagsData[index][tagPlayerID] != pData[playerid][pID]) && (!pData[playerid][pAdmin]))
				return Error(playerid, "~r~ERROR: ~w~Ini bukan tag milikmu!.");

			Tags_Delete(index);
			Servers(playerid, "Spray tag didekatmu telah dihapus!");
		}
		else Error(playerid, "Tidak ada tag didekatmu!");
	}
	else if (!strcmp(options, "info", true))
	{
		if(pData[playerid][pAdmin] < 1)
	        return PermissionError(playerid);

		static index;

		if((index = Tags_Nearest(playerid)) != -1) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Spray Tag - Info", WHITE_E"Text: "YELLOW_E"%s\n"WHITE_E"Created by: "YELLOW_E"%s\n"WHITE_E"Expired Date: "YELLOW_E"%s", "Close", "", TagsData[index][tagText], TagsData[index][tagPlayerName], TagsData[index][tagExpired]/10);
		else Error(playerid, "Tidak ada tag didekatmu!");
	}
	else if (!strcmp(options, "track", true))
	{
		if(!Tags_GetCount(playerid))
			return Error(playerid, "Kamu tidak memiliki tags!");

		new output[128];

		strcat(output, "Index\tLocation\n");
		foreach(new i : Tags) if(TagsData[i][tagPlayerID] == pData[playerid][pID])
			strcat(output, sprintf("%d\t%s\n", i, GetLocation(TagsData[i][tagPosition][0], TagsData[i][tagPosition][1], TagsData[i][tagPosition][2])));

		Dialog_Show(playerid, TrackTags, DIALOG_STYLE_TABLIST_HEADERS, "My Tags", output, "Track", "Close");
	}
	else Usage(playerid, "/tag [create/track/clean/info]");
	return 1;
}