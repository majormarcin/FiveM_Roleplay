local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local GUI = {}
GUI.Time = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Hide/Show HUD
local interface = false
local isPaused = false

function openInterface()
  interface = not interface
  if not interface then -- hidden
	--DisplayRadar(false)
	ESX.UI.HUD.SetDisplay(0.0)
	TriggerEvent('es:setMoneyDisplay', 0.0)
	TriggerEvent('esx_status:setDisplay', 0.0)
  elseif interface then -- shown
  --DisplayRadar(true)
	ESX.UI.HUD.SetDisplay(1.0)
	TriggerEvent('es:setMoneyDisplay', 1.0)
	TriggerEvent('esx_status:setDisplay', 1.0)
  end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if (IsPauseMenuActive() or IsControlPressed(1, 37)) and not isPaused and not interface then
		isPaused = true
		--DisplayRadar(false)
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('es:setMoneyDisplay', 0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
	elseif (IsPauseMenuActive() or IsControlPressed(1, 37)) and not isPaused and interface then
		isPaused = true
		--DisplayRadar(false)
     	ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('es:setMoneyDisplay', 0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
	elseif not (IsPauseMenuActive() or IsControlPressed(1, 37)) and isPaused and not interface then
		isPaused = false 
		--DisplayRadar(false)
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('es:setMoneyDisplay', 0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
	elseif not (IsPauseMenuActive() or IsControlPressed(1, 37)) and isPaused and interface then
		isPaused = false
		--DisplayRadar(true)
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('es:setMoneyDisplay', 1.0)
		TriggerEvent('esx_status:setDisplay', 1.0)
    end
  end
end)


Citizen.CreateThread(function()
	while true do
Citizen.Wait(0)

	local playerPed = GetPlayerPed(-1)
	local playerVeh = GetVehiclePedIsIn(playerPed, false)
	
	if IsPedInAnyVehicle(playerPed, true) then
		DisplayRadar(true)
	else
		DisplayRadar(false)
	end
	end
end)

--
--[[ Key controls
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustPressed(0,  Keys['F10']) and (GetGameTimer() - GUI.Time) > 300 then
			openInterface()	
		end
	end
end)
]]--