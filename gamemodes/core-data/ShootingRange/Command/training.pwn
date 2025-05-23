CMD:training(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == true) {

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 286.0766,-31.0150,1001.5156) && GetPlayerVirtualWorld(playerid) == 1)
		{
			if(TrainingUsed[0] == 1) 
				return Error(playerid, "Seseorang sedang latihan, tunggu giliran kamu.");

		    SetPVarInt(playerid, "TakeTraining", 1);
		    ShowPlayerDialog(playerid, WEAPON_TRAINING, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Training",
			"{FFFF00}Weapon Type\t{FFFF00}Cost\n\
			Colt 9mm\t$700\n\
			Silenced Pistol\t$800\n\
			Desert Eagle\t$1500\n\
			Shotgun\t$1000\n\
			SPAS-12\t$2500\n\
			Micro Uzi\t$5000\n\
			MP5\t$8000\n\
			AK47\t$10,000\n\
			M4\t$10,000\n\
			Sniper Rifle\t$15,000", "Select", "Cancel");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 286.0766,-31.0150,1001.5156) && GetPlayerVirtualWorld(playerid) == 2) {

			if(TrainingUsed[1] == 1) 
				return Error(playerid, "Seseorang sedang latihan, tunggu giliran kamu.");

		    SetPVarInt(playerid, "TakeTraining", 2);
			ShowPlayerDialog(playerid, WEAPON_TRAINING, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Training",
			"{FFFF00}Weapon Type\t{FFFF00}Cost\n\
			Colt 9mm\t$700\n\
			Silenced Pistol\t$800\n\
			Desert Eagle\t$1500\n\
			Shotgun\t$1000\n\
			SPAS-12\t$2500\n\
			Micro Uzi\t$5000\n\
			MP5\t$8000\n\
			AK47\t$10,000\n\
			M4\t$10,000\n\
			Sniper Rifle\t$15,000", "Select", "Cancel");
		}
		else
		{
		    Error(playerid, "You are not at training point.");
		}
	}
	return 1;
}