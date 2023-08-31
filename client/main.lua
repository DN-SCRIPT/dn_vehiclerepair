local fixing = false
local lastZone, currentAction

if Config.Blips then
	CreateThread(function()
		for i=1, #Config.Stations, 1 do
			local blip = AddBlipForCoord(Config.Stations[i].x, Config.Stations[i].y, Config.Stations[i].z)

			SetBlipSprite (blip, 643)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, 3)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U('blips'))
			EndTextCommandSetBlipName(blip)
		end
	end)
end

CreateThread (function()	
    while true do
		Wait(0)
		if not IsPedInAnyVehicle(PlayerPedId(), false) then 
		    Wait(1000)
		end
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			local playerPed = PlayerPedId()
			local pos = GetEntityCoords(playerPed, true)
			local isInMarker, currentZone, letSleep = false, nil, true	
			for k,v in pairs(Config.Stations) do
				if not fixing then
					if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15) then
						letSleep = false
						if IsPedInAnyVehicle(playerPed, false) then
							isInMarker, currentZone = true, k
						end
					end
				end
			end
			if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and lastZone ~= currentZone) then
				hasAlreadyEnteredMarker, lastZone = true, currentZone
				exports['okokTextUI']:Open('Press [E] to repair vehicle', 'darkred', 'right')
				TriggerEvent('dn_repairshop:hasEnteredMarker', currentZone)

			end
			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				exports['okokTextUI']:Close()
			end
			if letSleep then
				Wait(500)
			end
		end
    end
    Wait(1000)
end)


RegisterNetEvent('carfixstation:fixCar')
AddEventHandler('carfixstation:fixCar', function()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local fixing = true
	TriggerEvent('carfixstation:markAnimation')	
	FreezeEntityPosition(vehicle, true)
	sendNotification(_U('repair_processing'), 'warning', Config.RepairTime-700)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'car_repair', 0.7)
	DoorControl(4)
	lib.progressBar({
		duration = Config.RepairTime,
		label = _U('repair_ongoing'),
		useWhileDead = true,  --- You Can Change If You Need
		canCancel = true,

	})
	local fixing = false
	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)
	FreezeEntityPosition(vehicle, false)
end)

function DoorControl(door)
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end


CreateThread(function()
	while true do
		Wait(0)
		if currentAction then
			if IsControlJustReleased(0, 38) then
				if currentAction == 'dorepair' then
					TriggerServerEvent('carfixstation:costRepair', Config.cost)
				end
				
				currentAction = nil
			end
		else
			Wait(500)
		end
	end
end)

AddEventHandler('dn_repairshop:hasEnteredMarker', function(zone)
	currentAction  = 'dorepair'
end)
