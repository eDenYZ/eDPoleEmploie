ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


local JardinierMenu = false 
local mainMenu = RageUI.CreateMenu('Jardinier', '~b~Manager des jardiniers')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    JardinierMenu = false
end

local tafj = false
local taf2j = true

local vehicle = nil
local ZoneDeSpawn = vector3(-1336.572, 118.7055, 56.51094)

function OpenMenuJardinier()
	if JardinierMenu then 
		JardinierMenu = false
		RageUI.Visible(mainMenu, false)
		return
	else
		JardinierMenu = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while JardinierMenu do 
		   RageUI.IsVisible(mainMenu,function()

            RageUI.Button("Demander à travailler au Golf", nil, {}, not tafj, {
                onSelected = function()
                    tafj = true
                    taf2j = false
                    ESX.ShowNotification("Alors comme ça tu veux bosser sur le ~g~Golf~w~ hein ? Très bien, change toi !")
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    deleteMenuJardinier()
                    AuTravailleJardinier = true
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local clothesSkin = {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                                ['tshirt_1'] = 59, ['tshirt_2'] = 0,
                                ['torso_1'] = 56, ['torso_2'] = 0,
                                ['arms'] = 30,
                                ['pants_1'] = 31, ['pants_2'] = 0,
                                ['shoes_1'] = 25, ['shoes_2'] = 0,
                                ['mask_1'] = 0, ['mask_2'] = 0,
                                ['bproof_1'] = 0, ['bproof_2'] = 0,
                                ['helmet_1'] = 0, ['helmet_2'] = 0,
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                    end)
                    local spawnRandom = vector3(ZoneDeSpawn.x+math.random(1,15), ZoneDeSpawn.y+math.random(1,15), ZoneDeSpawn.z)
                    ESX.Game.SpawnVehicle(1783355638, spawnRandom, 274.95318603516, function(veh)
                        vehicle = NetworkGetNetworkIdFromEntity(veh)
                        local blip = AddBlipForEntity(veh)
                        SetBlipSprite(blip, 559)
                        SetBlipFlashes(blip, true)
                    end)
                    StartTravailleJardinier()
                       end
                    })

            RageUI.Button("Arreter de travailler", nil, {}, not taf2j, {
                onSelected = function()
                    tafj = false
                    taf2j = true
                    ESX.ShowNotification("haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.")
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    deleteMenuJardinier()
                    AuTravailleJardinier = false
                    ESX.Game.DeleteVehicle(NetworkGetEntityFromNetworkId(vehicle))
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        local isMale = skin.sex == 0
                        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                TriggerEvent('esx:restoreLoadout')
                    end)
                end)
            end)
        end
     })

           end)

           Wait(0)
          end
       end)
    end
  end


function deleteMenuJardinier()
    RageUI.CloseAll()
    JardinierMenu = false
    FreezeEntityPosition(PlayerPedId(), false)
end

