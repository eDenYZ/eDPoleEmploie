fx_version "adamant"
game "gta5"


shared_scripts {
    "shared/config.lua",
}


client_scripts {
    "@es_extended/locale.lua",
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",


    "CivilJobs/pomme/pomme_main.lua",
    "CivilJobs/pomme/pomme_menu.lua",
    "CivilJobs/jardinier/jardinier_main.lua",
    "CivilJobs/jardinier/menu_jardinier.lua",
    "CivilJobs/mine/mine_main.lua",
    "CivilJobs/mine/menu_mine.lua",
    "CivilJobs/bucheron/bucheron_main.lua",
    "CivilJobs/bucheron/bucheron_menu.lua",
    "CivilJobs/chantier/chantier_main.lua",
    "CivilJobs/chantier/chantier_menu.lua",
    "CivilJobs/Progressbar/client/main.lua",
    "CivilJobs/utility.lua",
    "CivilJobs/zone.lua",

    "client/*.lua",

}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "@es_extended/locale.lua",
    "CivilJobs/pomme/pomme_srv.lua",
    "CivilJobs/jardinier/srv_jardinier.lua",
    "CivilJobs/mine/srv_mine.lua",
    "CivilJobs/bucheron/srv_bucheron.lua",
    "CivilJobs/chantier/chantier_srv.lua",
    "CivilJobs/main_srv.lua",

    "server/*.lua",
}
