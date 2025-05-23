/**
 * Shooting Range System
 */

// Callback
#include "CORE-HASH\Feature\ShootingRange\Callback\OnDynamicObjectMoved.pwn"
#include "CORE-HASH\Feature\ShootingRange\Callback\OnPlayerShootDynamicObject.pwn"
#include "CORE-HASH\Feature\ShootingRange\Callback\StopTraining.pwn"

// Command
#include "CORE-HASH\Feature\ShootingRange\Command\gunskill.pwn"
#include "CORE-HASH\Feature\ShootingRange\Command\training.pwn"

// Dialog
#include "CORE-HASH\Feature\ShootingRange\Dialog\dR_TRAINING.pwn"

// Function
#include "CORE-HASH\Feature\ShootingRange\Function\CreateTrainingObject.pwn"
#include "CORE-HASH\Feature\ShootingRange\Function\SyncWeaponSkill.pwn"
#include "CORE-HASH\Feature\ShootingRange\Function\CreateTrainingTextDraw.pwn"
#include "CORE-HASH\Feature\ShootingRange\Function\DestroyTrainingTextDraw.pwn"
#include "CORE-HASH\Feature\ShootingRange\Function\ShowBoxTraining.pwn"