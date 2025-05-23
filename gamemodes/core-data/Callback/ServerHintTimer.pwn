forward ServerHintTimer();
public ServerHintTimer()
{
	foreach(new i : Player)
	{
		if(pData[i][IsLoggedIn])
		{
            new randHint = RandomEx(0, 4);

		    switch(randHint)
		    {
		        case 0:
		        {
                    SendClientMessage(i, ARWIN, "HINT: "WHITE_E"Anda dapat menggunakan /report untuk melaporkan player dan bug.");
				}
		        case 1:
		        {
                    SendClientMessage(i, ARWIN, "HINT: "WHITE_E"Gunakan /stuck untuk melaporkan karakter anda terkena bug kepada admin yang online.");
				}
		        case 2:
		        {
                    SendClientMessage(i, ARWIN, "HINT: "WHITE_E"Bingung dengan CMD yang ada? Anda dapat melihatnya pada /help.");
				}
		        case 3:
		        {
                    SendClientMessage(i, ARWIN, "HINT: "WHITE_E"Tidak paham tentang pekerjaan yang ada? anda bisa mengikuti guide yang ada pada discord server.");
				}
		        case 4:
		        {
                    SendClientMessage(i, ARWIN, "HINT: "WHITE_E"Greenzone adalah zona aman, tidak boleh ada kriminal.");
				}
			}
		}
	}
	return 1;
}