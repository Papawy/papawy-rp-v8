#include <a_samp>

#include <requests>

new RequestsClient:rClient;

main()
{
    print("Papawy RP V8 Vroum Vroum\n");

    print("Initializing request client...");
    rClient = RequestsClient("https://rp.papawy.com/api/");
    print(" Ok\n");

    return 1;
}

#include "users/forwards.pwn"

#include "users/welcome.pwn"
#include "users/login.pwn"
#include "users/register.pwn"
