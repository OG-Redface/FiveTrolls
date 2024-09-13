function IsAdmin(source, adminUserID, adminRoleID)
    local playerDiscordID = GetDiscordIdentifier(source)                     -- Get player's Discord ID
    local playerRoleIDs = exports.Badger_Discord_API:GetDiscordRoles(source) -- Get player's Discord roles

    -- Check if the player has the allowed user ID or the allowed role ID
    if playerDiscordID == adminUserID then
        return true -- Player is the allowed user
    elseif playerRoleIDs ~= nil then
        for _, roleID in pairs(playerRoleIDs) do
            if roleID == adminRoleID then
                return true -- Player has the allowed role
            end
        end
    end

    return false -- Player is not allowed to use the command
end

-- Grab the player's Discord ID
function GetDiscordIdentifier(source)
    local identifiers = GetPlayerIdentifiers(source)
    for _, identifier in ipairs(identifiers) do
        if string.find(identifier, "discord:") then
            return string.sub(identifier, 9)
        end
    end
    return nil
end

-- Function to send a message to the admin
function SendNotification(source, message, color)
    TriggerClientEvent('chat:addMessage', source, {
        color = color or { 255, 0, 0 }, -- Default red color if none provided
        multiline = true,
        args = { Config.NotificationAuthor, message }
    })
end

-- Grab the current version from fxmanifest.lua
function GetResourceVersion(resourceName)
    return GetResourceMetadata(resourceName, 'version', 0)
end
