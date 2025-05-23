#define SMALL_QUAKE 5

new AmountOfShakes[ MAX_PLAYERS ];

Function:SetPlayerEarthquakeEffect( playerid, amount_of_shakes ){
    if( amount_of_shakes < AmountOfShakes[ playerid ] )
    //    return 0;
    AmountOfShakes[ playerid ] = amount_of_shakes;
    new vehicleid = GetPlayerVehicleID( playerid );
    if( vehicleid ){
        if(amount_of_shakes <= SMALL_QUAKE+200 ){
            SetVehicleAngularVelocity( vehicleid, 0.09, 0.033, 0.05 );
        } else SetVehicleAngularVelocity( vehicleid, 0.03, 0.03, 0.03 );
    }
    return EarthquakeEffects( playerid, 10, false );
}

Function:EarthquakeEffects( playerid, interval, bool:status ){
    if( AmountOfShakes[ playerid ] <= 0 )
        return SetPlayerDrunkLevel( playerid, 0 );
    if( !(AmountOfShakes[ playerid ]%5) ){
        new vehicleid = GetPlayerVehicleID( playerid );
        if(vehicleid){
            if(AmountOfShakes[ playerid ] <= SMALL_QUAKE+200 ){
                SetVehicleAngularVelocity( vehicleid, 0.03, 0.03, 0.03 );
            } else SetVehicleAngularVelocity( vehicleid, 0.015, 0.015, 0.015 );
        }
    }
    if( status ){
        SetPlayerDrunkLevel( playerid, 3000 );
    } else SetPlayerDrunkLevel( playerid, 50000 );
    AmountOfShakes[ playerid ]--;
    return SetTimerEx( "EarthquakeEffects", interval, false, "iii", playerid, interval, !status );
}

CMD:earthquake(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7)
		return PermissionError(playerid);

    new amount_of_shakes;
    if(sscanf(params, "i", amount_of_shakes))
        return SendSyntaxMessage(playerid, "/earthquake [interval]");

    if(amount_of_shakes < 0) return 0;

    foreach (new i : Player) {
        SetPlayerEarthquakeEffect( i, amount_of_shakes );
    }
    return 1;
}
