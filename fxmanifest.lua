fx_version 'cerulean'
game 'gta5'
author '_elvano'
lua54 'yes'

shared_scripts {
    "config.lua",
}

client_scripts {
    "client.lua",
}

server_scripts {
    "server.lua",
}

escrow_ignore {
    'config.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/*.css',
	'html/*.js',
	'html/images/**/*.png'
}