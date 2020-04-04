#include <YSI_Storage\y_ini>

enum E_SERVER_CONF
{
	srvApiHost[256],
};

new gServerConfig[E_SERVER_CONF];

INI:serverconfig[API](name[], value[])
{
	INI_String("host", gServerConfig[srvApiHost], 256);

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

    printf("[OK] config.ini loaded !");
	printf("[OK] 	API Host: '%s'", gServerConfig[srvApiHost]);

    return 0;
}
