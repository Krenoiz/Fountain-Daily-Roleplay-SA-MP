#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
    DestroySpeedoTextDraws(playerid);
}