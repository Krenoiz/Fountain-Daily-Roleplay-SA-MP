/**
 * IsPlayerVehicleAtGarage
 */

IsPlayerVehicleAtGarage(playerid, Index, Garage)
{
    if (pvData[Index][cModel] != 0 && pvData[Index][cRent] == 0 && pvData[Index][vLoaded] && pvData[Index][cOwner] == pData[playerid][pID] && pvData[Index][vInGarage] == Garage) return true;

    return false;
}