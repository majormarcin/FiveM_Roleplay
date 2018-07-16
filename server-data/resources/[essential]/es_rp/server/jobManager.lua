jobs = {}
local firstSpawns = {}
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
local wanted = {}
local inventories = {}
local max = 20
local policeOfficersOnDuty = {}

AddEventHandler('es_rp:getJobs', function(cb)
	cb(jobs)
end)

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

local function power(a, b)
	return a ^ b
end

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(power(x1 - x2, 2) + power(y1 - y2, 2) + power(z1 - z2, 2))
end

local timeouts = {}

RegisterServerEvent('es_rp:process')
AddEventHandler('es_rp:process', function(i)
	if processors[i] then
		if timeouts[source] then
			TriggerClientEvent('es_rp:notify', source, "~r~You can refine every 3 seconds")
		else
			timeouts[source] = true
			local doTimeout = function(source)
				SetTimeout(3000, function()
					timeouts[source] = nil
				end)
			end

			doTimeout(source)

			if inventories[source] == nil then
				inventories[source] = {}
			end	
			
			local process = false
			local remove = nil
			for k,v in pairs(inventories[source])do
				if v.name == processors[i].product and v.amount > 0 then
					inventories[source][k].amount = inventories[source][k].amount - 1
					if inventories[source][k].amount == 0 then
						inventories[source][k] = nil
					end
					process = true
				end
			end

			if process then
				local amountReached = 0
				local set = false
				for k,v in pairs(inventories[source])do
					if v.name == processors[i].refined then
						inventories[source][k].amount = v.amount + 1
						amountReached = inventories[source][k].amount
						set = true
					end
				end

				if not set then
					inventories[source][#inventories[source] + 1] = {
						name = processors[i].refined,
						ex = processors[i].ex,
						amount = 1,
						illegal = processors[i].illegal
					}

					amountReached = 1
				end

				TriggerClientEvent('es_rp:notify', source, "You refined ~b~" .. processors[i].product .. "~w~(~b~" .. amountReached .. "~w~)")
				TriggerClientEvent('es_rp:updateInventory', source, inventories[source])
			else
				TriggerClientEvent('es_rp:notify', source, "~r~You don't have any weed on you")
			end
		end
	end
end)

RegisterServerEvent('es_rp:sell')
AddEventHandler('es_rp:sell', function(i)
	if sellPoints[i] then
		if inventories[source] == nil then
			inventories[source] = {}
		end

		local sell = false
		local sellAmount = 0
		local removeNormal = nil
		for k,v in pairs(inventories[source])do
			if v.name == sellPoints[i].product then
				if inventories[source][k].amount > 0 then
					sellAmount = inventories[source][k].amount
					inventories[source][k] = nil
					sell = true
				end
			end
		end

		local sellRefined = false
		local refinedAmount = 0
		local removeRefined = nil
		for k,v in pairs(inventories[source])do
			if v.name == sellPoints[i].refinedName then
				if inventories[source][k].amount > 0 then
					refinedAmount = inventories[source][k].amount
					inventories[source][k] = nil
					sellRefined = true
				end
			end
		end

		local give = sellAmount * sellPoints[i].price
		local giveRefined = refinedAmount * (sellPoints[i].refined or 0)
		local giveMoney = give + giveRefined

		if sell or sellRefined then
			TriggerEvent('es:getPlayerFromId', source, function(user)
				user.addMoney(giveMoney)
				TriggerClientEvent('es_rp:updateInventory', source, inventories[source])

				if sell then
					TriggerClientEvent('es_rp:notify', source, "You sold ~b~" .. sellAmount .. " ~w~of~b~ " .. sellPoints[i].product .. "~w~ for ~g~$" .. give)
				end

				if sellRefined then
					TriggerClientEvent('es_rp:notify', source, "You sold ~b~" .. refinedAmount .. " ~w~of~b~ " .. sellPoints[i].refinedName .. "~w~ for ~g~$" .. giveRefined)
				end
			end)
		else
			TriggerClientEvent('es_rp:notify', source, "~r~You don't have any " .. sellPoints[i].product)
		end
	end
end)

local function maxReached(inventory, cb)
	Citizen.CreateThread(function()
		local current = 0

		for i in ipairs(inventory)do
			current = current + inventory[i].amount
		end

		if current >= 30 then
			cb(true)
		else
			cb(false)
		end

		return
	end)
end

RegisterServerEvent('es_rp:removeItem')
AddEventHandler('es_rp:removeItem', function(item)
	if inventories[source] then
		for e in pairs(inventories[source]) do 
			print(inventories[source][e].name)
			if inventories[source][e].name == item then
				inventories[source][e] = nil
			end
		end

		TriggerClientEvent('es_rp:updateInventory', source, inventories[source])
	end
end)

RegisterServerEvent('es_rp:gather')
AddEventHandler('es_rp:gather', function(i)
	if gatherFields[i] then
		if timeouts[source]then
			TriggerClientEvent('es_rp:notify', source, "~r~You can gather every 3 seconds!")
		else
			timeouts[source] = true
			local doTimeout = function(source)
				SetTimeout(3000, function()
					timeouts[source] = nil
				end)
			end

			doTimeout(source)

			if inventories[source] == nil then
				inventories[source] = {}
			end

			local function passSource(source)
				maxReached(inventories[source], function(maxAmountReached)
					if not maxAmountReached then
						TriggerClientEvent('es_rp:playHarvestAnim', -1, source)
					end

					if inventories[source] == nil then
						inventories[source] = {}
					end

					local set = false
					local nowAmount = 0
					for e in pairs(inventories[source]) do
						if inventories[source][e].name == gatherFields[i].product and not maxAmountReached then
							inventories[source][e].amount = inventories[source][e].amount + 1
							nowAmount = inventories[source][e].amount
							set = true
						end
					end

					if not set and not maxAmountReached then
						inventories[source][#inventories[source] + 1] = {
							name = gatherFields[i].product,
							ex = gatherFields[i].ex,
							amount = 1,
							illegal = gatherFields[i].illegal
						}

						nowAmount = 1
					end

					if maxAmountReached then
						TriggerClientEvent('es_rp:notify', source, "~r~Your inventory is full")
					else
						TriggerClientEvent('es_rp:notify', source, "You gathered ~b~" .. gatherFields[i].product .. " ~w~(~b~" .. nowAmount .. "~w~)")
						TriggerClientEvent('es_rp:updateInventory', source, inventories[source])
					end
				end)
			end
			passSource(source)
		end
	end
end)


RegisterServerEvent('es_rp:showID')
AddEventHandler('es_rp:showID', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local myPos = user.getCoords()
		TriggerEvent('es:getPlayers', function(players)
			for k,v in pairs(players)do
				local theirPos = v.getCoords()
				if get3DDistance(myPos.x, myPos.y, myPos.z, theirPos.x, theirPos.y, theirPos.z) < 10.0 then
					TriggerClientEvent("es_rp:notify", v.get('source'), "~b~ID was shown: ~w~" .. (playersNames[source] or GetPlayerName(source)) .. ", " .. jobs[source].name)
					if wanted[source] then
						TriggerClientEvent('es_rp:notify', v.get('source'), "~r~WANTED: ~b~" .. wanted[source])
					end
				end
			end
		end)
	end)
end)

local searches = {}

RegisterServerEvent('es_rp:search')
AddEventHandler('es_rp:search', function(user)
	if POLICE[jobs[source].name] then
		if GetPlayerName(user) then
			if not POLICE[jobs[user].name] then			
				TriggerClientEvent('es_rp:notify', source, "You searched ~b~" .. GetPlayerName(user))
				TriggerClientEvent('es_rp:notify', user, "You have been searched by ~b~" .. GetPlayerName(source))

				searches[user] = source

				TriggerClientEvent('es_rp:search', user)
			else
				TriggerClientEvent('es_rp:notify', source, "~r~This person cannot be touched")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~No near player found")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not a police officer")
	end
end)

local cuffed = {}

RegisterServerEvent('es_rp:cuff')
AddEventHandler('es_rp:cuff', function(user)
	if POLICE[jobs[source].name] then
		if GetPlayerName(user) then
			if not POLICE[jobs[user].name] then
				if cuffed[user] == nil then
					cuffed[user] = true
				else
					cuffed[user] = not cuffed[user]
				end
			
				if cuffed[user] then
					TriggerClientEvent('es_rp:notify', source, "You cuffed ~b~" .. GetPlayerName(user))
					TriggerClientEvent('es_rp:notify', user, "You have been cuffed by ~b~" .. GetPlayerName(source))
				else
					TriggerClientEvent('es_rp:notify', source, "You uncuffed ~b~" .. GetPlayerName(user))
					TriggerClientEvent('es_rp:notify', user, "You have been uncuffed by ~b~" .. GetPlayerName(source))
				end

				TriggerClientEvent('es_rp:cuff', user, cuffed[user])
			else
				TriggerClientEvent('es_rp:notify', source, "~r~This person cannot be touched")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~No near player found")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not a police officer")
	end
end)

local deadPeople = {}

AddEventHandler('es:firstSpawn', function(source, user)
	user.displayMoney(user.getMoney())
	user.displayBank(user.getBank())
end)

RegisterServerEvent('es_rp:spawnPlayer')
AddEventHandler('es_rp:spawnPlayer', function()
	local Source = source

	local job = jobs[Source] or JOB_CIVILIAN
	local spawn = job.spawns[math.random(#job.spawns)]

	if firstSpawns[Source] == nil then
		TriggerEvent('es_rp:firstSpawn', Source)

		firstSpawns[Source] = true
	end

	if job.skins ~= "DEFAULT" then
		TriggerClientEvent('es_rp:spawn', Source, job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
	else 
		TriggerClientEvent('es_rp:spawn', Source, job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
		TriggerEvent('es_rp:setToDefaultS', Source, job.weapons, job.health, job.armour)
	end
end)

TriggerEvent('es:addCommand', 'respawn', function(source, args, user)
	if deadPeople[source] then
		deadPeople[source] = nil

		local job = jobs[source] or JOB_CIVILIAN
		local spawn = job.spawns[math.random(#job.spawns)]

		user.setMoney(0)
		inventories[source] = {}

		TriggerClientEvent('es_rp:updateInventory', source, inventories[source])

		TriggerClientEvent('es_rp:spawn', source, job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
	end
end)

TriggerEvent('es:addCommand', 'revive', function(source, args, user)
	-- Too fucking buggy

	--[[if jobs[source].name == "EMS" then
		if GetPlayerName(tonumber(args[2])) then
			if deadPeople[tonumber(args[2])]then
				TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
					TriggerClientEvent('es_rp:notify', source, "Revived ~b~" .. GetPlayerName(tonumber(args[2])))
					TriggerClientEvent('es_rp:notify', tonumber(args[2]), "You've been revived by ~b~" .. GetPlayerPed(source))

					local job = jobs[tonumber(args[2])] or JOB_CIVILIAN
					local spawn = target.getCoords()

					TriggerClientEvent('es_rp:spawn', tonumber(args[2]), job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
				end)
			else
				TriggerClientEvent('es_rp:notify', source, "~r~This person is fine")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /revive [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not EMS")
	end]]
end)

RegisterServerEvent('es_rp:heal')
AddEventHandler('es_rp:heal', function(usar)
	if jobs[source].name == "EMS" then
		if GetPlayerName(usar) then
			TriggerEvent('es:getPlayerFromId', usar, function(target)
				TriggerClientEvent('es_rp:notify', source, "Healed ~b~" .. GetPlayerName(usar))
				TriggerClientEvent('es_rp:notify', usar, "You've been healed by ~b~" .. GetPlayerName(source))

				TriggerClientEvent('es_admin:heal', usar) 
			end)
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /revive [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not EMS")
	end
end)

RegisterServerEvent('es_rp:revive')
AddEventHandler('es_rp:revive', function(usar)
	-- Too fucking buggy

	--[[if jobs[source].name == "EMS" then
		if GetPlayerName(tonumber(args[2])) then
			if deadPeople[tonumber(args[2])]then
				TriggerEvent('es:getPlayerFromId', tonumber(usar), function(target)
					TriggerClientEvent('es_rp:notify', source, "Revived ~b~" .. GetPlayerName(tonumber(args[2])))
					TriggerClientEvent('es_rp:notify', tonumber(usar), "You've been revived by ~b~" .. GetPlayerPed(source))

					local job = jobs[tonumber(usar)] or JOB_CIVILIAN
					local spawn = target.getCoords()

					TriggerClientEvent('es_rp:spawn', tonumber(usar), job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
				end)
			else
				TriggerClientEvent('es_rp:notify', source, "~r~This person is fine")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /revive [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not EMS")
	end]]
end)

AddEventHandler('playerDropped', function()
	jobs[source] = nil
end)

RegisterServerEvent('es_rp:changeJob')
AddEventHandler('es_rp:changeJob', function(job)
	if JOBS[job] then
		TriggerEvent('es:getPlayerFromId', source, function(user)
			if JOBS[job].permission_level <= user.getPermissions() then
				jobs[source] = JOBS[job] or JOB_CIVILIAN

				TriggerClientEvent('es_rp:setJob', source, jobs[source].name)

				local job = jobs[source] or JOB_CIVILIAN
				local spawn = user.getCoords()

				TriggerClientEvent('es_rp:notify', source, "Job changed to: ~b~" .. job.name)

				if job.skins ~= "DEFAULT" then
					TriggerClientEvent('es_rp:spawn', source, job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
				else 
					TriggerClientEvent('es_rp:spawn', source, job.skins[math.random(#job.skins)], spawn.x, spawn.y, spawn.z, spawn.heading or 0.0, job.weapons, job.health, job.armour) 
					TriggerEvent('es_rp:setToDefaultS', source, job.weapons, job.health, job.armour)
				end
			else
				if not JOBS[job].customPermissionLevelCheck then
					TriggerClientEvent('es_rp:notify', source, "You do not have the required permission level, required: ~r~" .. JOBS[job].permission_level)
				else
					JOBS[job].customPermissionLevelCheck(source)
				end
			end
		end)
	end
end)

local fines = {}
TriggerEvent('es:addCommand', 'fine', function(source, args, user)
	if #args > 1 then
		if args[2] then
			if GetPlayerName(args[2]) then
				if args[3] then
					if tonumber(args[3]) > 0 and tonumber(args[3]) < 501 then
						fines[tonumber(args[2])] = {
							amount = tonumber(args[3]),
							finer = source
						}

						TriggerClientEvent('es_rp:notify', source, "Fined ~b~" .. GetPlayerName(tonumber(args[2])))
						TriggerClientEvent('chatMessage', tonumber(args[2]), "FINE", {255, 0, 0}, "You're being fined you have 30 seconds to type /fine and pay ^2$" .. args[3])
					
						SetTimeout(30000, function()
							if fines[tonumber(args[2])] then
								TriggerClientEvent('chatMessage', tonumber(args[2]), "FINE", {255, 0, 0}, "Fine ^1WASN'T^0 payed by " .. GetPlayerName(tonumber(args[2])))
							end
						end)
					else
						TriggerClientEvent('es_rp:notify', source, "~r~Please enter a vaid amount")
					end
				else
					TriggerClientEvent('es_rp:notify', source, "~r~USAGE: /fine [USER] [AMOUNT]")
				end
			else
				TriggerClientEvent('es_rp:notify', source, "~r~USAGE: /fine [USER] [AMOUNT]")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~USAGE: /fine [USER] [AMOUNT]")
		end
	else
		if #args == 1 then
			if fines[source] then
				if user.getMoney() >= fines[source].amount then
          			TriggerClientEvent("banking:updateBalance", source, user.getBank() - fines[source].amount)
          			TriggerClientEvent("banking:removeBalance", source, fines[source].amount)

					user.setBankBalance(user.getBank() - fines[source].amount)
					TriggerClientEvent('chatMessage', source, "FINE", {255, 0, 0}, "Fine payed")
					TriggerClientEvent('chatMessage', fines[source].finer, "FINE", {255, 0, 0}, "Fine payed by ^2" .. GetPlayerName(source))

					fines[source] = nil
				end
			else
				TriggerClientEvent('es_rp:notify', source, "~r~You have no outstanding fines")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~You are not a police officer")
		end
	end
end)


TriggerEvent('es:addCommand', 'wanted', function(source, args, user)
	if POLICE[jobs[source].name] then
		if args[3] == nil then
			if(GetPlayerName(tonumber(args[2]))) then
				if wanted[tonumber(args[2])] then
					TriggerClientEvent('es_rp:notify', source, "~r~WANTED: ~b~" .. wanted[tonumber(args[2])])
				else
					TriggerClientEvent('es_rp:notify', source, "~b~Not wanted")
				end
			else
				TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /wanted [ID] (REASON)")
			end
		else
			if(GetPlayerName(tonumber(args[2]))) then
				local pl = tonumber(args[2])
				table.remove(args, 1)
				table.remove(args, 1)
				wanted[pl] = table.concat(args, " ")
				TriggerClientEvent('es_rp:notify', source, "~r~Player is now wanted")
			else
				TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /wanted [ID] (REASON)")
			end
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You are not a police officer")
	end
end)

TriggerEvent('es:addCommand', 'unwanted', function(source, args, user)
	if POLICE[jobs[source].name] then
		if(GetPlayerName(tonumber(args[2]))) then
			wanted[tonumber(args[2])] = nil
			TriggerClientEvent('es_rp:notify', source, "~r~Player is no longer wanted")
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /unwanted [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You are not a police officer")
	end
end)

TriggerEvent('es:addCommand', 'unseat', function(source, args, user)
	if POLICE[jobs[source].name] then
		if(GetPlayerName(tonumber(args[2]))) then
			TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
				if(get3DDistance(target.getCoords().x, target.getCoords().y, target.getCoords().z, user.getCoords().x, user.getCoords().y, user.getCoords().z) < 7.0)then
					TriggerClientEvent('es_rp:unseat', tonumber(args[2]))

					TriggerClientEvent('es_rp:notify', source, "You have unseated ~b~" .. GetPlayerName(tonumber(args[2])))
					TriggerClientEvent('es_rp:notify', tonumber(args[2]), "You have unseated by ~b~" .. GetPlayerName(source))
				else
					TriggerClientEvent('es_rp:notify', source, "~r~You are not near the player")
				end
			end)
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, /unwanted [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You are not a police officer")
	end
end)

RegisterServerEvent('es_rp:doPayment')
AddEventHandler('es_rp:doPayment', function(target, amount)
	local amount = tonumber(amount)
	if amount then
		if amount > 0 then
			if GetPlayerName(target) then
				TriggerEvent('es:getPlayerFromId', source, function(user)
					if user.getMoney() >= amount then
						user.removeMoney(amount)
						TriggerEvent('es:getPlayerFromId', target, function(target)
							target.addMoney(amount)

							TriggerClientEvent('es_rp:paymentFailed', user.get('source'), "You payed ~b~" .. GetPlayerName(target.get('source')) .. " ~g~$" .. tostring(amount))
							TriggerClientEvent('es_rp:paymentFailed', target.get('source'), "You were payed by ~b~" .. GetPlayerName(user.get('source')) .. " ~g~$" .. tostring(amount))
						end)
					else
						TriggerClientEvent('es_rp:paymentFailed', source, "~r~Not enough money")
					end
				end)
			else
				TriggerClientEvent('es_rp:paymentFailed', source, "~r~Unknown error: PLAYER NOT FOUND")
			end
		else
			TriggerClientEvent('es_rp:paymentFailed', source, "~r~Invalid amount")
		end
	else
		TriggerClientEvent('es_rp:paymentFailed', source, "~r~Invalid amount")
	end
end)

RegisterServerEvent('es_rp:searchS')
AddEventHandler('es_rp:searchS', function(found)
	if searches[source] then
		TriggerEvent('es:getPlayerFromId', source, function(userD)
			local weapons = ""
			if not inventories[source] then
				inventories[source] = {}
			end
			local inventory = inventories[source]
			local illegalGoods = ""
			for i in pairs(found.weapons)do
				weapons = weapons .. found.weapons[i] .. ", "
			end
			local removal = {}
			for k,v in pairs(inventory)do
				if v.illegal then
					illegalGoods = v.name .. "(" .. v.amount .. "),"
					table.insert(removal, k)
				end
			end
			for k,v in pairs(removal)do
				inventories[source][v] = nil
			end

			TriggerClientEvent('es_rp:updateInventory', source, inventories[source])
			TriggerClientEvent('es_rp:removeWeapons', source)

			if weapons ~= "" then
				TriggerClientEvent('es_rp:notify', searches[source], "~r~ILLEGAL WEAPONS: ~b~" .. weapons)
			else
				TriggerClientEvent('es_rp:notify', searches[source], "~b~No illegal weapons found")
			end

			if illegalGoods ~= "" then
				TriggerClientEvent('es_rp:notify', searches[source], "~r~ILLEGAL GOODS: ~b~" .. illegalGoods)
			else
				TriggerClientEvent('es_rp:notify', searches[source], "~b~No illegal goods found")
			end

			TriggerClientEvent('es_rp:notify', searches[source], "Money on hand ~g~$" .. userD.getMoney())
		end)
		searches[source] = nil
	end
end)


TriggerEvent('es:addCommand', 'jail', function(source, args, user)
	if POLICE[jobs[source].name] or true then
		if GetPlayerName(tonumber(args[2])) then
			if(type(tonumber(args[3])) ~= "number")then
				TriggerClientEvent('es_rp:notify', source, "~r~Incorrect time, between 1 and 5 minutes. /jail [ID] [TIME]")
			else
				if math.ceil(tonumber(args[3])) < 6 and math.ceil(tonumber(args[3])) > 0 then
					local jailed = false

					if not POLICE[jobs[tonumber(args[2])].name] then
						TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
							for i in ipairs(arrestPoints)do
								local p = arrestPoints[i]
								if(get3DDistance(target.get('coords').x, target.get('coords').y, target.get('coords').z, user.get('coords').x, user.get('coords').y, user.get('coords').z) < 4.0) or true then
									if(get3DDistance(target.get('coords').x, target.get('coords').y, target.get('coords').z, p.x, p.y, p.z) < 4.0) or true then
										TriggerClientEvent('es_rp:notify', source, "You have jailed ~b~" .. GetPlayerName(tonumber(args[2])))
										TriggerClientEvent('es_rp:notify', tonumber(args[2]), "You have been jailed by ~b~" .. GetPlayerName(source))

										TriggerClientEvent('es_rp:jail', tonumber(args[2]), true)

										SetTimeout(tonumber(args[3]) * 1000 * 60, function()
											TriggerClientEvent('es_rp:jail', tonumber(args[2]), false)
										end)

										jailed = true
									end
								else
									TriggerClientEvent('es_rp:notify', source, "~r~You are not near the person you are trying to jail")
								end
							end

							if not jailed then
								TriggerClientEvent('es_rp:notify', source, "~r~The person you are trying to jail is not near an arrest point")
							end
						end)
					else
						TriggerClientEvent('es_rp:notify', source, "~r~You cannot jail this person")
					end
				else
					TriggerClientEvent('es_rp:notify', source, "~r~Incorrect time, between 1 and 5 minutes. /jail [ID] [TIME]")
				end
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, please use their ID. /jail [ID] [TIME]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not a police officer")
	end
end)

TriggerEvent('es:addCommand', 'cuff', function(source, args, user)
	if POLICE[jobs[source].name] then
		if GetPlayerName(tonumber(args[2])) then
			if POLICE[jobs[tonumber(args[2])].name] then
				TriggerClientEvent('es_rp:notify', source, "You cuffed ~b~" .. GetPlayerName(tonumber(args[2])))
				TriggerClientEvent('es_rp:notify', tonumber(args[2]), "You have been cuffed by ~b~" .. GetPlayerName(tonumber(source)))
			
				TriggerClientEvent('es_rp:cuff', tonumber(args[2]), true)
			else
				TriggerClientEvent('es_rp:notify', source, "~r~This person cannot be cuffed")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, please use their ID. /cuff [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not a police officer")
	end
end)

TriggerEvent('es:addCommand', 'uncuff', function(source, args, user)
	if POLICE[jobs[source].name] then
		if GetPlayerName(tonumber(args[2])) then
			if POLICE[jobs[tonumber(args[2])].name] then
				TriggerClientEvent('es_rp:notify', source, "You uncuffed ~b~" .. GetPlayerName(tonumber(args[2])))
				TriggerClientEvent('es_rp:notify', tonumber(args[2]), "You have been uncuffed by ~b~" .. GetPlayerName(tonumber(source)))
			
				TriggerClientEvent('es_rp:cuff', tonumber(args[2]), false)
			else
				TriggerClientEvent('es_rp:notify', source, "~r~This person cannot be uncuffed")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found, please use their ID. /cuff [ID]")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You're not a police officer")
	end
end)

TriggerEvent('es:addCommand', 'police', function(source, args, user)
	table.remove(args, 1)
	TriggerClientEvent("chatMessage", source, '911', {255, 0, 0}, "Message send to dispatch")
	TriggerEvent('es:getPlayers', function(users)
		for k,v in pairs(users)do
			if jobs[k].name == "Police Officer" then
				TriggerClientEvent("chatMessage", k, '', {0,0,0}, '^2 ' .. tostring(source) .. ' | ' .. GetPlayerName(source) .. " ^* -> ^r Dispatch^0: " .. table.concat(args, " "))
			end
		end
	end)
end)
TriggerEvent('es:addCommand', 'medic', function(source, args, user)
	table.remove(args, 1)
	TriggerClientEvent("chatMessage", source, '911', {255, 0, 0}, "Message send to dispatch")
	TriggerEvent('es:getPlayers', function(users)
		for k,v in pairs(users)do
			if jobs[k].name == "EMS" then
				TriggerClientEvent("chatMessage", k, '', {0,0,0}, '^2 ' .. tostring(source) .. ' | ' .. GetPlayerName(source) .. " ^* -> ^r Dispatch^0: " .. table.concat(args, " "))
			end
		end
	end)
end)
TriggerEvent('es:addCommand', 'tow', function(source, args, user)
	table.remove(args, 1)
	TriggerClientEvent("chatMessage", source, '911', {255, 0, 0}, "Message send to dispatch")
	TriggerEvent('es:getPlayers', function(users)
		for k,v in pairs(users)do
			if jobs[k].name == "Mechanic" then
				TriggerClientEvent("chatMessage", k, '', {0,0,0}, '^2 ' .. tostring(source) .. ' | ' .. GetPlayerName(source) .. " ^* -> ^r Dispatch^0: " .. table.concat(args, " "))
			end
		end
	end)
end)
TriggerEvent('es:addCommand', 'dreply', function(source, args, user)
	if jobs[source].name == "Police Officer" or jobs[source].name == "EMS" or jobs[source].name == "Mechanic" then
		local usar = tonumber(args[2])

		if(GetPlayerName(usar))then
			table.remove(args, 1)
			table.remove(args, 1)

			if(#args > 0)then
				TriggerClientEvent('chatMessage', usar, "DISPATCH", {255, 0, 0}, table.concat(args, " "))
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "USAGE: /dreply [USER] [MESSAGE]")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Player not found")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~You cannot send dispatch messages")
	end
end)

local curTime = 8

AddEventHandler('es:playerLoaded', function(source, user)
	jobs[source] = JOB_CIVILIAN

	TriggerClientEvent('es_rp:setJob', source, jobs[source].name)
	TriggerClientEvent('es_rp:playerLoaded', source)
	TriggerClientEvent('es_rp:setTime', source, curTime)
end)

local function timeCycle()
	curTime = curTime + 1
	if curTime > 23 then
		curTime = 1
	end

	TriggerClientEvent('es_rp:setTime', -1, curTime)
	SetTimeout(10 * 1000 * 60, timeCycle)
end

SetTimeout(10 * 1000 * 60, timeCycle)

local function paychecks()
	TriggerEvent('es:getPlayers', function(players)
		for i in pairs(players)do
			if jobs[players[i].get('source')] == nil then
				jobs[players[i].get('source')] = JOB_CIVILIAN
				TriggerClientEvent('es_rp:setJob', source, jobs[players[i].get('source')].name)
			end

			players[i].addBank(jobs[players[i].get('source')].salary)
          	
          	if jobs[players[i].get('source')].name == "Civilian" then TriggerClientEvent('es_rp:notify', players[i].get('source'), "You've received your welfare ~g~$" .. jobs[players[i].get('source')].salary) end
			if jobs[players[i].get('source')].name ~= "Civilian" then TriggerClientEvent('es_rp:notify', players[i].get('source'), "You've received your paycheck ~g~$" .. jobs[players[i].get('source')].salary) end
		end
	end)
	SetTimeout(600000, paychecks)
end

SetTimeout(1000, paychecks)