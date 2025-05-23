#include <YSI_Coding\y_hooks>
//======== Streak ===========
#define streakpoint1 	1741.9521, -1953.8751, 13.5469
#define streakpoint2 	2283.8499, -875.1978, 29.2424
#define streakpoint3 	2765.1484, 391.7212, 9.0006
#define streakpoint4 	2782.7856, 1951.9636, 5.8756
#define streakpoint5 	2515.3599, 2645.0532, 12.1256
#define streakpoint6 	1911.3981, 2694.1250, 12.1256
#define streakpoint7 	1089.6060, 2708.0635, 15.3490
#define streakpoint8	-409.5888, 1228.8097, 31.9929
#define streakpoint9 	-1965.7073, -352.3301, 27.0006
#define streakpoint10	64.0489, -1018.1808, 22.9314
#define streakpoint11	1708.2813, -1953.7509, 13.5469
#define streakpoint12 	1681.1833, -1953.6350, 14.8756


new StreakVeh[1];

AddStreakVehicle()
{
	StreakVeh[0] = AddStaticVehicleEx(538, 1695.9348, -1953.6438, 14.8756, 89.9081, 100, 100, VEHICLE_RESPAWN);

}
IsAStreakVeh(carid)
{
    for(new v = 0; v < 1; v++) { 
        if(carid == StreakVeh[v]) return 1;
    }
    return 0;
}
