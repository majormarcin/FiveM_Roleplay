local CUFFED = false
local JAILED = false

local arrestPoints = {
	{['x'] = 1690.28, ['y'] = 2593.77, ['z'] = 45.45},
	{['x'] = 639.6, ['y'] = 1.3, ['z'] = 82.7},
	{['x'] = -1113.9, ['y'] = -852.5, ['z'] = 13.5},
	{['x'] = -886.0, ['y'] = -2365.6, ['z'] = 13.9},
	{['x'] = 371.1, ['y'] = -1609.0, ['z'] = 29.2},
	{['x'] = 872.2, ['y'] = -1288.8, ['z'] = 28.2},
	{['x'] = 462.1, ['y'] = -989.5, ['z'] = 24.91},
	{['x'] = -446.5, ['y'] = 6013.8, ['z'] = 31.7},
	{['x'] = 1852.9, ['y'] = 3688.1, ['z'] = 34.2}
}

Citizen.CreateThread(function()
	for i,v in pairs(arrestPoints)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 237)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Jail")
		EndTextCommandSetBlipName(blip)
	end

	while true do
		for i,e in pairs(arrestPoints)do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			if(pos and arrestPoints[i])then
				if(Vdist(arrestPoints[i].x, arrestPoints[i].y, arrestPoints[i].z, pos.x, pos.y, pos.z) < 100.0)then
					DrawMarker(1, arrestPoints[i].x, arrestPoints[i].y, arrestPoints[i].z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 255,155, 0,0, 0,0)
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('es_rp:jail')
AddEventHandler('es_rp:jail', function(t)
	JAILED = t

	if not JAILED then
		SetEntityCoords(GetPlayerPed(-1), 1847.22, 2586.20, 45.67)
		FreezeEntityPosition(GetPlayerPed(-1), false)

		SetEntityVisible(GetPlayerPed(-1), true, true)
	else
		SetEntityCoords(GetPlayerPed(-1), 1679.28, 2629.77, 45.45)
	end
end)

local weaponNames = { WEAPON_PISTOL50 = "50. Pistol", WEAPON_FIREWORK = "Firework Launcher", WEAPON_PISTOL = "Pistol", WEAPON_SMG = "SMG", WEAPON_MARKSMANPISTOL = "Marksman Rifle", WEAPON_SNSPISTOL = "SNS Pistol", WEAPON_VINTAGEPISTOL = "Vintage Pistol", WEAPON_COMBATPISTOL = "Combat Pistol", WEAPON_HEAVYPISTOL = "Heavy Pistol", WEAPON_HEAVYREVOLVER = "Heavy Revolver", WEAPON_APPISTOL = "AP Pistol", WEAPON_BOTTLE = "Bottle", WEAPON_BAT = "Baseball bat", WEAPON_BAT = "Baseball bat", WEAPON_KNUCKLE = "Knuckle Duster", WEAPON_KNIFE = "Knife", WEAPON_DAGGER = "Dagger", WEAPON_HAMMER = "Hammer", WEAPON_HATCHET = "Hatchet", WEAPON_NIGHTSTICK = "Nightstick", WEAPON_CROWBAR = "Crowbar", WEAPON_GOLFCLUB = "Golfclub", WEAPON_SWITCHBLADE = "Switchblade", WEAPON_MACHETE = "Machete", WEAPON_MICROSMG = "Micro SMG", WEAPON_ASSAULTSMG = "Assault SMG", WEAPON_COMBATPDW = "Combat PDW", WEAPON_MACHINEPISTOL = "Machine Pistol", WEAPON_COMPACTRIFLE = "Compact Rifle", WEAPON_ASSAULTRIFLE = "Assault Rifle", WEAPON_CARBINERIFLE = "Carbine Rifle", WEAPON_BULLPUPRIFLE = "Bullpup Rifle", WEAPON_ADVANCEDRIFLE = "Advanced Rifle", WEAPON_SPECIALCARBINE = "Special Carbine", WEAPON_GUSENBERG = "Gusenberg", WEAPON_MG = "MG", WEAPON_COMBATMG = "Combat MG", WEAPON_SNIPERRIFLE = "Sniper Rifle", WEAPON_MARKSMANRIFLE = "Marksman Rifle", WEAPON_HEAVYSNIPER = "Heavy Sniper", WEAPON_MOLOTOV = "Molotov", WEAPON_FLARE = "Flare", WEAPON_GRENADE = "Grenade", WEAPON_SAWNOFFSHOTGUN = "Sawnoff", WEAPON_PUMPSHOTGUN = "Pump Shotgun", WEAPON_BULLPUPSHOTGUN = "Bullpup Shotgun", WEAPON_HEAVYSHOTGUN = "Heavy Shotgun", WEAPON_ASSAULTSHOTGUN = "Assault Shotgun", WEAPON_SMOKEGRENADE = "Smoke Grenade", WEAPON_PETROLCAN = "Petrol Can", WEAPON_GRENADELAUNCHER_SMOKE = "Smoke Launcher", WEAPON_FIREEXTINGUISHER = "Fire Extinguisher", WEAPON_SNOWBALL = "Snowballs", WEAPON_FLASHLIGHT = "Flashlight", WEAPON_STUNGUN = "Tazer", WEAPON_MUSKET = "Musket", WEAPON_FLAREGUN = "Flaregun" }
local ILLEGAL_WEAPONS = {"WEAPON_PISTOL", "WEAPON_PISTOL50"}

RegisterNetEvent('es_rp:search')
AddEventHandler('es_rp:search', function()
	local found = {weapons = {}, items = {}}

	for i in pairs(ILLEGAL_WEAPONS) do
		if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(ILLEGAL_WEAPONS[i]), false) then
			found.weapons[i] = weaponNames[ILLEGAL_WEAPONS[i]]
		end
	end

	TriggerServerEvent('es_rp:searchS', found)
end)

Citizen.CreateThread(function()
	local handsup = false
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("random@mugging3")
		if IsControlPressed(1, 323) then
			if DoesEntityExist(lPed) and not CUFFED then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if not handsup then
						handsup = true
						TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
					end   
				end)
			end
		end

		if IsControlReleased(1, 323) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if handsup then
						handsup = false
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)

RegisterNetEvent('es_rp:unseat')
AddEventHandler('es_rp:unseat', function()
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNetEvent('es_rp:cuff')
AddEventHandler('es_rp:cuff', function(b)
	ClearPedSecondaryTask(GetPlayerPed(-1))
	CUFFED = b

	SetPedCanSwitchWeapon(GetPlayerPed(-1), not b)

	if not b then
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end
end)

RegisterNetEvent('es_rp:removeWeapons')
AddEventHandler('es_rp:removeWeapon', function()
	weapons = {}
	
	RemoveAllPedWeapons(GetPlayerPed(-1), false)
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		local pPos = GetEntityCoords(GetPlayerPed(-1), true)

		if JAILED then
			if GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) > 0 then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerEvent('es_rp:notify', "~r~You cannot enter a vehicle")
			end
			if Vdist(1679.28, 2629.77, 64.45, pPos.x, pPos.y, pPos.z) > 200.0 then
				SetEntityCoords(GetPlayerPed(-1), 1679.28, 2629.77, 45.45)
				TriggerEvent('es_rp:notify', "~r~You went too far and were teleported back")
			end
		end

		if CUFFED then
			DisableControlAction(1, 18, true)
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 69, true)
			DisableControlAction(1, 92, true)
			DisableControlAction(1, 106, true)
			DisableControlAction(1, 122, true)
			DisableControlAction(1, 135, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 144, true)
			DisableControlAction(1, 176, true)
			DisableControlAction(1, 223, true)
			DisableControlAction(1, 229, true)
			DisableControlAction(1, 237, true)
			DisableControlAction(1, 257, true)
			DisableControlAction(1, 329, true)
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 250, true)
			DisableControlAction(1, 263, true)
			DisableControlAction(1, 310, true)

			DisableControlAction(1, 22, true)
			DisableControlAction(1, 55, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 102, true)
			DisableControlAction(1, 114, true)
			DisableControlAction(1, 143, true)
			DisableControlAction(1, 179, true)
			DisableControlAction(1, 193, true)
			DisableControlAction(1, 203, true)
			DisableControlAction(1, 216, true)
			DisableControlAction(1, 255, true)
			DisableControlAction(1, 298, true)
			DisableControlAction(1, 321, true)
			DisableControlAction(1, 328, true)
			DisableControlAction(1, 331, true)
			DisableControlAction(0, 63, false)
			DisableControlAction(0, 64, false)
			DisableControlAction(0, 59, false)
			DisableControlAction(0, 278, false)
			DisableControlAction(0, 279, false)
			DisableControlAction(0, 68, false)
			DisableControlAction(0, 69, false)
			DisableControlAction(0, 75, false)
			DisableControlAction(0, 76, false)
			DisableControlAction(0, 102, false)	
			DisableControlAction(0, 81, false)
			DisableControlAction(0, 82, false)
			DisableControlAction(0, 83, false)
			DisableControlAction(0, 84, false)
			DisableControlAction(0, 85, false)
			DisableControlAction(0, 86, false) 
			DisableControlAction(0, 106, false)
			DisableControlAction(0, 25, false)

			while not HasAnimDictLoaded('mp_arresting') do
				RequestAnimDict('mp_arresting')
				Citizen.Wait(0)
			end

			if not IsEntityPlayingAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 3) then
				TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
			end
		end
	end
end)