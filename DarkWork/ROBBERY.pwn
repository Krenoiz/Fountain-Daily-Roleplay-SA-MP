CreateCarStealingPoint()
{
    //JOBS
    new strings[128];
    CreateDynamicPickup(1239, 23, 1114.5065, -319.9304, 73.9922, -1, -1, -1, 50);
    format(strings, sizeof(strings), "[Mulailah Maling Kendaraan]\n{ffffff}/chopvehicle");
    CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1114.5065, -319.9304, 73.9922, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Kurir
}

enum theftEnum
{
	tTime,
};

new theftInfo[theftEnum];

ResetCarStealing()
{
	theftInfo[tTime] = 1;
}


CMD:chopvehicle(playerid, params[]) 
{
    new vehid2 = GetPlayerVehicleID(playerid);
    new clientMessage[128];
    if(theftInfo[tTime] > 0)
    {
        return Info(playerid, "Car Stealing cooldown %i jam. Kamu tidak bisa mencurinya sekarang.", theftInfo[tTime]);
    }
    if((gettime() - pData[playerid][pLastChop]) < 7200000)
    {
        return Error(playerid, " Kamu harus menunggu sekitar 2 Jam lagi untuk mencuri!");
    }
    if(pData[playerid][pFaction] == 1)
    {
        return Error(playerid, "Tolol amat lu ikut fraksi dek");
    }
    if(pData[playerid][pFamily] == -1)
    {
        return Error(playerid, "Anda bukan bagian dari family");
    }
    // If player isn't at the drop point, abort.
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1114.5065, -319.9304, 73.9922)) 
    {
        Error(playerid, "Kamu harus area carstealing untuk mencuri mobil ini.");
        return 1;
    }
        // If player isn't high enough level, abort.
    if(pData[playerid][pLevel] < 4) 
    {
        Error(playerid, "Minimal level 4 untuk menggunakan command ini");
        return 1;
    }
    // If player isn't in a car (driver or passenger), abort.
    if(!IsPlayerInAnyVehicle(playerid)) 
    {
        Error(playerid, "Kamu harus berada di dalam kendaraan untuk mencuri.");
        return 1;
    }
    if(AdminVehicle{vehid2} || pvData[vehid2][cRent] != 0 || IsASweeperVeh(vehid2) || IsABusVeh(vehid2) || IsAForVeh(vehid2) || IsAMowerVeh(vehid2) || IsABaggageVeh(vehid2) || IsADmvVeh(vehid2) || IsSAPDCar(vehid2) || IsGovCar(vehid2) || IsSAMDCar(vehid2) || IsSANACar(vehid2))
    {
        return Error(playerid, "Kendaraan ini tidak dimiliki oleh orang tertentu!.");
    }
    if(Vehicle_IsOwner(playerid, vehid2))
    {
        return Error(playerid, "Kamu tidak bisa mencuri kendaraanmu sendiri!.");
    }
    new count;
    foreach(new i : Player)
    {
        if(pData[i][pFaction] == 1 && pData[i][pOnDuty] == 1)
        {
            count++;
        }
    }
    if(count < 2)
    {
        return Error(playerid, "Setidaknya harus ada 2+ Aparat yang on duty untuk mencuri kendaraan.");
    }

    pData[playerid][pLastChopTime] = 150;
    new mstr[64];
    format(mstr, sizeof(mstr), "Waktu Pencurian ~r~%d ~w~detik", pData[playerid][pLastChopTime]);
    Info(playerid, "Usahakan jangan pergi sebelum SAPD datang dan kamu tidak keluar dari kendaraan yang kamu curi agar berhasil!");
    InfoTD_MSG(playerid, 1000, mstr);
    TogglePlayerControllable(playerid, 0);
    MalingKendaraan = SetTimerEx("CarStealing", 120000, false, "i", playerid);

    //SM(pvData[vehid2][cOwner], "[SMS] From SAPD: Kendaraan anda telah dicuri orang, Kami masih proses penyelidikan");
    format(clientMessage, sizeof(clientMessage), "____________ Fountain Daily Robbery Sirene _____________");
    SendFactionMessage(1, COLOR_YELLOW, clientMessage);
    format(clientMessage,sizeof(clientMessage),"%s{ffffff} telah dilaporkan {FF0000}kendaraan dicuri{FFFFFF}. Lokasi dikirim ke GPSmu.", GetVehicleName(vehid2));
    SendFactionMessage(1, COLOR_YELLOW, clientMessage);
    pData[playerid][pLastChop] = gettime();
      
    ResetCarStealing();
      
    foreach(new p : Player)
    {
        if(pData[p][pFaction] == SAPD)
        {
            SetPlayerRaceCheckpoint(p, 1, 1114.5065, -319.9304, 73.9922, 1114.5065, -319.9304, 73.9922, 4.0);
        }
    }  
	return 1;  
}
