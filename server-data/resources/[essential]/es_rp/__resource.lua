-- Manifest
resource_manifest_version 'f15e72ec-3972-4fe4-9c7d-afc5394ae207'

-- Requiring essentialmode
dependency 'essentialmode'

ui_page 'ui/ui.html'

files {
	'ui/ui.html'
}

server_script 'jobs.lua'
server_script 'server/jobManager.lua'
server_script 'server/chat.lua'
server_script 'server/stores.lua'
server_script 'server.lua'

client_script 'jobs.lua'
client_script 'client/interact.lua'
client_script 'client/spawn.lua'
client_script 'client/jobOffice.lua'
client_script 'client/police.lua'