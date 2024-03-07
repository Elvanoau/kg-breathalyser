local QBCore = exports['qb-core']:GetCoreObject()
local Open = false

-------------------------------------------------------
-- Main
-------------------------------------------------------

RegisterNetEvent('kg-breathalyser:client:AddAlchoLevel', function(toAdd)
    if toAdd < 0 then
        return
    else
        TriggerServerEvent('kg-breathalyser:server:AddAlcho', toAdd)
    end
end)

RegisterNetEvent('kg-breathalyser:client:breathalyse', function()
    if Open == true then
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "close",
        })
        Open = false
    else
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "open",
        })
        Open = true
    end
end)

-------------------------------------------------------
-- NUI
-------------------------------------------------------

RegisterNUICallback('escape', function(_, cb)
    if Config.Debug then
        print("Close")
    end
    SetNuiFocus(false, false)
    SendNUIMessage({type = "close"})
    Open = false
    cb("ok")
end)

RegisterNUICallback('breth', function(_, cb)
    local coords = GetEntityCoords(PlayerPedId())
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer(coords)
    QBCore.Functions.TriggerCallback('kg-breathalyser:server:GetAlcho', function(result)
        if tostring(result) >= "0.050" then
            SendNUIMessage({
                type = "over",
                amount = "0." .. tostring(result),
            })
        else
            SendNUIMessage({
                type = "data",
                amount = "0." .. tostring(result),
            })
        end
    end, closestPlayer)
end)

-------------------------------------------------------
-- Debug
-------------------------------------------------------

RegisterCommand("bretho", function()
    if Config.Debug ~= true then
        return
    end

    if Open == true then
        print("Close")
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "close",
        })
        Open = false
    else
        print("Open")
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "open",
        })
        Open = true
    end
end)