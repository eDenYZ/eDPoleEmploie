
local config = {
    Heading = 219.18060302734,
    pedHash = "s_m_y_construct_01",
    AuTravaillepomme = false,
    ArgentMin = 60,
    ArgentMax = 80,
}






RegisterNetEvent("pommeAntiDump")
AddEventHandler("pommeAntiDump", function()
    TriggerClientEvent("pommeAntiDump", source, config, WorkerChillPos, WorkerWorkingPos)
end)
