playersNames = {}

local ACT = {
	["gathers"] = {
		dict = "amb@world_human_gardener_plant@male@idle_a",
		anim = "idle_a",
		time = 2000
	},
	["waves"] = {
		dict = "friends@frj@ig_1",
		anim = "wave_e",
		time = 3000
	},
	["sits"] = {
		dict = "amb@code_human_in_bus_passenger_idles@male@sit@idle_b",
		anim = "idle_d",
		time = 5000
	},
	["puts middlefinger up"] = {
		dict = "amb@code_human_in_car_mp_actions@finger@low@ds@base",
		anim = "idle_a",
		time = 5000
	},
	["jerks off"] = {
		dict = "switch@trevor@jerking_off",
		anim = "trev_jerking_off_loop",
		time = 5000
	},
	["slits throat with finger"] = {
		dict = "cellphone@self@trevor@",
		anim = "throat_slit",
		time = 5000
	},
	["leans"] = {
		dict = "mini@strip_club@leaning@base",
		anim = "base",
		time = 4000
	},
	["cheers"] = {
		dict = "amb@world_human_cheering@male_a",
		anim = "base",
		time = 5000
	},
	["points"] = {
		dict = "cellphone@self@michael@",
		anim = "finger_point",
		time = 2000
	}
}

RegisterServerEvent('es_rp:doMessage')
AddEventHandler('es_rp:doMessage', function(msg)
	if msg then
		TriggerEvent('es:getPlayerFromId', source, function(user)
			if user then
				local mPos = user.getCoords()
				TriggerEvent('es:getPlayers', function(users)
					for k,v in pairs(users)do
						local tPos = v.getCoords()

						if get3DDistance(tPos.x, tPos.y, tPos.z, mPos.x, mPos.y, mPos.z) < 20.0 then
							TriggerClientEvent('chatMessage', k, "", {0, 0, 0}, "^2* " .. (playersNames[source] or GetPlayerName(source)) .. " " .. msg)
						
							if ACT[msg] then
								local emote = ACT[msg]
								TriggerClientEvent('es_rp:playEmote', k, source, emote.dict, emote.anim, emote.time)
							end
						end
					end
				end)
			end
		end)
	end
end)

TriggerEvent('es:addCommand', 'jc', function(source, args, user)
	TriggerEvent('es:getPlayers', function(users)
		table.remove(args, 1)
		for s,u in pairs(users)do
			if jobs[source].name == jobs[s].name then
				TriggerClientEvent('chatMessage', s, "JOB", {255, 255, 0}, "^*^1" .. GetPlayerName(source) .. " ^2-> ^0^r" .. table.concat(args, " "))
			end
		end
	end)
end)

TriggerEvent('es:addCommand', 'give', function(source, args, user)
	if GetPlayerName(args[2]) then
		if tonumber(args[3]) > 0 then
			local amount = tonumber(args[3])
			if user.getMoney() >= amount then
				user.removeMoney(amount)
				TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
					target.addMoney(amount)
					TriggerClientEvent('es_rp:notify', source, "You paid ~b~" .. GetPlayerName(target.get('source')) .. "~w~ ~g~$" .. args[3])
					TriggerClientEvent('es_rp:notify', source, "You were paid by ~b~" .. GetPlayerName(source) .. "~w~ ~g~$" .. args[3])
				end)
			else
				TriggerClientEvent('es_rp:notify', source, "~r~You do not have the required amount")
			end
		else
			TriggerClientEvent('es_rp:notify', source, "~r~Please enter a valid money amount")
		end
	else
		TriggerClientEvent('es_rp:notify', source, "~r~Please enter a valid Player ID")
	end
end)

RegisterNetEvent('es_rp:setPlayerName')
AddEventHandler('es_rp:setPlayerName', function(name)
	playersNames[source] = name

	TriggerClientEvent('es_rp:setNames', -1, playersNames)
end)

AddEventHandler('es_rp:playerLoaded', function()
	TriggerClientEvent('es_rp:setNames', source, playersNames)
end)