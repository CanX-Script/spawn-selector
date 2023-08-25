local joined = {}

RegisterServerEvent("CanX-SpawnSelector:OpenSpawner")
AddEventHandler("CanX-SpawnSelector:OpenSpawner", function()
    if not joined[GetPlayerIdentifiers(source)[1]] then
        TriggerClientEvent("CanX-SpawnSelector:Open", source)
        joined[GetPlayerIdentifiers(source)[1]] = true
    end
end)