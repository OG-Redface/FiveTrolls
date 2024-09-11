RegisterNetEvent('MrRedDev:TimerUp')
AddEventHandler('MrRedDev:TimerUp', function(source, targetName, isFake)
    if source ~= 0 then
        local message = isFake and targetName .. " has been faked out with a bomb!" or targetName .. " has been blown up to pieces!"
        SendNotification(source, message)
    else
        local message = isFake and targetName .. " has been faked out with a bomb!" or targetName .. " has been blown up to pieces!"
        print(message)
    end
end)
