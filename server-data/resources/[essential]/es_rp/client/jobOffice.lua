local offices = {
	{ ['x'] = -268.85232543945, ['y'] = -956.97265625, ['z'] = 31.223134994507 }
}

local jobGarages = {
	{ ['x'] = 453.12744140625, ['y'] = -1020.1177978516, ['z'] = 28.369821548462 },
	{ ['x'] = 1872.3110351563, ['y'] = 3684.5046386719, ['z'] = 33.5915184021 },
	{ ['x'] = 320.97674560547, ['y'] = -551.46643066406, ['z'] = 28.743801116943 },
	{ ['x'] = -313.44668579102, ['y'] = -956.69598388672, ['z'] = 31.08060836792 },
}

local jobOfficeJobs = {
	JOB_CIVILIAN,
	JOB_POLICE,
	JOB_EMS,
	JOB_MECHANIC,
	JOB_TRUCKER
}

jobOfficeOpen = false
jobGarageOpen = false
local option = 1

job = "Civilian"

local function CreateNotification(str, img, title, subtitle)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(str)
	if img and title and subtitle then
		SetNotificationMessage(img, img, false, 4, title, subtitle)
	end
	DrawNotification(false, false)
end

FreezeEntityPosition(GetPlayerPed(-1), false)

RegisterNUICallback('choose_job', function(data, cb)
	local job = data.job

	TriggerServerEvent('es_rp:changeJob', job)
end)

local allowedToSpawn = true

RegisterNUICallback('spawn_vehicle', function(data, cb)
	if allowedToSpawn then
		jobGarageOpen = false
		SendNUIMessage({
			type = "garageSwitch",
			enable = jobGarageOpen
		})

		SetNuiFocus(false)

		allowedToSpawn = false
		TriggerEvent('es_admin:spawnVehicle', data.vehicle)
		TriggerEvent('es_rp:notify', "Vehicles spawned ~b~" .. data.vehicle)
		Citizen.CreateThread(function()
			Citizen.Wait(240000)
			allowedToSpawn = true
			return
		end)
	else
		TriggerEvent('es_rp:notify', "~r~You can spawn a job vehicle every 4 minutes")
	end
end)

RegisterNetEvent('es_rp:setJob')
AddEventHandler('es_rp:setJob', function(e)
	if job ~= e then
		jobOfficeOpen = not jobOfficeOpen

		SendNUIMessage({
			type = "jobSwitch",
			enable = jobOfficeOpen
		})
		job = e

		SetNuiFocus(false)
	else
		TriggerEvent('es_rp:notify', "~r~You currently have this job")
	end
end)

function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

RegisterNetEvent('es_rp:notify')
AddEventHandler('es_rp:notify', function(str, img, title, subtitle)
	CreateNotification(str, img, title, subtitle)
end)

function drawText(top, left, size, str, color, font, center)
	SetTextFont(font or 0)
	SetTextScale(1, size)
	SetTextColour(color[1], color[2], color[3], color[4])
	if center then SetTextCentre(true) end
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(tostring(str))
	EndTextCommandDisplayText(left, top)
end

function drawBox(top, left, height, width, colour)
	DrawRect(left, top,  width,  height, colour[1], colour[2], colour[3], colour[4])
end

local openVehicles = false

Citizen.CreateThread(function()
	for k,v in ipairs(offices)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 366)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Job Office")
		EndTextCommandSetBlipName(blip)
	end

	while true do
		Wait(0)

		local p = GetEntityCoords(GetPlayerPed(-1), true)

		drawText(0.95, 0.16, 0.4, "Job ~b~" .. job, {255, 255, 255, 255}, 0, false)

		if not openVehicles then
			for i in ipairs(jobGarages)do
				if Vdist(p.x, p.y, p.z, jobGarages[i].x, jobGarages[i].y, jobGarages[i].z) < 30.0 then
					DrawMarker(1, jobGarages[i].x, jobGarages[i].y, jobGarages[i].z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 255, 255,155, 0,0, 0,0)
				
					if Vdist(p.x, p.y, p.z, jobGarages[i].x, jobGarages[i].y, jobGarages[i].z) < 3.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to get a job vehicle")

						if(IsControlJustReleased(1, 51))then
							if JOB_VEHICLES[job] then
								if not IsPedInAnyVehicle(GetPlayerPed(false), false) then
									jobGarageOpen = true
									SendNUIMessage({
										type = "garageUpdate",
										vehicles = json.encode(JOB_VEHICLES[job])
									})
									SendNUIMessage({
										type = "garageSwitch",
										enable = jobGarageOpen
									})

									SetNuiFocus(true, true)
								else
									TriggerEvent('es_rp:notify', "~r~You cannot be in a vehicle to do this")
								end
							else
								TriggerEvent('es_rp:notify', "~r~Your job doesn't have any available job vehicles")
							end
						end
					end
				end
			end			
		end

		if not jobOfficeOpen then
			for i in ipairs(offices)do
				if Vdist(p.x, p.y, p.z, offices[i].x, offices[i].y, offices[i].z) < 30.0 then
					DrawMarker(1, offices[i].x, offices[i].y, offices[i].z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 255, 255,155, 0,0, 0,0)
				
					if Vdist(p.x, p.y, p.z, offices[i].x, offices[i].y, offices[i].z) < 3.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to change job")

						if(IsControlJustReleased(1, 51))then
							option = 1
							jobOfficeOpen = true
							SendNUIMessage({
								type = "jobSwitch",
								enable = jobOfficeOpen
							})
							SetNuiFocus(true, true)
						end
					end
				end
			end
		end
	end
end)