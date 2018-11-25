ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)
    
end)


ESX.RegisterServerCallback('netr_garages:getOwnedVehicles', function (source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}

      for i=1, #result, 1 do
        local vehicleData = json.decode(result[i].vehicle)
        table.insert(vehicles, vehicleData)
      end

      cb(vehicles)
    end
  )
end)

ESX.RegisterServerCallback('netr_garages:checkIfVehicleIsOwned', function (source, cb, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (owner = @owner AND plate = @plate)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function (result)
		if result[1] ~= nil then
			cb(json.decode(result[1].vehicle))
		else
			cb(nil)
		end
	end)
end)

--[[
ESX.RegisterServerCallback('netr_garages:checkIfVehicleIsOwned', function (source, cb, plate)

  local xPlayer = ESX.GetPlayerFromId(source)
  local found = nil
  local vehicleData = nil

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}

      for i=1, #result, 1 do
        vehicleData = json.decode(result[i].vehicle)
        if vehicleData.plate == plate then
          found = true
          cb(vehicleData)
          break
        end
      end

      if not found then
        cb(nil)
      end
    end
  )
end)]]

RegisterServerEvent('netr_garages:updateOwnedVehicle')
AddEventHandler('netr_garages:updateOwnedVehicle', function(vehicleProps)
 
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(source)
 
 	MySQL.Async.fetchAll(
 		'SELECT * FROM owned_vehicles WHERE owner = @owner',
 		{
 			['@owner'] = xPlayer.identifier
 		},
 		function(result)
 
 			local foundVehicleId = nil
 
 			for i=1, #result, 1 do
 				
 				local vehicle = json.decode(result[i].vehicle)
 				
 				if vehicle.plate == vehicleProps.plate then
 					foundVehicleId = result[i].id
 					break
 				end
 
 			end
 
 			if foundVehicleId ~= nil then

 				MySQL.Async.execute(
 					'UPDATE owned_vehicles SET vehicle = @vehicle WHERE id = @id',
 					{
						['@vehicle'] = json.encode(vehicleProps),
						['@id']      = foundVehicleId
 					}
 				)
 
 			end
 
 		end
 	)
 
 end)


RegisterServerEvent('netr_garages:addCarToParking')
AddEventHandler('netr_garages:addCarToParking', function(vehicleProps)

	local xPlayer = ESX.GetPlayerFromId(source)

	if vehicleProps ~= nil then

		MySQL.Async.execute(
			'INSERT INTO `user_parkings` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)',
			{
				['@identifier']   = xPlayer.identifier,
        ['@plate']        = vehicleProps.plate,
				['@vehicle']      = json.encode(vehicleProps)
			}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_stored'))
			end
		)

	end

end)

RegisterServerEvent('netr_garages:removeCarFromParking')
AddEventHandler('netr_garages:removeCarFromParking', function(plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then

		MySQL.Async.execute(
			'DELETE FROM `user_parkings` WHERE `identifier` = @identifier AND `plate` = @plate',
			{
				['@identifier'] = xPlayer.identifier,
        ['@plate'] = plate
			}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_released'))
			end
		)

	end

end)


RegisterServerEvent('netr_garages:getCustomPlate')
AddEventHandler('netr_garages:getCustomPlate', function(plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then

    MySQL.Async.fetchAll(
      'SELECT `plate_name` FROM custom_plate WHERE original_plate = @plate',
      {
        ['@plate'] = plate
      },
      function(result)
        return result[1].plate_name
    end)

	end

end)


ESX.RegisterServerCallback('netr_garages:getVehiclesInGarage', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM `user_parkings` WHERE `identifier` = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local vehicles = {}

			for i=1, #result, 1 do
        local vehicleData = json.decode(result[i].vehicle)
        table.insert(vehicles, vehicleData)
			end

			cb(vehicles)

		end
	)

end)

--[[ runs everytime the server is restarted]]
--[[ 

  adds all user owned cars into the parking garage table so people can pull their cars out


function parkAllOwnedVehicles()

  MySQL.ready(function ()

    MySQL.Sync.execute(
      'DELETE FROM `user_parkings`',
      {
      }, function(rowsChanged)
      end
    )

    print('deleteing vehs')

    local result = MySQL.Sync.fetchAll(
      'SELECT * FROM owned_vehicles',
      {})

    local foundVehicleId = nil

    for i=1, #result, 1 do
    
      local vehicle = result[i].vehicle
      local identifier = result[i].owner

      MySQL.Sync.execute(
        'INSERT INTO `user_parkings` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)',
        {
          ['@identifier'] = identifier,
          ['@plate'] = json.decode(vehicle).plate,
          ['@vehicle']     = vehicle
        })

    end
    
  end)


end
]]

RegisterServerEvent('netr_garages:updateInventory')
AddEventHandler('netr_garages:updateInventory', function()
	parkAllOwnedVehicles()
end)

function parkAllOwnedVehicles()
	Citizen.CreateThread(function()
		MySQL.Async.execute('TRUNCATE user_parkings')

		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {}, function(result)
			for i=1, #result, 1 do
				MySQL.Async.execute('INSERT INTO `user_parkings` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)', {
					['@identifier'] = result[i].owner,
					['@plate']      = result[i].plate,
					['@vehicle']    = result[i].vehicle
				})
			end
		end)

		print('netr_garages: loaded garage hive!')
		TriggerClientEvent('chatMessage', -1, 'SYSTEM', { 0, 0, 255 }, 'Garaż załadowany!')
		--TriggerClientEvent("chatMessage", -1, "Garaż załadowany!", {255, 0, 0})
	end)
end


AddEventHandler('onMySQLReady', function()
	hasSqlRun = true
	Citizen.CreateThread(function()
		parkAllOwnedVehicles()
	end)
end)

-- extremely useful when restarting script mid-game
Citizen.CreateThread(function()
	Citizen.Wait(10000) -- hopefully enough for connection to the SQL server

	if not hasSqlRun then
		parkAllOwnedVehicles()
		hasSqlRun = true
	end
end)

TriggerEvent('es:addGroupCommand', 'garload', 'superadmin', function (source, args, user)
	parkAllOwnedVehicles()
end, function (source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', { 255, 0, 0 }, 'Insufficienct permissions!')
end, { help = 'Reload the garage database' })
