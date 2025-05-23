#include <a_samp>
#include <Pawn.CMD>
#include <sscanf2>
#include <sampvoice>
#include <streamer>
#define 	WARNA_MERAH		"{FF0000}"
#define 	WARNA_KUNING	"{FFFF00}"
#define 	WARNA_BIRU		"{0099FF}"
#define 	WARNA_PUTIH		"{FFFFFF}"
#define COLOR_GREEN 		0x3BBD44FF
#define function%0(%1) forward %0(%1); public %0(%1)
#define 	Info(%1,%2)		SendClientMessage(%1, -1, ""WARNA_BIRU"[INFO]: "WARNA_PUTIH""%2)
#define 	Error(%1,%2)	SendClientMessage(%1, -1, ""WARNA_MERAH"[ERROR]: "WARNA_PUTIH""%2)
#define 	Usage(%1,%2)	SendClientMessage(%1, -1, ""WARNA_KUNING"[USAGE]: "WARNA_PUTIH""%2)

//#include <Notifikasi>
main() 
{}

public OnFilterScriptInit()
{
    printf("");
    printf("// -------- Voice System & Radio System Loaded! -------- // ");
    printf("");
}     
enum
{
	DIALOG_UNUSED,
	DIALOG_RADIO
}
public OnFilterScriptExit() 
{
    return 1;
}

//Local Voice
#define MAX_RADIOS 999
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };
new SV_GSTREAM:StreamTelpon[MAX_PLAYERS] = { SV_NULL, ... };
new SV_GSTREAM:StreamFreq[MAX_RADIOS] = SV_NULL;
new IDStream[MAX_PLAYERS];

new PlayerText:Radio[MAX_PLAYERS][19];

enum pEnum
{
	pTombolVoiceRadio,
	pRadioVoice,
	Text3D:TagVoice,
	pCallStage,
	pTombolVoice,
	pCallLine,
	pFrekuensi,
	pCall,
	pInjured,
	pFaction
};
new pData[MAX_PLAYERS][pEnum];

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid)
{
    if(pData[playerid][pTombolVoiceRadio] == 1)
	{
		if(pData[playerid][pRadioVoice] == 1)
		{
		    //ApplyAnimation(playerid, "ped", "phone_talk", 4.1, 1, 1, 1, 1, 1, 1);
    	    if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, 19942, 2, 0.0300, 0.1309, -0.1060, 118.8998, 19.0998, 164.2999);


			if(!IsPlayerInAnyVehicle(playerid))
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			}  

			if(keyid == 0x42 && IDStream[playerid] >= 1) SvAttachSpeakerToStream(StreamFreq[IDStream[playerid]], playerid);
			pData[playerid][TagVoice] = CreateDynamic3DTextLabel("[Radio]", 0x3BBD44FF, 0.0, 0.0, 0.2, 10.0, .attachedplayer = playerid, .testlos = 1);
		}
	}
	else if(pData[playerid][pCallStage] == 2)
	{
	    if (keyid == 0x42 && StreamTelpon[playerid]) SvAttachSpeakerToStream(StreamTelpon[playerid], playerid);
	    pData[playerid][TagVoice] = CreateDynamic3DTextLabel("[Menelepon]", 0x3BBD44FF, 0.0, 0.0, 0.2, 10.0, .attachedplayer = playerid, .testlos = 1);
	}
	else if(pData[playerid][pTombolVoice] == 1)
	{
		if (keyid == 0x42 && lstream[playerid])  SvAttachSpeakerToStream(lstream[playerid], playerid);
		pData[playerid][TagVoice] = CreateDynamic3DTextLabel("[Berbicara]", 0x3BBD44FF, 0.0, 0.0, 0.2, 10.0, .attachedplayer = playerid, .testlos = 1);
	}
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid)
{
	if(pData[playerid][pTombolVoiceRadio] == 1)
	{
		if(pData[playerid][pRadioVoice] == 1)
		{
			if(keyid == 0x42 && IDStream[playerid] >= 1) SvDetachSpeakerFromStream(StreamFreq[IDStream[playerid]], playerid);
			if(IsValidDynamic3DTextLabel(pData[playerid][TagVoice]))
              DestroyDynamic3DTextLabel(pData[playerid][TagVoice]);
			if(!IsPlayerInAnyVehicle(playerid))
			{
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
			}
			if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
		}
	}
	else if(pData[playerid][pCallStage] == 2)
	{
		if (keyid == 0x42 && StreamTelpon[playerid]) SvDetachSpeakerFromStream(StreamTelpon[playerid], playerid);
		if(IsValidDynamic3DTextLabel(pData[playerid][TagVoice]))
              DestroyDynamic3DTextLabel(pData[playerid][TagVoice]);
	}
	else if(pData[playerid][pTombolVoice] == 1)
	{
	    if(IsValidDynamic3DTextLabel(pData[playerid][TagVoice]))
              DestroyDynamic3DTextLabel(pData[playerid][TagVoice]);
		if (keyid == 0x42 && lstream[playerid]) SvDetachSpeakerFromStream(lstream[playerid], playerid);
	}
}

public OnPlayerConnect(playerid)
{
    if (SvGetVersion(playerid) == SV_NULL)
    {
		Error(playerid, "Tidak dapat menemukan plugin sampvoice.");
		/*new lstr[512];
		format(lstr, sizeof(lstr), "System Detected:Authentic Warning\nKepada:(pemain) Roleplay\n\nUntuk bermain peran di Authentic Roleplay, maka anda harus memenuhi salah satu syarat yaitu memasang plugin voice di SAMP: {FFFF00}discord.gg/Authentic");
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "{FFFFFF}Authentic Roleplay - Plugins Tidak Terdeteksi", lstr, "Keluar", "");
		SendClientMessage(playerid, -1, "{FFFF00}[i] Anda telah ditendang dari server karena {FF0000}Plugin Voice {FFFF00}tidak terdeteksi!");*/
    }
    else if (SvHasMicro(playerid) == SV_FALSE)
    {
        SendClientMessage(playerid, -1, "Mikrofon tidak dapat ditemukan.");
    }
    else if ((lstream[playerid] = SvCreateDLStreamAtPlayer(15.0, SV_INFINITY, playerid, 0xff0000ff, "Berbicara")))
    {
		Info(playerid, "{ffffff}Device Kamu Telah Terbaca Menggunakan Plugin Voice.");
        SvAddKey(playerid, 0x42);
    }
    pData[playerid][pRadioVoice] = 0;
	pData[playerid][pTombolVoice] = 1;
	pData[playerid][pTombolVoiceRadio] = 0;

	//tdne
	Radio[playerid][0] = CreatePlayerTextDraw(playerid, 267.000000, 353.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][0], 0.600000, 3.700000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][0], 296.000000, 1.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][0], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][0], 1296911871);
	PlayerTextDrawUseBox(playerid, Radio[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][0], 0);

	Radio[playerid][1] = CreatePlayerTextDraw(playerid, 241.000000, 386.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][1], 0.600000, 10.300003);
	PlayerTextDrawTextSize(playerid, Radio[playerid][1], 298.500000, 77.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][1], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][1], 16777215);
	PlayerTextDrawUseBox(playerid, Radio[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][1], 0);

	Radio[playerid][2] = CreatePlayerTextDraw(playerid, 198.000000, 374.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][2], 17.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][2], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][2], 16777215);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][2], 0);

	Radio[playerid][3] = CreatePlayerTextDraw(playerid, 267.000000, 374.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][3], 17.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][3], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][3], 16777215);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][3], 0);

	Radio[playerid][4] = CreatePlayerTextDraw(playerid, 241.000000, 379.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][4], 0.600000, 10.300003);
	PlayerTextDrawTextSize(playerid, Radio[playerid][4], 298.500000, 65.500000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][4], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][4], 16777215);
	PlayerTextDrawUseBox(playerid, Radio[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][4], 0);

	Radio[playerid][5] = CreatePlayerTextDraw(playerid, 241.000000, 386.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][5], 0.600000, 10.300003);
	PlayerTextDrawTextSize(playerid, Radio[playerid][5], 297.500000, 74.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][5], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][5], 1296911871);
	PlayerTextDrawUseBox(playerid, Radio[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][5], 0);

	Radio[playerid][6] = CreatePlayerTextDraw(playerid, 241.000000, 381.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][6], 0.600000, 10.300003);
	PlayerTextDrawTextSize(playerid, Radio[playerid][6], 298.500000, 65.500000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][6], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][6], 1296911871);
	PlayerTextDrawUseBox(playerid, Radio[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][6], 0);

	Radio[playerid][7] = CreatePlayerTextDraw(playerid, 199.000000, 376.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][7], 17.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][7], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][7], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][7], 0);

	Radio[playerid][8] = CreatePlayerTextDraw(playerid, 266.000000, 376.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][8], 17.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][8], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][8], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][8], 0);

	Radio[playerid][9] = CreatePlayerTextDraw(playerid, 261.000000, 342.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][9], 11.000000, 14.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][9], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][9], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][9], 0);

	Radio[playerid][10] = CreatePlayerTextDraw(playerid, 241.000000, 386.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][10], 0.600000, 3.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][10], 297.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][10], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][10], -1094795521);
	PlayerTextDrawUseBox(playerid, Radio[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][10], 0);

	Radio[playerid][11] = CreatePlayerTextDraw(playerid, 202.000000, 381.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][11], 13.000000, 14.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][11], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][11], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][11], 0);

	Radio[playerid][12] = CreatePlayerTextDraw(playerid, 267.000000, 381.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, Radio[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][12], 13.500000, 14.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][12], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][12], -1094795521);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][12], 0);

	Radio[playerid][13] = CreatePlayerTextDraw(playerid, 241.000000, 392.000000, "_");
	PlayerTextDrawFont(playerid, Radio[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][13], 0.600000, 2.350001);
	PlayerTextDrawTextSize(playerid, Radio[playerid][13], 297.500000, 70.500000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][13], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][13], -1094795521);
	PlayerTextDrawUseBox(playerid, Radio[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][13], 0);

	Radio[playerid][14] = CreatePlayerTextDraw(playerid, 241.000000, 382.000000, "33.33");
	PlayerTextDrawFont(playerid, Radio[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][14], 0.600000, 3.399996);
	PlayerTextDrawTextSize(playerid, Radio[playerid][14], 31.500000, 56.500000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][14], 2);
	PlayerTextDrawColor(playerid, Radio[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][14], 1);

	Radio[playerid][15] = CreatePlayerTextDraw(playerid, 245.000000, 425.000000, "ld_bum:blkdot");
	PlayerTextDrawFont(playerid, Radio[playerid][15], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][15], 33.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][15], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][15], -16776961);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][15], 1);

	Radio[playerid][16] = CreatePlayerTextDraw(playerid, 204.000000, 425.000000, "ld_bum:blkdot");
	PlayerTextDrawFont(playerid, Radio[playerid][16], 4);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Radio[playerid][16], 33.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][16], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][16], 16711935);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][16], 1);

	Radio[playerid][17] = CreatePlayerTextDraw(playerid, 206.000000, 426.000000, "Connect");
	PlayerTextDrawFont(playerid, Radio[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][17], 0.224998, 1.399999);
	PlayerTextDrawTextSize(playerid, Radio[playerid][17], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][17], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][17], 0);

	Radio[playerid][18] = CreatePlayerTextDraw(playerid, 252.000000, 426.000000, "Reset");
	PlayerTextDrawFont(playerid, Radio[playerid][18], 1);
	PlayerTextDrawLetterSize(playerid, Radio[playerid][18], 0.224998, 1.399999);
	PlayerTextDrawTextSize(playerid, Radio[playerid][18], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Radio[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, Radio[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, Radio[playerid][18], 1);
	PlayerTextDrawColor(playerid, Radio[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, Radio[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, Radio[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, Radio[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, Radio[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, Radio[playerid][18], 0);

}

public OnPlayerDisconnect(playerid, reason)
{
    if (lstream[playerid])
    {
        SvDeleteStream(lstream[playerid]);
        lstream[playerid] = SV_NULL;
    }
}

public OnGameModeInit()
{

}

public OnGameModeExit()
{

}

stock GetPName(playerid)
{
	new namep[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, namep, MAX_PLAYER_NAME+1);
	return namep;
}

stock DisplayMicRadio(playerid)
{
	if(pData[playerid][pCallStage] == 2)
	{
		return Error(playerid, "Kamu Sedang Menelpon");
	}
	else if(pData[playerid][pTombolVoiceRadio] == 0)
	{
		if(pData[playerid][pRadioVoice] == 0)
		{
			///
		}
		pData[playerid][pTombolVoiceRadio] = 1;
		Info(playerid, "MicRadio Menyala");
		SetPlayerAttachedObject(playerid, 9, 19942, 6, 0.083999, 0.030999, 0.000000, -7.699999, -29.100000, -164.100006, 1.000000, 1.000000, 1.000000);
	}
	else if(pData[playerid][pTombolVoiceRadio] == 1)
	{
		pData[playerid][pTombolVoiceRadio] = 0;
		Info(playerid, "MicRadio Dimatikan");
		RemovePlayerAttachedObject(playerid, 9);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == Radio[playerid][14])
	{
        ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_INPUT, "Set Freq", "Silakan isi frequensi yang ingin di sambungkan.", "Sambung", "Batal");
	}
	if(playertextid == Radio[playerid][16])
	{
		PlayerTextDrawHide(playerid, Radio[playerid][0]);
		PlayerTextDrawHide(playerid, Radio[playerid][1]);
		PlayerTextDrawHide(playerid, Radio[playerid][2]);
		PlayerTextDrawHide(playerid, Radio[playerid][3]);
		PlayerTextDrawHide(playerid, Radio[playerid][4]);
		PlayerTextDrawHide(playerid, Radio[playerid][5]);
		PlayerTextDrawHide(playerid, Radio[playerid][6]);
		PlayerTextDrawHide(playerid, Radio[playerid][7]);
		PlayerTextDrawHide(playerid, Radio[playerid][8]);
		PlayerTextDrawHide(playerid, Radio[playerid][9]);
		PlayerTextDrawHide(playerid, Radio[playerid][10]);
		PlayerTextDrawHide(playerid, Radio[playerid][11]);
		PlayerTextDrawHide(playerid, Radio[playerid][12]);
		PlayerTextDrawHide(playerid, Radio[playerid][13]);
		PlayerTextDrawHide(playerid, Radio[playerid][14]);
		PlayerTextDrawHide(playerid, Radio[playerid][15]);
		PlayerTextDrawHide(playerid, Radio[playerid][16]);
		PlayerTextDrawHide(playerid, Radio[playerid][17]);
		PlayerTextDrawHide(playerid, Radio[playerid][18]);
	    CancelSelectTextDraw(playerid);
	}
	if(playertextid == Radio[playerid][15])
	{
		callcmd::resetradio(playerid, "");
	}
}
CMD:rv(playerid, params[])
{
	DisplayMicRadio(playerid);
	return 1;
}
CMD:setradiotry(playerid, params[])
{
	PlayerTextDrawShow(playerid, Radio[playerid][0]);
	PlayerTextDrawShow(playerid, Radio[playerid][1]);
	PlayerTextDrawShow(playerid, Radio[playerid][2]);
	PlayerTextDrawShow(playerid, Radio[playerid][3]);
	PlayerTextDrawShow(playerid, Radio[playerid][4]);
	PlayerTextDrawShow(playerid, Radio[playerid][5]);
	PlayerTextDrawShow(playerid, Radio[playerid][6]);
	PlayerTextDrawShow(playerid, Radio[playerid][7]);
	PlayerTextDrawShow(playerid, Radio[playerid][8]);
	PlayerTextDrawShow(playerid, Radio[playerid][9]);
	PlayerTextDrawShow(playerid, Radio[playerid][10]);
	PlayerTextDrawShow(playerid, Radio[playerid][11]);
	PlayerTextDrawShow(playerid, Radio[playerid][12]);
	PlayerTextDrawShow(playerid, Radio[playerid][13]);
	PlayerTextDrawShow(playerid, Radio[playerid][14]);
	PlayerTextDrawShow(playerid, Radio[playerid][15]);
	PlayerTextDrawShow(playerid, Radio[playerid][16]);
	PlayerTextDrawShow(playerid, Radio[playerid][17]);
	PlayerTextDrawShow(playerid, Radio[playerid][18]);
	SelectTextDraw(playerid, 0x00FFFFFF);
	return 1;
}
CMD:resetradio(playerid, params[])
{
    if(pData[playerid][pRadioVoice] == 0)
	{
		return Error(playerid, "Anda perlu menghubungkan saluran radio");
    }
    pData[playerid][pRadioVoice] = 0;
	pData[playerid][pTombolVoiceRadio] = 0;
    Info(playerid, "Terputus dari saluran radio.");
    SvDetachListenerFromStream(StreamFreq[IDStream[playerid]], playerid);
	pData[playerid][pFrekuensi] = 0;
	PlayerTextDrawHide(playerid, Radio[playerid][0]);
	PlayerTextDrawHide(playerid, Radio[playerid][1]);
	PlayerTextDrawHide(playerid, Radio[playerid][2]);
	PlayerTextDrawHide(playerid, Radio[playerid][3]);
	PlayerTextDrawHide(playerid, Radio[playerid][4]);
	PlayerTextDrawHide(playerid, Radio[playerid][5]);
	PlayerTextDrawHide(playerid, Radio[playerid][6]);
	PlayerTextDrawHide(playerid, Radio[playerid][7]);
	PlayerTextDrawHide(playerid, Radio[playerid][8]);
	PlayerTextDrawHide(playerid, Radio[playerid][9]);
	PlayerTextDrawHide(playerid, Radio[playerid][10]);
	PlayerTextDrawHide(playerid, Radio[playerid][11]);
	PlayerTextDrawHide(playerid, Radio[playerid][12]);
	PlayerTextDrawHide(playerid, Radio[playerid][13]);
	PlayerTextDrawHide(playerid, Radio[playerid][14]);
	PlayerTextDrawHide(playerid, Radio[playerid][15]);
	PlayerTextDrawHide(playerid, Radio[playerid][16]);
	PlayerTextDrawHide(playerid, Radio[playerid][17]);
	PlayerTextDrawHide(playerid, Radio[playerid][18]);
	CancelSelectTextDraw(playerid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_RADIO)
	{
		if(response)
        {
			new id;
			if(sscanf(inputtext, "i", id))
			{
				return 1;
			}
			if(pData[playerid][pCallStage] == 2)
			{
				return Error(playerid, "Kamu Sedang Menelpon");
			}
			if(!(1 <= id <= 999))
			{
				return Error(playerid, "Saluran radio yang ditentukan harus berkisar antara 1 dan 999.");
			}
			if(pData[playerid][pRadioVoice] == 1)
			{
				return Error(playerid, "Anda perlu memutuskan sambungan dari saluran radio untuk menghubungkan saluran lain");
			}
			else if(id <= 10)
			{
				if(pData[playerid][pFaction] == 0)
				{
					return Error(playerid, "Untuk frequensi 1-10 cuman fraksi goodside.");
				}
				else
				{
					IDStream[playerid] = id;
					pData[playerid][pFrekuensi] = id;

					if(StreamFreq[IDStream[playerid]] == SV_NULL)
					{
						pData[playerid][pRadioVoice] = 1;
						StreamFreq[IDStream[playerid]] = SvCreateGStream(0xFF0000FF, "Radio");
						SvAttachListenerToStream(StreamFreq[IDStream[playerid]], playerid);
						Info(playerid, "Berhasil terhubung ke saluran radio");
					}
					else
					{
						pData[playerid][pRadioVoice] = 1;
						SvAttachListenerToStream(StreamFreq[IDStream[playerid]], playerid);
						Info(playerid, "Berhasil terhubung ke saluran radio");
					}
				}
			}
			else
			{
				IDStream[playerid] = id;
				pData[playerid][pFrekuensi] = id;

				if(StreamFreq[IDStream[playerid]] == SV_NULL)
				{
					pData[playerid][pRadioVoice] = 1;
					StreamFreq[IDStream[playerid]] = SvCreateGStream(0xFF0000FF, "Radio");
					SvAttachListenerToStream(StreamFreq[IDStream[playerid]], playerid);
					Info(playerid, "Berhasil terhubung ke saluran radio");
				}
				else
				{
					pData[playerid][pRadioVoice] = 1;
					SvAttachListenerToStream(StreamFreq[IDStream[playerid]], playerid);
					Info(playerid, "Berhasil terhubung ke saluran radio");
				}
			}
        }
    }
	return 1;
}
