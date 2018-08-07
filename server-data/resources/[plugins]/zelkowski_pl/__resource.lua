resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description 'Zelkowski_pl'

client_script {
	'@es_extended/locale.lua',
	"client.lua",
	'config.lua',
}
server_scripts {
	'@es_extended/locale.lua',
	"server.lua",
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
} 
export "SetQueueMax"
export "SendNotification"
dependency 'es_extended'