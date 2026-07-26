fx_version 'cerulean'
game 'gta5'

author 'Mago Scripts'
description 'MAGOz City Assist - recurso universal para FiveM con bridges modulares'
version '1.0'

lua54 'yes'

ui_page 'web/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/services.lua'
}

server_scripts {
    'bridge/custom.lua',
    'bridge/core.lua',
    'server/main.lua'
}

files {
    'web/index.html',
    'web/style.css',
    'web/app.js',
    'web/assets/**/*',
    'THIRD_PARTY_NOTICES.md'
}

escrow_ignore {
    'config.lua',
    'bridge/custom.lua',
    'README.md',
    'THIRD_PARTY_NOTICES.md',
    'web/assets/**/*'
}
