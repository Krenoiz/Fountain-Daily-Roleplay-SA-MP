#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    CreateRadialTextDraws(playerid);
}