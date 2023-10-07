-- <<<     CanX Spawn Selector     >>> --|
--    Discord : discord.gg/MGEVjBbKHw  --|                      
--        Tebex : canx.tebex.io        --|        
-- <<<     CanX Spawn Selector     >>> --|

-- AddEventHandler('playerSpawned', function(spawn)
-- 	TriggerServerEvent('CanX-SpawnSelector:OpenSpawner')
-- end)

RegisterNetEvent('CanX-SpawnSelector:Open')
AddEventHandler('CanX-SpawnSelector:Open', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        Action = 'ShowUi',
        Display = true,
        Data = Config.Locations
    })
end)

ShowLoadingPromt = function(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

RegisterNUICallback('spawn', function(data, cb)
    local TeleportPos = nil
    SetNuiFocus(false, false)
    for k,v in ipairs(Config.Locations) do
        if v.Loc_Name == data.location then
            TeleportPos = v.Pos
        end
    end
    StartFade()
	CreateCameraOnTop2(TeleportPos.x, TeleportPos.y, TeleportPos.z)
	EndFade()
	ReadToPlay(TeleportPos.x, TeleportPos.y, TeleportPos.z)
end)

RegisterNUICallback('last-loc', function(data, cb)
    local pos = GetEntityCoords(PlayerPedId())
    SetNuiFocus(false, false)
    StartFade()
	CreateCameraOnTop2(pos.x, pos.y, pos.z)
	EndFade()
	ReadToPlay(pos.x, pos.y, pos.z)
end)

local cam = nil
local continuousFadeOutNetwork = false
local needAskQuestions, needRegister
local firstSpawn, disableAttack = true, true
local risdead = false

function f(n)
	n = n + 0.00000
	return n
end

function setCamHeight(height)
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(height)))
end

function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

function DisalbeAttack()
	DisableControlAction(0, 19, true) 
	DisableControlAction(0, 45, true)
	DisableControlAction(0, 24, true) 
	DisableControlAction(0, 257, true)
	DisableControlAction(0, 25, true) 
	DisableControlAction(0, 68, true)
	DisableControlAction(0, 69, true)
	DisableControlAction(0, 70, true) 
	DisableControlAction(0, 92, true) 
	DisableControlAction(0, 346, true) 
	DisableControlAction(0, 347, true) 
	DisableControlAction(0, 264, true) 
	DisableControlAction(0, 257, true) 
	DisableControlAction(0, 140, true) 
	DisableControlAction(0, 141, true) 
	DisableControlAction(0, 142, true) 
	DisableControlAction(0, 143, true) 
	DisableControlAction(0, 263, true) 
	if disableAttack then
		SetTimeout(0, function ()
			DisalbeAttack()
		end)
	end
end

function showLoadingPromt(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

function ReadToPlay(x, y, z)
	TriggerServerEvent('PX_LoadingSystem:ChangeKobs', false)
	disableAttack = false
	if x ~= nil and  y ~= nil and  z ~= nil then
		CameraLoadToGround2(x, y, z)
	else
		CameraLoadToGround()
	end
	SetEntityInvincible(PlayerPedId(),false)
	SetEntityVisible(PlayerPedId(),true)
	FreezeEntityPosition(PlayerPedId(),false)
	SetPedDiesInWater(PlayerPedId(),true)
	if x ~= nil and  y ~= nil and  z ~= nil then
		SetEntityCoords(PlayerPedId(), x, y, z)
	end
	KillCamera()
	if x ~= nil and  y ~= nil and  z ~= nil then
		SetEntityCoords(PlayerPedId(), x, y, z)
	end


end

function StartUpLoading()
	Citizen.CreateThread(function()
		StartFade()
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		showLoadingPromt("MP_SPINLOADING", 500000)
		CreateCameraOnTop()
		SetEntityVisible(PlayerPedId(),true)
		DisalbeAttack()
		SetEntityInvincible(PlayerPedId(),true)
		FreezeEntityPosition(PlayerPedId(),true)
		SetPedDiesInWater(PlayerPedId(),false)
		DisplayRadar(false)
		Wait(1000)
		EndFade()
		DoScreenFadeIn(500)
        showLoadingPromt("MP_SPINLOADING", 0)
        showLoadingPromt("PCARD_JOIN_GAME", 500000)
        Wait(1000)
        showLoadingPromt("PCARD_JOIN_GAME", 0)
        CreateCameraOnTop()
        EndFade()		
	end)
end

function CreateCameraOnTop()
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(1000)))
	SetCamRot(cam,-f(90),f(0),f(0),2)
	SetCamActive(cam,true)
	StopCamPointing(cam)
	RenderScriptCams(true,true,0,0,0,0)
end

function CameraLoadToGround()
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	local altura = 1000
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(1000)))
	while altura > (pos.z - 5.0) do
		if altura <= 300 then
			altura = altura - 6
		elseif altura >= 301 and altura <= 700 then
			altura = altura - 4
		else
			altura = altura - 2
		end
		setCamHeight(altura)
		Citizen.Wait(10)
	end
end

function KillCamera()
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	SetCamActive(cam,false)
	StopCamPointing(cam)
	RenderScriptCams(0,0,0,0,0,0)
	SetFocusEntity(PlayerPedId())
end

function CreateCharacterCamera()
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	SetCamCoord(cam,vector3(-38.2,-589.89,79.50))
	-- SetCamRot(cam,f(0),f(0),f(159),73)
	SetCamRot(cam, 0.0, 0.0, 159.0)
	SetCamActive(cam,true)
	RenderScriptCams(true,true,20000000000000000000000000,0,0,0)
end

function FadeOutNet()
	if continuousFadeOutNetwork then 
		for _, id in ipairs(GetActivePlayers()) do
			if id ~= PlayerId() then
				NetworkFadeOutEntity(GetPlayerPed(id),false)
			end
		end
		SetTimeout(0, FadeOutNet)
	end
end


function CreateCameraOnTop2(x, y, z)
    if x ~= nil and  y ~= nil and  z ~= nil then
        if not DoesCamExist(cam) then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
        end
        SetCamCoord(cam,vector3(x, y,f(1000)))
        SetCamRot(cam,-f(90),f(0),f(0),2)
        SetCamActive(cam,true)
        StopCamPointing(cam)
        RenderScriptCams(true,true,0,0,0,0)
        SetEntityCoords(PlayerPedId(), x, y, z)
    end
end

function CameraLoadToGround2(x, y, z)
    if x ~= nil and  y ~= nil and  z ~= nil then
        if not DoesCamExist(cam) then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
        end
        local altura = 1000
        SetCamCoord(cam,vector3(x, y,f(1000)))
        while altura > (z - 5.0) do
            SetEntityCoords(PlayerPedId(), x, y, z)
            if altura <= 300 then
                altura = altura - 6
            elseif altura >= 301 and altura <= 700 then
                altura = altura - 4
            else
                altura = altura - 2
            end
            setCamHeight(altura)
            Citizen.Wait(10)
        end
    end
end

