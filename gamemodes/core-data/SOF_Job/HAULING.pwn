#define MAX_TRAILERS 10 

new Float:trailerSpawnPositions[MAX_TRAILERS][4] = {
    {-1016.3370,-681.1544,32.6586,0.9607},      // Trailer 1
    {-981.1186,-703.9873,32.6655,0.5025},       // Trailer 2
    {2678.2114,-2534.2019,14.0021,359.8166},     // Trailer 3
    {-1945.8602,-1077.5360,31.4557,359.8189},   // Trailer 4
    {-143.3597,-209.5456,2.0831,78.8503},       // Trailer 5
    {-167.2143,-223.7070,2.0841,91.5038},       // Trailer 6
    {1731.2153,720.7055,11.4670,91.2018},       // Trailer 7
    {1695.9073,764.5255,11.4769,179.3070},      // Trailer 8
    {1195.4628,247.3265,20.2097,336.2903},      // Trailer 9
    {-2444.1250,2230.7593,5.5002,91.4045}       // Trailer 10
};

new Float:deliveryCheckpoints[MAX_TRAILERS][3] = {
    {2906.3469,2442.7317,10.8203}, // Checkpoint 1
    {2787.2158,-2494.8506,13.6510}, // Checkpoint 2
    {-2469.4702,786.4584,35.1719}, // Checkpoint 3
    {2505.5015,-2629.8391,13.6472}, //Checkpoint 4
    {2125.2888,954.0547,10.8130}, // Checkpoint 5
    {2478.8606,2773.2065,10.7407}, // Checkpoint 6
    {-2262.0708,2289.7231,4.8202}, // Checkpoint 7
    {2099.7368,-2241.4036,30.6250}, // Checkpoint 8
    {-532.7147,2555.4321,53.4154}, // Checkpoint 9
    {2227.3262,-2679.7625,13.5409}  // Checkpoint 10
};
new locationNames[MAX_TRAILERS][32] = {
    "Easter Bay Chemicals",
    "Easter Bay Chemicals",
    "Ocean Docks",
    "Foster Valley",
    "Blueberry Acres",
    "Blueberry Acres",
    "Randolph Industrial",
    "Randolph Industrial",
    "Montgomery",
    "Bayside"
};

new trailerStatus[MAX_TRAILERS]; 
new earnings[MAX_TRAILERS] = {
    1880, // Easter Bay Chemicals
    2567, // Easter Bay Chemicals
    2572,  // Ocean Docks
    2190, // Foster Valley
    2145, // Blueberry Acres
    2928,  // Blueberry Acres
    1952,  // Randolph Industrial
    2105, // Randolph Industrial
    3015,  // Montgomery
    3095,  // Bayside
};

CMD:hauling(playerid, params[])
{
    if(pData[playerid][pTruckerHeavyLicense] == 0)
		return Error(playerid, "Anda tidak memiliki license truck hauling!");
    if(pData[playerid][pDelayHauling] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa hauling kembali.", pData[playerid][pDelayHauling]);
    new vehicleid = GetPlayerVehicleID(playerid);
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER || !IsAHaulTruck(vehicleid)) 
            return Error(playerid, "Anda harus mengendarai truk Hauling.");
    if(pData[playerid][pLevel] < 5)
			return Error(playerid, "You must level 5 to use this!");
    if (pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
    {
        new string[2048]; 
        string[0] = '\0'; 

        format(string, sizeof(string), "List Delivery\tStatus\tEarnings\n");

        for (new i = 0; i < MAX_TRAILERS; i++)
        {
            new status[32];
            if (trailerStatus[i] == 0) 
            {
                format(status, sizeof(status), "{33ee33}Available");
            }
            else
            {
                format(status, sizeof(status), "{ff0000}Taken");
            }
            format(string, sizeof(string), "%s %d.%s \t%s \t{33ee33}$%d\n", string, i + 1, locationNames[i], status, earnings[i]);
        }
        ShowPlayerDialog(playerid, DIALOG_HAULING_FD, DIALOG_STYLE_TABLIST_HEADERS, "Menu Trucker", string, "Select", "Cancel");
    }
    else 
    {
        return Error(playerid, "You are not a trucker.");
    }
    return 1;
}

