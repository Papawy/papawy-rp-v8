#include <a_samp>

forward KickEx(playerid);
public KickEx(playerid)
{
    SetTimerEx("DelayedKick", 500, false, "i", playerid);
}

forward DelayedKick(playerid);
public DelayedKick(playerid)
{
    Kick(playerid);
}
