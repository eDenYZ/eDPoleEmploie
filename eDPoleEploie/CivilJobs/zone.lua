DecorRegister("Yay", 4)
Heading = 206.31968688965
pedHash = "a_f_y_business_02"
zone = {
    Chantier = vector3(-509.94, -1001.59, 22.55),
    Jardinier = vector3(-1347.78, 113.09, 55.37),
    mine = vector3(2831.689, 2798.311, 56.49803),
    bucheron = vector3(-570.853, 5367.214, 69.21643),
    pomme = vector3(2304.62, 5035.64, 43.23),
}

local travailleZone = {
    {
        zone = vector3(-509.94, -1001.59, 22.55),
        nom = "Chantier",
        blip = 175,
        couleur = 44,
    },
    {
        zone = vector3(2831.689, 2798.311, 56.49803),
        nom = "Mine",
        blip = 477,
        couleur = 70,
    },
    {
        zone = vector3(-1347.78, 113.09, 55.37),
        nom = "Golf",
        blip = 109,
        couleur = 43,
    },
    {
        zone = vector3(2304.62, 5035.64, 44.23),
        nom = "Orange",
        blip = 12,
        couleur = 47,
    },
    {
        zone = vector3(-570.853, 5367.214, 70.21643),
        nom = "Bucheron",
        blip = 477,
        couleur = 21,
    },
    
}


Citizen.CreateThread(function()
    for k,v in pairs(travailleZone) do
        local blip = AddBlipForCoord(v.zone)
        SetBlipSprite(blip, v.blip)
        SetBlipScale(blip, 0.7)
        SetBlipShrink(blip, true)
        SetBlipColour(blip, v.couleur)
        SetBlipAsShortRange(blip, true)


        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.nom)
        EndTextCommandSetBlipName(blip)
    end
end)


function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(100)
    end
end