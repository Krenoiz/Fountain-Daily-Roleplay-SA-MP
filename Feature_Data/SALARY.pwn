/*#define MAX_SALARY 15

enum E_SALARY
{
	salOwner,
	salInfo[16],
	salMoney,
	salDate[30]
};
new SalData[MAX_SALARY][E_SALARY];*/

AddPlayerSalary(playerid, info[], money)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO salary(owner, info, money, date) VALUES ('%d', '%s', '%d', CURRENT_TIMESTAMP())", pData[playerid][pID], info, money);
	mysql_tquery(g_SQL, query);
	return true;
}

alias:salary("mysalary")

CMD:salary(playerid, params[])
{
	DisplaySalary(playerid);
	return 1;
}

DisplaySalary(playerid)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 30", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new list[2000], date[30], info[46], money, gajiduty, totalsal, total;
		
		/* totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		format(list, sizeof(list), ""WHITE_E"Date\t""WHITE_E"Info\t""WHITE_E"Amount\n");
		if(pData[playerid][pJob] == 9 || pData[playerid][pJob2] == 9)
		{
			if(totalduty > 600)
			{
				gajiduty = 600;
			}
			else
			{
				gajiduty = totalduty;
			}
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		} */
		format(list, sizeof(list), ""WHITE_E"Date\t"WHITE_E"Info\t"WHITE_E"Amount\n");
		for(new i; i < rows; ++i)
	    {
			cache_get_value_name(i, "info", info);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "money", money);
			
			format(list, sizeof(list), "%s"WHITE_E"%s\t%s\t"LG_E"%s\n", list, date, info, FormatMoney(money));
			totalsal += money;
		}
		total = gajiduty + totalsal;
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"%s\n", list, FormatMoney(total));
		
		new title[48];
		format(title, sizeof(title), "Salary: %s", pData[playerid][pName]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Close", "");
	}
	else
	{
		new list[2000], gajiduty;
		
		// totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		format(list, sizeof(list), ""WHITE_E"Date\t"WHITE_E"Info\t"WHITE_E"Amount\n");
		// if(pData[playerid][pFaction] >= 1)
		// {
		// 	format(list, sizeof(list), "%sCurrent Time\tFaction\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		// }
		/* if(pData[playerid][pJob] == 9 || pData[playerid][pJob2] == 9)
		{
			if(totalduty > 500)
			{
				gajiduty = 500;
			}
			else
			{
				gajiduty = totalduty;
			}
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		} */
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		
		new title[48];
		format(title, sizeof(title), "Salary: %s", pData[playerid][pName]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Close", "");
	}
	return 1;
}

CMD:salaryjobs(playerid)
{
    new longstr2[3500];
    longstr2[0] = '\0';
    
    strcat(longstr2, "{5FC6F4}Looking for Salary jobs? | You can check here the list!\n\n");
    strcat(longstr2, "{f30909}Ilegal Jobs Salary:\n");
    strcat(longstr2, "{ffffff}Job Courir Drugs {f30909}Redmoney 3.000$ / items\n");
    strcat(longstr2, "{ffffff}Job Smuggler {f30909}Redmoney 2.000$ / items\n\n");
    strcat(longstr2, "{21c800}Legal Jobs Salary:\n");
    strcat(longstr2, "{ffffff}Job Pemotong Ayam: {21c800}100$ / items\n");
    strcat(longstr2, "{ffffff}Job Dairy Cattle: {21c800}100$ / items\n");
    strcat(longstr2, "{ffffff}Job Miner and Oil Driller: {21c800} 50$ - 110$ / items\n");
    strcat(longstr2, "{ffffff}Job Lumberjack: {21c800} 200$ / items\n");
    strcat(longstr2, "{ffffff}Job Trucker Crate: {21c800}300$ / items\n");
    strcat(longstr2, "{ffffff}Job Trucker Restock: {21c800}1.000$ - $10.000 / mission\n");
    strcat(longstr2, "{ffffff}Job Trucker Hauling: {21c800}1.800$ - $25.000 /hauling\n");
    strcat(longstr2, "{ffffff}Job Production: {21c800}2.000$ / items\n");
    strcat(longstr2, "{ffffff}Job Merchant Filler: {21c800}100$ / items\n");
    strcat(longstr2, "{ffffff}Job Street Vendor: {21c800}50$ / items\n");
    strcat(longstr2, "{ffffff}Job Fruits Farmer: {21c800}80$ / items\n");
    strcat(longstr2, "{ffffff}Job Taxi: {21c800}150$ / 10 Menit\n\n");
    strcat(longstr2, "{21c800}Sidejobs Salary:\n");
    strcat(longstr2, "{ffffff}Sidejob Fishing: {21c800}150$ - 300$ / fish\n");
    strcat(longstr2, "{ffffff}Sidejob Micin Farmer: {21c800}200$ / items\n");
    strcat(longstr2, "{ffffff}Sidejob Baggage: {21c800}500$\n");
    strcat(longstr2, "{ffffff}Sidejob Bus: {21c800}400$ - 800$\n");
    strcat(longstr2, "{ffffff}Sidejob Sweeper: {21c800}100$ - 300$\n");
    strcat(longstr2, "{ffffff}Sidejob Fisher: {21c800}2000$\n");
    strcat(longstr2, "{ffffff}Sidejob Machinist: {21c800}2.000$\n");
    strcat(longstr2, "{ffffff}Sidejob Forklifster: {21c800}800$\n\n");
    strcat(longstr2, "{5FC6F4}For more guide, Check our guides at Discord! \n");
    strcat(longstr2, "{5FC6F4}Untuk bantuan pekerjaan, anda dapat cek channel discord Guide Jobs");

    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Fountain Daily Roleplay | Salary Jobs & Sidejobs ", longstr2, "Close", "");
    return 1;
}

DisplaySalaryATM(playerid)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 30", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new list[2000], date[30], info[46], money, gajiduty, totalsal, total, pajak, hasil;
		format(list, sizeof(list), ""WHITE_E"Date\t"WHITE_E"Info\t"WHITE_E"Amount\n");
		for(new i; i < rows; ++i)
	    {
			cache_get_value_name(i, "info", info);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "money", money);
			
			format(list, sizeof(list), "%s", info);
			PlayerTextDrawSetString(playerid, ATMFountain[playerid][129], list);
			totalsal += money;
		}
		total = gajiduty + totalsal;
		pajak = total / 100 * 10;
		hasil = total - pajak;
		format(list, sizeof(list), "-%s", FormatMoney(pajak));
		PlayerTextDrawSetString(playerid, ATMFountain[playerid][130], list);
		format(list, sizeof(list), "+%s", FormatMoney(hasil));
		PlayerTextDrawSetString(playerid, ATMFountain[playerid][131], list);
	}
	return 1;
}

DisplayPaycheck(playerid)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 30", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new list[2000], date[30], info[46], money, gajiduty, totalsal, total, pajak, hasil;
		format(list, sizeof(list), ""WHITE_E"Date\t"WHITE_E"Info\t"WHITE_E"Amount\n");
		for(new i; i < rows; ++i)
	    {
			cache_get_value_name(i, "info", info);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "money", money);
			
			format(list, sizeof(list), "%s"WHITE_E"%s\t%s\t"LG_E"%s\n", list, date, info, FormatMoney(money));
			totalsal += money;
		}
		total = gajiduty + totalsal;
		pajak = total / 100 * 10;
		hasil = total - pajak;
		format(list, sizeof(list), "%s"WHITE_E"     \tTax:\t"RED_E"%s\n", list, FormatMoney(pajak));
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"%s\n", list, FormatMoney(hasil));
		new title[48];
		format(title, sizeof(title), "Paycheck: %s", pData[playerid][pName]);
		ShowPlayerDialog(playerid, DIALOG_PAYCHECK, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Get", "Close");
	}
	else
	{
		new list[2000], gajiduty, total, pajak, hasil;
		
		// totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		format(list, sizeof(list), ""WHITE_E"Date\t"WHITE_E"Info\t"WHITE_E"Amount\n");
		/* if(pData[playerid][pJob] == 9 || pData[playerid][pJob2] == 9)
		{
			if(totalduty > 500)
			{
				gajiduty = 500;
			}
			else
			{
				gajiduty = totalduty;
			}
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		} */
		
		total = gajiduty;
		pajak = total / 100 * 10;
		hasil = total - pajak;
		format(list, sizeof(list), "%s"WHITE_E"     \tTax:\t"RED_E"%s\n", list, FormatMoney(pajak));
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"%s\n", list, FormatMoney(hasil));
		new title[48];
		format(title, sizeof(title), "Paycheck: %s", pData[playerid][pName]);
		ShowPlayerDialog(playerid, DIALOG_PAYCHECK, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Get", "Close");
	}
	return 1;
}


