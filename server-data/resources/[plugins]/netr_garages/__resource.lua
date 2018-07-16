resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Netr Garage'

version '1.0.0'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
  '@warmenu/warmenu.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'config.lua',
	--'client/names.lua',
	'client/main.lua'
}
