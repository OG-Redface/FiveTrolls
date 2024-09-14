-- Store player admin status to a table
PlayerAdminStatus = {}

RegisterNetEvent('MrRedDev:TimerUp')
AddEventHandler('MrRedDev:TimerUp', function(source, targetName, isFake)
    if source ~= 0 then
        local message = isFake and targetName .. " has been faked out with a bomb!" or
            targetName .. " has been blown up to pieces!"
        SendNotification(source, message)
    else
        local message = isFake and targetName .. " has been faked out with a bomb!" or
            targetName .. " has been blown up to pieces!"
        print(message)
    end
end)

-- Event to check admin status when player connects
RegisterNetEvent('MrRedDev:checkAdminStatus')
AddEventHandler('MrRedDev:checkAdminStatus', function()
    local player = source

    -- Check admin status
    local isAdmin = IsAdmin(player, Config.AdminUserID, Config.AdminRoleID)

    -- Store admin status in a table
    PlayerAdminStatus[player] = isAdmin

    print("[^1FiveTrolls^0]: " .. GetPlayerName(source) .. " has admin access: " .. tostring(isAdmin))
end)

-- Clean up table when a player disconnects
AddEventHandler('playerDropped', function(reason)
    local player = source
    if PlayerAdminStatus[player] then
        PlayerAdminStatus[player] = nil
        print("[^1FiveTrolls^0]: " .. GetPlayerName(source) .. " has been dropped")
    end
end)

-- Add command suggestions for all commands
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Add suggestion for /restrictspeed command
        TriggerEvent('chat:addSuggestion', '/restrictspeed', 'Restrict speed for your friend', {
            { name = 'id', help = 'Server ID of the player (leave blank for all players)' }
        })

        -- Add suggestion for /blowup command
        TriggerEvent('chat:addSuggestion', '/blowup', 'Blow your friend up!', {
            { name = 'id', help = 'Server ID of the player (leave blank for all players)' }
        })

        -- Add suggestion for /playsound command
        TriggerEvent('chat:addSuggestion', '/playsound', 'Fake a bomb timer for your friend', {
            { name = 'id', help = 'Server ID of the player (leave blank for all players)' }
        })

        -- Add suggestion for /ragdoll command
        TriggerEvent('chat:addSuggestion', '/ragdoll', 'Ragdoll your friend', {
            { name = 'id', help = 'Server ID of the player (leave blank for all players)' }
        })

        -- Add suggestion for /kill command
        TriggerEvent('chat:addSuggestion', '/kill', 'Kill your friend', {
            { name = 'id', help = 'Server ID of the player (leave blank for all players)' }
        })

        -- Add suggestion for /mw command
        TriggerEvent('chat:addSuggestion', '/mw', 'Spawn Merryweather personnel to take out your friend', {
            { name = 'id', help = 'Server ID of the player' }
        })
    end
end)
