CMD:gunskill(playerid, params[])
{
	new String[512];
	format(String, sizeof(String), "{FFFFFF}Weapon\t{FFFFFF}Exp\n");
	format(String, sizeof(String), "%s9mm\t%d/999\n", String, pData[playerid][pWeaponSkill][0]);
	format(String, sizeof(String), "%sSilenced Pistol\t%d/999\n", String, pData[playerid][pWeaponSkill][1]);
	format(String, sizeof(String), "%sDesert Eagle\t%d/999\n", String, pData[playerid][pWeaponSkill][2]);
	format(String, sizeof(String), "%sShotgun\t%d/999\n", String, pData[playerid][pWeaponSkill][3]);
	format(String, sizeof(String), "%sSPAS-12\t%d/999\n", String, pData[playerid][pWeaponSkill][5]);
	format(String, sizeof(String), "%sMicro Uzi\t%d/999\n", String, pData[playerid][pWeaponSkill][6]);
	format(String, sizeof(String), "%sMP5\t%d/999\n", String, pData[playerid][pWeaponSkill][7]);
	format(String, sizeof(String), "%sAK47\t%d/999\n", String, pData[playerid][pWeaponSkill][8]);
	format(String, sizeof(String), "%sM4\t%d/999\n", String, pData[playerid][pWeaponSkill][9]);
	format(String, sizeof(String), "%sSniper Rifle\t%d/999\n", String, pData[playerid][pWeaponSkill][10]);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Weapon Skill", String, "Close", "" );
	return 1;
}