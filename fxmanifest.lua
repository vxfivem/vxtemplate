game 'gta5'
fx_version 'cerulean'

version '0.0.1'

shared_scripts {
    '__vx/luaoop.lua',
    '__vx/logger.lua',
    '__vx/typecheck.lua',
    '__vx/id_generator.lua'
}

client_script '__vx/__vx.lua'
client_script '__vx/__vx_client_rpc.lua'
client_script '__vx/__vx_client_keybinds.lua'
client_script '__vx/__vx_client_ui.lua'

server_script '__vx/__vx.lua'
server_script '__vx/__vx_server_rpc.lua'

client_script 'client/__main.lua'
server_script 'server/__main.lua'

-- current env
ENV 'some env'

-- if set to 'true' - enables the debug mode
IS_DEBUG 'true'
