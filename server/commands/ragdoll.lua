RegisterCommand('ragdoll', function(source, args)
    -- Check if the command is run from RCON (source = 0)
    if source == 0 then
        -- Check if the command has an argument (server ID)
        if args[1] then
            local targetPlayerId = tonumber(args[1])

            -- Check if the player with the given server ID exists
            if GetPlayerName(targetPlayerId) then
                -- Trigger a client event to blow up the player
                TriggerClientEvent('ragdollPlayer', targetPlayerId)
                print("Seems like " .. GetPlayerName(targetPlayerId) .. " can't walk straight!")
            else
                print("Player with server ID " .. targetPlayerId .. " not found.")
            end
        else
            TriggerClientEvent('ragdollPlayer', -1)
            print("No server ID provided. Everyone will now flop!")
        end
    else
        -- Command was run by a player in-game
        if IsAdmin(source, Config.AdminDiscordID) then
            if args[1] then
                local targetPlayerId = tonumber(args[1])

                -- Check if the player with the given server ID exists
                if GetPlayerName(targetPlayerId) then
                    -- Trigger a client event to blow up the player
                    TriggerClientEvent('ragdollPlayer', targetPlayerId)

                    -- Notify the admin that the player has been blown up
                    SendNotification(source, "Seems like " .. GetPlayerName(targetPlayerId) .. " can't walk straight!")
                else
                    -- Notify the admin if the player ID is invalid
                    SendNotification(source, "Player with server ID " .. targetPlayerId .. " not found.")
                end
            else
                TriggerClientEvent('ragdollPlayer', -1)
                -- Notify the admin if no server ID was provided
                SendNotification(source, "No server ID provided. Everyone will now flop!")
            end
        else
            -- Notify the player that they do not have permission to use the command
            SendNotification(source, "You do not have permission to use this command.")
        end
    end
end, false)