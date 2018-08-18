if Config.Crosshair then
	Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		--print(GetHashKey("WEAPON_SNIPERRIFLE"))
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)
		--ClearAreaOfCops()
	end
end)

Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		Citizen.Wait( 5000 )

		if NetworkIsSessionStarted() then
			TriggerEvent('properload')
			return
		end
	end
end )

RegisterNetEvent("PokaKordy")
AddEventHandler("PokaKordy", function()
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	    local PlayerName = GetPlayerName()
    TriggerEvent("chatMessage", "", { 0, 200, 0 }, "\nX:" .. x .. "\nY:" .. y .. "\nZ:" .. z .. " \n")
	TriggerEvent("pNotify:SendNotification", {text = "<h1 style='color:green'>Twoja pozycja</h1><br><b style='font-size: 1.6rem'>X:" .. x .. "<br>Y:" .. y .. "<br>Z:" .. z .. " </b>", 
            type = "success", 
            timeout = 2000,
            layout = "centerLeft",
            queue = "left"})
end)