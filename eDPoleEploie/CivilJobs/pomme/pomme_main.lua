

local sync = false
local WorkerChillPos = {}
local workzone = {}
local WorkerWorkingPos = {}
local Heading
local pedHash
AuTravaillePomme = nil
local ArgentMin
local ArgentMax

Citizen.CreateThread(function()
    LoadModel("a_m_m_farmer_01")
    local ped = CreatePed(2, GetHashKey("a_m_m_farmer_01"), zone.pomme, 42.24, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetEntityAsMissionEntity(ped, 1, 1)
    SetBlockingOfNonTemporaryEvents(ped, 1)
end)




local object = {
    "prop_veg_crop_orange"
}


local zoneTest = vector3(2318.09, 5023.32, 43.24)


function StartTravaillePomme()
    self = object
    RequestAnimDict("missfinale_c2mcs_1")
    AuTravaillePomme = true
    Citizen.CreateThread(function()
        while AuTravaillePomme do
            EnAction = false
            local zoneRandom = vector3(zoneTest.x+math.random(-15.0, 15.0), zoneTest.y+math.random(-15.0, 15.0), zoneTest.z)
            local random = math.random(1, #object)
            local model = GetHashKey(object[random])
            RequestModel(model)
            while not HasModelLoaded(model) do print("Chargement model") Wait(100) end
            testObj = CreateObject(model, zoneRandom, 1, 0, 0)
            blip = AddBlipForEntity(testObj)
           
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(testObj), true)
            SetBlipSprite(blip, 1)
            SetBlipColour(blip, 47)
            SetBlipScale(blip, 0.65)
            PlaceObjectOnGroundProperly(testObj)
            local pos = GetEntityCoords(testObj)
            SetEntityCoords(testObj, pos.x, pos.y, pos.z-0.5, 0.0, 0.0, 0.0, 0)
            FreezeEntityPosition(testObj, 1)
            local coords = GetEntityCoords(testObj)
            while not EnAction and AuTravaillePomme do
                Citizen.Wait(1)
                dstToMarker = GetDistanceBetweenCoords(zoneRandom, pCoords, true)
                DrawMarker(2, coords.x, coords.y, coords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 100.0, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(testObj), false)
                if dst <= 3.0 and AuTravaillePomme then
                    HelpMsg("~b~E~w~ pour récolter")
                    if IsControlJustPressed(1, 51) and dst <= 3.0 then
                        FreezeEntityPosition(PlayerPedId(), true)
                        RemoveBlip(blip)
                        EnAction = true
                        TaskTurnPedToFaceEntity(PlayerPedId(), testObj, 2000)
                        Wait(5000)
                        RemoveObj(NetworkGetNetworkIdFromEntity(testObj))
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        local money = math.random(5, 15)
                        TriggerServerEvent("ori_jobs:pay", money)
                        ESX.ShowNotification("Bien ! Tu à été payé ~g~"..money.."$ ~w~pour ton travaille, continue comme ça !")
                        break
                    end
                end
            end
            RemoveObj(NetworkGetNetworkIdFromEntity(testObj))
            RemoveBlip(blip)
        end
        RemoveObj(NetworkGetNetworkIdFromEntity(testObj))
        RemoveBlip(blip) 
    end)
end
function RemoveObj(id)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and IsEntityAttached(entity) do 
            DetachEntity(entity, 0, 0)
            Wait(1)
            test = test + 1
        end

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            DetachEntity(entity, 0, 0)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end

    end)
end