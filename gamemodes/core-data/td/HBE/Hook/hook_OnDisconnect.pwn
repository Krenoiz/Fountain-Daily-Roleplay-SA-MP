#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyHBETextDraws(playerid);
}