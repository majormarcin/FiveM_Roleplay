ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_godirtyjob:pay')
AddEventHandler('esx_godirtyjob:pay', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(tonumber(amount)) -- Add Clean Money
	xPlayer.removeAccountMoney('black_money', amount) -- Removes Dirty Money
end)

--------------------------------------------------------------------------
-----------------MODIFIED BY  K R I Z F R O S T---------------------------
--------------------------------------------------------------------------
----- MONEY LAUNDERING SCRIPT RELEASED CREDITS TO ORIGINAL CREATOR--------
----- OF ESX_POSTALJOB RE WORKED AND MODIFIED BY KRIZFROST ---------------
-------------------------------------------------------------------------- 