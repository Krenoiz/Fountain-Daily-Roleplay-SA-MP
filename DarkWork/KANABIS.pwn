function olah1(playerid)
{
	ShowItemBox(playerid, "Marijuana", "ADD_1x", 1578, 4);
	pData[playerid][pMarijuana] ++;
	pData[playerid][pKanabis] -= 1;
	ClearAnimations(playerid);
    if(pData[playerid][pFaction] == 1)
	{
		SendFactionMessage(1, COLOR_BLUE, "ALLERT: "WHITE_E"Saat ini ada seseorang yang mengambil kanabis Lokasi Telah Di Tandai");
	}
    foreach(new p : Player)
    {
        if(pData[p][pFaction] == SAPD)
        {
            SetPlayerRaceCheckpoint(p, 1, 887.3530, -20.0613, 63.3195, 887.3530, -20.0613, 63.3195, 4.0);
        }
    }  
	return 1;
}

function ambil1(playerid)
{
	ShowItemBox(playerid, "Kanabis", "ADD_1x", 800, 4);
	pData[playerid][pKanabis] ++;
	ClearAnimations(playerid);
	return 1;
}
CMD:olahkanabis(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 287.7309, -105.9845, 1001.5156)) return Error(playerid, "Kamu harus diblackmarket!");
	if(pData[playerid][pFamily] == -1) return Error(playerid, "Kamu bukan anggota Geng/ Family.");
	if(pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
	if(pData[playerid][pKanabis] < 1) return Error(playerid, "Anda Tidak memiliki kanabis");
	ShowProgressbar(playerid, "Mengolah kanabis..", 10);
	//ShowProgressbar(playerid, 35, "Mengolah...");
	ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.0, 1, 0, 0, 0, 0,1);
	SetTimerEx("olah1", 9000, false, "d", playerid);
	return 1;
}

CMD:ambilkanabis(playerid, params[])
{
	if(pData[playerid][pFamily] == -1) return Error(playerid, "Kamu bukan anggota Geng/ Family.");
	if(pData[playerid][pProgress] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
	if(pData[playerid][pKanabis] > 7) return Error(playerid, "Anda Tidak bisa membawa lebih dari 8 kanabis");
	//ShowProgressbar(playerid, "Mengambil kanabis..", 10);
	ShowProgressbar(playerid, "Mengambil kanabis..", 10);
	//StartPlayerLoadingBar(playerid, 35, "Mengambil...");
	ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0, 1, 0, 0, 0, 0, 1);
	SetTimerEx("ambil1", 9000, false, "d", playerid);
	return 1;
}