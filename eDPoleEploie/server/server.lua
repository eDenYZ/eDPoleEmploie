ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
print("Chargement du ^4Pôle Emploi^0 ...")

ESX.RegisterServerCallback('kTeste:getJobs', function(source, cb)
     MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY label ASC', {}, function(result)
         cb(result)
     end)
 end)
