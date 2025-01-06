fx_version 'cerulean'
game 'gta5'

lua54 'yes'

name 'qb-lootprop'
description 'Loot prop'
author '77Killer'
version '1.0.0'

shared_scripts {
	'Config.lua'
	--'@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    --'qb-core',
    'ox_target',
    'ox_inventory'
}
