#include <YSI_Coding\y_hooks>

#include <easyDialog>


public OnPlayerWantsLogin(playerid)
{
    return 1;
}

Dialog:LoginMenu(playerid, response, listitem, inputtext[])
{
    SendClientMessage(playerid, 0xFFFFFFFF, "Youhou t'es login lel");
    return 1;
}
