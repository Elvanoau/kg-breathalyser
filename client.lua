local QBCore = exports['qb-core']:GetCoreObject()
local Open = false
local Power = false

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

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({type = "close"})
    Open = false
    cb("ok")
end)

RegisterNUICallback('breth', function(data, cb)
    if Power ~= true then return end
    local coords = GetEntityCoords(PlayerPedId())
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer(coords)
    local playerId = GetPlayerServerId(closestPlayer)
    QBCore.Functions.TriggerCallback('kg-breathalyser:server:GetAlcho', function(result)
        if result >= 0.050 then
            SendNUIMessage({
                type = "over",
                amount = result,
            })
        else
            SendNUIMessage({
                type = "data",
                amount = result,
            })
        end
    end, playerId)
end)

RegisterNUICallback('onOff', function(data, cb)
    if data.onOff then
        Power = data.onOff
    end
end)

-------------------------------------------------------
-- Debug
-------------------------------------------------------

RegisterCommand("bretho", function()
    if Config.Debug ~= true then
        return
    end

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

RegisterCommand("setalco", function()
    if Config.Debug ~= true then
        return
    end
    
    TriggerEvent('kg-breathalyser:client:AddAlchoLevel', 0.900)
end)