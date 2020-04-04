#include <a_samp>

#include <YSI_Coding\y_hooks>
#include <requests>


hook OnPlayerConnect(playerid)
{
    new url[64], name[MAX_PLAYER_NAME + 1];

    GetPlayerName(playerid, name, sizeof(name));

    format(url, 45, "accounts/%s", name);

    RequestJSON(
        rClient,
        url,
        HTTP_METHOD_GET,
        "OnGetWelcome",
        .headers = RequestHeaders()
    );

    return 1;
}
