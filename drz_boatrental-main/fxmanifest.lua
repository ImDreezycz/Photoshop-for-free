fx_version 'cerulean'
lua54 'yes'
games { 'rdr3', 'gta5' }

author 'Jak$ußcz€#3297'
description 'Boat rental script'
version '1.9.4'

client_scripts {
    'client/*.lua',
    'config.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}

server_script 'server/*.lua'
