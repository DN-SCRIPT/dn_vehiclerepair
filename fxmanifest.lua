fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

version '1.0.0'
author 'DN DEVELOPMENT'
description 'Vehicle repair script'

shared_script {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'@ox_lib/init.lua',
}

server_scripts {
	'server/main.lua',
}

client_scripts {
	'client/main.lua',
}
