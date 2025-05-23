#define AUCTION_COOLDOWN 15000 // Cooldown dalam milidetik (15 detik)

new AuctionInProgress = false;
new AuctionCooldown[MAX_PLAYERS];
new CurrentAuctionID = 0;
new BidTimer[MAX_PLAYERS];

// Auction Data Array
new const MAX_AUCTIONS = 100; // Sesuaikan sesuai kebutuhan
new AuctionData[MAX_AUCTIONS][4]; // [ID Rumah/Bisnis][Penawar terakhir][Tawaran tertinggi][Status]

// Function untuk mencari lelang aktif berdasarkan ID
stock FindActiveAuction()
{
    for (new i = 0; i < MAX_AUCTIONS; i++)
    {
        if (AuctionData[i][3] == 1) // Status lelang aktif (1)
            return i; // Mengembalikan index lelang aktif
    }
    return -1; // Jika tidak ada lelang yang aktif
}

// Command untuk memulai lelang
CMD:startauction(playerid, params[])
{
        foreach(new hid : Houses)
        foreach(new bid : Bisnis)
        {
        if (AuctionInProgress)
        {
            SendClientMessage(playerid, COLOR_RED, "Saat ini sedang ada lelang yang berlangsung.");
            return;
        }

        // Lakukan persiapan untuk lelang, misalnya mendapatkan ID rumah/bisnis dari params
        new auction_id = CurrentAuctionID; // ID lelang saat ini
        // Lakukan validasi dan persiapan data lelang
        // Misalnya:
        // AuctionData[auction_id][0] = houseid;
        // AuctionData[auction_id][1] = INVALID_PLAYER_ID; // belum ada penawar
        // AuctionData[auction_id][2] = 0; // tawaran tertinggi, di awal 0
        // AuctionData[auction_id][3] = 1; // status lelang (1 = aktif)

        AuctionInProgress = true;
        SendClientMessageToAll(COLOR_YELLOW, "Admin telah memulai lelang untuk rumah/bisnis dengan ID %d. Gunakan /auctionjoin untuk bergabung.", hid, bid);

        // Set timer untuk menangani akhir lelang jika tidak ada bid
        BidTimer[auction_id] = SetTimer("EndAuction", AUCTION_COOLDOWN, false);

        CurrentAuctionID++;
        return;
        }
}

// Command untuk edit lelang (ID rumah/bisnis dan tawaran)
CMD:editauction(playerid, params[])
{
    foreach(new hid : Houses)
    foreach(new bid : Bisnis)
    if (!AuctionInProgress)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada lelang yang sedang berlangsung saat ini.");
        return;
    }

    // Lakukan validasi admin
    if (pData[playerid][pAdmin] < 7)
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya admin yang bisa mengedit lelang.");
        return;
    }

    // Contoh implementasi edit ID rumah/bisnis dan tawaran lelang
    new auction_id = FindActiveAuction();
    if (auction_id == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak dapat menemukan lelang yang sedang aktif.");
        return;
    }

    // Misalnya, mengubah ID rumah/bisnis dan tawaran
    // AuctionData[auction_id][0] = new_house_id;
    // AuctionData[auction_id][2] = new_bid_amount;

    SendClientMessageToAll(COLOR_YELLOW, "Admin telah mengedit lelang untuk rumah/bisnis dengan ID %d.", hid, bid);

    return;
}

// Command untuk player bergabung dalam lelang
CMD:auctionjoin(playerid, params[])
{
    if (!AuctionInProgress)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada lelang yang sedang berlangsung saat ini.");
        return;
    }

    // Tambahkan player ke dalam lelang (opsional)
    // Anda bisa menyimpan informasi pemain yang bergabung di sini
    SendClientMessage(playerid, COLOR_YELLOW, "Anda telah bergabung dalam lelang rumah/bisnis. Gunakan /auctionbid untuk menaikkan bid.");

    return;
}

// Command untuk player melakukan bid dalam lelang
CMD:auctionbid(playerid, params[])
{
    if (!AuctionInProgress)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada lelang yang sedang berlangsung saat ini.");
        return;
    }

    // Cek cooldown player
    if (gettime() < AuctionCooldown[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Anda harus menunggu sebelum melakukan bid lagi.");
        return;
    }

    // Cari lelang aktif
    new auction_id = FindActiveAuction();
    if (auction_id == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak dapat menemukan lelang yang sedang aktif.");
        return ;
    }

    // Update tawaran tertinggi
    new current_bid = AuctionData[auction_id][2];
    new new_bid = current_bid + 100; // misalnya menaikkan bid sebesar 100

    AuctionData[auction_id][1] = playerid; // update penawar terakhir
    AuctionData[auction_id][2] = new_bid; // update tawaran tertinggi

    // Kirim pesan ke semua pemain
    SendClientMessageToAll(COLOR_YELLOW, "%s telah menaikkan tawaran untuk lelang rumah/bisnis dengan ID %d menjadi %d.", GetPlayerName(playerid), AuctionData[auction_id][0], new_bid);

    // Reset cooldown player
    AuctionCooldown[playerid] = gettime() + AUCTION_COOLDOWN;

    // Reset timer karena ada bid baru
    KillTimer(BidTimer[auction_id]);

    return;
}

// Function untuk menangani akhir lelang jika tidak ada bid dalam waktu tertentu
forward EndAuction(auction_id);

// Implementasi function EndAuction
public EndAuction(auction_id)
{
    // Pastikan lelang masih dalam keadaan berlangsung
    if (AuctionData[auction_id][3] == 1) // Status lelang aktif (1)
    {
        // Tentukan pemenang lelang (contoh sederhana: penawar terakhir)
        new winner = AuctionData[auction_id][1]; // ID pemain terakhir yang melakukan bid

        // Lakukan operasi jika ada pemenang
        if (winner != INVALID_PLAYER_ID)
        {
            // Misalnya, kurangi uang pemain dan lakukan operasi lainnya
            // Contoh: TakePlayerMoney(winner, AuctionData[auction_id][2]);
            SendClientMessage(winner, COLOR_YELLOW, "Anda telah memenangkan lelang untuk rumah/bisnis dengan ID %d dengan tawaran %d.", AuctionData[auction_id][0], AuctionData[auction_id][2]);
        }

        // Ubah status lelang menjadi non-aktif
        AuctionData[auction_id][3] = 0;

        // Kirim pesan ke semua pemain bahwa lelang telah berakhir
        SendClientMessageToAll(COLOR_YELLOW, "Lelang untuk rumah/bisnis dengan ID %d telah berakhir.", AuctionData[auction_id][0]);
    }
}