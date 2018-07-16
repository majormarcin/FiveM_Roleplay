local WEAPON_PRICES = {
	["WEAPON_KNIFE"] = 20,
	["WEAPON_HAMMER"] = 20,
	["WEAPON_BAT"] = 20,
	["WEAPON_CROWBAR"] = 20,
	["WEAPON_GOLFCLUB"] = 20,
	["WEAPON_BOTTLE"] = 20,
	["WEAPON_DAGGER"] = 20,
	["WEAPON_HATCHET"] = 20,
	["WEAPON_KNUCKLEDUSTER"] = 20,
	["WEAPON_MACHETE"] = 20,
	["WEAPON_FLASHLIGHT"] = 20,
	["WEAPON_SWITCHBLADE"] = 20,
	-- Pistols
	["WEAPON_PISTOL"] = 250,
	["WEAPON_SNSPISTOL"] = 275,
	["WEAPON_VINTAGEPISTOL"] = 300,
	["WEAPON_COMBATPISTOL"] = 320,
	["WEAPON_HEAVYPISTOL"] = 375,
	["WEAPON_PISTOL50"] = 390,
	["WEAPON_MARKSMANPISTOL"] = 400,
	["WEAPON_APPISTOL"] = 450,
	["WEAPON_FLAREGUN"] = 300,
	-- SMGs
	["WEAPON_MICROSMG"] = 500,
	["WEAPON_MINISMG"] = 500,
	["WEAPON_SMG"] = 650,
	["WEAPON_COMBATPDW"] = 800,
	["WEAPON_ASSAULTSMG"] = 900,
	-- Shotguns
	["WEAPON_PUMPSHOTGUN"] = 400,
	["WEAPON_SAWNOFFSHOTGUN"] = 400,
	["WEAPON_BULLPUPSHOTGUN"] = 700,
	["WEAPON_ASSAULTSHOTGUN"] = 900,
	-- Assault Rifles
	["WEAPON_COMPACTRIFLE"] = 900,
	["WEAPON_ASSAULTRIFLE"] = 1000,
	["WEAPON_CARBINERIFLE"] = 1100,
	["WEAPON_SPECIALCARBINE"] = 1250,
	["WEAPON_BULLPUPRIFLE"] = 1250,
	["WEAPON_ADVANCEDRIFLE"] = 1400,
	-- Heavy Weapons
	["GRENADELAUNCHERSMOKE"] = 10000,
	["WEAPON_RAILGUN"] = 9999999,
	-- Thrown
	--["WEAPON_SNOWBALL"] = 1,
	["WEAPON_BALL"] = 10,
	["WEAPON_FIREEXTINGUISHER"] = 25,
	["WEAPON_PETROLCAN"] = 50,
	["WEAPON_GRENADE"] = 500,
	["WEAPON_MOLOTOV"] = 500,
	["WEAPON_SMOKEGRENADE"] = 500,
	["WEAPON_KNIFE"] = 20,
	["WEAPON_HAMMER"] = 20,
	["WEAPON_BAT"] = 20,
	["WEAPON_CROWBAR"] = 20,
	["WEAPON_GOLFCLUB"] = 20,
	["WEAPON_BOTTLE"] = 20,
	["WEAPON_DAGGER"] = 20,
	["WEAPON_HATCHET"] = 20,
	["WEAPON_KNUCKLEDUSTER"] = 20,
	["WEAPON_MACHETE"] = 20,
	["WEAPON_FLASHLIGHT"] = 20,
	["WEAPON_SWITCHBLADE"] = 20,
	["WEAPON_PISTOL"] = 250,
	["WEAPON_SNSPISTOL"] = 275,
	["WEAPON_VINTAGEPISTOL"] = 300,
	["WEAPON_COMBATPISTOL"] = 320,
	["WEAPON_HEAVYPISTOL"] = 375,
	["WEAPON_PISTOL50"] = 390,
	["WEAPON_MARKSMANPISTOL"] = 400,
	["WEAPON_FLAREGUN"] = 300,
	-- SMGs
	["WEAPON_MICROSMG"] = 500,
	-- Shotguns
	["WEAPON_PUMPSHOTGUN"] = 400,
	["WEAPON_SAWNOFFSHOTGUN"] = 400,
	-- Thrown
	["WEAPON_FIREEXTINGUISHER"] = 25,
	["WEAPON_PETROLCAN"] = 50,
	--["WEAPON_SNOWBALL"] = 1,
	["WEAPON_BALL"] = 10,
}

local weaponsOwned = {}

AddEventHandler('playerDropped', function()
	weaponsOwned[source] = {}
end)

RegisterServerEvent('es_rp:buyWeapon')
AddEventHandler('es_rp:buyWeapon', function(w)
	if weaponsOwned[source] == nil then
		weaponsOwned[source] = {}
	end

	if WEAPON_PRICES[w] then
		if weaponsOwned[source][w] == nil then
			TriggerEvent('es:getPlayerFromId', source, function(user)
				if user.getMoney() >= WEAPON_PRICES[w] then
					user.removeMoney(WEAPON_PRICES[w])

					TriggerClientEvent('es_rp:notify', source, 'Thank you for your purchase!', "CHAR_MILSITE", "Warstock Cache & Carry", "Purschase")
					TriggerClientEvent('es_rp:giveWeapon', source, w)
					weaponsOwned[source][w] = true
				else
					TriggerClientEvent('es_rp:notify', source, '~r~Not enough cash')
				end
			end)
		else
			TriggerClientEvent('es_rp:notify', source, '~r~You already own this')
		end
	end
end)