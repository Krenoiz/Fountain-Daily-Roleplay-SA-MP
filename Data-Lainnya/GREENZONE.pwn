#define MAX_GREENZONE (14)

new GreenZoneArea[MAX_GREENZONE] = {INVALID_STREAMER_ID, ...},
		GangZoneID;

new Float:busSidejob_Point[] = {
	906.0, -1390.0, 1049.0, -1266.0 
};
new Float:asgh_Point[] = {
	1068.0, -1390.0, 1286.0, -1275.0 
};
new Float:sapd_Point[] = {
	1433.0, -1727.0, 1625.0, -1596.0 
};
new Float:cityHall_Point[] = {
	1393.0, -1868.0, 1577.0, -1729.0 
};
new Float:sana_Point[] = {
	620.0, -1391.0, 793.0, -1313.0 
};
new Float:marketStation_Point[] = {
	802.0, -1390.0, 868.0, -1313.0 
};
new Float:sweeperSidejob_Point[] = {
	1368.0, -1631.0, 1425.0, -1550.0 
};
new Float:sorting_Point[] = {
	-326.0, -2221.0, -240.0, -2145.0 
};
new Float:cargo_Point[] = {
	-78.0, -301.0, 18.0, -192.0 
};
new Float:smb_Point[] = {
	57.0, -1975.0, 226.0, -1769.0 
};
new Float:fishFactory_Point[] = {
	2784.0, -1603.0, 2981.0, -1476.0 
};
new Float:miner_Point[] = {
	500.0, 807.0, 704.0, 939.0 
};
new Float:lsp_Point[] = {
	1743.0, -1613.0, 1849.0, -1511.0 
};
new Float:newbieSchool_Point[] = {
	652.0, -1309.0, 787.0, -1217.0 
};

#include <YSI\y_hooks>
hook OnGameModeInitEx() {
	GreenZoneArea[0] = CreateDynamicRectangle(busSidejob_Point[0], busSidejob_Point[1], busSidejob_Point[2], busSidejob_Point[3], 0, 0);
	GreenZoneArea[1] = CreateDynamicRectangle(asgh_Point[0], asgh_Point[1], asgh_Point[2], asgh_Point[3], 0, 0);
	GreenZoneArea[2] = CreateDynamicRectangle(sapd_Point[0], sapd_Point[1], sapd_Point[2], sapd_Point[3], 0, 0);
	GreenZoneArea[3] = CreateDynamicRectangle(cityHall_Point[0], cityHall_Point[1], cityHall_Point[2], cityHall_Point[3], 0, 0);
	GreenZoneArea[4] = CreateDynamicRectangle(sana_Point[0], sana_Point[1], sana_Point[2], sana_Point[3], 0, 0);
	GreenZoneArea[5] = CreateDynamicRectangle(marketStation_Point[0], marketStation_Point[1], marketStation_Point[2], marketStation_Point[3], 0, 0);
	GreenZoneArea[6] = CreateDynamicRectangle(sweeperSidejob_Point[0], sweeperSidejob_Point[1], sweeperSidejob_Point[2], sweeperSidejob_Point[3], 0, 0);
	GreenZoneArea[7] = CreateDynamicRectangle(sorting_Point[0], sorting_Point[1], sorting_Point[2], sorting_Point[3], 0, 0);
	GreenZoneArea[8] = CreateDynamicRectangle(cargo_Point[0], cargo_Point[1], cargo_Point[2], cargo_Point[3], 0, 0);
	GreenZoneArea[9] = CreateDynamicRectangle(smb_Point[0], smb_Point[1], smb_Point[2], smb_Point[3], 0, 0);
	GreenZoneArea[10] = CreateDynamicRectangle(fishFactory_Point[0], fishFactory_Point[1], fishFactory_Point[2], fishFactory_Point[3], 0, 0);
	GreenZoneArea[11] = CreateDynamicRectangle(miner_Point[0], miner_Point[1], miner_Point[2], miner_Point[3], 0, 0);
	GreenZoneArea[12] = CreateDynamicRectangle(lsp_Point[0], lsp_Point[1], lsp_Point[2], lsp_Point[3], 0, 0);
	GreenZoneArea[13] = CreateDynamicRectangle(newbieSchool_Point[0], newbieSchool_Point[1], newbieSchool_Point[2], newbieSchool_Point[3], 0, 0);

	GangZoneID = GangZoneCreate(-3000, -3000, 3000, 3000);
	
	return 1;
}


hook OnPlayerEnterDynArea(playerid, areaid) {
    if (IsPlayerConnected(playerid)) {
        for (new i = 0; i < MAX_GREENZONE; i ++) if (areaid == GreenZoneArea[i]) {
            if (i == 1 || i == 2 || i == 3 || i == 12 || i == 13) {
                GangZoneShowForPlayer(playerid, GangZoneID, 0x0000FF66);
                GangZoneFlashForPlayer(playerid, GangZoneID, 0x0000FF66);
            } else {
                GangZoneShowForPlayer(playerid, GangZoneID, 0x00FF0066);
                GangZoneFlashForPlayer(playerid, GangZoneID, 0x00FF0066);
            }
        }
    }

    return 1;
}


hook OnPlayerLeaveDynArea(playerid, areaid) {
    if (IsPlayerConnected(playerid)) {
        for (new i = 0; i < MAX_GREENZONE; i ++) if (areaid == GreenZoneArea[i]) {
            GangZoneHideForPlayer(playerid, GangZoneID);
            GangZoneStopFlashForPlayer(playerid, GangZoneID);
        }
    }

    return 1;
}