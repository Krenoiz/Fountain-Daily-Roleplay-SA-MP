/**
 * Garage Global Variables
 */

enum garageInfo
{
    ORM: gkORM,
    gkID,
    gkIdx,
    gkName[32],
    Float: gkInX,
    Float: gkInY,
    Float: gkInZ,
    Float: gkOutX,
    Float: gkOutY,
    Float: gkOutZ,
    Float: gkOutA,
    Text3D: gkText,
    gkVW,
    gkInt, 
    gkInObject, 
    gkOutObject
}

new GarageInfo[MAX_GARAGES][garageInfo];
new SelectGarage[MAX_PLAYERS];