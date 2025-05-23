#include <a_samp>

#define AT_SLOT_SAE 6 //���� �� ����

#define DEFAUT_SAE_COUNT 20 //������� ��� ����� ����� ������������ ������� (�� ������ 999)


#define SAE_SMOKING 1
#define SAE_BURGER 2
#define SAE_SPRUNK 3
#define SAE_PIZZA 4
#define SAE_GUITAR 5
#define SAE_COFFEE 6
#define SAE_MILK 7
#define SAE_BREAD 8
#define SAE_MEAT 9
#define SAE_APPLE 10
#define SAE_JUICE 11

new PlayerSAEData[MAX_PLAYERS];


/*public OnPlayerSpawn(playerid)
{
    PlayerSAEData[playerid] = 0;
	return 1;
}*/


SpecialActionEx(playerid,sae,count = DEFAUT_SAE_COUNT){
	new specialaction = GetPlayerSpecialAction(playerid);
	if(specialaction >= 20 && specialaction <= 23) SetPlayerSpecialAction(playerid, 0);
	
    PlayerSAEData[playerid] = sae * 1000 + count;
    
	switch(sae){
	    case SAE_SMOKING:{
			    SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 1485, 6, 0.054, 0.101, 0.054, 158.3, -37.0, 36.6);
			    ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.0,0,0,0,0,0,0);
		}
	    case SAE_BURGER: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 2703, 6, 0.067, 0.041, 0, 0, 0, 32.4);
	    case SAE_SPRUNK: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 2601, 5, 0.066, 0.058, 0.021, -176.799, 9.500, 0.000);
	    case SAE_PIZZA: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 2702, 6, 0.060, 0.105, 0.000, 0.000, 0.000, 0.000);
	    case SAE_GUITAR: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19317 + random(3), 6, -0.007, 0.079, -0.346, 6.300, 11.300, -173.699);
	    case SAE_COFFEE: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19835, 5, 0.089, 0.038, -0.027, 160.999, -13.900, 0.000);
	    case SAE_MILK: 		SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19569, 5, 0.054, 0.069, 0.123, -178.199, 0.000, 10.700);
	    case SAE_BREAD: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19579, 6, 0.022, 0.044, 0.000, -86.399, 48.699, -86.500);
	    case SAE_MEAT: 		SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19847, 6, 0.079, 0.015, 0.000, -87.699, 4.000, 9.899, 0.461, 0.518, 0.528);
	    case SAE_APPLE: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19574 + random(2), 6, 0.059, 0.056, 0.018);
	    case SAE_JUICE: 	SetPlayerAttachedObject(playerid, AT_SLOT_SAE, 19563 + random(2), 5, 0.076, 0.037, 0.160, -175.899, 0.000, 9.599);
	}
}


OnPlayerUseSAE(playerid,action,count){
	if(count == 0){
		RemovePlayerAttachedObject(playerid, AT_SLOT_SAE);
		if(action == SAE_SMOKING){
		
		}
		PlayerSAEData[playerid] = 0;
	}else{
		switch(action){
		    case SAE_SMOKING:{
		        count--;
		  		switch(random(4)){
					case 0..2:{	ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.0,0,0,0,0,0,0);}
					case 3:{	ApplyAnimation(playerid, "SMOKING", "M_smk_tap", 4.0,0,0,0,0,0,0);}
				}
				SetPlayerDrunkLevel(playerid, 3000);
				GiveHealth(playerid, -1);
			}
			case SAE_COFFEE,SAE_JUICE,SAE_SPRUNK,SAE_MILK:{
				count--;
			    ApplyAnimation(playerid, "VENDING", "VEND_Drink2_P", 4.0,0,0,0,0,0,0);
			    GiveHealth(playerid, 2);
			}
			case SAE_BURGER,SAE_PIZZA,SAE_APPLE:{
			    count--;
			    ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.0,0,0,0,0,0,0);
			    GiveHealth(playerid, 2);
			}
			case SAE_MEAT,SAE_BREAD:{
			    count--;
				ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.0,0,0,0,0,0,0);
				GiveHealth(playerid, 2);
			}
		    case SAE_GUITAR: ApplyAnimation(playerid, "DILDO", "DILDO_IDLE", 4.1, 1, 1, 1, 1, 1, 1);
		}
		PlayerSAEData[playerid] = action * 1000 + count;
	}
}


GiveHealth(playerid,Float:count){
	new Float:health;
	GetPlayerHealth(playerid,health);
	if(count + health < 100){
		SetPlayerHealth(playerid, health + count);
	}
}


#define KEY_AIM KEY_HANDBRAKE
/*public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_AIM){
		new playersae = PlayerSAEData[playerid] / 1000;
	    if(playersae != 0 && GetPlayerSpecialAction(playerid) < 2){ //���� ����� �� ����� ��� �����
	        new saecount = PlayerSAEData[playerid] - (playersae * 1000);
	   		OnPlayerUseSAE(playerid, playersae, saecount);
	    }
	}
	if(newkeys & KEY_SECONDARY_ATTACK){
	    RemovePlayerAttachedObject(playerid, AT_SLOT_SAE);
		PlayerSAEData[playerid] = 0;
	}
	return 1;
}*/


public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/smoking", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_SMOKING);
	}
	if (strcmp("/burger", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_BURGER);
	}
	if (strcmp("/sprunk", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_SPRUNK);
	}
	if (strcmp("/pizza", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_PIZZA);
	}
	if (strcmp("/guitar", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_GUITAR, 100);
	}
	if (strcmp("/coffee", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_COFFEE);
	}
	if (strcmp("/milk", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_MILK);
	}
	if (strcmp("/bread", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_BREAD);
	}
	if (strcmp("/meat", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_MEAT);
	}
	if (strcmp("/apple", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_APPLE);
	}
	if (strcmp("/juice", cmdtext, true, 10) == 0){
		SpecialActionEx(playerid, SAE_JUICE);
	}
	if (strcmp("/cskin", cmdtext, true, 10) == 0){
		SetPlayerSkin(playerid, random(300));
	}
	return 1;
}

