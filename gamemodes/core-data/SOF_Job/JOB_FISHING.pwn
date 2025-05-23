//==============[ Fishing ]
#define fishing1 	441.4902, -1963.4465, 1.0000
#define fishing2 	451.2530, -2084.9646, 1.0000
#define fishing3 	589.7161, -2106.9531, 1.0000
#define fishing4 	585.0607, -2219.6614, 1.0000
#define fishing5 	497.0680, -2270.9954, 1.0000
#define fishing6 	537.1627, -2375.4541, 1.0000
#define fishing7 	720.8754, -2305.7004, 1.0000
#define fishing8 	900.0414, -2213.6882, 1.0000
#define fishing9 	921.1352, -2097.7412, 1.0000
#define fishing10	763.1146, -2068.8018, 1.0000
#define fishing11 	641.3939, -1960.3282, 1.0000
#define fishing12 	477.8578, -1956.9999, 1.0000

new BoatVeh[4];

AddBoatVeh()
{
    BoatVeh[0] = AddStaticVehicleEx(453, 451.6560, -1930.9999, 4.0715, 90.0000, 0, 0, VEHICLE_RESPAWN);
	BoatVeh[1] = AddStaticVehicleEx(453, 451.3568, -1938.1527, 4.0715, 90.0000, 0, 0, VEHICLE_RESPAWN);
	BoatVeh[2] = AddStaticVehicleEx(453, 414.9229, -1938.4740, 4.0715, 270.0000, 0, 0, VEHICLE_RESPAWN);
	BoatVeh[3] = AddStaticVehicleEx(453, 416.7606, -1931.8820, 4.0715, 270.0000, 0, 0, VEHICLE_RESPAWN);
}

IsABoatVeh(carid)
{
	for(new v = 0; v < sizeof(BoatVeh); v++) {
	    if(carid == BoatVeh[v]) return 1;
	}
	return 0;
}