local cur = {
	menu = "main",
	curOption = 1
}

weapons = {}

DoScreenFadeIn(1)

local open = false
weaponShopOpen = false

local weaponShops = {
	{['x'] = 842.40, ['y'] = -1033.12, ['z'] = 28.19, illegal = true},
	{['x'] = 21.70, ['y'] = -1107.41, ['z'] = 29.79, illegal = false}
}

local gatherFields = {
	{ ['blipname'] = "Weed Field", illegal = true, ['ex'] = "gr", ["blipicon"] = 140, ['x'] = 2219.6147460938, ['y'] = 5578.4462890625, ['z'] = 53.709136962891, ['product'] = "Weed"},
	{ ['blipname'] = "Cocaine Field", illegal = true, ['ex'] = "gr", ["blipicon"] = 51, ['x'] = 273.39547729492, ['y'] = 6698.642578125, ['z'] = 29.204326629639, ['product'] = "Cocaine"},
	{ ['blipname'] = "Oil Stealing", illegal = true, ['ex'] = "", ["blipicon"] = 361, ['x'] = -244.89166259766, ['y'] = -2237.0388183594, ['z'] = 23.698638916016, ['product'] = "Oil"},
	{ ['blipname'] = "Oil Stealing", illegal = true, ['ex'] = "", ["blipicon"] = 361, ['x'] = -275.12301635742, ['y'] = -2230.7446289063, ['z'] = 23.698638916016, ['product'] = "Oil"},
	{ ['blipname'] = "Oil Stealing", illegal = true, ['ex'] = "", ["blipicon"] = 361, ['x'] = -206.64949035645, ['y'] = -2235.9814453125, ['z'] = 23.70198059082, ['product'] = "Oil"},
	{ ['blipname'] = "Wood Cutting", ['ex'] = "", ["blipicon"] = 85, ['x'] = 1571.1754150391, ['y'] = 6511.1767578125, ['z'] = 18.66967010498, ['product'] = "Wood"},
	{ ['blipname'] = "Coal Mine", ['ex'] = "", ["blipicon"] = 17, ['x'] = 1432.4019775391, ['y'] = 2556.1516113281, ['z'] = 38.704284667969, ['product'] = "Coal"},
	{ ['blipname'] = "Tomato Collection", ['ex'] = "", ["blipicon"] = 17, ['x'] = 1919.171875, ['y'] = 4816.203125, ['z'] = 43.99760055542, ['product'] = "Tomato"},
	{ ['blipname'] = "Stone Mine", ['ex'] = "", ["blipicon"] = 17, ['x'] = 2969.4025878906, ['y'] = 2781.7336425781, ['z'] = 37.965412139893, ['product'] = "Stone"},
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -537.27514648438, ['y'] = 6427.9663085938, ['z'] = 1.8609119653702 },
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -606.72436523438, ['y'] = 6392.3369140625, ['z'] = 2.4399950504303 },
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -743.7412109375, ['y'] = 6078.5810546875, ['z'] = 0.53491020202637 },
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -910.80291748047, ['y'] = 5761.5693359375, ['z'] = 1.9689185619354 },
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -1615.2686767578, ['y'] = 5259.7236328125, ['z'] = 3.9984483718872 },
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -2602.4282226563, ['y'] = 3647.1381835938, ['z'] = 0.76799869537354 },
	{ ['blipname'] = "Fishing Area", ['ex'] = "", ['blipicon'] = 377, ['product'] = "Fish", ['x'] = -3354.4536132813, ['y'] = 970.34161376953, ['z'] = 8.2915191650391 },
}

local processors = {
	{ product = "Weed", ['blipname'] = "Weed Processor", illegal = true, "Weed Processor", ["blipicon"] = 140, ['ex'] = 'gr', ['x'] = 2559.1064453125, ['y'] = 4289.0283203125, ['z'] = 41.596225738525, ['refined'] = "Refined Weed", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ product = "Cocaine", ['blipname'] = "Cocaine Processor", illegal = true, "Cocaine Processor", ["blipicon"] = 51, ['ex'] = 'gr', ['x'] = 1215.6077880859, ['y'] = 1899.6010742188, ['z'] = 77.862831115723, ['refined'] = "Refined Cocaine", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ product = "Coal", ['blipname'] = "Coal Processor", ["blipicon"] = 18, ['ex'] = '', ['x'] = 1261.7117919922, ['y'] = 1910.6234130859, ['z'] = 78.569519042969, ['refined'] = "Refined Coal", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ product = "Oil", ['blipname'] = "Oil Processor", illegal = true, ["blipicon"] = 361, ['ex'] = '', ['x'] = -279.5876159668, ['y'] = 6631.0234375, ['z'] = 6.3686723709106, ['refined'] = "Refined Oil", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ product = "Wood", ['blipname'] = "Wood Processor", ["blipicon"] = 85, ['ex'] = '', ['x'] = -513.46087646484, ['y'] = 5264.1982421875, ['z'] = 80.543678283691, ['refined'] = "Plank", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ product = "Tomato", ['blipname'] = "Tomato Packaging", ["blipicon"] = 18, ['ex'] = '', ['x'] = 919.00524902344, ['y'] = 3658.9548339844, ['z'] = 32.508087158203, ['refined'] = "Packaged Tomato", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ product = "Stone", ['blipname'] = "Stone Processor", ["blipicon"] = 18, ['ex'] = '', ['x'] = 2678.5288085938, ['y'] = 2800.4594726563, ['z'] = 40.362369537354, ['refined'] = "Brick", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
}

local sellPoints = {
	{ ['blipname'] = "Weed Dealer", illegal = true, ['refinedName'] = "Refined Weed", ['refined'] = 50, ["blipicon"] = 140, price = 20, ['x'] = 72.763198852539, ['y'] = -1971.3873291016, ['z'] = 19.810777664185, ['product'] = "Weed", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ ['blipname'] = "Cocaine Dealer", illegal = true, ['refinedName'] = "Refined Cocaine", ['refined'] = 80, ["blipicon"] = 51, price = 35, ['x'] = 142.8088684082, ['y'] = -1921.3966064453, ['z'] = 20.131340026855, ['product'] = "Cocaine", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ ['blipname'] = "Coal Seller", ['refinedName'] = "Refined Coal", ['refined'] = 30, ["blipicon"] = 408, price = 15, ['x'] = 833.95190429688, ['y'] = -1991.6448974609, ['z'] = 28.301328659058, ['product'] = "Cocaine", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ ['blipname'] = "Fish Seller", ["blipicon"] = 377, price = 10, ['product'] = "Fish", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0, ['x'] = -460.00094604492, ['y'] = -2434.5295410156, ['z'] = 5.0007848739624 },
	{ ['blipname'] = "Fish Seller", ["blipicon"] = 377, price = 10, ['product'] = "Fish", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0, ['x'] = 27.541465759277, ['y'] = 3730.8173828125, ['z'] = 38.646636962891 },
	{ ['blipname'] = "Oil Trader", illegal = true, ['refinedName'] = "Refined Oil", ['refined'] = 140, ["blipicon"] = 361, price = 6, ['product'] = "Oil", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0, ['x'] = 714.00653076172, ['y'] = -2234.2158203125, ['z'] = 28.435352325439 },
	{ ['blipname'] = "Plank Seller", ['refinedName'] = "Plank", ['refined'] = 20, ["blipicon"] = 85, price = 10, ['x'] = -247.23770141602, ['y'] = 6053.5200195313, ['z'] = 30.960485458374, ['product'] = "Wood", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ ['blipname'] = "Tomato Seller", ['refinedName'] = "Packaged Tomato", ['refined'] = 15, ["blipicon"] = 408, price = 10, ['x'] = 2631.4797363281, ['y'] = 3297.2905273438, ['z'] = 54.2580909729, ['product'] = "Tomato", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
	{ ['blipname'] = "Brick Seller", ['refinedName'] = "Brick", ['refined'] = 15, ["blipicon"] = 408, price = 10, ['x'] = 2707.2666015625, ['y'] = 1566.2606201172, ['z'] = 23.506977081299, ['product'] = "Stone", ['npc'] = "S_M_Y_Dealer_01", ['heading'] = 250.0 },
}

Citizen.CreateThread(function()
	for k,v in ipairs(gatherFields)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.blipicon)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("" .. v.blipname)
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(processors)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.blipicon)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("" .. v.blipname)
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(weaponShops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 110)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Ammunation")
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(sellPoints)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.blipicon)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("" .. v.blipname)
		EndTextCommandSetBlipName(blip)
	end

	return
end)

Citizen.CreateThread(function()
	for i in ipairs(sellPoints) do
		RequestModel(GetHashKey(sellPoints[i].npc))
		while not HasModelLoaded(GetHashKey(sellPoints[i].npc))do
			Wait(0)
		end

		local ped = CreatePed(4, GetHashKey(sellPoints[i].npc), sellPoints[i].x, sellPoints[i].y, sellPoints[i].z, sellPoints[i].heading, false, false)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedFleeAttributes(ped, 0, 0)
	end
end)

local inventoryOpen = false
local inventoryItems = {}

RegisterNetEvent('es_rp:updateInventory')
AddEventHandler('es_rp:updateInventory', function(v)
	inventoryItems = v

	SendNUIMessage({
		type = "inventoryUpdate",
		inventory = json.encode(inventoryItems)
	})
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

local options = 0
local interactions = {
	drawTitle = function(title)
		drawBox(0.2, 0.1, 0.05, 0.2, {151,66,66, 205})
		drawText(0.175, 0.103, 0.7, "" .. title, {255, 255, 255, 255}, 0, true)
	end,
	menuOption = function(option, func)
		if (options + 1) ~= cur.curOption then drawBox(0.2 + 0.045 + (options * 0.04), 0.1, 0.04, 0.2, {40, 40, 40, 205}) else drawBox(0.2 + 0.045 + (options * 0.04), 0.1, 0.04, 0.2, {80, 80, 80, 205}) end 
		drawText(0.175 + 0.054 + (options * 0.04), 0.003, 0.4, "" .. option, {255, 255, 255, 255}, 0, false)
	
		if IsControlJustPressed(1, 175) then
			if (options + 1) == cur.curOption then
				func()
			end
		end

		options = options + 1
	end,
	subMenuOption = function(option, sub)

	end
}

local menus = {}

local curPolice = 2
local policeSkins = {
	"s_f_y_cop_01",
	"s_m_y_cop_01",
	"s_m_y_sheriff_01",
	"s_f_y_sheriff_01"
}

local getNearPlayer = function()
	local pl = nil
	local coords = GetEntityCoords(GetPlayerPed(-1), true)
	for k,v in pairs(GetPlayers()) do
		if NetworkIsPlayerActive(v) and GetPlayerName(v) ~= GetPlayerName(PlayerId()) then
			local coords2 = GetEntityCoords(GetPlayerPed(v), true)
			if Vdist(coords.x, coords.y, coords.z, coords2.x, coords2.y, coords2.z) < 4.0 then
				pl = v
			end
		end
	end

	return pl
end

local doingAction = false

menus["main"] = {
	draw = function()
		options = 0

		interactions.drawTitle("Interactions")
		interactions.menuOption("Action", function()
			DisplayOnscreenKeyboard(0, "ENTER_INTERACTION", 0, "", nil, nil, nil, 60)
			doingAction = true
		end)
		interactions.menuOption("Show ID", function()
			TriggerServerEvent('es_rp:showID')
		end)
		invExtend = ""
		if inventoryOpen then
			invExtend = " ~HUD_COLOUR_CONTROLLER_FRANKLIN~(Open)"
		end
		interactions.menuOption("Inventory " .. invExtend, function()
			inventoryOpen = not inventoryOpen

			SendNUIMessage({
				type = "inventorySwitch",
				enable = inventoryOpen
			})

			SetNuiFocus(inventoryOpen, true)
		end)
		local myPos = GetEntityCoords(GetPlayerPed(-1), true)
		for i in ipairs(gatherFields)do
			local pos = gatherFields[i]
			if Vdist(myPos.x, myPos.y, myPos.z, pos.x, pos.y, pos.z) < 10.0 then
				interactions.menuOption("Harvest " .. gatherFields[i].product, function()
					if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
						TriggerEvent('es_rp:notify', "~r~You cannot harvest in your vehicle")
					else
						ClearPedTasks(GetPlayerPed(-1))
						TriggerServerEvent('es_rp:gather', i)
					end
				end)		
			end
		end
		for i in ipairs(sellPoints)do
			local pos = sellPoints[i]
			if Vdist(myPos.x, myPos.y, myPos.z, pos.x, pos.y, pos.z) < 5.0 then
				interactions.menuOption("Sell " .. pos.product, function()
					TriggerServerEvent('es_rp:sell', i)
				end)		
			end
		end
		for i in ipairs(processors)do
			local pos = processors[i]
			if Vdist(myPos.x, myPos.y, myPos.z, pos.x, pos.y, pos.z) < 5.0 then
				interactions.menuOption("Process " .. pos.product, function()
					TriggerServerEvent('es_rp:process', i)
				end)		
			end			
		end
		local near = getNearPlayer()
		if near ~= nil then
			interactions.menuOption("Pay " .. GetPlayerName(near), function()
				DisplayOnscreenKeyboard(0, "", 0, "", nil, nil, nil, 60)
				doingPayment = true
			end)			
		end
		if job == "Police Officer" then
			if near ~= nil then
				interactions.menuOption("Cuff " .. GetPlayerName(near), function()
					TriggerServerEvent('es_rp:cuff', GetPlayerServerId(near))
				end)
				interactions.menuOption("Search " .. GetPlayerName(near), function()
					TriggerServerEvent('es_rp:search', GetPlayerServerId(near))
				end)
			end
			interactions.menuOption("Next skin", function()
				if curPolice > 4 then
					curPolice = 1
				end

				RequestModel(GetHashKey(policeSkins[curPolice]))
				while not HasModelLoaded(GetHashKey(policeSkins[curPolice])) do
					Wait(0)
				end

				SetPlayerModel(PlayerId(), GetHashKey(policeSkins[curPolice]))
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), 1000, true, false)
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 1000, true, false)
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 1000, true, false)
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 1000, true, false)
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 1000, true, false)

				SetPedArmour(GetPlayerPed(-1), 100)

				curPolice = curPolice + 1
			end)
		end
		if job == "EMS" or job == "Police Officer" then
			if near ~= nil then
				interactions.menuOption("Heal " .. GetPlayerName(near), function()
					TriggerServerEvent('es_rp:heal', GetPlayerServerId(near))
				end)
			end
		end
	end
}

menus["inventory"] = {
	parent = "main",
	draw = function()
		interactions.drawTitle("Inventory")
	end
}

Citizen.CreateThread(function()
	while true do
		Wait(0)

		local myPos = GetEntityCoords(GetPlayerPed(-1), true)
		for _,v in ipairs(weaponShops)do
			if Vdist(myPos.x, myPos.y, myPos.z, v.x, v.y, v.z) < 20.0 then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 255, 255,155, 0,0, 0,0)
				if Vdist(myPos.x, myPos.y, myPos.z, v.x, v.y, v.z) < 2.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the weapon store")

					if IsControlJustPressed(1, 51) then
						weaponShopOpen = not weaponShopOpen

						SendNUIMessage({
							type = "weaponSwitch",
							enable = weaponShopOpen,
							legal = not v.illegal
						})

						SetNuiFocus(true, true)
					end
				end
			end
		end
	end
end)

RegisterNUICallback('buy_weapon', function(data, cb)
	local weapon = data.weapon

	TriggerServerEvent('es_rp:buyWeapon', weapon)
end)

RegisterNetEvent('es_rp:giveWeapon')
AddEventHandler('es_rp:giveWeapon', function(v)
	Citizen.InvokeNative(0x67C540AA08E4A6F5, -1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET")
	
	GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey(v), 0, false)

	SendNUIMessage({
		type = "ownWeapon",
		weapon = v
	})

	table.insert(weapons, v)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		for k,v in ipairs(weapons) do
			local hash = GetHashKey(v)

			SetPedInfiniteAmmo(GetPlayerPed(-1), true, hash)
			GiveDelayedWeaponToPed(GetPlayerPed(-1), hash, 0, false)
		end
	end
end)

RegisterNUICallback('close', function(data, cb)
	inventoryOpen = false
	jobOfficeOpen = false
	weaponShopOpen = false
	jobGarageOpen = false

	SendNUIMessage({
		type = "inventorySwitch",
		enable = inventoryOpen
	})

	SendNUIMessage({
		type = "jobSwitch",
		enable = jobOfficeOpen
	})

	SendNUIMessage({
		type = "weaponSwitch",
		enable = weaponShopOpen,
		legal = true
	})

	SendNUIMessage({
		type = "weaponSwitch",
		enable = weaponShopOpen,
		legal = false
	})

	SendNUIMessage({
		type = "garageSwitch",
		enable = jobGarageOpen
	})

	SetNuiFocus(false)	
end)

RegisterNUICallback('remove_item', function(data, cb)
	local item = data.item

	TriggerServerEvent('es_rp:removeItem', item)
end)

RegisterNetEvent('es_rp:playHarvestAnim')
AddEventHandler('es_rp:playHarvestAnim', function(p)
	RequestAnimDict("amb@world_human_gardener_plant@male@idle_a")
	while not HasAnimDictLoaded("amb@world_human_gardener_plant@male@idle_a")do
		Wait(0)
	end
	TaskPlayAnim(GetPlayerPed(GetPlayerFromServerId(p)), "amb@world_human_gardener_plant@male@idle_a", "idle_a", 8.0, 1.0, 3000, 0, 0.0, true, true, true)
end)

RegisterNetEvent('es_rp:playEmote')
AddEventHandler('es_rp:playEmote', function(p, category, emote, time)
	RequestAnimDict(category)
	while not HasAnimDictLoaded(category)do
		Wait(0)
	end
	TaskPlayAnim(GetPlayerPed(GetPlayerFromServerId(p)), category, emote, 8.0, 1.0, time, 0, 0.0, true, true, true)
end)

local function drawInteractionMenu()
	menus[cur.menu].draw()

	if cur.curOption > options then
		cur.curOption = cur.curOption - 1
	end

	if doingAction then
		UpdateOnscreenKeyboard()

		local t = GetOnscreenKeyboardResult()

		if t then
			if #t > 0 then
				TriggerServerEvent('es_rp:doMessage', t)
			end

			doingAction = false
		end
	end

	if doingPayment then
		UpdateOnscreenKeyboard()

		local t = GetOnscreenKeyboardResult()

		if t then
			if #t > 0 then
				TriggerServerEvent('es_rp:doPayment', GetPlayerServerId(getNearPlayer()), t)
			end

			doingPayment = false
		end
	end

	if IsControlJustPressed(1, 172) then
		PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		-- Up arrow
		if cur.curOption > 1 then
			cur.curOption = cur.curOption - 1
		end
	elseif IsControlJustPressed(1, 173) then
		PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		-- Down arrow
		if cur.curOption < (options) then
			cur.curOption = cur.curOption + 1
		end
	elseif IsControlJustPressed(1, 177)then
		-- Close
	end
end

RegisterNetEvent('es_rp:paymentFailed')
AddEventHandler('es_rp:paymentFailed', function(msg)
	TriggerEvent('es_rp:notify', msg)
end)

local vehicleLocked = false
local blinkerR = false
local blinkerL = false

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= 0 then
			local veh = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
			if GetPedInVehicleSeat(veh, -1) ~= 0 then
				if not IsPedAPlayer(GetPedInVehicleSeat(veh, -1)) and not IsPedDeadOrDying(GetPedInVehicleSeat(veh, -1)) then
					Wait(500)
					local coords = GetEntityCoords(GetPlayerPed(-1), true)
					SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z - 1)
				end
			end
		end

		if not open then
			if IsControlJustPressed(1, 175) then
				if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					vehicleLocked = not vehicleLocked
					SetVehicleDoorsLockedForAllPlayers(GetVehiclePedIsIn(GetPlayerPed(-1), true), vehicleLocked)
				
					local l = "locked"
					if not vehicleLocked then
						l = "unlocked"
					end

					TriggerEvent('es_rp:notify', "Last vehicle has been ~b~" .. l)
				else
					blinkerR = not blinkerR
					blinkerL = false

					SetVehicleIndicatorLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, false)
					SetVehicleIndicatorLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, false)
					SetVehicleIndicatorLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, blinkerR)
				end
			end

			if IsControlJustReleased(1, 174) then
				if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					blinkerL = not blinkerL
					blinkerR = false

					SetVehicleIndicatorLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, false)
					SetVehicleIndicatorLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, false)
					SetVehicleIndicatorLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, blinkerL)
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
        if inventoryOpen or jobOfficeOpen or weaponShopOpen or jobGarageOpen then
			DisableAllControlActions(1)

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsControlJustPressed(1, 244) then
			open = not open
		end

		if open then
			drawInteractionMenu()
		end
	end
end)