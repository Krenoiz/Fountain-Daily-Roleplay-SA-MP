/**
 * Phone
 */

// Command
// #include "CORE-HASH\td\Phone\Command\newphone.pwn"

// Function
#include "CORE-HASH\td\Phone\Function\CreatePhoneTextDraws.pwn"
#include "CORE-HASH\td\Phone\Function\DestroyPhoneTextDraws.pwn"
#include "CORE-HASH\td\Phone\Function\HidePhone.pwn"
#include "CORE-HASH\td\Phone\Function\HidePhoneLockscreen.pwn"
#include "CORE-HASH\td\Phone\Function\HidePhoneMainscreen.pwn"
#include "CORE-HASH\td\Phone\Function\ShowPhoneLockscreen.pwn"
#include "CORE-HASH\td\Phone\Function\ShowPhoneMainscreen.pwn"
#include "CORE-HASH\td\Phone\Function\HidePhoneCallingscreen.pwn"
#include "CORE-HASH\td\Phone\Function\HidePhoneIncomingCallscreen.pwn"
#include "CORE-HASH\td\Phone\Function\ShowPhoneCallingscreen.pwn"
#include "CORE-HASH\td\Phone\Function\ShowPhoneIncomingCallscreen.pwn"

// Hook
#include "CORE-HASH\td\Phone\Hook\hook_OnConnect.pwn"
#include "CORE-HASH\td\Phone\Hook\hook_OnDisconnect.pwn"
#include "CORE-HASH\td\Phone\Hook\hook_OnClickPhone.pwn"