/**
 * SyncWeaponSkill
 */
SyncWeaponSkill(playerid) {
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, pData[playerid][pWeaponSkill][0]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, pData[playerid][pWeaponSkill][1]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, pData[playerid][pWeaponSkill][2]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, pData[playerid][pWeaponSkill][3]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, pData[playerid][pWeaponSkill][4]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, pData[playerid][pWeaponSkill][5]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, pData[playerid][pWeaponSkill][6]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, pData[playerid][pWeaponSkill][7]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, pData[playerid][pWeaponSkill][8]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, pData[playerid][pWeaponSkill][9]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, pData[playerid][pWeaponSkill][10]);
}