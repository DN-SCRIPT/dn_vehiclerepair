ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('carfixstation:costRepair')
AddEventHandler('carfixstation:costRepair', function(cost)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.cost then		
		xPlayer.removeMoney(Config.cost)


	TriggerClientEvent('carfixstation:fixCar', _source)
		
	TriggerClientEvent("dn_notify:notify", source, 'VEHICLE REPAIR STATION', 'YOUR VEHICLE IS REPAIRING', 'info', 10000) -- you can change this notify if you need 
else
	TriggerClientEvent("dn_notify:notify", source, 'VEHICLE REPAIR STATION', 'NOT HAVE ENOUGH MONEY TO REPAIR', 'error', 10000) -- you can change this notify if you need 
end
end)