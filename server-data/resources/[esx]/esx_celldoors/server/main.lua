ESX				= nil
local DoorInfo	= {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_celldoors:updateState')
AddEventHandler('esx_celldoors:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name ~= 'police' then
		print('esx_celldoors: ' .. xPlayer.identifier .. ' attempted to open a locked door using an injector!')
		return
	end

	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('esx_celldoors:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('esx_celldoors:getDoorInfo', function(source, cb)
	local amount = 0
	for i=1, #Config.DoorList, 1 do
		amount = amount + 1
	end

	cb(DoorInfo, amount)
end)