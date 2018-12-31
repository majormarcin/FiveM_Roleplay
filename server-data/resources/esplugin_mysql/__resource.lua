resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'MySQL plugin for ES'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'essentialmode',
	'mysql-async'
}