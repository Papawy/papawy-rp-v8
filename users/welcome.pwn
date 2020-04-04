#include <a_samp>

#include <YSI_Coding\y_hooks>
#include <requests>
#include <easyDialog>
#include <map>
#include <MD5>

new Map:WelcomeRequestToPlayerID;

hook OnPlayerConnect(playerid)
{
    new url[64], name[MAX_PLAYER_NAME + 1];

    GetPlayerName(playerid, name, sizeof(name));

    format(url, 64, "accounts/%s", MD5::Hash(name));

    new Request:id = RequestJSON(
        rClient,
        url,
        HTTP_METHOD_GET,
        "OnGetWelcome",
        .headers = RequestHeaders()
    );

    MAP_insert_val_val(WelcomeRequestToPlayerID, _:id, playerid);

    return 1;
}

forward OnGetWelcome(Request:id, E_HTTP_STATUS:status, data[], dataLen);
public OnGetWelcome(Request:id, E_HTTP_STATUS:status, data[], dataLen)
{
    new playerid = MAP_get_val_val(WelcomeRequestToPlayerID, _:id);
    MAP_remove_val(WelcomeRequestToPlayerID, _:id);

    if(status == HTTP_STATUS_OK)
    {
        new login_msg[256], name[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, name, sizeof(name));
        format(login_msg, 256, "Welcome back %s !\nPlease enter your password to sign in.", name);
        Dialog_Show(playerid, LoginMenu, DIALOG_STYLE_PASSWORD, "Login", login_msg, "Login", "Cancel");
        return 0;
    }
    else if (status == HTTP_STATUS_NOT_FOUND)
    {
        new register_msg[256], name[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, name, sizeof(name));
        format(register_msg, 256, "Welcome %s !\nPlease enter a password to sign up.", name);
        Dialog_Show(playerid, RegisterMenu, DIALOG_STYLE_PASSWORD, "Registration", register_msg, "Register", "Cancel");
        return 0;
    }

    SendClientMessage(playerid, 0xFFFFFFFF, "An error occurred.");
    return 1;
}
