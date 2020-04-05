#include <YSI_Coding\y_hooks>

enum P_DATA {
    pID,
    pName[MAX_PLAYER_NAME + 1]
}

new pInfos[MAX_PLAYERS][P_DATA];

hook OnPlayerConnect(playerid)
{
    new resetPArray[P_DATA];
    pInfos[playerid] = resetPArray;

    return 1;
}
