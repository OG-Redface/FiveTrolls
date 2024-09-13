local resourceName = GetCurrentResourceName()
local currentVersion = GetResourceVersion(resourceName)
local versionURL = "https://raw.githubusercontent.com/OG-Redface/FiveTrolls/master/version.txt"

-- Version check function
Citizen.CreateThread(function()
    PerformHttpRequest(versionURL, function(err, text, headers)
        if err == 200 then
            local latestVersion = text:gsub("%s+", "") -- Clean up any extra spaces or line breaks
            if currentVersion ~= latestVersion then
                print("^1[WARNING] ^0" ..
                    resourceName ..
                    " is outdated! Current version: " .. currentVersion .. ", Latest version: " .. latestVersion)
                print("^3Please update your resource to the latest version!^0")
            else
                print("^2" .. resourceName .. " is up-to-date! Version: " .. currentVersion .. "^0")
            end
        else
            print("^1[ERROR] ^0Unable to check for updates for " .. resourceName .. ". HTTP Error code: " .. err)
        end
    end, "GET", "")
end)
