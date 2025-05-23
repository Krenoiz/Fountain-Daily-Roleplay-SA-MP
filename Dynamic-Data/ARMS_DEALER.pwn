//291.35, -106.30, 1001.51

CreateArmsPoint()
{
	
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 291.35, -106.30, 1001.51, -1, -1, -1, 50);
	format(strings, sizeof(strings), "{7fffd4}[Black Market]\n{FFFFFF}/buyschematic");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 291.35, -106.30, 1001.51, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	new lstr[128];
	CreateDynamicPickup(1239, 23, 290.2280, -109.7393, 1001.5156, -1, -1, -1, 50);
	format(lstr, sizeof(lstr), "{7fffd4}[Store Gun]\n{FFFFFF}/buygun");
	CreateDynamic3DTextLabel(lstr, COLOR_GREY, 290.2280, -109.7393, 1001.5156, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
}
CMD:unscrap(playerid, params[])
{
    new weaponid = GetPlayerWeaponEx(playerid);

    if (weaponid >= 22 && weaponid <= 31)
    {
        ResetPlayerWeaponsEx(playerid);

        new randomMetal = 300 + random(301);

        pData[playerid][pMetal] += randomMetal;

        new msg[128];
        format(msg, sizeof(msg), "Kamu telah membongkar senjatamu dan mendapatkan material %d", randomMetal);
        SendClientMessage(playerid, COLOR_GREY, msg);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "Kamu tidak memegang senjata yang bisa dibongkar.");
    }

    return 1;
}




CMD:buyschematic(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 291.35, -106.30, 1001.51))
		{
			new Dstring[750];
			if(pData[playerid][pFamily] != -1)
			{
				format(Dstring, sizeof(Dstring), "Schematic (Weapon)\tPrice\n");
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic SLC\t$8.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Colt45\t$10.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Shotgun\t$15.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Desert Eagle\t$50.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Riffle\t$15.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Uzi\t$100.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic AK-47\t$180.000\n", Dstring);
			}
			else if(pData[playerid][pFamily] == -1)
			{
				format(Dstring, sizeof(Dstring), "Schematic (Weapon)\tPrice\n");
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic SLC\t$10.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Colt45\t$10.000\n", Dstring);
				format(Dstring, sizeof(Dstring), "{ffffff}%sSchematic Shotgun\t$15.000\n", Dstring);
			}
			ShowPlayerDialog(playerid, DIALOG_SCHEMATIC, DIALOG_STYLE_TABLIST_HEADERS, "Buy Schematic", Dstring, "Buy", "Cancel");
		}
	return 1;
}
CMD:buydrugs(playerid, params[])
{
    if (pData[playerid][pCharacterStory] == 0) return Error(playerid, "Anda tidak memiliki Story Character!");
    if (pData[playerid][pFamily] == -1 && pData[playerid][pVerified] == -1) return Error(playerid, "Kamu bukan anggota Geng / Family.");
	if (pData[playerid][pFamilyRank] < 5) 
	{
		if (pData[playerid][pVerifiedRank] < 5) 
		{
			return Error(playerid, "Hanya rank tertinggi yang bisa membelinya.");
		}
	}
    
    if (IsPlayerInRangeOfPoint(playerid, 2.5, -1633.2416, -2240.3623, 31.4766))
    {
        ShowPlayerDialog(playerid, DIALOG_CRACK, DIALOG_STYLE_MSGBOX, "Pembelian Narkoba", "Apakah Anda ingin membeli narkoba secara acak?", "Beli", "Batal");
    }

    return 1;
}
CMD:createweapon(playerid, params[])
{
	if(pData[playerid][pCharacterStory] == 0) return Error(playerid, "Anda tidak memiliki Story Character!");
	if(pData[playerid][pLevel] < 5) return Error(playerid, "Level kamu kurang dari 5.");
		
	new Dstring[750];
 	if(pData[playerid][pFamily] != -1 || IsPlayerAdmin(playerid))
	{
		format(Dstring, sizeof(Dstring), "WEAPONS (ammo)\tMetal\n");
		format(Dstring, sizeof(Dstring), "{ffffff}%sSilenced Pistol(ammo 50)\t650\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sColt45 9mm (ammo 50)\t500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sShotgun (ammo 50)\t500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sDesert Eagle(ammo 50)\t800\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sRifle (ammo 50)\t650\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sUzi(ammo 50)\t1000\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sAK-47(ammo 50)\t1500\n", Dstring);
	}
    else if(pData[playerid][pFamily] == -1)
	{
		// Jika pemain tidak memiliki Family, beri akses terbatas
		format(Dstring, sizeof(Dstring), "WEAPONS (ammo)\tMetal\n");
		format(Dstring, sizeof(Dstring), "{ffffff}%sSilenced Pistol(ammo 50)\t650\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sColt45 9mm (ammo 50)\t500\n", Dstring);
		format(Dstring, sizeof(Dstring), "{ffffff}%sShotgun (ammo 50)\t600\n", Dstring);
	}

	ShowPlayerDialog(playerid, DIALOG_ARMS_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Create Gun", Dstring, "Create", "Cancel");
	return 1;
}

function CreateGun(playerid, gunid, ammo)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pArmsDealerStatus] != 1) return 0;
	if(gunid == 0 || ammo == 0) return 0;
	if(pData[playerid][pActivityTime] >= 100)
	{
		GivePlayerWeaponEx(playerid, gunid, ammo);
		
		Info(playerid, "Kamu telah berhasil membuat senjata ilegal.");
		TogglePlayerControllable(playerid, 1);
		InfoTD_MSG(playerid, 9000, "Senjatamu terbuat!");
		KillTimer(pData[playerid][pArmsDealer]);
		pData[playerid][pActivityTime] = 0;
		pData[playerid][pDelaySenjata] += 10800;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		pData[playerid][pEnergy] -= 3;
		return 1;
	}
	else if(pData[playerid][pActivityTime] < 100)
	{
		pData[playerid][pActivityTime] += 5;
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}


