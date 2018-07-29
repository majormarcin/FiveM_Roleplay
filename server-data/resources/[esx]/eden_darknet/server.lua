ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'darknet', "Dark Net", true, false, true, true)

RegisterServerEvent('esx_phone:reload')
AddEventHandler('esx_phone:reload', function(phoneNumber)

	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local darkPhone = xPlayer.getInventoryItem('black_chip')

	if darkPhone.count > 0 then
		if xPlayer.job.name ~= 'police' then
			TriggerEvent('esx_phone:addSource', 'darknet', _source)
		end
	end
end)

