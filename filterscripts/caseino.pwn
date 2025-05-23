#include <a_samp>
#include <DC_CMD>
#define dialogid_bet                                                         500
#define dialog_exit                                                          501

new PlayerText:casino[MAX_PLAYERS][25];
new
    PlayerWin[MAX_PLAYERS],
    GameOwer[MAX_PLAYERS],
    Mode[MAX_PLAYERS] = 1,
    InGame[MAX_PLAYERS] = 0,
    clicked_td[MAX_PLAYERS][25],
	Money_Win[MAX_PLAYERS];

info_casino(playerid)
{
	new mes[1000];
	strcat(mes,"{FFFFFF}Описание системы\n");
	strcat(mes,"В системе имеется 3 режима игры:\n");
	strcat(mes,"1. У игрока есть 3 права на ошибку, после третьей ошибки игра заканчивается, он проигрывает всё.\n");
	strcat(mes,"Возможные призы: (10%, 25%, 50%, 100%).\n");
	strcat(mes,"2. У игрока нет права на ошибку, если он не угадывает, то проигрывает всё.\n");
	strcat(mes,"Призы увеличены: (25%, 50%, 75%, 150%).\n");
	strcat(mes,"3. Игрок может открыть все ячейки, жизней нет, но призы будут равны 10$ за каждый проигрыш\n");
	strcat(mes,"а шансы на получение максимального приза значительно меньше, шансы на проигрыш увеличены\n");
	strcat(mes,"Призы: (5% 10% 25% 50%) \n");
	strcat(mes,"C вами был grod надеюсь вам понравится\n");
	strcat(mes,"Это бюджет версия(т.е)халявная, а не та которую продают. . .\n");
	ShowPlayerDialog(playerid, 0, 0, "{FF6F00}ИНФОРМАЦИЯ", mes, "ок", "");
}

public OnPlayerConnect(playerid)
{
    td_casino(playerid);
	return 1;
}
public OnGameModeInit()
{
	//( = Автома  =)
    CreateObject(2754, 2019.06714, 1003.26709, 10.59883,   0.00000, 0.00000, 178.77919);
	print("                     ____________________________");
	print("                    | 	     RPC  by  GROD  	 |");
	print("                    | 	    Copyright 2017 (c)	 |");
	print("                    |________vk.com/rpc2014______|");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

CMD:test(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid,3.0,2020.2573,1003.2549,10.8203))
	{
	    SetPlayerCameraPos(playerid, 2020.461059, 1003.224975, 11.354500);
		SetPlayerCameraLookAt(playerid, 2015.511840, 1003.381774, 10.661425);
		new string[15];
		format(string, sizeof(string), "BET: ~y~0");
		PlayerTextDrawSetString(playerid, casino[playerid][5],string);
		format(string, sizeof(string), "WIN: ~y~0",Money_Win[playerid]);
		PlayerTextDrawSetString(playerid, casino[playerid][6],string);
	    for(new x = 0;x < 13 ; x++) PlayerTextDrawShow(playerid, casino[playerid][x]);
	 	SelectTextDraw(playerid, 0xF68879AA);
	}
    return true;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == casino[playerid][4])
    {
        PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
		info_casino(playerid);
	}
    if(playertextid == casino[playerid][8])
    {
        PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
    	ShowPlayerDialog(playerid,dialogid_bet,1,"Установка ставки для игры:","Ставка должна быть не менее 100 $\nи не более 3000 $. Введите сумму ставки..","Далее","Отмена");
    	return true;
    }
    if(playertextid == casino[playerid][9])
    {
        PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
        if(InGame[playerid] == 1) return ShowPlayerDialog(playerid, 0, 0, "{FF6F00}ДУРА", "Во время игры нельзя менять режим.", "Ок","");
    	new string[25];
    	Mode[playerid] += 1;
    	if(Mode[playerid] > 3)
    	{
    	    Mode[playerid] = 1;
    	}
        format(string, sizeof(string), "MODE: ~y~%d",Mode[playerid]);
		PlayerTextDrawSetString(playerid, casino[playerid][7],string);
    }
	if(playertextid >= casino[playerid][13] && playertextid <= casino[playerid][24])
    {
        if(Money_Win[playerid] == 0) return ShowPlayerDialog(playerid, 0, 0, "{FF6F00}ДУРА", "Сначала ставку сделай [BET]", "Ок","");
        new clicked;
        for(new t = 25; t-- != 13;)
        {
            if(playertextid == casino[playerid][t])
               clicked = t;
        }
        if(clicked_td[playerid][clicked])
            return true;
        InGame[playerid] = 1;
        PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
        new ran;
	    ran = random(2);
	    switch(ran)
	    {
	        case 0:
	        {
	            PlayerTextDrawSetString(playerid,casino[playerid][clicked], "LD_CHAT:thumbup");
	            PlayerWins(playerid);//вычисляем процент от правельного открытия)))
	        }
	        case 1:
			{
				PlayerTextDrawSetString(playerid,casino[playerid][clicked], "LD_CHAT:thumbdn");
	            GameOwers(playerid);//подчет ошибок
			}
		}
		clicked_td[playerid][clicked] = 1;
    }
    if(playertextid == casino[playerid][10])
    {
    	PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
        if(Money_Win[playerid] == 0) return ShowPlayerDialog(playerid, 0, 0, "{FF6F00}ВЫЙГРЫШ", "Вы не чего не выйграли.", "Ок","");
        new string[15];
        format(string,sizeof(string),"~g~+$%d",Money_Win[playerid]);
		GameTextForPlayer(playerid, string, 3000, 6);
    	GivePlayerMoney(playerid, Money_Win[playerid]);
    	Money_Win[playerid] = 0;
    	PlayerWin[playerid] = 0;
    	InGame[playerid] = 0;
    	format(string, sizeof(string), "BET: ~y~0");
		PlayerTextDrawSetString(playerid, casino[playerid][5],string);
    	format(string, sizeof(string), "WIN: ~y~%d",Money_Win[playerid]);
		PlayerTextDrawSetString(playerid, casino[playerid][6],string);
		PlayerTextDrawShow(playerid, casino[playerid][12]);
		for ( new t = 13 ; t < 25 ; t++ ) PlayerTextDrawHide(playerid, casino[playerid][t]);
		PlayerPlaySound(playerid, 43001, 0.0, 0.0, 0.0);
    }
    if(playertextid == casino[playerid][11])
    {
        if(Money_Win[playerid] > 0) return ShowPlayerDialog(playerid, dialog_exit, 0, "{FFFFFF}Предупреждение", "{FF0000}У вас сделана ставка,если вы выйдите сейчас,то она пропадет\n\
		{FFFF00}Вы действительно хотите покинуть игру?", "Yes","No");
        PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
    	for(new x; x < 25; x++) PlayerTextDrawHide(playerid, casino[playerid][x]);
        CancelSelectTextDraw(playerid);
        Money_Win[playerid] = 0;
    	PlayerWin[playerid] = 0;
    	InGame[playerid] = 0;
    	SetCameraBehindPlayer(playerid);
    }
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == dialogid_bet)
	{
  		if(!response) return 1;
        if(strval(inputtext) < 100 || strval(inputtext) > 3000) return SendClientMessage(playerid,0xAFAFAFAA,"Неверная ставка");
        GivePlayerMoney(playerid, -strval(inputtext));
        Money_Win[playerid] += SetPVarInt(playerid,"w_m",strval(inputtext)/100);//100 - это для того чтобы вычислить нужный нам процент
        new string[25];
        format(string, sizeof(string), "BET: ~y~%d",strval(inputtext));
		PlayerTextDrawSetString(playerid, casino[playerid][5],string);
		PlayerTextDrawHide(playerid, casino[playerid][12]);
		for ( new t = 13 ; t < 25 ; t++ )
		{
		    if(t < 25) clicked_td[playerid][t] = 0;
			PlayerTextDrawShow(playerid, casino[playerid][t]);
			PlayerTextDrawSetString(playerid,casino[playerid][t], "LD_BEAT:cring");
		}
	}
	if(dialogid == dialog_exit)
	{
  		if(!response) return 1;
  		PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
    	for(new x; x < 25; x++) PlayerTextDrawHide(playerid, casino[playerid][x]);
        CancelSelectTextDraw(playerid);
        Money_Win[playerid] = 0;
    	PlayerWin[playerid] = 0;
    	InGame[playerid] = 0;
    	SetCameraBehindPlayer(playerid);
	}
	return 1;
}
forward PlayerWins(playerid);
public PlayerWins(playerid)
{
	new string[25];
    PlayerWin[playerid] ++; // прибовляет +1 при ножатие
    switch(Mode[playerid])
    {
        case 1:
        {
		    switch(PlayerWin[playerid])
		    {
		        case 1,2: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 10;
		        case 3: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 25;
		        case 4: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 50;
		        case 5..12: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 100;
		    }
		}
		case 2:
        {
		    switch(PlayerWin[playerid])
		    {
		        case 1,2: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 25;
		        case 3: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 50;
		        case 4: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 75;
		        case 5..12: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 150;
		    }
		}
		case 3:
        {
		    switch(PlayerWin[playerid])
		    {
		        case 1,2: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 5;
		        case 3: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 10;
		        case 4: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 25;
		        case 5..12: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 50;
		    }
		}
	}
    format(string, sizeof(string), "WIN: ~y~%d",Money_Win[playerid]);
	PlayerTextDrawSetString(playerid, casino[playerid][6],string);
    return 1;
}
forward GameOwers(playerid);
public GameOwers(playerid)
{
	new string[25];
	GameOwer[playerid] ++;
	switch(Mode[playerid])
    {
        case 1:
        {
			if(GameOwer[playerid] >= 3)
			{

		    	Money_Win[playerid] = 0;
		    	PlayerWin[playerid] = 0;
		    	format(string, sizeof(string), "BET: ~y~0");
				PlayerTextDrawSetString(playerid, casino[playerid][5],string);
		    	format(string, sizeof(string), "WIN: ~y~%d",Money_Win[playerid]);
				PlayerTextDrawSetString(playerid, casino[playerid][6],string);
				GameOwer[playerid] = 0;
				InGame[playerid] = 0;
				GameTextForPlayer(playerid, "~r~GameOwer", 3000, 6);
				for ( new t = 13 ; t < 25 ; t++ ) PlayerTextDrawHide(playerid, casino[playerid][t]);
				PlayerTextDrawShow(playerid, casino[playerid][12]);
				PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
			}
		}
		case 2:
        {
			if(GameOwer[playerid] >= 1)
			{

		    	Money_Win[playerid] = 0;
		    	PlayerWin[playerid] = 0;
		    	format(string, sizeof(string), "BET: ~y~0");
				PlayerTextDrawSetString(playerid, casino[playerid][5],string);
		    	format(string, sizeof(string), "WIN: ~y~%d",Money_Win[playerid]);
				PlayerTextDrawSetString(playerid, casino[playerid][6],string);
				GameOwer[playerid] = 0;
				InGame[playerid] = 0;
				GameTextForPlayer(playerid, "~r~GameOwer", 3000, 6);
				for ( new t = 13 ; t < 25 ; t++ ) PlayerTextDrawHide(playerid, casino[playerid][t]);
				PlayerTextDrawShow(playerid, casino[playerid][12]);
				PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
			}
		}
		case 3:
        {
			if(GameOwer[playerid] >= 1)
			{

                Money_Win[playerid] = 10;
       			GameOwer[playerid] = 0;
       			format(string, sizeof(string), "WIN: ~y~%d",Money_Win[playerid]);
				PlayerTextDrawSetString(playerid, casino[playerid][6],string);
			}
		}
	}
}
stock td_casino(playerid)
{
    casino[playerid][0] = CreatePlayerTextDraw(playerid, 217.999969, 171.733337, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, casino[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, casino[playerid][0], 200.333343, 225.659332);
	PlayerTextDrawAlignment(playerid, casino[playerid][0], 1);
	PlayerTextDrawColor(playerid, casino[playerid][0], 0xF6BD79AA);
	PlayerTextDrawSetShadow(playerid, casino[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, casino[playerid][0], 0);
	PlayerTextDrawFont(playerid, casino[playerid][0], 4);

	casino[playerid][1] = CreatePlayerTextDraw(playerid, 420.333343, 209.737030, "usebox");
	PlayerTextDrawLetterSize(playerid, casino[playerid][1], 0.000000, 0.052055);
	PlayerTextDrawTextSize(playerid, casino[playerid][1], 216.666671, 0.000000);
	PlayerTextDrawAlignment(playerid, casino[playerid][1], 1);
	PlayerTextDrawColor(playerid, casino[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, casino[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, casino[playerid][1], 102);
	PlayerTextDrawSetShadow(playerid, casino[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, casino[playerid][1], 0);
	PlayerTextDrawFont(playerid, casino[playerid][1], 0);

	casino[playerid][2] = CreatePlayerTextDraw(playerid, 420.333343, 369.440582, "usebox");
	PlayerTextDrawLetterSize(playerid, casino[playerid][2], 0.000000, 0.052055);
	PlayerTextDrawTextSize(playerid, casino[playerid][2], 216.666610, 0.000000);
	PlayerTextDrawAlignment(playerid, casino[playerid][2], 1);
	PlayerTextDrawColor(playerid, casino[playerid][2], 0);
	PlayerTextDrawUseBox(playerid, casino[playerid][2], true);
	PlayerTextDrawBoxColor(playerid, casino[playerid][2], 102);
	PlayerTextDrawSetShadow(playerid, casino[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, casino[playerid][2], 0);
	PlayerTextDrawFont(playerid, casino[playerid][2], 0);

	casino[playerid][3] = CreatePlayerTextDraw(playerid, 259.333343, 172.818511, "usebox");
	PlayerTextDrawLetterSize(playerid, casino[playerid][3], 0.000000, 3.739300);
	PlayerTextDrawTextSize(playerid, casino[playerid][3], 216.666671, 0.000000);
	PlayerTextDrawAlignment(playerid, casino[playerid][3], 1);
	PlayerTextDrawColor(playerid, casino[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, casino[playerid][3], true);
	PlayerTextDrawBoxColor(playerid, casino[playerid][3], 102);
	PlayerTextDrawSetShadow(playerid, casino[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, casino[playerid][3], 0);
	PlayerTextDrawFont(playerid, casino[playerid][3], 0);

	casino[playerid][4] = CreatePlayerTextDraw(playerid, 218.333343, 172.148147, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, casino[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, casino[playerid][4], 38.000000, 35.259262);
	PlayerTextDrawAlignment(playerid, casino[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, casino[playerid][4], 0xFFFFFF00);
	PlayerTextDrawColor(playerid, casino[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, casino[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, casino[playerid][4], 0);
	PlayerTextDrawFont(playerid, casino[playerid][4], 5);
	PlayerTextDrawSetSelectable(playerid, casino[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, casino[playerid][4], 1239);
	PlayerTextDrawSetPreviewRot(playerid, casino[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);
	
	casino[playerid][5] = CreatePlayerTextDraw(playerid, 263.666625, 173.392593, "bet: ~y~0$");
	casino[playerid][6] = CreatePlayerTextDraw(playerid, 263.666625, 189.985183, "win: ~y~0$");
	casino[playerid][7] = CreatePlayerTextDraw(playerid, 362.333312, 191.229629, "mode: ~y~1");
 	for(new i = 5;i<8; i++)
	{
		PlayerTextDrawLetterSize(playerid, casino[playerid][i], 0.337332, 1.508741);
		PlayerTextDrawAlignment(playerid, casino[playerid][i], 1);
		PlayerTextDrawColor(playerid, casino[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, casino[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, casino[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, casino[playerid][i], 51);
		PlayerTextDrawFont(playerid, casino[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, casino[playerid][i], 1);
	}
	casino[playerid][8] = CreatePlayerTextDraw(playerid, 226.999923, 377.481414, "bet");
	PlayerTextDrawTextSize(playerid, casino[playerid][8], 252.666656, 24.474069);
	casino[playerid][9] = CreatePlayerTextDraw(playerid, 263.333374, 377.481414, "mode");
	PlayerTextDrawTextSize(playerid, casino[playerid][9], 301.000000, 15.348150);
	casino[playerid][10] = CreatePlayerTextDraw(playerid, 309.333374, 377.481445, "take win");
	PlayerTextDrawTextSize(playerid, casino[playerid][10], 374.000061, 8.711110);
	casino[playerid][11] = CreatePlayerTextDraw(playerid, 381.000091, 377.481414, "exit");
	PlayerTextDrawTextSize(playerid, casino[playerid][11], 412.333587, 8.711111);
	for(new x = 8; x <12; x++)
	{
		PlayerTextDrawLetterSize(playerid, casino[playerid][x], 0.306665, 1.512889);
		PlayerTextDrawAlignment(playerid, casino[playerid][x], 1);
		PlayerTextDrawColor(playerid, casino[playerid][x], -1);
		PlayerTextDrawSetShadow(playerid, casino[playerid][x], 0);
		PlayerTextDrawSetOutline(playerid, casino[playerid][x], 1);
		PlayerTextDrawBackgroundColor(playerid, casino[playerid][x], 51);
		PlayerTextDrawFont(playerid, casino[playerid][x], 2);
		PlayerTextDrawSetProportional(playerid, casino[playerid][x], 1);
		PlayerTextDrawSetSelectable(playerid, casino[playerid][x], true);
	}
	casino[playerid][12] = CreatePlayerTextDraw(playerid, 227.333236, 233.955368, "\tPLACE A BET~n~\t\t\t\t\tTO~n~START THE GAME");
	PlayerTextDrawLetterSize(playerid, casino[playerid][12], 0.664333, 4.258965);
	PlayerTextDrawAlignment(playerid, casino[playerid][12], 1);
	PlayerTextDrawColor(playerid, casino[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, casino[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, casino[playerid][12], 1);
	PlayerTextDrawBackgroundColor(playerid, casino[playerid][12], 51);
	PlayerTextDrawFont(playerid, casino[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, casino[playerid][12], 1);
	casino[playerid][13] = CreatePlayerTextDraw(playerid, 234.000000, 229.370376, "LD_BEAT:cring");
	casino[playerid][14] = CreatePlayerTextDraw(playerid, 281.333343, 229.370376, "LD_BEAT:cring");
	casino[playerid][15] = CreatePlayerTextDraw(playerid, 326.333435, 228.370376, "LD_BEAT:cring");
	casino[playerid][16] = CreatePlayerTextDraw(playerid, 370.333526, 228.148117, "LD_BEAT:cring");
	
	casino[playerid][17] = CreatePlayerTextDraw(playerid, 234.000000, 275.437072, "LD_BEAT:cring");
	casino[playerid][18] = CreatePlayerTextDraw(playerid, 281.333343, 275.437072, "LD_BEAT:cring");
	casino[playerid][19] = CreatePlayerTextDraw(playerid, 326.333435, 275.437072, "LD_BEAT:cring");
	casino[playerid][20] = CreatePlayerTextDraw(playerid, 370.333526, 275.437072, "LD_BEAT:cring");
	
	casino[playerid][21] = CreatePlayerTextDraw(playerid, 234.000000, 321.481628, "LD_BEAT:cring");
	casino[playerid][22] = CreatePlayerTextDraw(playerid, 281.333343, 318.481628, "LD_BEAT:cring");
	casino[playerid][23] = CreatePlayerTextDraw(playerid, 326.333435, 318.481628, "LD_BEAT:cring");
	casino[playerid][24] = CreatePlayerTextDraw(playerid, 370.333526, 317.481628, "LD_BEAT:cring");
	for(new x= 13; x < 25; x++)
	{
		PlayerTextDrawLetterSize(playerid, casino[playerid][x], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, casino[playerid][x], 31.333358, 33.600006);
		PlayerTextDrawAlignment(playerid, casino[playerid][x], 1);
		PlayerTextDrawColor(playerid, casino[playerid][x], -1);
		PlayerTextDrawSetShadow(playerid, casino[playerid][x], 0);
		PlayerTextDrawSetOutline(playerid, casino[playerid][x], 0);
		PlayerTextDrawFont(playerid, casino[playerid][x], 4);
		PlayerTextDrawSetSelectable(playerid, casino[playerid][x], true);
	}
	return 1;
}

