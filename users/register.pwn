#include <a_samp>

#include <YSI_Coding\y_hooks>
#include <easyDialog>
#include <map>

public OnPlayerWantsRegister(playerid)
{
    return 1;
}

new Map:RegisterRequestToPlayerID;

Dialog:RegisterMenu(playerid, response, listitem, inputtext[])
{
    if(response == 0)
    {
        KickEx(playerid);
        return 1;
    }

    if(strlen(inputtext) < 8)
    {
        new register_msg[256];
        format(register_msg, 256, "Ton mot de passe fait moins de 8 caractères !\nEntre un mot de passe pour t'enregistrer (8 caractères minimum).", pInfos[playerid][pName]);
        Dialog_Show(playerid, RegisterMenu, DIALOG_STYLE_PASSWORD, "Registration", register_msg, "S'enregistrer", "Quitter");
        return 0;

    }

    new url[64];
    format(url, 64, "accounts/%i", pInfos[playerid][pID]);

    new Request:id = RequestJSON(
        rClient,
        url,
        HTTP_METHOD_POST,
        "OnRegisterRequest",
        JsonObject(
            "name", JsonString(pInfos[playerid][pName]),
            "password", JsonString(inputtext)
        )
    );

    MAP_insert_val_val(RegisterRequestToPlayerID, _:id, playerid);

    return 1;
}

forward OnRegisterRequest(Request:id, E_HTTP_STATUS:status, Node:json);
public OnRegisterRequest(Request:id, E_HTTP_STATUS:status, Node:json)
{
    new playerid = MAP_get_val_val(RegisterRequestToPlayerID, _:id);
    MAP_remove_val(RegisterRequestToPlayerID, _:id);

    if(status != HTTP_STATUS_CREATED)
    {
        SendClientMessage(playerid, X11_RED, "Une erreur est survenue, essayez de vous reconnecter.");
        KickEx(playerid);
        return 1;
    }

    Dialog_Show(playerid, CharCreationBegin, DIALOG_STYLE_MSGBOX, "Création de personnage", "Vous allez maintenant pouvoir créer votre personnage.", "Suivant", "");

    return 0;
}
