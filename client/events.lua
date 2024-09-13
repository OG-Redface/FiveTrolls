AddEventHandler('playerSpawned', function()
    -- Notify the server when a player has loaded
    TriggerServerEvent('MrRedDev:checkAdminStatus')
end)