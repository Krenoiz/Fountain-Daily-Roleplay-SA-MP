/**
 * Garage System
 */

// Callback
#include "CORE-HASH\Feature\Garage\Callback\OnGarageDataLoaded.pwn"
#include "CORE-HASH\Feature\Garage\Callback\OnGarageDataSaved.pwn"

// Command
#include "CORE-HASH\Feature\Garage\Command\gkedit.pwn"
#include "CORE-HASH\Feature\Garage\Command\gknext.pwn"
#include "CORE-HASH\Feature\Garage\Command\gknear.pwn"

// Dialog
#include "CORE-HASH\Feature\Garage\Dialog\dR_GARAGEMENU.pwn"

// Function
#include "CORE-HASH\Feature\Garage\Function\LoadGarages.pwn"
#include "CORE-HASH\Feature\Garage\Function\SaveGarage.pwn"
#include "CORE-HASH\Feature\Garage\Function\SyncGarage.pwn"
#include "CORE-HASH\Feature\Garage\Function\GetNearbyGarage.pwn"
#include "CORE-HASH\Feature\Garage\Function\RetrieveVehicleFromGarage.pwn"
#include "CORE-HASH\Feature\Garage\Function\IsPlayerVehicleAtGarage.pwn"
#include "CORE-HASH\Feature\Garage\Function\ShowGarageVehicles.pwn"

// Hook
#include "CORE-HASH\Feature\Garage\Hook\hook_OnKeyStateChange.pwn"