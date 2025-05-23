// ========== [INCLUDE] ========== //
#include <a_samp>
#include <sampvoice>
#define FILTERSCRIPT
#include <Pawn.CMD>
//#include <timerfix>
#include <sscanf2>

#define Usage(%1,%2) SendClientMessage(%1, ARWIN , "[USAGE]: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, ARWIN, "INFO: "WHITE_E""%2)
#define ARWIN				0xC6E2FFFF
#define DARK_E 		"{7A7A7A}"
#define WHITE_E 	"{FFFFFF}"

#define MAX_JARAK 35
#define MIN_JARAK 20

#define MAX_FREQUENCIAS 1000
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// ========== [VARIABLE] ========== //
new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };
new SV_GSTREAM:Frequencia[MAX_FREQUENCIAS] = { SV_NULL, ... };

enum PlayerData
{
	FreqConnect,
	pVoiceRadio
};

new pData[MAX_PLAYERS][PlayerData];
// ========== [CONSOLE LOG] ========== //
main()
{
	printf("=============================\n");
	printf("[FILTERSCRIPT SAMP VOICE LOADED]\n");
	printf("=============================\n");
}

// ========== [FUNCTION FROM INCLUDE SAMPVOICE] ========== //
public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid)
{
    // Attach player to local stream as speaker if 'B' key is pressed
    if (keyid == 0x42 && lstream[playerid])  SvAttachSpeakerToStream(lstream[playerid], playerid);
    // Attach player to radio stream as speaker if 'B' key is pressed
    if (keyid == 0x42 && pData[playerid][FreqConnect] >= 1)
	{
	    pData[playerid][pVoiceRadio] = 1;
	    PlayAudioStreamForPlayer(playerid, "http://20.213.160.211/music/micon.ogg");
		if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, 19942, 2, 0.0300, 0.1309, -0.1060, 118.8998, 19.0998, 164.2999);
		SvAttachSpeakerToStream(Frequencia[pData[playerid][FreqConnect]], playerid);
	}
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid)
{
    // Detach the player from the local stream if the 'B' key is released
    if (keyid == 0x42 && lstream[playerid])
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		// Detach the player from the radio stream if 'B' key is released
	    if (pData[playerid][FreqConnect] >= 1)
		{
		    pData[playerid][pVoiceRadio] = 0;
		    PlayAudioStreamForPlayer(playerid, "http://20.213.160.211/music/micoff.ogg");
			SvDetachSpeakerFromStream(Frequencia[pData[playerid][FreqConnect]], playerid);
			//ClearAnimations(playerid);
			if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
		}
	}
}

public OnPlayerConnect(playerid)
{
    // Checking for plugin availability
    if (SvGetVersion(playerid) == SV_NULL)
    {
        SendClientMessage(playerid, -1, "Could not find plugin sampvoice.");
    }
    // Checking for a microphone
    else if (SvHasMicro(playerid) == SV_FALSE)
    {
        SendClientMessage(playerid, -1, "The microphone could not be found.");
    }
    // Create a local stream with an audibility distance of 20.0, an unlimited number of listeners
    // and the name 'Local' (the name 'Local' will be displayed in red in the players' speakerlist)
    else if ((lstream[playerid] = SvCreateDLStreamAtPlayer(10.0, SV_INFINITY, playerid)))
    {
        //SendClientMessage(playerid, -1, "KTRP");
        SendClientMessage(playerid, -1, "Gunakan /vc Buat Settings Voice.");
    	Info(playerid, "Jika Kamu Player PC Tekan Tombol B Untuk Mengobrol.");
        // Assign microphone activation keys to the player
        SvAddKey(playerid, 0x42);
    }
    pData[playerid][pVoiceRadio] = 0;
    pData[playerid][FreqConnect] = 0;
}

public OnPlayerDisconnect(playerid, reason)
{
    // Removing the player's local stream after disconnecting
    if (lstream[playerid])
    {
        SvDeleteStream(lstream[playerid]);
        lstream[playerid] = SV_NULL;
    }
}

// public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
// {
//  	if(dialogid == 2975)
//     {
//         if(response)
//         {
//             new jarak = strval(inputtext);
// 			if(!(MIN_JARAK <= jarak <= MAX_JARAK))
// 			{
// 				SendClientMessage(playerid, -1, !"Minimal 20.0 jarak. dan Maksimal 35.0 jarak");
// 			}
// 			else
// 			{
// 		        Info(playerid, "You has been custom jarak");
// 				lstream[playerid] = SvCreateDLStreamAtPlayer(jarak, SV_INFINITY, playerid);
// 				return 1;
// 			}
//         }
//     }
//     if(dialogid == 9000)
//     {
//         if(!response) return 1;
//         switch(listitem)
//         {
//             case 0:
//             {
//                 lstream[playerid] = SvCreateDLStreamAtPlayer(10.0, SV_INFINITY, playerid);
//                 Info(playerid, "Normal");
//             }
//             case 1:
//             {
//                 lstream[playerid] = SvCreateDLStreamAtPlayer(2.0, SV_INFINITY, playerid);
//                 Info(playerid, "Berbisik");
//             }
//             case 2:
//             {
//                 lstream[playerid] = SvCreateDLStreamAtPlayer(35.0, SV_INFINITY, playerid);
//                 Info(playerid, "Teriak");
//             }
//             case 3:
//             {
//                 new str[128];
// 				format(str, sizeof(str), "Atur Jarak Semaulu\nContoh 30.0 harus pake .0");
// 				ShowPlayerDialog(playerid, 2975, DIALOG_STYLE_INPUT, "Voice Settings", str, "Atur", "Batalkan");
//             }
//         }
//     }
//     return 1;
// }

public OnFilterScriptInit()
{
    for(new i = 0; i < MAX_FREQUENCIAS; i++)
	{
		Frequencia[i] = SvCreateGStream(0xFF5800FF, "Radio");
	}
	return 1;
}

public OnFilterScriptExit()
{
    for(new i = 0; i < MAX_FREQUENCIAS; i++)
	{
		SvDeleteStream(Frequencia[i]);
	}
}

stock MsgFrequencia(freq, color, msg[])
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			if(pData[i][FreqConnect] > 0 && pData[i][FreqConnect] == freq)
			{
				SendClientMessage(i, color, msg);
			}
		}
	}
	return 1;
}

forward ConectarNaFrequencia(playerid, freq);
public ConectarNaFrequencia(playerid, freq)
{
	pData[playerid][FreqConnect] = freq;
	SvAttachListenerToStream(Frequencia[freq], playerid);
	return 1;
}
stock Get_Nome(playerid)
{
	new namep[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, namep, MAX_PLAYER_NAME+1);
	return namep;
}
SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
    static
        args,
            str[144];

    if((args = numargs()) == 3)
    {
            SendClientMessage(playerid, color, text);
    }
    else
    {
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

CMD:rvasd(playerid, params[])
{
	new freq;
	if(sscanf(params, "d", freq)) return Usage(playerid, "/rv(radio stream) [Frequency 1-1000]");
	if(freq > 1000 || freq < 0) return SendClientMessage(playerid, 0xFF0000FF, "Frequency is  valid!");
	if(pData[playerid][pVoiceRadio] == 1)
	{
	    return SendClientMessage(playerid, -1, "Kamu harus mematikan voice kamu jika ingin berpindah frequensi");
	}
	if(freq == 0)
	{
		SendClientMessage(playerid, -1, "You has disconnect from radio");
		SvDetachListenerFromStream(Frequencia[pData[playerid][FreqConnect]], playerid);
		pData[playerid][FreqConnect] = 0;
	}
	else
	{
		new string[128];
		format(string, 128, "[Radio] You has connecting to freq: (%d).", freq);
		SendClientMessage(playerid, 0x00AE00FF, string);

		format(string, 128, "[Radio] %s Connect to freq(%d)", Get_Nome(playerid), pData[playerid][FreqConnect]);
		MsgFrequencia(pData[playerid][FreqConnect], 0xBF0000FF, string);
		format(string, 128, "[Radio] %s connect to freq(%d)", Get_Nome(playerid), freq);
		MsgFrequencia(freq, 0xFF6C00FF, string);

		SetTimerEx("ConectarNaFrequencia", 100, false, "id", playerid, freq);
	}
	return 1;
}

CMD:vc(playerid)
{
    ShowPlayerDialog(playerid, 9000, DIALOG_STYLE_LIST, "Voice Chat Setting", "Normal\nBebisik\nTeriak\nCustom", "Pilih", "Batalkan");
    return 1;
}
