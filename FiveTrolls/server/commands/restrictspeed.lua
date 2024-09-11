local speedLimiterActive = false
local speedLimiterStatusById = {} -- Track speed limiter status for specific player IDs (server ID based)

-- Command to toggle speed limiter for a specific player by server ID
RegisterCommand('restrictspeed', function(source, args)
    -- Check if the command is run from RCON (source = 0)
    if source == 0 then
        -- Check if an argument (server ID) is provided
        if args[1] then
            local targetPlayerId = tonumber(args[1])

            if GetPlayerName(targetPlayerId) then
                -- Toggle the speed limiter for this player
                if not speedLimiterStatusById[targetPlayerId] then
                    speedLimiterStatusById[targetPlayerId] = true
                    TriggerClientEvent('restrictSpeed', targetPlayerId)
                    print("Speed restriction is now ^2ON^0 for " .. GetPlayerName(targetPlayerId))
                else
                    speedLimiterStatusById[targetPlayerId] = false
                    TriggerClientEvent('restrictSpeed', targetPlayerId)
                    print("Speed restriction is now ^1OFF^0 for " .. GetPlayerName(targetPlayerId))
                end
            else
                print("Player with server ID " .. targetPlayerId .. " not found.")
            end
        else
            if not speedLimiterActive then
                speedLimiterActive = true
                print("Speed restriction is now ^2ON^0 for everyone!")
            else
                speedLimiterActive = false
                print("Speed restriction is now ^1OFF^0 for everyone!")
            end
            TriggerClientEvent('restrictSpeed', -1)
        end
    else
        -- Command was run by a player in-game
        if IsAdmin(source, Config.AdminDiscordID) then
            -- Check if an argument (server ID) is provided
            if args[1] then
                local targetPlayerId = tonumber(args[1])

                if GetPlayerName(targetPlayerId) then
                    -- Toggle the speed limiter for this player
                    if not speedLimiterStatusById[targetPlayerId] then
                        speedLimiterStatusById[targetPlayerId] = true
                        TriggerClientEvent('restrictSpeed', targetPlayerId)
                        SendNotification(source, "Speed restriction is now ^2ON^0 for " .. GetPlayerName(targetPlayerId))
                    else
                        speedLimiterStatusById[targetPlayerId] = false
                        TriggerClientEvent('restrictSpeed', targetPlayerId)
                        SendNotification(source, "Speed restriction is now ^1OFF^0 for " .. GetPlayerName(targetPlayerId))
                    end
                else
                    SendNotification(source, "Player with server ID " .. targetPlayerId .. " not found.")
                end
            else
                if not speedLimiterActive then
                    speedLimiterActive = true
                    SendNotification(source, "Speed restriction is now ^2ON^0 for everyone!")
                else
                    speedLimiterActive = false
                    SendNotificaiton(source, "Speed restriction is now ^OFF^0 for everyone!")
                end
                TriggerClientEvent('restrictSpeed', -1)
            end
        else
            -- Notify the player that they do not have permission to use the command
            SendNotification(source, "You do not have permission to use this command.")
        end
    end
end, false)
