-- Spawn two squad vehicles with Merryweather security to attack a specific player by server ID
RegisterCommand('mw', function(source, args)
    if source == 0 then
        if args[1] then
            local targetPlayerId = tonumber(args[1])

            if GetPlayerName(targetPlayerId) then
                -- Trigger the client event to spawn Merryweather security for the target player
                TriggerClientEvent('spawnMerryweatherSquads', targetPlayerId)
                print("A bounty has been place on " .. GetPlayerName(targetPlayerId) .. "!")
            else
                print("Player with server ID " .. targetPlayerId .. " not found.")
            end
        else
            print("No server ID provided. Usage: /mw <serverID>")
        end
    else
        if IsAdmin(source, Config.AdminDiscordID, Config.AdminRoleID) then
            if args[1] then
                local targetPlayerId = tonumber(args[1])

                if GetPlayerName(targetPlayerId) then
                    -- Trigger the client event to spawn Merryweather security for the target player
                    TriggerClientEvent('spawnMerryweatherSquads', targetPlayerId)
                    SendNotification(source, "A bounty has been place on " .. GetPlayerName(targetPlayerId) .. "!")
                else
                    SendNotification(source, "Player with server ID " .. targetPlayerId .. " not found.")
                end
            else
                SendNotification(source, "No server ID provided. Usage: /mw <serverID>")
            end
        else
            SendNotification(source, "You do not have permission to use this command.")
        end
    end
end, false)
