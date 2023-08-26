-- <<<     CanX Spawn Selector     >>> --|
--    Discord : discord.gg/MGEVjBbKHw  --|                      
--        Tebex : canx.tebex.io        --|        
-- <<<     CanX Spawn Selector     >>> --|

fx_version 'cerulean'
game 'gta5'

author 'CanX Scripts'
description 'CanX-SpawnSelector'

--Client Scripts-- 
client_scripts {
 'Client/*.lua'
}

--Server Scripts-- 
server_scripts {
 'Server/*.lua'
}

shared_scripts {
    'Shared/*.lua'
}
--UI Part-- 
ui_page {
 'Ui/index.html', 
}

--File Part-- 
files {
 'Ui/index.html',
 'Ui/*.js', 
 'Ui/*.css', 
 'Ui/locations-image/*.png', 
 'Ui/*.jpg'
} 
