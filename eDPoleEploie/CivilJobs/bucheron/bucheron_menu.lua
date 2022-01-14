ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)


local open = false 
local mainMenu = RageUI.CreateMenu('Bûcheron', '~b~Manager des bûcherons')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
end

local tafb = false
local taf2b = true

function OpenMenuBucheron()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu,function()


             RageUI.Button("Demander à travailler sur le chantier", nil, {}, not tafb, {
                onSelected = function()
                tafb = true
                taf2b = false
                ESX.ShowNotification("Alors comme ça tu veu bosser pour les ~g~bucherons~w~ hein ? Très bien, met ta tenue .")
				deleteMenuBucheron()
				RenderScriptCams(0, 1, 1500, 1, 1)
				DestroyCam(cam, 1)
				AuTravaillebucheron = true
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
				StartTravaillebucheron()
            end
            })

            RageUI.Button("Arreter de travailler", nil, {}, not taf2b, {
                onSelected = function()
                tafb = false
                taf2b = true
                ESX.ShowNotification("haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.")
                deleteMenuBucheron()
                RenderScriptCams(0, 1, 1500, 1, 1)
                DestroyCam(cam, 1)
                AuTravaillebucheron = false
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

function deleteMenuBucheron()
    RageUI.CloseAll()
    open = false
    FreezeEntityPosition(PlayerPedId(), false)
end

