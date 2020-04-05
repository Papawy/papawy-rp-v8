#include <YSI_Storage\y_ini>

enum E_SERVER_CONF
{
	srvApiHost[256]
}

new gServerConfig[E_SERVER_CONF];

INI:config[api](name[], value[])
{
	INI_String("url", gServerConfig[srvApiHost], 256);
    return 0;
}

LoadConfigFile()
{
    if (!INI_Load("config.ini"))
	{
		printf("[ERROR] Couldn't load config.ini");
		printf("[HINT] config.ini should be located inside the scriptfiles folder.");
        return 1;
	}

    printf("[CONFIG] config.ini loaded !");
	printf("[CONFIG] 	API Host: '%s'", gServerConfig[srvApiHost]);

    return 0;
}
