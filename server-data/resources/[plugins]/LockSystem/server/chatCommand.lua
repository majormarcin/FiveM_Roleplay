if(globalConf["SERVER"].enableGiveKey)then
    RegisterCommand('givekey', function(source, args, rawCommand)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]

        if(args[1])then
            local targetId = args[1]
            local targetIdentifier = GetPlayerIdentifiers(targetId)[1]
            if(targetIdentifier)then
                if(targetIdentifier ~= identifier)then
                    if(args[2])then
                        local plate = string.lower(args[2])
                        if(owners[plate])then
                            if(owners[plate] == identifier)then
                                alreadyHas = false
                                for k, v in pairs(secondOwners) do
                                    if(k == plate)then
                                        for _, val in ipairs(v) do
                                            if(val == targetIdentifier)then
                                                alreadyHas = true
                                            end
                                        end
                                    end
                                end

                                if(not alreadyHas)then
                                    TriggerClientEvent("ls:giveKeys", targetIdentifier, plate)
                                    TriggerEvent("ls:addSecondOwner", targetIdentifier, plate)

                                    TriggerClientEvent("ls:notify", targetId, "Dostałeś klucze do pojazdu o rejestracji " .. plate .. " od " .. GetPlayerName(src))
                                    TriggerClientEvent("ls:notify", src, "Dałeś klucze do pojazdu " .. plate .. " dla " .. GetPlayerName(targetId))
                                else
                                    TriggerClientEvent("ls:notify", src, "Ta osoba ma już klucze od twojego auta.")
                                    TriggerClientEvent("ls:notify", targetId, GetPlayerName(src) .. " próbował ci dać klucze, ale już je miałeś")
                                end
                            else
                                TriggerClientEvent("ls:notify", src, "To nie jest twój pojazd")
                            end
                        else
                            TriggerClientEvent("ls:notify", src, "Pojazd z tą tablicą nie istnieje")
                        end
                    else
                        TriggerClientEvent("ls:notify", src, "Drugi brakujący argument : /givekey <id> <plate>")
                    end
                else
                    TriggerClientEvent("ls:notify", src, "Nie możesz celować w siebie")
                end
            else
                TriggerClientEvent("ls:notify", src, "Gracz nieodnaleziony")
            end
        else
            TriggerClientEvent("ls:notify", src, 'Pierwszy brakujący argument : /givekey <id> <plate>')
        end

        CancelEvent()
    end)
end
