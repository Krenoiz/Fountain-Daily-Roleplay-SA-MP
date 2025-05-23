/*=========================================================================================|
|----------------------------Created By: Zack Larson and Josh Greening---------------------|
|-------------------------------------Siren Filterscript-----------------------------------|
|==========================================================================================*/
/*|---------------------------------Dont remove Credits from script------------------------|
===========================================================================================*/
#include <a_samp>
#include <zcmd>

#define FILTERSCRIPT

forward FlasherFunc();

new FlasherState[MAX_VEHICLES];
new obj3[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new obj4[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new obj5[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new LightPwr[MAX_VEHICLES];
new FlashTimer;
new obj[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new obj2[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new Flasher[MAX_VEHICLES] = 0;


CMD:ctwo(playerid, params[]) return cmd_codetwo(playerid, params);
CMD:c2(playerid, params[]) return cmd_codetwo(playerid, params);
CMD:codetwo(playerid, params[])
{
        new vehicleid,panels,doors,lights,tires;
        vehicleid = GetPlayerVehicleID(playerid);
        if(!Flasher[vehicleid]) {
                if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                {
                        return SendClientMessage(playerid, -1, "Вы не водитель.");
                }
                if (!GetVehicleModel(vehicleid)) return SendClientMessage(playerid, -1, "Вы не находитесь в автомобиле полиции.");
                if (IsValidObject(obj[vehicleid]) || IsValidObject(obj2[vehicleid]) || IsValidObject(obj3[vehicleid]) || IsValidObject(obj4[vehicleid]) || IsValidObject(obj5[vehicleid]))
                {
                        SendClientMessage(playerid, -1, "Вы выключили огни."), DestroyObject(obj[vehicleid]), DestroyObject(obj2[vehicleid]), DestroyObject(obj3[vehicleid]), DestroyObject(obj4[vehicleid]), DestroyObject(obj5[vehicleid]);
                        GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                        if(LightPwr[vehicleid] == 1)
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
                        else
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
                        Flasher[vehicleid] = 0;
                }
                switch (GetVehicleModel(vehicleid))
                {
                        case 596:
                        {
								obj3[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj4[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj5[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								AttachObjectToVehicle(obj3[vehicleid], vehicleid, -0.02, 2.18, -0.15,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj4[vehicleid], vehicleid, -0.60, -1.67, 0.39,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj5[vehicleid], vehicleid, 0.50, -1.67, 0.39,   0.00, 0.00, 0.00);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 597:
                        {
                                obj[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj2[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj3[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj4[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj5[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								AttachObjectToVehicle(obj[vehicleid], vehicleid, -0.53, -0.43, 0.79,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj2[vehicleid], vehicleid, 0.46, -0.43, 0.79,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj3[vehicleid], vehicleid, -0.02, 2.18, -0.15,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj4[vehicleid], vehicleid, -0.60, -1.67, 0.39,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj5[vehicleid], vehicleid, 0.50, -1.67, 0.39,   0.00, 0.00, 0.00);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 598:
                        {
								obj3[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj4[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj5[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								AttachObjectToVehicle(obj3[vehicleid], vehicleid, -0.02, 2.18, -0.15,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj4[vehicleid], vehicleid, -0.60, -1.67, 0.39,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj5[vehicleid], vehicleid, 0.50, -1.67, 0.39,   0.00, 0.00, 0.00);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 599:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                obj2[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.000000,1.125000,0.000000,0.000000,0.000000);
                                AttachObjectToVehicle(obj2[vehicleid], vehicleid, -0.524999,0.000000,1.125000,0.000000,0.000000,0.000000);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 541:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.375000,0.524999,0.375000,0.000000,0.000000,0.000000);

                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 426:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.749999,0.375000,0.000000,0.000000,0.000000);

                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 427:
                        {
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 416:
                        {
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 407:
                        {
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 560:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.225000,0.750000,0.449999,0.000000,0.000000,0.000000);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 490:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.000000,1.125000,0.599999,0.000000,0.000000,0.000000);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        default:
                        {
                                return SendClientMessage(playerid, -1, "Вы должны находиться в автомобиле полиции.");
                        }
                }
                return SendClientMessage(playerid, -1, "Огни сирены включены.");
        } else {
                if (IsValidObject(obj[vehicleid]) || IsValidObject(obj2[vehicleid]) || IsValidObject(obj3[vehicleid]) || IsValidObject(obj4[vehicleid]) || IsValidObject(obj5[vehicleid])) {
                        SendClientMessage(playerid, -1, "Огни сирены выключены."), DestroyObject(obj[vehicleid]), DestroyObject(obj2[vehicleid]), DestroyObject(obj3[vehicleid]), DestroyObject(obj4[vehicleid]), DestroyObject(obj5[vehicleid]);
                }
                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                if(LightPwr[vehicleid] == 1)
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
                else
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
                Flasher[vehicleid] = 0;
        }
        return 1;
}
public OnFilterScriptInit()
{
        for (new x=0; x<MAX_VEHICLES; x++)
        {
                LightPwr[x]=1;
                Flasher[x]=0;
                FlasherState[x]=0;
        }

        FlashTimer = SetTimer("FlasherFunc",200,1);
        return 1;
}

public OnFilterScriptExit()
{
        KillTimer(FlashTimer);
        for (new i = 0; i < MAX_VEHICLES; i++)
        {
                DestroyObject(obj[i]);
                DestroyObject(obj2[i]);
                DestroyObject(obj3[i]);
                DestroyObject(obj4[i]);
                DestroyObject(obj5[i]);
        }
        return 1;
}

public OnVehicleSpawn(vehicleid)
{
        DestroyObject(obj[vehicleid]);
        DestroyObject(obj2[vehicleid]);
        DestroyObject(obj3[vehicleid]);
        DestroyObject(obj4[vehicleid]);
        DestroyObject(obj5[vehicleid]);
        return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
        DestroyObject(obj[vehicleid]);
        DestroyObject(obj2[vehicleid]);
        DestroyObject(obj3[vehicleid]);
        DestroyObject(obj4[vehicleid]);
        DestroyObject(obj5[vehicleid]);
        return 1;
}

public FlasherFunc() {
        new panelsx,doorsx,lightsx,tiresx;
        for (new p=0; p<MAX_VEHICLES; p++)
        {
                if (Flasher[p] == 1)
                {
                        if (FlasherState[p] == 1)
                        {
                                GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
                                UpdateVehicleDamageStatus(p, panelsx, doorsx, 4, tiresx);
                                FlasherState[p] = 0;
                        }
                        else
                        {
                                GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
                                UpdateVehicleDamageStatus(p, panelsx, doorsx, 1, tiresx);
                                FlasherState[p] = 1;
                        }
                }
        }
        return 1;
}

