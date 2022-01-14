ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(0)
	end
end)

function HelpMsg(msg)
	AddTextEntry('LocationNotif', msg)
	BeginTextCommandDisplayHelp('LocationNotif')
	EndTextCommandDisplayHelp(0, false, true, -1)
end