ESX = exports.es_extended:getSharedObject()


ESX.RegisterServerCallback('CheckLocMoney', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerMoney = xPlayer.getMoney()
  cb(playerMoney >= 500)
  if xPlayer.getMoney() < 500 then
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'You dont have enough money.',
        type = 'error'
    })
    end
end)

RegisterServerEvent('RemoveLocMoney')
AddEventHandler('RemoveLocMoney', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()

    if playerMoney >= amount then
        xPlayer.removeMoney(amount)
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'You have rented a boat/scooter',
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'You dont have enough money.',
            type = 'error'
        })
    end
end)
