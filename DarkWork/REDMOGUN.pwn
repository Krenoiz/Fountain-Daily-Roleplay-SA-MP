//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CMD:buygun(playerid)
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 290.2280, -109.7393, 1001.5156)) return Error(playerid, "Kamu harus diblackmarket!");
	if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda Belum Mencapai Level 5.");
	if(pData[playerid][pFamily] == -1) return Error(playerid, "Only Family Bro!!.");
    if(pData[playerid][pVerified] == -1) return Error(playerid, "Only Family Bro!!.");

	new Dstring[512];
	format(Dstring, sizeof(Dstring), "WEAPONS\tREDMONEY\n");
	format(Dstring, sizeof(Dstring), "{ffffff}%sDesert Eagle(ammo 350)\t$50.000\n", Dstring);
	format(Dstring, sizeof(Dstring), "{ffffff}%sRiffle(ammo 125)\t$15.000\n", Dstring);
	format(Dstring, sizeof(Dstring), "{ffffff}%sShotgun(ammo 250)\t$15.000\n", Dstring);
	format(Dstring, sizeof(Dstring), "{ffffff}%sUzi(ammo 1500)\t$200.000\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_REDMOGUN, DIALOG_STYLE_TABLIST_HEADERS, "REDMOGUNMARKET", Dstring, "Buygun", "Cancel");
	return 1;
}
////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LENZ : CODER
