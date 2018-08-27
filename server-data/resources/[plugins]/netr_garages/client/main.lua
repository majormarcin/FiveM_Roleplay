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

local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentGarage           = nil
local PlayerData              = {}
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local closest                 = 0

ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Create Blips
Citizen.CreateThread(function()
		
	for k,v in pairs(Config.Garages) do

    local blip = AddBlipForCoord(v.Marker.x, v.Marker.y, v.Marker.z)

    SetBlipSprite (blip, 357)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.9)
    SetBlipColour (blip, 3)
    SetBlipAsShortRange(blip, true)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Garage")
    EndTextCommandSetBlipName(blip)

	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)

		for k,v in pairs(Config.Garages) do

      if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < Config.DrawDistance) then
        DrawMarker(Config.MarkerType, v.Marker.x, v.Marker.y, v.Marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
      end	

		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Garages) do
      if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
        CurrentGarage = v
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('netr_garages:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('netr_garages:hasExitedMarker', LastZone)
    end
  end
end)

-- Key controls
Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)

    if CurrentAction ~= nil then

      local playerPed  = GetPlayerPed(-1)
      if IsPedInAnyVehicle(playerPed) then
        DisplayHelpText("Wciśnij ~INPUT_CONTEXT~ aby ~g~Zaparkować~w~ Auto")
      else
        DisplayHelpText("Wciśnij ~INPUT_CONTEXT~ aby ~b~Otworzyć~w~ Garaż")
      end

      if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
        if CurrentAction == 'parking_menu' then

          local coords      = GetEntityCoords(GetPlayerPed(-1))

          for k,v in pairs(Config.Garages) do
            if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x) then

              if IsPedInAnyVehicle(playerPed) then

                local vehicle       = GetVehiclePedIsIn(playerPed)
                local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
                local name          = GetDisplayNameFromVehicleModel(vehicleProps.model)
                local plate         = vehicleProps.plate

                ESX.TriggerServerCallback('netr_garages:checkIfVehicleIsOwned', function (owned)

                  if owned ~= nil then                    
                    TriggerServerEvent("netr_garages:updateOwnedVehicle", vehicleProps)
                    TriggerServerEvent("netr_garages:addCarToParking", vehicleProps)

                    TaskLeaveVehicle(playerPed, vehicle, 16)
                    ESX.Game.DeleteVehicle(vehicle)
                  else
                    DisplayHelpText("You don't own this car")
                  end

                end, vehicleProps.plate)

                --WarMenu.OpenMenu('park')

              else 

                SendNUIMessage({
                  clearme = true
                })

                ESX.TriggerServerCallback('netr_garages:getVehiclesInGarage', function (vehicles)

                  for i=1, #vehicles, 1 do
                    SendNUIMessage({
                      addcar = true,
                      number = i,
                      model = vehicles[i].plate,
                      name = GetDisplayNameFromVehicleModel(vehicles[i].model)
                    })
                  end

                end)

                openGui()

              end

            end
          end

          --WarMenu.OpenMenu('Parking')

        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end
  end
end)

-- Open Gui and Focus NUI
function openGui()
  SetNuiFocus(true, true)
  SendNUIMessage({openBank = true})
end

-- Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openBank = false})
  bankOpen = false
  atmOpen = false
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

-- NUI Callback Methods
RegisterNUICallback('pullCar', function(data, cb)

  local playerPed  = GetPlayerPed(-1)

  ESX.TriggerServerCallback('netr_garages:checkIfVehicleIsOwned', function (owned)

			local spawnCoords  = {
				x = CurrentGarage.Marker.x,
				y = CurrentGarage.Marker.y,
				z = CurrentGarage.Marker.z,
			}

      TriggerServerEvent("netr_garages:removeCarFromParking", owned.plate)

      ESX.Game.SpawnVehicle(owned.model, spawnCoords, 20, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        ESX.Game.SetVehicleProperties(vehicle, owned)
      end)

  end, data.model)

  closeGui()
  cb('ok')
end)

Citizen.CreateThread(function()

	WarMenu.CreateMenu('Parking', 'My Vehicles')
	WarMenu.SetSubTitle('Parking', 'Vehicle Parking')

	WarMenu.CreateSubMenu('stored', 'Parking', 'Stored Vehicles')
  WarMenu.CreateSubMenu('closeMenu', 'stored', 'Are you sure?')
  WarMenu.CreateSubMenu('park', 'Parking', 'Do you want to park this vehicle?')

	WarMenu.SetTitleBackgroundColor('Parking', 120,120,120,255)
	WarMenu.SetTitleBackgroundColor('stored', 120,120,120,255)
	WarMenu.SetTitleBackgroundColor('closeMenu', 120,120,120,255)
	
	WarMenu.SetMenuBackgroundColor('Parking', 0,0,0,220)
	WarMenu.SetMenuBackgroundColor('stored', 0,0,0,220)
	WarMenu.SetMenuBackgroundColor('closeMenu', 0,0,0,220)
	
  WarMenu.CreateSubMenu('Banger', 'stored', 'Fuckin Banger')

end)


function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end


AddEventHandler('netr_garages:hasEnteredMarker', function (zone)

    CurrentAction     = 'parking_menu'

end)

AddEventHandler('netr_garages:hasExitedMarker', function (zone)
  if IsInShopMenu then
    DisplayHelpText("Closed")
    WarMenu.CloseMenu()
    IsInShopMenu = false
    CurrentGarage = nil
  end

  CurrentAction = nil
end)


