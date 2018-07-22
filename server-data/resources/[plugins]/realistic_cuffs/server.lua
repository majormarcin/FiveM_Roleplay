-- Register the cuff command.
RegisterCommand('cuff', function(source, args)
    -- If there is at least 1 argument passed to the command ("/cuff <id>" was used), we want to...
    if args[1] ~= nil then
        -- ...cuff the player specified by the argument (server id)
        TriggerClientEvent('anim:cuff', tonumber(args[1]))
    
    -- There's no arguments passed ("/cuff" was used.) then....
    else
        --... if the source is 0, that means the server console/RCON executed the command.
        if source == 0 then
            -- We obviously want to let them know that the console cannot be cuffed!
            -- So let's put some shame on them!
            print('You can\'t cuff from the console without specifying a player to cuff, you idiot!')
        
        -- if they were smart enough to be an actual player, but still not specify who to cuff, we
        -- want to hint that they may have forgotten to provide the ID to cuff, by cuffing the player themselves.
        -- lets see how long it takes before this command is ran again because the realized their foolish mistake! hehehe
        else
            -- Cuff that idiot!
            TriggerClientEvent('anim:cuff', source)
        end
    end
    
    -- And last but not least, make it restricted, only people with the "command.cuff" permission can use this command.
end, true)
