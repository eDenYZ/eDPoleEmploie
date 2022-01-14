ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


local ChantierMenu = false 
local mainMenu = RageUI.CreateMenu('Chantier', '~b~Manager du chantier')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    ChantierMenu = false
end

local tafc = false
local taf2c = true

function OpenMenuChantier()
	if ChantierMenu then 
		ChantierMenu = false
		RageUI.Visible(mainMenu, false)
		return
	else
		ChantierMenu = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while ChantierMenu do 
		   RageUI.IsVisible(mainMenu,function()

               RageUI.Button("Demander à travailler sur le chantier", nil, {}, not tafc, {
                onSelected = function()
                    tafc = true
                    taf2c = false
                    ESX.ShowNotification("Alors comme ça tu veux bosser sur le ~g~chantier~w~ hein ? Très bien, met ta tenue .")
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    deleteMenuChantier()
                    AuTravailleChantier = true
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
                    StartTravailleChantier()
            end
            })

            RageUI.Button("Arreter de travailler", nil, {}, not taf2c, {
                onSelected = function()
                    tafc = false
                    taf2c = true
                    ESX.ShowNotification("haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.")
                    deleteMenuChantier()
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleChantier = false
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

function deleteMenuChantier()
    RageUI.CloseAll()
    ChantierMenu = false
    FreezeEntityPosition(PlayerPedId(), false)
end

