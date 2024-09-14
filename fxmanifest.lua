fx_version 'cerulean'
game 'gta5'

author 'Redface'
description 'A pretty decent troll script to mess with your friends'
version '1.0.6'
lua54 'yes'

client_scripts
{
    'config.lua',
    'client/events.lua',
    'client/client.lua'
}

server_scripts
{
    'config.lua',
    'server/functions.lua',
    'server/events.lua',
    'server/version.lua',
    'server/commands/merryweather.lua',
    'server/commands/restrictspeed.lua',
    'server/commands/blowup.lua',
    'server/commands/kill.lua',
    'server/commands/ragdoll.lua',
    'server/commands/playsound.lua'
}

escrow_ignore
{
    'config.lua'
}
