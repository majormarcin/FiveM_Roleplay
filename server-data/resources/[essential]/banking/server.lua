local balances = {}

AddEventHandler('es:playerLoaded', function(source, user)
    balances[source] = user.getBank()

    TriggerClientEvent('banking:updateBalance', source, user.getBank())
end)

RegisterServerEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    balances[source] = user.getBank()

    TriggerClientEvent('banking:updateBalance', source, user.getBank())
  end)
end)

AddEventHandler('playerDropped', function()
  balances[source] = nil
end)

-- HELPER FUNCTIONS
function bankBalance(player)
  return exports.essentialmode:getPlayerFromId(player).getBank()
end

function deposit(player, amount)
  local bankbalance = bankBalance(player)
  local new_balance = bankbalance + math.abs(amount)
  balances[player] = new_balance

  local user = exports.essentialmode:getPlayerFromId(player)
  TriggerClientEvent("banking:updateBalance", source, new_balance)
  user.addBank(math.abs(amount))
  user.removeMoney(math.abs(amount))
end

function withdraw(player, amount)
  local bankbalance = bankBalance(player)
  local new_balance = bankbalance - math.abs(amount)
  balances[player] = new_balance

  local user = exports.essentialmode:getPlayerFromId(player)
  TriggerClientEvent("banking:updateBalance", source, new_balance)
  user.removeBank(math.abs(amount))
  user.addMoney(math.abs(amount))
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.abs(math.floor(num * mult + 0.5) / mult)
end

local notAllowedToDeposit = {}

AddEventHandler('bank:addNotAllowed', function(pl)
  notAllowedToDeposit[pl] = true

  local savedSource = pl
  SetTimeout(300000, function()
    notAllowedToDeposit[savedSource] = nil
  end)
end)

-- Bank Deposit

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  if not amount then return end

  TriggerEvent('es:getPlayerFromId', source, function(user)
    if notAllowedToDeposit[source] == nil then
      local rounded = math.ceil(tonumber(amount))
      if(string.len(rounded) >= 9) then
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Input too high^0")
      else
      	if(rounded <= user.getMoney()) then
          TriggerClientEvent("banking:updateBalance", source, (user.getBank() + rounded))
          TriggerClientEvent("banking:addBalance", source, rounded)
          
          deposit(source, rounded)
          local new_balance = user.getBank()
        else
          TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough cash!^0")
        end
      end
    else
        TriggerClientEvent('es_rp:notify', source, "~r~You cannot deposit recently stolen money, please wait 5 minutes.")
    end
  end)
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  if not amount then return end
  
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local rounded = round(tonumber(amount), 0)
      if(string.len(rounded) >= 9) then
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Input too high^0")
      else
        local bankbalance = user.getBank()
        if(tonumber(rounded) <= tonumber(bankbalance)) then
          TriggerClientEvent("banking:updateBalance", source, (user.getBank() - rounded))
          TriggerClientEvent("banking:removeBalance", source, rounded)

          withdraw(source, rounded)
        else
          TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in account!^0")
        end
      end
  end)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(fromPlayer, toPlayer, amount)
  if tonumber(fromPlayer) == tonumber(toPlayer) then
    TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Cannot transfer to self^0")
  else
    TriggerEvent('es:getPlayerFromId', fromPlayer, function(user)
        local rounded = round(tonumber(amount), 0)
        if(string.len(rounded) >= 9) then
          TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Input too high^0")
        else
          local bankbalance = user.getBank()
          if(tonumber(rounded) <= tonumber(bankbalance)) then
            TriggerClientEvent("banking:updateBalance", source, (user.getBank() - rounded))
            TriggerClientEvent("banking:removeBalance", source, rounded)

            withdraw(source, rounded)
            TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Transferred: ~r~-$".. rounded .." ~n~~s~New Balance: ~g~$" .. new_balance)
            TriggerEvent('es:getPlayerFromId', toPlayer, function(user2)
              TriggerClientEvent("banking:updateBalance", toPlayer, (user2.getBank() + rounded))
              TriggerClientEvent("banking:addBalance", toPlayer, rounded)

                local recipient = user2.get('identifier')
                deposit(toPlayer, rounded)
                new_balance2 = user2.getBank()
            end)
          else
            TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in account!^0")
          end
        end
    end)
  end
end)

RegisterServerEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= tonumber(amount)) then
			TriggerEvent('es:getPlayerFromId', toPlayer, function(recipient)
				recipient.addMoney(amount)
			end)
		else
			if (tonumber(user.getMoney()) < tonumber(amount)) then
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in wallet!^0")
			end
		end
	end)
end)

AddEventHandler('es:playerLoaded', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local bankbalance = user.getBank()
      TriggerClientEvent("banking:updateBalance", source, bankbalance)
      user.displayBank(bankbalance)
    end)
end)
