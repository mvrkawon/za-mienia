ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'infozacmienie', 'admin', function(source, args, user)

	if args[1] ~= nil then
		local czas = tonumber(args[1])

  		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

  			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
  			TriggerClientEvent('ps:zacmienie', xPlayer.source, czas)

		end
	end

end, function(source, args, user)
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Nie masz uprawnien.' } })
end, { help = 'Zaćmienie serwera.', params = { { name = 'id' } } })