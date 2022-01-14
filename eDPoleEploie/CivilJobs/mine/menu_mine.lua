
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


local MineMenu = false 
local mainMenu = RageUI.CreateMenu('Mine', '~b~Manager des ouvriers')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    MineMenu = false
end

local tafm = false
local taf2m = true

function OpenMenuMine()
	if MineMenu then 
		MineMenu = false
		RageUI.Visible(mainMenu, false)
		return
	else
		MineMenu = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while MineMenu do 
		   RageUI.IsVisible(mainMenu,function()

            RageUI.Button("Demander à travailler sur le Mine", nil, {}, not tafm, {
                onSelected = function()
                    tafm = true
                    taf2m = false
                    ESX.ShowNotification("Alors comme ça tu veux bosser à la ~g~mine~w~ hein ? Très bien, met ta tenue .")
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravaillemine = true
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
                    if not ESX.Game.IsSpawnPointClear(vector3(2843.071, 2784.613, 59.94376), 6.0) then
                        local veh = ESX.Game.GetClosestVehicle(vector3(2843.071, 2784.613, 59.94376))
                        TriggerEvent("LS_LSPD:RemoveVeh", veh)
                    end
                    ESX.Game.SpawnVehicle(GetHashKey("sadler"), vector3(2843.071, 2784.613, 59.94376), 59.144374847412, function(veh)
                        SetVehicleOnGroundProperly(veh)
                        vehicle = NetworkGetNetworkIdFromEntity(veh)
                    end)
                    StartTravaillemine()
                       end
                    })

            RageUI.Button("Arreter de travailler", nil, {}, not taf2m, {
                onSelected = function()
                    tafm = false
                    taf2m = true
                    ESX.ShowNotification("haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.")
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravaillemine = false
                    endwork()
                    TriggerEvent("LS_LSPD:RemoveVeh", NetworkGetEntityFromNetworkId(vehicle))
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

function deleteMenuMine()
    RageUI.CloseAll()
    MineMenu = false
    FreezeEntityPosition(PlayerPedId(), false)
end

