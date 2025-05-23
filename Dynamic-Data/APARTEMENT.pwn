

	
// -----------------------------------------------------------------------------
// Includes
// --------

// -----------------------------------------------------------------------------
// Defines
// -------

// Movement speed of the elevator
#define ELEVATOR_SPEED      (2.0)

// Movement speed of the doors
#define DOORS_SPEED         (2.0)

// Time in ms that the elevator will wait in each floor before continuing with the queue...
// be sure to give enough time for doors to open
#define ELEVATOR_WAIT_TIME  (5000)

// Dialog ID for the LS Apartments building elevator dialog
#define DIALOG_ID           (876)

// Position defines
#define Y_DOOR_CLOSED       (-1180.535917)
#define Y_DOOR_R_OPENED     Y_DOOR_CLOSED - 1.6
#define Y_DOOR_L_OPENED     Y_DOOR_CLOSED + 1.6

#define GROUND_Z_COORD      (20.879316)

#define ELEVATOR_OFFSET     (0.059523)

#define X_ELEVATOR_POS      (1181.622924)
#define Y_ELEVATOR_POS      (-1180.554687)

// Elevator state defines
#define ELEVATOR_STATE_IDLE     (0)
#define ELEVATOR_STATE_WAITING  (1)
#define ELEVATOR_STATE_MOVING   (2)

// Invalid floor define
#define INVALID_FLOOR           (-1)

// Used for chat text messages
#define COLOR_MESSAGE_YELLOW        0xFFDD00AA


// -----------------------------------------------------------------------------
// Constants
// ---------

// Elevator floor names for the 3D text labels
static FloorNames[11][] =
{
	"Car Park",
	"Ground Floor",
	"First Floor",
	"Second Floor",
	"Third Floor",
	"Fourth Floor",
	"Fifth Floor",
	"Sixth Floor",
	"Seventh Floor",
	"Eighth Floor",
	"Ninth Floor"
};

// Elevator floor Z heights
static Float:FloorZOffsets[11] =
{
    0.0, 		// Car Park
    13.604544,	// Ground Floor
    18.808519,	// First Floor = 13.604544 + 5.203975
    24.012494,  // Second Floor = 18.808519 + 5.203975
    29.216469,  // Third Floor = 24.012494 + 5.203975
    34.420444,  // Fourth Floor = 29.216469 + 5.203975
    39.624419,  // Fifth Floor = 34.420444 + 5.203975
    44.828394,  // Sixth Floor = 39.624419 + 5.203975
    50.032369,  // Seventh Floor = 44.828394 + 5.203975
    55.236344,  // Eighth Floor = 50.032369 + 5.203975
    60.440319   // Ninth Floor = 55.236344 + 5.203975
};

// ------------------------------------------------------------------------------
// Variables
// ---------

// Stores the created object number of the replacement building so it can be
// destroyed when the filterscript is unloaded
new LSApartments1Object;

// Stores the created object number of the new cark park so it can be
// destroyed when the filterscript is unloaded
new LSApartments1CPObject;

// Stores the created object numbers of the elevator, the elevator doors and
// the elevator floor doors so they can be destroyed when the filterscript
// is unloaded
new Obj_Elevator, Obj_ElevatorDoors[2], Obj_FloorDoors[11][2];

// Stores a reference to the 3D text labels used on each floor and inside the
// elevator itself so they can be detroyed when the filterscript is unloaded
new Text3D:Label_Elevator, Text3D:Label_Floors[11];

// Stores the current state of the elevator (ie ELEVATOR_STATE_IDLE,
// ELEVATOR_STATE_WAITING or ELEVATOR_STATE_MOVING)
new ElevatorState;

// Stores the current floor the elevator is on or heading to... if the value is
// ELEVATOR_STATE_IDLE or ELEVATOR_STATE_WAITING this is the current floor. If
// the value is ELEVATOR_STATE_MOVING then it is the floor it's moving to
new	ElevatorFloor;

// Stores the elevator queue for each floor
new ElevatorQueue[11];

// Stores who requested the floor for the elevator queue...
// FloorRequestedBy[floor_id] = playerid;  (stores who requested which floor)
new	FloorRequestedBy[11];

// Used for a timer that makes the elevator move faster after players start
// surfing the object
new ElevatorBoostTimer;

// ------------------------------------------------------------------------------
// Function Forwards
// -----------------

// Public:
forward CallElevator(playerid, floorid);    // You can use INVALID_PLAYER_ID too.
forward ShowElevatorDialog(playerid);

// Private:
forward Elevator_Initialize();
forward Elevator_Destroy();

forward Elevator_OpenDoors();
forward Elevator_CloseDoors();
forward Floor_OpenDoors(floorid);
forward Floor_CloseDoors(floorid);

forward Elevator_MoveToFloor(floorid);
forward Elevator_Boost(floorid);        	// Increases the elevator speed until it reaches 'floorid'.
forward Elevator_TurnToIdle();

forward ReadNextFloorInQueue();
forward RemoveFirstQueueFloor();
forward AddFloorToQueue(floorid);
forward IsFloorInQueue(floorid);
forward ResetElevatorQueue();

forward DidPlayerRequestElevator(playerid);

forward Float:GetElevatorZCoordForFloor(floorid);
forward Float:GetDoorsZCoordForFloor(floorid);

// ------------------------------------------------------------------------------
// Callbacks
// ---------


// Uncomment the OnPlayerCommandText callback below (remove the "/*" and the "*/")
// to enable a simple teleport command (/lsa) which teleports the player to
// outside the LS Apartments 1 building.

public OnObjectMoved(objectid)
{
	// Create variables
    new Float:x, Float:y, Float:z;

    // Loop
	for(new i; i < sizeof(Obj_FloorDoors); i ++)
	{
	    // Check if the object that moved was one of the elevator floor doors
		if(objectid == Obj_FloorDoors[i][0])
		{
		    GetObjectPos(Obj_FloorDoors[i][0], x, y, z);

            // Some floor doors have shut, move the elevator to next floor in queue:
            if (y < Y_DOOR_L_OPENED - 0.5)
		    {
				Elevator_MoveToFloor(ElevatorQueue[0]);
				RemoveFirstQueueFloor();
			}
		}
	}

	if(objectid == Obj_Elevator)   // The elevator reached the specified floor.
	{
	    KillTimer(ElevatorBoostTimer);  // Kills the timer, in case the elevator reached the floor before boost.

	    FloorRequestedBy[ElevatorFloor] = INVALID_PLAYER_ID;

	    Elevator_OpenDoors();
	    Floor_OpenDoors(ElevatorFloor);

	    GetObjectPos(Obj_Elevator, x, y, z);
	    Label_Elevator	= Create3DTextLabel(""LB_E"Static Apartement\n"WHITE_E"Press "RED_E"'Y' "WHITE_E"to acces", 0xCCCCCCAA, X_ELEVATOR_POS - 1.7, Y_ELEVATOR_POS - 1.75, z - 0.4, 4.0, 0, 1);

	    ElevatorState 	= ELEVATOR_STATE_WAITING;
	    SetTimer("Elevator_TurnToIdle", ELEVATOR_WAIT_TIME, 0);
	}

	return 1;
}

// ------------------------ Functions ------------------------
stock Elevator_Initialize()
{
	// Create the elevator and elevator door objects
	Obj_Elevator 			= CreateObject(18755, X_ELEVATOR_POS, Y_ELEVATOR_POS, GROUND_Z_COORD + ELEVATOR_OFFSET, 0.000000, 0.000000, 0.000000);
	Obj_ElevatorDoors[0] 	= CreateObject(18757, X_ELEVATOR_POS, Y_ELEVATOR_POS, GROUND_Z_COORD + ELEVATOR_OFFSET, 0.000000, 0.000000, 0.000000);
	Obj_ElevatorDoors[1] 	= CreateObject(18756, X_ELEVATOR_POS, Y_ELEVATOR_POS, GROUND_Z_COORD + ELEVATOR_OFFSET, 0.000000, 0.000000, 0.000000);

    // Create the 3D text label for inside the elevator
	Label_Elevator = Create3DTextLabel(""LB_E"Static Apartement\n"WHITE_E"Press "RED_E"'Y' "WHITE_E"to acces", 0xCCCCCCAA, X_ELEVATOR_POS - 1.7, Y_ELEVATOR_POS - 1.75, GROUND_Z_COORD - 0.4, 4.0, 0, 1);

	// Create variables
	new string[128], Float:z;

	// Loop
	for (new i; i < sizeof(Obj_FloorDoors); i ++)
	{
	    // Create elevator floor door objects
	    Obj_FloorDoors[i][0] 	= CreateObject(18757, X_ELEVATOR_POS - 0.245, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(i), 0.000000, 0.000000, 0.000000);
		Obj_FloorDoors[i][1] 	= CreateObject(18756, X_ELEVATOR_POS - 0.245, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(i), 0.000000, 0.000000, 0.000000);

		// Format string for the floor 3D text label
		format(string, sizeof(string), ""LB_E"Static Apartement\n"WHITE_E"Press "RED_E"'Y' "WHITE_E"to acces", FloorNames[i]);

		// Get label Z position
		z = GetDoorsZCoordForFloor(i);

		// Create floor label
		Label_Floors[i] = Create3DTextLabel(string, 0xCCCCCCAA, X_ELEVATOR_POS - 2.5, Y_ELEVATOR_POS - 2.5, z - 0.2, 10.5, 0, 1);
	}

	// Open the car park floor doors and the elevator doors
	Floor_OpenDoors(0);
	Elevator_OpenDoors();

    // Exit here
	return 1;
}

stock Elevator_Destroy()
{
	// Destroys the elevator.

	DestroyObject(Obj_Elevator);
	DestroyObject(Obj_ElevatorDoors[0]);
	DestroyObject(Obj_ElevatorDoors[1]);
	Delete3DTextLabel(Label_Elevator);

	for(new i; i < sizeof(Obj_FloorDoors); i ++)
	{
	    DestroyObject(Obj_FloorDoors[i][0]);
		DestroyObject(Obj_FloorDoors[i][1]);
		Delete3DTextLabel(Label_Floors[i]);
	}

	return 1;
}

stock Elevator_OpenDoors()
{
	// Opens the elevator's doors.

	new Float:x, Float:y, Float:z;

	GetObjectPos(Obj_ElevatorDoors[0], x, y, z);
	MoveObject(Obj_ElevatorDoors[0], x, Y_DOOR_L_OPENED, z, DOORS_SPEED);
	MoveObject(Obj_ElevatorDoors[1], x, Y_DOOR_R_OPENED, z, DOORS_SPEED);

	return 1;
}

stock Elevator_CloseDoors()
{
    // Closes the elevator's doors.

    if(ElevatorState == ELEVATOR_STATE_MOVING)
	    return 0;

    new Float:x, Float:y, Float:z;

	GetObjectPos(Obj_ElevatorDoors[0], x, y, z);
	MoveObject(Obj_ElevatorDoors[0], x, Y_DOOR_CLOSED, z, DOORS_SPEED);
	MoveObject(Obj_ElevatorDoors[1], x, Y_DOOR_CLOSED, z, DOORS_SPEED);

	return 1;
}

stock Floor_OpenDoors(floorid)
{
    // Opens the doors at the specified floor.

    MoveObject(Obj_FloorDoors[floorid][0], X_ELEVATOR_POS - 0.245, Y_DOOR_L_OPENED, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);
	MoveObject(Obj_FloorDoors[floorid][1], X_ELEVATOR_POS - 0.245, Y_DOOR_R_OPENED, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);

	//PlaySoundForPlayersInRange(6401, 50.0, X_ELEVATOR_POS, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid) + 5.0);

	return 1;
}

stock Floor_CloseDoors(floorid)
{
    // Closes the doors at the specified floor.

    MoveObject(Obj_FloorDoors[floorid][0], X_ELEVATOR_POS - 0.245, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);
	MoveObject(Obj_FloorDoors[floorid][1], X_ELEVATOR_POS - 0.245, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);

	//PlaySoundForPlayersInRange(6401, 50.0, X_ELEVATOR_POS, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid) + 5.0);

	return 1;
}

stock Elevator_MoveToFloor(floorid)
{
	// Moves the elevator to specified floor (doors are meant to be already closed).

	ElevatorState = ELEVATOR_STATE_MOVING;
	ElevatorFloor = floorid;

	// Move the elevator slowly, to give time to clients to sync the object surfing. Then, boost it up:
	MoveObject(Obj_Elevator, X_ELEVATOR_POS, Y_ELEVATOR_POS, GetElevatorZCoordForFloor(floorid), 0.25);
    MoveObject(Obj_ElevatorDoors[0], X_ELEVATOR_POS, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid), 0.25);
    MoveObject(Obj_ElevatorDoors[1], X_ELEVATOR_POS, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid), 0.25);
    Delete3DTextLabel(Label_Elevator);

	ElevatorBoostTimer = SetTimerEx("Elevator_Boost", 2000, 0, "i", floorid);

	return 1;
}

public Elevator_Boost(floorid)
{
	// Increases the elevator's speed until it reaches 'floorid'
	StopObject(Obj_Elevator);
	StopObject(Obj_ElevatorDoors[0]);
	StopObject(Obj_ElevatorDoors[1]);

	MoveObject(Obj_Elevator, X_ELEVATOR_POS, Y_ELEVATOR_POS, GetElevatorZCoordForFloor(floorid), ELEVATOR_SPEED);
    MoveObject(Obj_ElevatorDoors[0], X_ELEVATOR_POS, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid), ELEVATOR_SPEED);
    MoveObject(Obj_ElevatorDoors[1], X_ELEVATOR_POS, Y_ELEVATOR_POS, GetDoorsZCoordForFloor(floorid), ELEVATOR_SPEED);

	return 1;
}

public Elevator_TurnToIdle()
{
	ElevatorState = ELEVATOR_STATE_IDLE;
	ReadNextFloorInQueue();

	return 1;
}

stock RemoveFirstQueueFloor()
{
	// Removes the data in ElevatorQueue[0], and reorders the queue accordingly.

	for(new i; i < sizeof(ElevatorQueue) - 1; i ++)
	    ElevatorQueue[i] = ElevatorQueue[i + 1];

	ElevatorQueue[sizeof(ElevatorQueue) - 1] = INVALID_FLOOR;

	return 1;
}

stock AddFloorToQueue(floorid)
{
 	// Adds 'floorid' at the end of the queue.

	// Scan for the first empty space:
	new slot = -1;
	for(new i; i < sizeof(ElevatorQueue); i ++)
	{
	    if(ElevatorQueue[i] == INVALID_FLOOR)
	    {
	        slot = i;
	        break;
	    }
	}

	if(slot != -1)
	{
	    ElevatorQueue[slot] = floorid;

     	// If needed, move the elevator.
	    if(ElevatorState == ELEVATOR_STATE_IDLE)
	        ReadNextFloorInQueue();

	    return 1;
	}

	return 0;
}

stock ResetElevatorQueue()
{
	// Resets the queue.

	for(new i; i < sizeof(ElevatorQueue); i ++)
	{
	    ElevatorQueue[i] 	= INVALID_FLOOR;
	    FloorRequestedBy[i] = INVALID_PLAYER_ID;
	}

	return 1;
}

stock IsFloorInQueue(floorid)
{
	// Checks if the specified floor is currently part of the queue.

	for(new i; i < sizeof(ElevatorQueue); i ++)
	    if(ElevatorQueue[i] == floorid)
	        return 1;

	return 0;
}

stock ReadNextFloorInQueue()
{
	// Reads the next floor in the queue, closes doors, and goes to it.

	if(ElevatorState != ELEVATOR_STATE_IDLE || ElevatorQueue[0] == INVALID_FLOOR)
	    return 0;

	Elevator_CloseDoors();
	Floor_CloseDoors(ElevatorFloor);

	return 1;
}

stock DidPlayerRequestElevator(playerid)
{
	for(new i; i < sizeof(FloorRequestedBy); i ++)
	    if(FloorRequestedBy[i] == playerid)
	        return 1;

	return 0;
}

stock ShowElevatorDialog(playerid)
{
	new string[512];
	for(new i; i < sizeof(ElevatorQueue); i ++)
	{
	    if(FloorRequestedBy[i] != INVALID_PLAYER_ID)
	        strcat(string, "{FF0000}");

	    strcat(string, FloorNames[i]);
	    strcat(string, "\n");
	}

	ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_LIST, "LS Apartments 1 Elevator...", string, "Accept", "Cancel");

	return 1;
}

stock CallElevator(playerid, floorid)
{
	// Calls the elevator (also used with the elevator dialog).

	if(FloorRequestedBy[floorid] != INVALID_PLAYER_ID || IsFloorInQueue(floorid))
	    return 0;

	FloorRequestedBy[floorid] = playerid;
	AddFloorToQueue(floorid);

	return 1;
}

stock Float:GetElevatorZCoordForFloor(floorid)
{
    // Return Z height value plus a small offset
    return (GROUND_Z_COORD + FloorZOffsets[floorid] + ELEVATOR_OFFSET);
}

stock Float:GetDoorsZCoordForFloor(floorid)
{
	// Return Z height value plus a small offset
	return (GROUND_Z_COORD + FloorZOffsets[floorid] + ELEVATOR_OFFSET);
}

