local QBCore = exports['qb-core']:GetCoreObject()
local alcho = {}

RegisterServerEvent('kg-breathalyser:server:AddAlcho', function(value)
    local src = source
    if value < 0 then
        return
    else
        alcho[src] = (alcho[src] + value)
    end
end)

QBCore.Functions.CreateCallback('kg-breathalyser:server:GetAlcho', function(source, cb, closestPlayer)
    TriggerClientEvent('QBCore:Notfy', closestPlayer, "You Are Being Breathalysed", "success")
    if alcho[closestPlayer] ~= nil then
        cb(alcho[closestPlayer])
    else
        cb("000")
    end
end)

QBCore.Functions.CreateUseableItem(Config.Breathalyseritem, function(source, item)
    local src = source
    TriggerClientEvent('kg-breathalyser:client:breathalyse', src)
end)

Citizen.CreateThread(function()     -- This Thread Ticks BAC
    while true do
        local sleep = 60000
        for i = 1, #alcho do
            if alcho[i] > 0 then
                alcho[i] = (alcho[i] - 5)
            else
                alcho[i] = 0
            end
        end
        Wait(sleep)
    end
end)