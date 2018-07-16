resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	"client.lua",

	-- add skins here
	"skins/default.lua",
	"skins/default_middle.lua",


}

exports {
	"getAvailableSkins",
	"changeSkin",
	"addSkin",
	"toggleSpeedo",
	"getCurrentSkin",
	"addSkin",
	"toggleFuelGauge",
	"DoesSkinExist",
}