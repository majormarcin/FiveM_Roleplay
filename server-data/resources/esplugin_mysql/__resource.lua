resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
dependency 'fxmigrant'

description 'MySQL plugin for ES'

migration_files {
    'migrations/0001_create_user.cs',
	'migrations/0002_add_roles.cs'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@fxmigrant/helper.lua',
	'server.lua'
}

dependencies {
	'essentialmode',
	'mysql-async'
}