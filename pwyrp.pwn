#pragma warning disable 239
#pragma warning disable 214

#define YSI_NO_HEAP_MALLOC

#include <a_samp>

#include <requests>

new RequestsClient:rClient;

#include "utils/configfile.pwn"

main()
{
    print("Papawy RP V8 Vroum Vroum\n");

    if(LoadConfigFile() != 0)
        return 0;

    print("Initializing request client...");
    rClient = RequestsClient(gServerConfig[srvApiHost], RequestHeaders());
    print("Ok\n");

    RequestJSON(
        rClient,
        "healthcheck",
        HTTP_METHOD_GET,
        "OnHealthCheckGet",
        .headers = RequestHeaders()
    );

    return 1;
}

forward OnHealthCheckGet(Request:id, E_HTTP_STATUS:status, Node:node);
public OnHealthCheckGet(Request:id, E_HTTP_STATUS:status, Node:node)
{
    if (status != HTTP_STATUS_OK)
    {
        print("[HTTP] API Healthcheck : FAILED");
        return 1;
    }
    print("[HTTP] API Healthcheck : SUCCESS");
    return 0;
}

forward OnRequestFailure(Request:id, errorCode, errorMessage[], len);
public OnRequestFailure(Request:id, errorCode, errorMessage[], len)
{
    printf("[HTTP] ERROR: (%i) %s", errorCode, errorMessage);
    return 0;
}

#include "utils/functions.pwn"

#include "users/forwards.pwn"
#include "users/data.pwn"
#include "users/welcome.pwn"
#include "users/login.pwn"
#include "users/register.pwn"
