#include <a_samp>

#include <YSI_Coding\y_hooks>
#include <YSI_Server\y_colors>
#include <requests>
#include <easyDialog>
#include <map>
#include <MD5>

new Map:WelcomeRequestToPlayerID;

hook OnPlayerConnect(playerid)
{
    new url[64];

    GetPlayerName(playerid, pInfos[playerid][pName], MAX_PLAYER_NAME + 1);

    format(url, 64, "accounts/%s", MD5::Hash(pInfos[playerid][pName]));

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

forward OnGetWelcome(Request:id, E_HTTP_STATUS:status, Node:json);
public OnGetWelcome(Request:id, E_HTTP_STATUS:status, Node:json)
{
    new playerid = MAP_get_val_val(WelcomeRequestToPlayerID, _:id);
    MAP_remove_val(WelcomeRequestToPlayerID, _:id);

    if(status == HTTP_STATUS_OK)
    {
        new ret = JsonGetInt(json, "id", pInfos[playerid][pID]);
        if(ret)
        {
            SendClientMessage(playerid, X11_RED, "Une erreur est survenue, essayez de vous reconnecter.");
            KickEx(playerid);
        }


        new login_msg[256], name[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, name, sizeof(name));
        format(login_msg, 256, "Content de te revoir %s !\nEntre ton mot de passe pour te connecter.", name);
        Dialog_Show(playerid, LoginMenu, DIALOG_STYLE_PASSWORD, "Login", login_msg, "Connexion", "Quitter");
        return 0;
    }
    else if (status == HTTP_STATUS_NOT_FOUND)
    {
        new register_msg[256], name[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, name, sizeof(name));
        format(register_msg, 256, "Bienvenu %s !\nEntre un mot de passe pour t'enregistrer (8 caractères minimum).", name);
        Dialog_Show(playerid, RegisterMenu, DIALOG_STYLE_PASSWORD, "Registration", register_msg, "S'enregistrer", "Quitter");
        return 0;
    }

    SendClientMessage(playerid, 0xFFFFFFFF, "Une erreur est survenue, essayez de vous reconnecter..");
    KickEx(playerid);
    return 1;
}
