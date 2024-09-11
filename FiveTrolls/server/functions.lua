function IsAdmin(source, adminDiscordID)
    local identifiers = GetPlayerIdentifiers(source)

    -- Loop through the player's identifiers to find their Discord ID
    for _, id in ipairs(identifiers) do
        if string.find(id, "discord:") then
            local discordId = string.sub(id, 9) -- Extract the Discord ID
            if discordId == adminDiscordID then
                return true                     -- Player is an admin
            end
        end
    end

    return false -- Player is not an admin
end

-- Function to send a message to the admin
function SendNotification(source, message, color)
    TriggerClientEvent('chat:addMessage', source, {
        color = color or { 255, 0, 0 }, -- Default red color if none provided
        multiline = true,
        args = { Config.NotificationAuthor, message }
    })
end
