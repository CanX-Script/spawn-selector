-- <<<     CanX Spawn Selector     >>> --|
--    Discord : discord.gg/MGEVjBbKHw  --|                      
--        Tebex : canx.tebex.io        --|        
-- <<<     CanX Spawn Selector     >>> --|

local joined = {}

RegisterServerEvent("CanX-SpawnSelector:OpenSpawner")
AddEventHandler("CanX-SpawnSelector:OpenSpawner", function()
    if not joined[GetPlayerIdentifiers(source)[1]] then
        TriggerClientEvent("CanX-SpawnSelector:Open", source)
        joined[GetPlayerIdentifiers(source)[1]] = true
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(1000)
        print('^2>>------------------^4CanX^2------------------<<')
		print('^4CanX Spawn Selector ^0(Made By CanX-Scripts)')
        print('^1Discord : ^0https://discord.gg/MGEVjBbKHw')
        print('^5Tebex : ^0https://canx.tebex.io')
        print('^2>>------------------^4CanX^2-----------------<<')
	end
end)