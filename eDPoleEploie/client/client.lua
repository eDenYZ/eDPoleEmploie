ESX = nil
Citizen.CreateThread(function()
     while ESX == nil do
         TriggerEvent('Blow:getSharedObject', function(obj) ESX = obj end)
         Citizen.Wait(0)
     end
     while ESX.GetPlayerData().job == nil do
           Citizen.Wait(10)
     end
     if ESX.IsPlayerLoaded() then
           ESX.PlayerData = ESX.GetPlayerData()
     end
end)


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

     AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
     
     blockinput = true 
     DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
     while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
         Citizen.Wait(0)
     end 
          
     if UpdateOnscreenKeyboard() ~= 2 then
         local result = GetOnscreenKeyboardResult()
         Citizen.Wait(500) 
         blockinput = false
         return result 
     else
         Citizen.Wait(500) 
         blockinput = false 
         return nil 
     end
 end
 
PoleEmploi = {
     menu = false,
     CivilJobs = {
          {jobLabel = "Bûcheron", waypoint = vector2(-570.853, 5367.214)},
          {jobLabel = "Ouvrier", waypoint = vector2(-509.94, -1001.59)},
          {jobLabel = "Mineur", waypoint = vector2(2831.689, 2798.311)},
          {jobLabel = "Récolte d'orange", waypoint = vector2(2304.62, 5035.64)}
     },
     Pos = {
          Blip = {
               {posblip = vector3(-268.91, -956.93, 31.22)}
          },
          Chantier = {
               {poscht = vector3(-509.94, -1001.59, 23.55)}
          },
          Bucheron = {
               {posbch = vector3(-570.853, 5367.214, 70.21643)}
          },
          Orange = {
               {posorg = vector3(2304.29, 5036.07, 44.29)}
          },
          Mine = {
               {posmine = vector3(2831.689, 2798.311, 57.49803)}
          },
          Jardin = {
               {posjdr = vector3(-1347.78, 113.09, 56.37)}
          }
     }
}


local open = false 
local mainMenu = RageUI.CreateMenu('Pôle Emploi', '~b~Accueil')
local subMenu = RageUI.CreateSubMenu(mainMenu,'Pôle Emploi', '~b~Intérim')
local subMenu1 = RageUI.CreateSubMenu(mainMenu,'Pôle Emploi', '~b~Petit-Job')
local subMenu2 = RageUI.CreateSubMenu(mainMenu,'Candidature Intérim', '~b~Intérim')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end


Citizen.CreateThread(function()
     while true do
          local pCoords2 = GetEntityCoords(GetPlayerPed(-1))
          local activerfps = false
          for k,v in pairs(PoleEmploi.Pos.Blip) do
                  if #(pCoords2 - v.posblip) < 1.0 then
                          activerfps = true
                          Visual.Subtitle("Appuyer sur ~b~E~s~ pour accèder au ~o~Pôle Emploi",1)
                          if IsControlJustReleased(1, 51) then
                              OpenMenuPoleEmploie()
                          end
                  elseif #(pCoords2 - v.posblip) < 5.0 then
                          activerfps = true
                          DrawMarker(22, v.posblip, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
                  end
          end
          for k,v in pairs(PoleEmploi.Pos.Mine) do
               if #(pCoords2 - v.posmine) < 1.0 then
                       activerfps = true
                       Visual.Subtitle("Appuyer sur ~b~E~s~ pour parler au ~o~Chef des ouvriers",1)
                       if IsControlJustReleased(1, 51) then
                         OpenMenuMine()
                       end
               elseif #(pCoords2 - v.posmine) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posmine, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Jardin) do
               if #(pCoords2 - v.posjdr) < 1.0 then
                       activerfps = true
                       Visual.Subtitle("Appuyer sur ~b~E~s~ pour parler au ~o~Chef des jardiniers",1)
                       if IsControlJustReleased(1, 51) then
                         OpenMenuJardinier()
                       end
               elseif #(pCoords2 - v.posjdr) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posjdr, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Orange) do
               if #(pCoords2 - v.posorg) < 1.0 then
                       activerfps = true
                       Visual.Subtitle("Appuyer sur ~b~E~s~ pour parler au ~o~Chef du champ",1)
                       if IsControlJustReleased(1, 51) then
                         openPommeMenu()
                       end
               elseif #(pCoords2 - v.posorg) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posorg, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Chantier) do
               if #(pCoords2 - v.poscht) < 1.0 then
                       activerfps = true
                       Visual.Subtitle("Appuyer sur ~b~E~s~ pour parler au ~o~Chef de chantier",1)
                       if IsControlJustReleased(1, 51) then
                         OpenMenuChantier()
                       end
               elseif #(pCoords2 - v.poscht) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.poscht, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Bucheron) do
               if #(pCoords2 - v.posbch) < 1.0 then
                       activerfps = true
                       Visual.Subtitle("Appuyer sur ~b~E~s~ pour parler au ~o~Chef des bûcherons",1)
                       if IsControlJustReleased(1, 51) then
                         OpenMenuBucheron()
                       end
               elseif #(pCoords2 - v.posbch) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posbch, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          if activerfps then
              Wait(1)
          else
              Wait(1800)
          end
      end
end)

function OpenMenuPoleEmploie()
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

               RageUI.Button("Quitter mon métier .", "ATTENTION~s~ pas de route possible !", {Color = { HightLightColor = { 255, 255,255, 150 }, BackgroundColor = { 255, 0, 0, 160 } }}, true, {
                    onSelected = function()
                         ESX.ShowNotification("~b~Pôle Emploi~s~\nPréparation des papiers ...")
                         Wait(5000)
                         TriggerServerEvent("blowJobs:changeJob", "unemployed", "Chômeur", 0)
                end
                })

                RageUI.Button("Accéder aux Métiers Intérim", nil, {RightLabel = "→→"}, true, {
                     onSelected = function()
                         GetKJobs()
                     end
                },subMenu)

                RageUI.Button("Accéder aux Petits-Travaux", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                    end
               },subMenu1)

               end)
               
                RageUI.IsVisible(subMenu,function()

                    for k,v in pairs(getTListjobs) do
                    RageUI.Button("Métier : ~o~"..v.label, nil, {RightLabel = "~o~Prendre~s~ →"}, true,{
                         onSelected = function()
                         ESX.ShowNotification("~b~Pôle Emploi~s~\nVérifications des papiers ...")
                       Wait(5000)
                       ESX.ShowAdvancedNotification('Pôle emploi', 'Emploie', 'Pour intégrer les job veuillez rédiger une ~b~candidature sur le Discord', 'CHAR_LIFEINVADER')
                      end
                    })

               end
               end)

               RageUI.IsVisible(subMenu1,function()

               for k,v in pairs(PoleEmploi.CivilJobs) do
               RageUI.Button("Travail : ~o~"..v.jobLabel, nil, {RightLabel = "~o~Go~s~ →"}, true,{
                    onSelected = function()
                    SetNewWaypoint(v.waypoint)
                    ESX.ShowNotification("Vous avez choisis ~b~"..v.jobLabel.."~w~ ? Très bien, je vous ai donné les coordonées GPS .")
                    DeleteMenu()
          end
     })

end
end)

               Wait(0)
              end
           end)
        end
      end

function DeleteMenu()
     RageUI.CloseAll()
     PoleEmploi.menu = false
     FreezeEntityPosition(PlayerPedId(), false)
end

function GetKJobs()
     getTListjobs = {}
     ESX.TriggerServerCallback("kTeste:getJobs", function(kJobs) 
         for k,v in pairs(kJobs) do
             table.insert(getTListjobs,  {name = v.name, label = v.label}) 
         end
     end)
 end

