
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


local PommeMenu = false 
local mainMenu = RageUI.CreateMenu('Champ de pomme', '~b~Manager du champ')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    PommeMenu = false
end


local tafp = false
local taf2p = true

function OpenMenuPomme()
	if PommeMenu then 
		PommeMenu = false
		RageUI.Visible(mainMenu, false)
		return
	else
		PommeMenu = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while PommeMenu do 
		   RageUI.IsVisible(mainMenu,function()

               RageUI.Button("Demander à travailler sur le chantier", nil, {}, not tafp, {
                onSelected = function()
                    tafp = true
                    taf2p = false
                    ESX.ShowNotification("Alors comme ça tu veu bosser pour le ~g~champ de pommes~w~ hein ? Très bien, vas-y !")
                    deleteMenuPomme()
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravaillePomme = true
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local clothesSkin = {
                            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                            ['torso_1'] = 66,   ['torso_2'] = 1,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 93,
                            ['pants_1'] = 39,   ['pants_2'] = 1,
                            ['shoes_1'] = 24,   ['shoes_2'] = 0,
                            ['chain_1'] = 0,  ['chain_2'] = 0
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                    end)
                    StartTravaillePomme()
            end
            })

            RageUI.Button("Arreter de travailler", nil, {}, not taf2p, {
                onSelected = function()
                    tafp = false
                    taf2p = true
                    ESX.ShowNotification("haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.")
                    deleteMenuPomme()
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillePomme = false
                            endwork()
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


function deleteMenuPomme()
    RageUI.CloseAll()
    PommeMenu = false
    FreezeEntityPosition(PlayerPedId(), false)
end

