
#define 	WARNA_MERAH		"{FF0000}"
#define 	WARNA_KUNING	"{FFFF00}"
#define 	WARNA_BIRU		"{0099FF}"
#define 	WARNA_PUTIH		"{FFFFFF}"
#define COLOR_GREEN 		0x3BBD44FF
#define FILTERSCRIPT

#include <a_samp>
#include <core>
#include <float>
#include <sampvoice>
#include <dini>
#include <sscanf2>
#include <Pawn.CMD>
#include <a_mysql>

// RADIO DEFINE
//#define 	MAX_PLAYERS 1000
#define 	MAX_FREQUENSI	9999

// MESSAGE DEFINE
#define 	Info(%1,%2)		SendClientMessage(%1, -1, ""WARNA_BIRU"[INFO]: "WARNA_PUTIH""%2)
#define 	Error(%1,%2)	SendClientMessage(%1, -1, ""WARNA_MERAH"[ERROR]: "WARNA_PUTIH""%2)
#define 	Usage(%1,%2)	SendClientMessage(%1, -1, ""WARNA_KUNING"[USAGE]: "WARNA_PUTIH""%2)

// OTHER DEFINE
#define function%0(%1) forward %0(%1); public %0(%1)
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

new SV_LSTREAM:localStream[MAX_PLAYERS] = SV_NULL;
new SV_GSTREAM:radioStream[MAX_FREQUENSI] = SV_NULL;

// SAVE SYSTEM (MYSQL)
#define     MYSQL_HOST      "204.10.192.68"
#define     MYSQL_USER      "u500_k8uovdjDb5"
#define     MYSQL_PASS      "3MtD.Ovp=wA1tg4Cmw0hXJ8I"
#define     MYSQL_DATA      "s500_samp_fountain"
//#define		MYSQL_HOST 			"as1.ultra-h.com"
//#define		MYSQL_USER 			"server_9249"
//#define		MYSQL_PASS 		"2u3dwkixys"
//#define		MYSQL_DATA 		"server_9249_Avalon"
new MySQL:voiceData;
new Text:Voice1;
new Text:Voice2;



// DIALOG DEFINE
enum
{
    DIALOG_RADIOSETTINGS,
    DIALOG_SETFREQ,
    DIALOG_SETSFX,
    DIALOG_SHOPELE
}

// PLAYER DATA
enum E_PLAYERS
{
    pID,
    pName[MAX_PLAYER_NAME],
    pMoney,
    bool: IsLoggedIn,
    bool: dataTerload,
    pRadio,
    pTogRadio,
    pTogMic,
    pTogSemua,
    pFreqRadio,
    pSfxTurnOn,
    pFaction,
    pSfxTurnOff
};
new pData[MAX_PLAYERS][E_PLAYERS];

main()
{

}
 
public OnFilterScriptInit()
{
    voiceData = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DATA);
    if(mysql_errno(voiceData) != 0)
    {
        print("[MySQL]: Koneksi ke database mengalami kegagalan.");
    } else {
        print("[MySQL]: Sukses terhubung ke database.");
    }

    print("                                                                  ");
    print("[-|-----=====-----=====-----=====-----=====-----=====-----=====|-]");
    print("                                                                  ");
    print("                                                                  ");
    print("                                                                  ");
    print("             [ALL SYSTEM VOICE LOADED, BY TEAM MERPATI]           "); // Disini
    print("                                                                  ");
    print("                                                                  ");
    print("                                                                  ");  
    print("[-|=====-----=====-----=====-----=====-----=====-----=====-----|-]");
    print("                                                                  ");

    for(new i = 0; i < MAX_FREQUENSI; i++)
    {
        radioStream[i] = SvCreateGStream(0xDB881AFF, "RadioStream");
    }   

	Voice1 = TextDrawCreate(590.000000, 431.000000, "VOICE :");
	TextDrawFont(Voice1, 1);
	TextDrawLetterSize(Voice1, 0.220833, 1.299999);
	TextDrawTextSize(Voice1, 400.000000, 17.000000);
	TextDrawSetOutline(Voice1, 1);
	TextDrawSetShadow(Voice1, 0);
	TextDrawAlignment(Voice1, 3);
	TextDrawColor(Voice1, -1);
	TextDrawBackgroundColor(Voice1, 255);
	TextDrawBoxColor(Voice1, 50);
	TextDrawUseBox(Voice1, 0);
	TextDrawSetProportional(Voice1, 1);
	TextDrawSetSelectable(Voice1, 0);

	Voice2 = TextDrawCreate(593.000000, 431.000000, "NORMAL");
	TextDrawFont(Voice2, 1);
	TextDrawLetterSize(Voice2, 0.220833, 1.299999);
	TextDrawTextSize(Voice2, 400.000000, 17.000000);
	TextDrawSetOutline(Voice2, 1);
	TextDrawSetShadow(Voice2, 0);
	TextDrawAlignment(Voice2, 1);
	TextDrawColor(Voice2, 2094792959);
	TextDrawBackgroundColor(Voice2, 255);
	TextDrawBoxColor(Voice2, 50);
	TextDrawUseBox(Voice2, 0);
	TextDrawSetProportional(Voice2, 1);
	TextDrawSetSelectable(Voice2, 0);

    return 1;
}

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid) 
{
    if(keyid == 0x42 && pData[playerid][pFreqRadio] >= 1 && pData[playerid][pTogMic] == 1 && pData[playerid][pTogRadio] == 1)
    {
        SfxSoundTurnOn(pData[playerid][pFreqRadio]);
        if(pData[playerid][pSfxTurnOn] == 1) PlaySoundToFrequensi(pData[playerid][pFreqRadio], "http://20.213.160.211/music/micon.ogg");
    	ApplyAnimation(playerid, "ped", "phone_talk", 4.1, 1, 1, 1, 1, 1, 1);
        SetPlayerChatBubble(playerid,"[Radio]",COLOR_GREEN,10.0,5000);
        if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, 19942, 2, 0.0300, 0.1309, -0.1060, 118.8998, 19.0998, 164.2999);
        SvAttachSpeakerToStream(radioStream[pData[playerid][pFreqRadio]], playerid);
    } 	
    
    if (keyid == 0x42 && localStream[playerid]) SvAttachSpeakerToStream(localStream[playerid], playerid); // Local Stream
    SetPlayerChatBubble(playerid,"[Berbicara]",COLOR_GREEN,10.0,5000);
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid)
{
    if(keyid == 0x42 && pData[playerid][pFreqRadio] >= 1 && pData[playerid][pTogMic] == 1 && pData[playerid][pTogRadio] == 1)
    {
        SfxSoundTurnOff(pData[playerid][pFreqRadio]);
        if(pData[playerid][pSfxTurnOff] == 1) PlaySoundToFrequensi(pData[playerid][pFreqRadio], "http://20.213.160.211/music/micoff.ogg");
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
        SvDetachSpeakerFromStream(radioStream[pData[playerid][pFreqRadio]], playerid);
        if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
    }
 
    if (keyid == 0x42 && localStream[playerid]) SvDetachSpeakerFromStream(localStream[playerid], playerid); // Local Stream
}

// public OnPlayerConnect(playerid)
// {
//     if (SvGetVersion(playerid) == SV_NULL)
//     {
//     	Error(playerid, "Tidak dapat menemukan plugin sampvoice.");
//         //Kick(playerid);
//     }
//     else if (SvHasMicro(playerid) == SV_FALSE)
//     {
//     	Error(playerid, "Mikrofon tidak dapat ditemukan.");
//     }
//     else if ((localStream[playerid] = SvCreateDLStreamAtPlayer(20.0, SV_INFINITY, playerid)))
//     {
//     	Info(playerid, "System Voice Only Fountain Daily & Radio System");
//         SvAddKey(playerid, 0x42);
//     }

// 	TextDrawShowForPlayer(playerid, Voice1);
// 	TextDrawShowForPlayer(playerid, Voice2);

//     GetPlayerName(playerid, pData[playerid][pName], MAX_PLAYER_NAME);
//     pData[playerid][IsLoggedIn] = true;     
// 	return 1;
// }

public OnPlayerSpawn(playerid)
{
    new Query[90];
    format(Query, sizeof(Query), "SELECT * FROM `voicedata` WHERE `pUsername` = '%s' LIMIT 1", GetPlayerNameEx(playerid));
    mysql_tquery(voiceData, Query, "CheckDataVoicePlayer", "d", playerid);     
    return 1;    
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_WALK))
	{
        if(pData[playerid][pRadio] == 0) return 1;
        if(pData[playerid][pTogMic] == 0)
        {
            if(pData[playerid][pTogRadio] == 0) return Error(playerid, "Radio anda sedang mati, Gunakan /togradio untuk menghidupkan radio anda.");
            if(pData[playerid][pFreqRadio] == 0) return Error(playerid, "Frequensi Anda Masih Berada Di {ff0000}(0){FFFFFF}, Tidak dapat menghidupkan Mic Radio");    

            new msgRadio[256];
            format(msgRadio, sizeof msgRadio, "{008000}[MIC]: {FFFFFF}Mic Radio Aktif, terhubung ke Frequensi: {ff0000}(%d).", pData[playerid][pFreqRadio]);
            SendClientMessage(playerid, -1, msgRadio);

            pData[playerid][pTogMic] = 1;
        }
        else if(pData[playerid][pTogMic] == 1)
        {
            if(pData[playerid][pTogRadio] == 0) return Error(playerid, "Radio anda sedang mati, Gunakan /togradio untuk menghidupkan radio anda.");
            if(pData[playerid][pFreqRadio] == 0) return Error(playerid, "Frequensi Anda Masih Berada Di {ff0000}(0){FFFFFF}, Tidak dapat menghidupkan Mic Radio");    

            new msgRadio[256];
            format(msgRadio, sizeof msgRadio, "{008000}[MIC]: {FFFFFF}Mic Radio NonAktif, terhubung ke Frequensi: {ff0000}(%d).", pData[playerid][pFreqRadio]);
            SendClientMessage(playerid, -1, msgRadio);

            pData[playerid][pTogMic] = 0;
        }  		
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if (localStream[playerid])
    {
        SvDeleteStream(localStream[playerid]);
        localStream[playerid] = SV_NULL;
    }   

    RemovePlayerMask(playerid);

    printf("[MySql]: Berhasil Menyimpan Data Player %s Dengan ID %d", GetPlayerNameEx(playerid), pData[playerid][pID]);

    pData[playerid][pTogRadio] = 0;
    SavePlayerDataVoice(playerid);
    ResetDataVoicePlayer(playerid);

    pData[playerid][dataTerload] = false;
    pData[playerid][IsLoggedIn] = false;
    return 1;
}

public OnFilterScriptExit()
{
    for(new i = 0; i < MAX_FREQUENSI; i++)
    {
        SvDeleteStream(radioStream[i]);
    }	
    TextDrawDestroy(Voice1);
	TextDrawDestroy(Voice2);
	return 1;
}


function CheckDataVoicePlayer(playerid)
{
    if(cache_num_rows())
    {
        new Query[90];
        mysql_format(voiceData, Query, sizeof(Query), "SELECT * FROM voicedata WHERE pUsername = '%e'", GetPlayerNameEx(playerid));
        mysql_tquery(voiceData, Query, "LoadDataVoicePlayer", "i", playerid);
    }
    else if(!cache_num_rows())
    {
        new Query[90];
        mysql_format(voiceData, Query, sizeof(Query), "INSERT INTO `voicedata`(`pUsername`) VALUES ('%e')", GetPlayerNameEx(playerid));
        mysql_tquery(voiceData, Query, "CreateDataVoicePlayer", "i", playerid);
    }
}

function CreateDataVoicePlayer(playerid)
{
    new Query[256];
    pData[playerid][pID] = cache_insert_id();
    printf("[MYSQL]: Player %s terdaftar Dengan ID %d", GetPlayerNameEx(playerid), pData[playerid][pID]);

    mysql_format(voiceData, Query, sizeof(Query), "SELECT * FROM voicedata WHERE pID='%i'", pData[playerid][pID]);
    mysql_query(voiceData, Query);

    LoadDataVoicePlayer(playerid);
}

function LoadDataVoicePlayer(playerid)
{
    if(pData[playerid][dataTerload] == true) return 1;
    cache_get_value_int(0, "pID", pData[playerid][pID]);
    cache_get_value_name(0, "pUsername", pData[playerid][pName], MAX_PLAYER_NAME+1);

    cache_get_value_int(0, "pRadio", pData[playerid][pRadio]);
    cache_get_value_int(0, "pTogRadio", pData[playerid][pTogRadio]);
    cache_get_value_int(0, "pTogMic", pData[playerid][pTogMic]);
    //cache_get_value_int(0, "pTogSemua", pData[playerid][pTogSemua]);
    cache_get_value_int(0, "pFreqRadio", pData[playerid][pFreqRadio]);
    cache_get_value_int(0, "pSfxTurnOn", pData[playerid][pSfxTurnOn]);
    cache_get_value_int(0, "pSfxTurnOff", pData[playerid][pSfxTurnOff]);
    pData[playerid][dataTerload] = true;

    printf("[MySql]: Berhasil Mengambil Data Player %s Dengan ID %d", GetPlayerNameEx(playerid), pData[playerid][pID]);
    return 1;
}
function AssignPlayerData(playerid)
{
	cache_get_value_name_int(0, "faction", pData[playerid][pFaction]);
}
function ConnectToFrequensi(playerid, freq, bool:rConnected)
{
    if(freq == 0) return 1;
    if(rConnected == true)
    {
        new msgToFreq[256];
        format(msgToFreq, 256, "{ff0000}(%s){FFFFFF} Telah Keluar Dari Frequensi: {ff0000}(%d).", GetPlayerNameEx(playerid), pData[playerid][pFreqRadio]);
        SendMessageToFrequensi(pData[playerid][pFreqRadio], msgToFreq);

        new msgFreq[256];
        format(msgFreq, sizeof msgFreq, ""WARNA_KUNING"[RADIO]: "WARNA_PUTIH"Anda telah terputus dari Frequensi: {ff0000}(%d){FFFFFF}, Dan terhubung ke Frequensi: {ff0000}(%d).", pData[playerid][pFreqRadio], freq);
        SendClientMessage(playerid, -1, msgFreq);

        SvDetachSpeakerFromStream(radioStream[pData[playerid][pFreqRadio]], playerid);
        SvDetachListenerFromStream(radioStream[pData[playerid][pFreqRadio]], playerid);

        pData[playerid][pFreqRadio] = freq;

        SvAttachListenerToStream(radioStream[freq], playerid);

        format(msgToFreq, 256, "{ff0000}(%s){FFFFFF} Telah Terhubung Ke Frequensi: {ff0000}(%d).", GetPlayerNameEx(playerid), pData[playerid][pFreqRadio]);
        SendMessageToFrequensi(pData[playerid][pFreqRadio], msgToFreq);
    }
    else if(rConnected == false)
    {
        pData[playerid][pFreqRadio] = freq;
        SvAttachListenerToStream(radioStream[freq], playerid);

        new string[128];
        format(string, 128, ""WARNA_KUNING"[RADIO]:"WARNA_PUTIH" Anda berhasil Terhubung ke Frequensi: {ff0000}(%d).", freq);
        SendClientMessage(playerid, 0x00AE00FF, string);

        format(string, 128, "{FF0000}(%s){FFFFFF} Telah Terhubung ke frequensi {ff0000}(%d)", GetPlayerNameEx(playerid), pData[playerid][pFreqRadio]);
        SendMessageToFrequensi(pData[playerid][pFreqRadio], string);
    }
    return 1;
}

function DisconnectToFrequensi(playerid, freq, bool:togOnRadio)
{
    SvDetachListenerFromStream(radioStream[freq], playerid);
    SvDetachSpeakerFromStream(radioStream[freq], playerid);

    new msgToFreq[256];
    format(msgToFreq, 256, "{ff0000}(%s) {FFFFFF}Telah Keluar Dari Frequensi: {FF0000}(%d).", GetPlayerNameEx(playerid), freq);
    SendMessageToFrequensi(freq, msgToFreq);

    new msgFreq[256];
    format(msgFreq, 256, ""WARNA_KUNING"[RADIO]: "WARNA_PUTIH"Anda telah terputus dari Frequensi: {ff0000}(%d).", freq);
    SendClientMessage(playerid, -1, msgFreq);

    if(togOnRadio == false)
    {
        pData[playerid][pFreqRadio] = 0;
    }
    return 1;
}

// ---=== STOCK ===---

stock GetPlayerNameEx(playerid)
{
    new getName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, getName, MAX_PLAYER_NAME);
    return getName;
}

stock ResetDataVoicePlayer(playerid)
{
    pData[playerid][pID] = 0;
    pData[playerid][pRadio] = 0;
    pData[playerid][pTogRadio] = 0;
    pData[playerid][pTogMic] = 0;
    pData[playerid][pTogSemua] = 0;
    pData[playerid][pFreqRadio] = 0;
    pData[playerid][pSfxTurnOn] = 0;
    pData[playerid][pSfxTurnOff] = 0;
    pData[playerid][IsLoggedIn] = false;
}

stock SavePlayerDataVoice(playerid)
{
    new Query[2560];
    mysql_format(voiceData, Query, sizeof(Query), "UPDATE `voicedata` SET `pUsername`='%e',`pRadio`='%d',`pTogRadio`='%d',`pTogMic`='%d',`pFreqRadio`='%d',`pSfxTurnOn`='%d',`pSfxTurnOff`='%d' WHERE `pID`='%d'",
        pData[playerid][pName],
        pData[playerid][pRadio],
        pData[playerid][pTogRadio],
        pData[playerid][pTogMic],
        //pData[playerid][pTogSemua],
        pData[playerid][pFreqRadio],
        pData[playerid][pSfxTurnOn],
        pData[playerid][pSfxTurnOff],
        pData[playerid][pID]
    );
    return mysql_query(voiceData, Query);
}

GivePlayerMoneyEx(playerid, cashgiven)
{
    pData[playerid][pMoney] += cashgiven;
    GivePlayerMoney(playerid, cashgiven);
}

stock SendMessageToFrequensi(freq, msg[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pData[i][pFreqRadio] > 0 && pData[i][pFreqRadio] == freq)
            {
            	new getMsg[256];
            	format(getMsg, 256, ""WARNA_KUNING"[RADIO]: "WARNA_PUTIH"%s", msg);
                SendClientMessage(i, -1, getMsg);
            }
        }
    }
    return 1;
}

stock PlaySoundToFrequensi(freq, getUrl[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pData[i][pFreqRadio] > 0 && pData[i][pFreqRadio] == freq)
            {
                PlayAudioStreamForPlayer(i, getUrl);
            }
        }
    }
    return 1;
}

stock SfxSoundTurnOn(freq)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pData[i][pFreqRadio] > 0 && pData[i][pFreqRadio] == freq && pData[i][pSfxTurnOn] == 1)
            {
                PlayAudioStreamForPlayer(i, "http://20.213.160.211/music/micon.ogg");
            }
        }
    }
}

stock SfxSoundTurnOff(freq)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pData[i][pFreqRadio] > 0 && pData[i][pFreqRadio] == freq && pData[i][pSfxTurnOff] == 1)
            {
                PlayAudioStreamForPlayer(i, "http://20.213.160.211/music/micoff.ogg");
            }
        }
    }
}

/*public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_RADIOSETTINGS)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    return callcmd::togradio(playerid);
                }
                case 1:
                {
                    return callcmd::togmic(playerid);
                }
                case 2:
                {
                    ShowPlayerDialog(playerid, DIALOG_SETFREQ, DIALOG_STYLE_INPUT, "Set Frequensi Radio", "Masukkan Frequensi Radio Yang Ingin Kamu Hubungkan (Maksimal 1 - 99999)", "Hubungkan", "Tutup");
                }
                case 3:
                {
                    new str[256], togSfxTurnOn[256], togSfxTurnOff[256];
                    if(pData[playerid][pSfxTurnOn] == 0)
                    {
                        togSfxTurnOn = "{ff0000}Disable";
                    }
                    else if(pData[playerid][pSfxTurnOn] == 1)
                    {
                        togSfxTurnOn = "{00ff00}Enable";
                    }

                    if(pData[playerid][pSfxTurnOff] == 0)
                    {
                        togSfxTurnOff = "{ff0000}Disable";
                    }
                    else if(pData[playerid][pSfxTurnOff] == 1)
                    {
                        togSfxTurnOff = "{00ff00}Enable";
                    }

                    format(str, sizeof(str), "Sound Effect Settings\tStatus\n{FFFFFF}Status FX TurnON:\t%s\n{FFFFFF}Status FX TurnOFF:\t%s\n{FFFFFF}Hidupkan Semua FX\n{FFFFFF}Matikan Semua FX", togSfxTurnOn, togSfxTurnOff);
                }
                case 4:
                {
                    if(pData[playerid][pSfxTurnOff] == 0)
                    {
                        pData[playerid][pSfxTurnOff] = 1;
                        Info(playerid, "(Sfx Turning Off) Radio Berhasil Dihidupkan.");
                    }
                    else if(pData[playerid][pSfxTurnOff] == 1)
                    {
                        pData[playerid][pSfxTurnOff] = 0;
                        Info(playerid, "(Sfx Turning Off) Radio Berhasil Dimatikan.");
                    }
                }
            }
        }
    }
    if(dialogid == DIALOG_SETFREQ)
    {
        if(response)
        {
            new Frequensi = strval(inputtext);

            if(isnull(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_SETFREQ, DIALOG_STYLE_INPUT, "Set Frequensi Radio", "{ff0000}ERROR: {FFFFFF}Harap Input Frequensi Yang Benar\n\nMasukkan Frequensi Radio Yang Ingin Anda Hubungkan (Maksimal 1 - 99999)", "Hubungkan", "Tutup");
                return 1;
            }
            if(Frequensi > 99999 || Frequensi < 0)
            {
                ShowPlayerDialog(playerid, DIALOG_SETFREQ, DIALOG_STYLE_INPUT, "Set Frequensi Radio", "{ff0000}ERROR: {FFFFFF}Maksimal Frequensi 1 - 99999\n\nMasukkan Frequensi Radio Yang Ingin Anda Hubungkan (Maksimal 1 - 99999)", "Hubungkan", "Tutup");
                return 1;
            }

            if(pData[playerid][pFreqRadio] >= 1)
            {
                ConnectToFrequensi(playerid, Frequensi, true);
            }
            else if(pData[playerid][pFreqRadio] == 0)
            {
                ConnectToFrequensi(playerid, Frequensi, false);
            }
        }
    }
    if(dialogid == DIALOG_SETSFX)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(pData[playerid][pSfxTurnOn] == 0)
                    {
                        pData[playerid][pSfxTurnOn] = 1;
                        Info(playerid, "(FX) Radio TurnON Berhasil Dihidupkan.");
                    }
                    else if(pData[playerid][pSfxTurnOn] == 1)
                    {
                        pData[playerid][pSfxTurnOn] = 0;
                        Info(playerid, "(FX) Radio TurnON Berhasil Dimatikan.");
                    }
                }
                case 1:
                {
                    if(pData[playerid][pSfxTurnOff] == 0)
                    {
                        pData[playerid][pSfxTurnOff] = 1;
                        Info(playerid, "(FX) Radio TurnOFF Berhasil Dihidupkan.");
                    }
                    else if(pData[playerid][pSfxTurnOff] == 1)
                    {
                        pData[playerid][pSfxTurnOff] = 0;
                        Info(playerid, "(FX) Radio TurnOFF Berhasil Dimatikan.");
                    }
                }
                case 2:
                {
                    if(pData[playerid][pSfxTurnOn] == 1 && pData[playerid][pSfxTurnOff] == 1) return Error(playerid, "(FX) Radio Anda telah Aktif");

                    pData[playerid][pSfxTurnOn] = 1;
                    pData[playerid][pSfxTurnOff] = 1;

                    Info(playerid, "(FX) Radio anda berhasil di aktifkan semua");
                }
                case 3:
                {
                    if(pData[playerid][pSfxTurnOn] == 0 && pData[playerid][pSfxTurnOff] == 0) return Error(playerid, "(FX) Radio Anda telah Nonaktif");

                    pData[playerid][pSfxTurnOn] = 0;
                    pData[playerid][pSfxTurnOff] = 0;

                    Info(playerid, "(FX) Radio anda berhasil di Nonaktifkan semua");
                }
            }
        }yu
    }*/
  /*  if(dialogid == DIALOG_SHOPELE)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    new getMoney = GetPlayerMoney(playerid);
                    if(pData[playerid][pRadio] == 1) return Error(playerid, "Anda sudah memiliki radio.");
                    if(getMoney < 10000) return Error(playerid, "Uang Anda Kurang");
                    GivePlayerMoney(playerid, -10000);
                    pData[playerid][pRadio] = 1;
                    Info(playerid, "Anda berhasil membeli radio dengan harga $10.000");
                }
            }
        }
    }
    return 1;
}*/

// ---=== RADIO COMMANDS ====---
CMD:togsfx(playerid)
{
   
	if(pData[playerid][pSfxTurnOn] == 0)
	{
	    pData[playerid][pSfxTurnOn] = 1;
	}
	else if(pData[playerid][pSfxTurnOn] == 1)
	{
	    pData[playerid][pSfxTurnOn] = 0;
	}
	if(pData[playerid][pSfxTurnOff] == 0)
	{
	    pData[playerid][pSfxTurnOff] = 1;
	}
	else if(pData[playerid][pSfxTurnOff] == 1)
	{
        pData[playerid][pSfxTurnOff] = 0;
	}
	return 1;
}
CMD:togsemua(playerid)
{
    
    if(pData[playerid][pTogSemua] == 0)
    {
        pData[playerid][pTogSemua] = 1;
    }
    else if(pData[playerid][pTogSemua] == 1)
    {
        pData[playerid][pTogSemua] = 0;
    }
    return 1;
}
CMD:togmic(playerid)
{
    //if(pData[playerid][pRadio] == 0) return Error(playerid, "Anda tidak memiliki Radio, Silahkan membelinya di toko 24/7");

    if(pData[playerid][pTogMic] == 0)
    {
        if(pData[playerid][pTogRadio] == 0) return Error(playerid, "Radio anda sedang mati, Gunakan /togradio untuk menghidupkan radio anda.");
        if(pData[playerid][pFreqRadio] == 0) return Error(playerid, "Frequensi Anda Masih Berada Di {ff0000}(0){FFFFFF}, Tidak dapat menghidupkan Mic Radio");

        new msgRadio[256];
        format(msgRadio, sizeof msgRadio, "{008000}[MIC]: {FFFFFF}Mic Radio Aktif, terhubung ke Frequensi: {ff0000}(%d).", pData[playerid][pFreqRadio]);
        SendClientMessage(playerid, -1, msgRadio);

        pData[playerid][pTogMic] = 1;
    }
    else if(pData[playerid][pTogMic] == 1)
    {
        if(pData[playerid][pTogRadio] == 0) return Error(playerid, "Radio anda sedang mati, Gunakan /togradio untuk menghidupkan radio anda.");
        if(pData[playerid][pFreqRadio] == 0) return Error(playerid, "Frequensi Anda Masih Berada Di {ff0000}(0){FFFFFF}, Tidak dapat menghidupkan Mic Radio");

        new msgRadio[256];
        format(msgRadio, sizeof msgRadio, "{008000}[MIC]: {FFFFFF}Mic Radio NonAktif, terhubung ke Frequensi: {ff0000}(%d).", pData[playerid][pFreqRadio]);
        SendClientMessage(playerid, -1, msgRadio);

        pData[playerid][pTogMic] = 0;
    }
    return 1;
}

CMD:togradio(playerid)
{
    //if(pData[playerid][pRadio] == 0) return Error(playerid, "Anda tidak memiliki Radio, Silahkan membelinya di toko 24/7");

	if(pData[playerid][pTogRadio] == 0)
	{
		if(pData[playerid][pFreqRadio] >= 1)
		{
            new msgTogRadio[256];
            format(msgTogRadio, sizeof msgTogRadio, ""WARNA_KUNING"[RADIO]: "WARNA_PUTIH"Radio anda telah berhasil {7FFF00}dihidupakan{FFFFFF}");
            SendClientMessage(playerid, -1, msgTogRadio);
			ConnectToFrequensi(playerid, pData[playerid][pFreqRadio], false);
            pData[playerid][pTogRadio] = 1;
		}
        else
        {
            Info(playerid, "Radio anda berhasil Dihidupkan.");
            pData[playerid][pTogRadio] = 1;
        }
	}
	else if(pData[playerid][pTogRadio] == 1)
	{
		if(pData[playerid][pFreqRadio] >= 1)
		{
            new msgTogRadio[256];
            format(msgTogRadio, sizeof msgTogRadio, ""WARNA_KUNING"[RADIO]: "WARNA_PUTIH"Radio anda telah berhasil {FF0000}dimatikan{FFFFFF}.");
			SendClientMessage(playerid, -1, msgTogRadio);
            DisconnectToFrequensi(playerid, pData[playerid][pFreqRadio], true);
            pData[playerid][pTogRadio] = 0;
		}
        else
        {
            Info(playerid, "Radio anda berhasil Dimatikan.");
            pData[playerid][pTogRadio] = 0;
        }
	}
	return 1;
}

CMD:setradio(playerid, params[])
{
    //if(pData[playerid][pRadio] == 0) return Error(playerid, "Anda tidak memiliki Radio, Silahkan membelinya di toko 24/7");
	if(pData[playerid][pTogRadio] == 0) return Error(playerid, "Radio anda sedang mati, Gunakan /togradio untuk menghidupkan radio anda.");

    new freq;
    if(sscanf(params, "d", freq)) return Usage(playerid, "/setradio [Frequensi]");
    if(freq > 99999 || freq < 0) return Error(playerid, "Frequensi Tidak Valid, Maksimal Frequensi 1 - 99999!");
    if(freq == pData[playerid][pFreqRadio]) return Error(playerid, "Kamu sedang berada di Frequensi Yang Anda Input.");

    if(freq == 0)
    {
    	DisconnectToFrequensi(playerid, pData[playerid][pFreqRadio], false);
    }
    else
    {
        if(pData[playerid][pFreqRadio] >= 1)
        {
            SetTimerEx("ConnectToFrequensi", 100, false, "idb", playerid, freq, true);
            SavePlayerDataVoice(playerid);
        }

        if(pData[playerid][pFreqRadio] == 0)
        {
            SetTimerEx("ConnectToFrequensi", 100, false, "idb", playerid, freq, false);
        }
    }
    return 1;
}
/*CMD:setradiof(playerid, params[])
{
    if(pData[playerid][pRadio] == 0) return Error(playerid, "Anda tidak memiliki Radio, Silahkan membelinya di toko 24/7");
	if(pData[playerid][pTogRadio] == 0) return Error(playerid, "Radio anda sedang mati, Gunakan /togradio untuk menghidupkan radio anda.");
	if(pData[playerid][pFaction] != 1) return Error(playerid, "cuk");

    new freq;
    if(sscanf(params, "d", freq)) return Usage(playerid, "/setradio [Frequensi]");
    if(freq > 10 || freq < 0) return Error(playerid, "Frequensi Tidak Valid, Maksimal Frequensi 1 - 99999!");
    if(freq == pData[playerid][pFreqRadio]) return Error(playerid, "Kamu sedang berada di Frequensi Yang Anda Input.");

    if(freq == 0)
    {
    	DisconnectToFrequensi(playerid, pData[playerid][pFreqRadio], false);
    }
    else
    {
        if(pData[playerid][pFreqRadio] >= 1)
        {
            SetTimerEx("ConnectToFrequensi", 100, false, "idb", playerid, freq, true);
            SavePlayerDataVoice(playerid);
        }

        if(pData[playerid][pFreqRadio] == 0)
        {
            SetTimerEx("ConnectToFrequensi", 100, false, "idb", playerid, freq, false);
        }
    }
    return 1;
}*/

CMD:minti(playerid, params[])
{
    //if(pData[playerid][pRadio] == 0) return Error(playerid, "Anda tidak memiliki Radio, Silahkan membelinya di toko 24/7");

    new str[1024], togRadio[64], togMic[64], radioFreq[64];
    if(pData[playerid][pTogRadio] == 0)
    {
        togRadio = "{ff0000}Disable";
    }
    else if(pData[playerid][pTogRadio] == 1)
    {
        togRadio = "{00ff00}Enable";
    }

    if(pData[playerid][pTogMic] == 0)
    {
        togMic = "{ff0000}Disconnected";
    }
    else
    {
        togMic = "{00ff00}Connected";
    }

    if(pData[playerid][pFreqRadio] == 0)
    {
        radioFreq = "{ff0000}Freq Not Connected";
    }
    else if(pData[playerid][pFreqRadio] >= 1)
    {
        format(radioFreq, sizeof radioFreq, "{00ff00}%d", pData[playerid][pFreqRadio]);
    }

    format(str, sizeof(str), "Radio Settings\tStatus\n{FFFFFF}Status Radio:\t%s\n{FFFFFF}Status Mic:\t%s\n{FFFFFF}Frequensi Radio:\t%s\n{FFFFFF}Atur FX Radio", togRadio, togMic, radioFreq);

    ShowPlayerDialog(playerid, DIALOG_RADIOSETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "Radio Settings", str, "Set", "Close");

    return 1;
}

CMD:saveradio(playerid, params[])
{
    
    SavePlayerDataVoice(playerid);
    Info(playerid, "Berhasil Di Simpan");
}
CMD:buangradio(playerid, params[])
{
    //if(pData[playerid][pRadio] < 1) return Error(playerid, "Anda tidak memiliki radio.");
    {
	    pData[playerid][pRadio] -= 1;
		Info(playerid, "Anda berhasil membeli radio dengan harga $10.000");
	}
	return 1;
}
CMD:buyradio(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1176.6796,-1314.8643,14.0150)) return Info(playerid, "Kamu tidak berada di pasar");
    {
    				new getMoney = GetPlayerMoney(playerid);
                    if(pData[playerid][pRadio] == 1) return Error(playerid, "Anda sudah memiliki radio.");
                    if(getMoney < 10000) return Error(playerid, "Uang Anda Kurang");
                    GivePlayerMoney(playerid, -5000);
                    pData[playerid][pRadio] = 1;
                    Info(playerid, "Anda berhasil membeli radio dengan harga $5.000");
	}
    return 1;
}
CMD:global(playerid)
{
	SvUpdateDistanceForLStream(localStream[playerid], 5000000.0);
	SendClientMessage(playerid, 0xFF0000FF, "[INFO] Anda telah global distance suara gunakan /n untuk kembali normal");
	return 1;
}
CMD:n(playerid)
{
	SvUpdateDistanceForLStream(localStream[playerid], 20.0);
    TextDrawSetString(Voice2, "TERIAK");
	SendClientMessage(playerid, 0xFF0000FF, "[INFO] Anda telah memperbesar distance suara gunakan /n untuk kembali normal");
	return 1;
}
CMD:n(playerid)
{
    SvUpdateDistanceForLStream(localStream[playerid], 10.0);
    TextDrawSetString(Voice2, "NORMAL");
	SendClientMessage(playerid, 0xFF0000FF, "[INFO] Suara anda telah kembali normal");
	return 1;
}
CMD:w(playerid)
{
    SvUpdateDistanceForLStream(localStream[playerid], 2.0);
    TextDrawSetString(Voice2, "PELAN");
	SendClientMessage(playerid, 0xFF0000FF, "[INFO] Anda telah memperkecil distance suara gunakan /n untuk kembali normal");
	return 1;
}
