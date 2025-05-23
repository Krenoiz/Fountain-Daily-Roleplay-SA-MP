/**
 * Sync garage
 */

SyncGarage(Index)
{
    if (IsValidDynamicObject(GarageInfo[Index][gkInObject])) 
        DestroyDynamicObject(GarageInfo[Index][gkInObject]);
    if (IsValidDynamicObject(GarageInfo[Index][gkOutObject])) 
        DestroyDynamicObject(GarageInfo[Index][gkOutObject]);
    if (IsValidDynamic3DTextLabel(GarageInfo[Index][gkText])) 
        DestroyDynamic3DTextLabel(GarageInfo[Index][gkText]);

    GarageInfo[Index][gkInObject] = INVALID_STREAMER_ID;
    GarageInfo[Index][gkOutObject] = INVALID_STREAMER_ID;
    GarageInfo[Index][gkText] = Text3D: INVALID_STREAMER_ID;

    if (GarageInfo[Index][gkInX] != 0.0)
    {
        if (isnull(GarageInfo[Index][gkName]))
            format(GarageInfo[Index][gkName], 32, "Unset");

        new String[756];
        format(String, sizeof String, "\
            {00FFFF}[%s | ID: %d]\n\
            {FFFFFF}Tekan {00FF00}[Y]{FFFFFF} untuk mengambil kendaraan dari garasi\n\
            {FFFFFF}Tekan {00FF00}[H/Klakson]{FFFFFF} untuk menyimpan kendaraan ke garasi",
            GarageInfo[Index][gkName], Index
        );

        GarageInfo[Index][gkText] = CreateDynamic3DTextLabel(
            String, 
            0xFFFFFFFF, 
            GarageInfo[Index][gkInX], 
            GarageInfo[Index][gkInY], 
            GarageInfo[Index][gkInZ]+0.5, 
            8.0, 
            .testlos = 1, 
            .worldid = GarageInfo[Index][gkVW],
            .interiorid = GarageInfo[Index][gkInt],
            .streamdistance = 10.0
        );

        GarageInfo[Index][gkInObject] = CreateDynamicObject(
            1316, 
            GarageInfo[Index][gkInX], 
            GarageInfo[Index][gkInY], 
            GarageInfo[Index][gkInZ] - 0.9, 
            0.0,
            0.0,
            0.0,
            .worldid = GarageInfo[Index][gkVW], 
            .interiorid = GarageInfo[Index][gkInt], 
            .streamdistance = 100.0, 
            .drawdistance = 50.0
        );
        SetDynamicObjectMaterial(GarageInfo[Index][gkInObject], 0, 0, "none", "none", 0xFF00FF00);
    }

    if (GarageInfo[Index][gkOutX] != 0.0)
    {
        GarageInfo[Index][gkOutObject] = CreateDynamicObject(
            1316, 
            GarageInfo[Index][gkOutX], 
            GarageInfo[Index][gkOutY], 
            GarageInfo[Index][gkOutZ] - 0.9, 
            0.0,
            0.0,
            0.0,
            .worldid = GarageInfo[Index][gkVW], 
            .interiorid = GarageInfo[Index][gkInt], 
            .streamdistance = 100.0, 
            .drawdistance = 50.0
        );
        SetDynamicObjectMaterial(GarageInfo[Index][gkOutObject], 0, 0, "none", "none", 0xFFFF0000);
    }

    return 1;
}