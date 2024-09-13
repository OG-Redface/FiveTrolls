RegisterCommand('playsound', function(source, args)
    -- Check if the command is run from RCON (source = 0)
    if source == 0 then
        -- Check if the command has an argument (server ID)
        if args[1] then
            local targetPlayerId = tonumber(args[1])

            -- Check if the player with the given server ID exists
            if GetPlayerName(targetPlayerId) then
                -- Trigger a client event to play sounds for the player
                TriggerClientEvent('startBombTimer', targetPlayerId, source, true)
                print("Faking a bomb countdown for " .. GetPlayerName(targetPlayerId) .. "...")
            else
                print("Player with server ID " .. targetPlayerId .. " not found.")
            end
        else
            TriggerClientEvent('startBombTimer', -1, source, true)
            print("Faking a bomb countdown for everyone!")
        end
    else
        -- Command was run by a player in-game
        if IsAdmin(source, Config.AdminDiscordID, Config.AdminRoleID) then
            if args[1] then
                local targetPlayerId = tonumber(args[1])

                -- Check if the player with the given server ID exists
                if GetPlayerName(targetPlayerId) then
                    -- Trigger a client event to play sounds for the player
                    TriggerClientEvent('startBombTimer', targetPlayerId, source, true)

                    -- Notify the admin
                    SendNotification(source, "Faking a bomb countdown for " .. GetPlayerName(targetPlayerId) .. "...")
                else
                    -- Notify the admin if the player ID is invalid
                    SendNotification(source, "Player with server ID " .. targetPlayerId .. " not found.")
                end
            else
                TriggerClientEvent('startBombTimer', -1, source, true)
                SendNotification(source, "Faking a bomb countdown for everyone!")
            end
        else
            -- Notify the player that they do not have permission to use the command
            SendNotification(source, "You do not have permission to use this command.")
        end
    end
end, false)
