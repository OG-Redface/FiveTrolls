local notified = false
local speedLimiterActive = false -- This flag controls if the speed limiter is active
local playSoundActive = false    -- This flag controls if the audio playback is active
local timer = Config.Timer

-- Function to limit vehicle speed
Citizen.CreateThread(function()
    local playerPed = PlayerPedId()

    while true do
        Citizen.Wait(0)

        if speedLimiterActive then
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                local speed = GetEntitySpeed(vehicle)
                if notified then
                    DrawText3D(Config.SpeedLimiterText, 0.5, 0.35)
                end

                -- If the vehicle speed exceeds the limit, reduce it
                if speed > Config.MaxSpeed / 2.236936 then
                    SetVehicleForwardSpeed(vehicle, speed - 1)

                    -- Send a message to the player if not already notified
                    if not notified then
                        notified = true -- Set to true to avoid multiple notifications
                    end
                end
            else
                -- Reset notified status when the player exits the vehicle
                notified = false
            end
        else
            -- Also resets when the speed restriction is turned off
            notified = false
        end
    end
end)

RegisterNetEvent('killPlayer')
AddEventHandler('killPlayer', function()
    -- Get the player's ped (pedestrian entity)
    local playerPed = PlayerPedId()

    -- Set the player's health to 0 to kill them
    SetEntityHealth(playerPed, 0)
end)

RegisterNetEvent('spawnMerryweatherSquads')
AddEventHandler('spawnMerryweatherSquads', function(targetPlayerId)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetPlayerId))
    local playerCoords = GetEntityCoords(targetPed)

    -- Model and vehicle details
    local vehicleModel = GetHashKey("granger")       -- Merryweather vehicle model
    local pedModel = GetHashKey("s_m_y_blackops_01") -- Merryweather NPC model

    RequestModel(vehicleModel)
    RequestModel(pedModel)

    while not HasModelLoaded(vehicleModel) or not HasModelLoaded(pedModel) do
        Wait(1)
    end

    -- Create a relationship group for Merryweather
    AddRelationshipGroup("MERRYWEATHER_GROUP")
    SetRelationshipBetweenGroups(0, GetHashKey("MERRYWEATHER_GROUP"), GetHashKey("MERRYWEATHER_GROUP")) -- Make sure they don't attack each other

    -- Spawn 2 vehicles with Merryweather NPCs
    for i = 1, Config.MerryweatherSquads do
        local spawnOffset = 50.0 -- Offset to avoid overlapping
        local vehicle = CreateVehicle(vehicleModel, playerCoords.x + (i * 5 + spawnOffset),
            playerCoords.y + (i * 5 + spawnOffset), playerCoords.z, GetEntityHeading(targetPed), true, true)

        -- Spawn 4 Merryweather NPCs in each vehicle
        for seat = -1, 2 do -- Driver (-1) and passengers (0, 1, 2)
            local ped = CreatePedInsideVehicle(vehicle, 4, pedModel, seat, true, true)

            -- Assign them to the relationship group
            SetPedRelationshipGroupHash(ped, GetHashKey("MERRYWEATHER_GROUP"))

            -- Give them weapons
            GiveWeaponToPed(ped, GetHashKey("WEAPON_CARBINERIFLE"), 9999, false, true)
            GiveWeaponToPed(ped, GetHashKey("WEAPON_MICROSMG"), 9999, false, true)

            -- Task NPCs to attack the target player
            TaskCombatPed(ped, targetPed, 0, 16)
            SetPedCombatAttributes(ped, 46, true)
        end
    end
end)


RegisterNetEvent('startBombTimer')
AddEventHandler('startBombTimer', function(source, isFake)
    playSoundActive = not playSoundActive

    Citizen.CreateThread(function()
        while playSoundActive do
            local playerPed = PlayerPedId()
            -- Play the specified sound from the player's entity
            PlaySoundFromEntity(-1, "ATM_WINDOW", playerPed, "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 0)

            timer = timer - 50

            -- Reset the timer when its up
            if timer < 0 then
                playSoundActive = false
                timer = Config.Timer

                -- If the bomb is not fake, go boom
                if not isFake then
                    TriggerEvent('blowupPlayer', -1)
                end
                TriggerServerEvent('MrRedDev:TimerUp', source, GetPlayerName(PlayerId()), isFake)
            end

            Citizen.Wait(timer)
        end
    end)
end)

RegisterNetEvent('ragdollPlayer')
AddEventHandler('ragdollPlayer', function()
    -- Get the player's ped (pedestrian entity)
    local playerPed = PlayerPedId()

    -- Set the player's ped to ragdoll
    SetPedToRagdoll(playerPed, 10000, 10000, 0, true, true, false)
end)

RegisterNetEvent('blowupPlayer')
AddEventHandler('blowupPlayer', function()
    -- Get the player's ped (pedestrian entity)
    local playerPed = PlayerPedId()

    -- Get the player's position
    local playerCoords = GetEntityCoords(playerPed)

    -- Create an explosion at the player's position
    AddExplosion(playerCoords.x, playerCoords.y, playerCoords.z, 2, 500.0, true, false, 5.0)
end)


-- Event to toggle speed limiter for the player
RegisterNetEvent('restrictSpeed')
AddEventHandler('restrictSpeed', function()
    speedLimiterActive = not speedLimiterActive
    --  print("Speed restriction activated for the player.")
end)

-- Function to draw 3D text on the screen (as a HUD element)
function DrawText3D(text, x, y)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 0, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
