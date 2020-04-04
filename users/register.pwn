#include <a_samp>

#include <YSI_Coding\y_hooks>
#include <easyDialog>

public OnPlayerWantsRegister(playerid)
{
    return 1;
}

Dialog:RegisterMenu(playerid, response, listitem, inputtext[])
{
    SendClientMessage(playerid, 0xFFFFFFFF, "Youhou t'es register lel");
    return 1;
}
