RegisterCommand('blowup', function(source, args)
    -- Check if the command is run from RCON (source = 0)
    if source == 0 then
        -- Check if the command has an argument (server ID)
        if args[1] then
            local targetPlayerId = tonumber(args[1])

            -- Check if the player with the given server ID exists
            if GetPlayerName(targetPlayerId) then
                -- Trigger a client event to blow up the player
                TriggerClientEvent('startBombTimer', targetPlayerId, source, false)
                print(GetPlayerName(targetPlayerId) .. "'s bomb countdown has started...")
            else
                print("Player with server ID " .. targetPlayerId .. " not found.")
            end
        else
            TriggerClientEvent('startBombTimer', -1, source, false)
            print("No server ID provided. Blowing the whole server to pieces...")
        end
    else
        -- Command was run by a player in-game
        if PlayerAdminStatus[source] then
            if args[1] then
                local targetPlayerId = tonumber(args[1])

                -- Check if the player with the given server ID exists
                if GetPlayerName(targetPlayerId) then
                    -- Trigger a client event to blow up the player
                    TriggerClientEvent('startBombTimer', targetPlayerId, source, false)

                    -- Notify the admin that the player has been blown up
                    SendNotification(source, GetPlayerName(targetPlayerId) .. "'s bomb countdown has started...")
                else
                    -- Notify the admin if the player ID is invalid
                    SendNotification(source, "Player with server ID " .. targetPlayerId .. " not found.")
                end
            else
                -- Notify the admin if no server ID was provided
                TriggerClientEvent('startBombTimer', -1, source, false)
                SendNotification(source, "No server ID provided. Blowing the whole server to pieces...")
            end
        else
            -- Notify the player that they do not have permission to use the command
            SendNotification(source, "You do not have permission to use this command.")
        end
    end
end, false)
