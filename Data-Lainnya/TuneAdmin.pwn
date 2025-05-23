//private command by lenz
// STATISTIC VEHICLE SAGS //
#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == TuneVehicle)
	{
		if(!response) return 1;
	    switch (listitem)
	    {
	        case 0:
	            ShowModelSelectionMenu(playerid, "Add Wheels", MODEL_SELECTION_WHEELS, {1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1096, 1097, 1098}, 17, 0.0, 0.0, 90.0);

			case 1:
			    ShowPlayerDialog(playerid, AddNOS, DIALOG_STYLE_LIST, "Add Nitrous", "2x NOS\n5x NOS\n10x NOS", "Select", "Cancel");

			case 2:
			{
			    AddComponent(vehicleid, 1087);
			    SendServerMessage(playerid, "You have added hydraulics to this vehicle.");
			}
	    }
	}
	if(dialogid == AddNOS)
	{
		if(!response) return 1;
	    switch (listitem)
	    {
	        case 0:
			{
			    AddComponent(vehicleid, 1009);
			    SendServerMessage(playerid, "You have added 2x NOS to this vehicle.");
			}
			case 1:
			{
			    AddComponent(vehicleid, 1008);
			    SendServerMessage(playerid, "You have added 5x NOS to this vehicle.");
			}
            case 2:
			{
			    AddComponent(vehicleid, 1010);
			    SendServerMessage(playerid, "You have added 10x NOS to this vehicle.");
			}
		}
	}
	return 1;
}
//end