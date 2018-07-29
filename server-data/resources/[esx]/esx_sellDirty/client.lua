ESX                 = nil
local myJob     = nil
local selling       = false
local has       = false
local copsc     = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
  TriggerServerEvent('fetchjob')
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('getjob')
AddEventHandler('getjob', function(jobName)
  myJob = jobName
end)


currentped = nil
Citizen.CreateThread(function()

while true do
  Wait(0)
  local player = GetPlayerPed(-1)
  local playerloc = GetEntityCoords(player, 0)
  local handle, ped = FindFirstPed()
  repeat
    success, ped = FindNextPed(handle)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
      if DoesEntityExist(ped)then
        if IsPedDeadOrDying(ped) == false then
          if IsPedInAnyVehicle(ped) == false then
            local pedType = GetPedType(ped)
            if pedType ~= 28 and IsPedAPlayer(ped) == false then
              currentped = pos
              if distance <= 2 and ped  ~= GetPlayerPed(-1) and ped ~= oldped then
                TriggerServerEvent('checkD')
                if has == true then
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Press ~g~E ~w~to sell drugs", 255, 255, 255, 255)
                  if IsControlJustPressed(1, 86) then
                      oldped = ped
                      SetEntityAsMissionEntity(ped)
                      TaskStandStill(ped, 9.0)
                      pos1 = GetEntityCoords(ped)
                      TriggerServerEvent('drugs:trigger')
                      Citizen.Wait(2850)
                      TriggerEvent('sell')
                      SetPedAsNoLongerNeeded(oldped)
                  end
                end
              end
            end
          end
        end
      end
    end
  until not success
  EndFindPed(handle)
end
end)

RegisterNetEvent('sell')
AddEventHandler('sell', function()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= 2 then
      TriggerServerEvent('drugs:sell')
    elseif distance > 2 then
      TriggerServerEvent('sell_dis')
    end
end)


RegisterNetEvent('checkR')
AddEventHandler('checkR', function(test)
  has = test
end)

RegisterNetEvent('notifyc')
AddEventHandler('notifyc', function()

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
    if crossing ~= nil then
      crossing = GetStreetNameFromHashKey(crossing)

      local coords      = GetEntityCoords(GetPlayerPed(-1))

      TriggerServerEvent('esx_phone:send', "police", "boi sell drugs on " .. streetName .. " and " .. crossing, true, {
        x = coords.x,
        y = coords.y,
        z = coords.z
      })

    else
      TriggerServerEvent('esx_phone:send', "police", "boi sell drugs on " .. streetName, true, {
        x = coords.x,
        y = coords.y,
        z = coords.z
      })
    end
end)

RegisterNetEvent('animation')
AddEventHandler('animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(750)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
