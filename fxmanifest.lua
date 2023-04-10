game 'gta5'
fx_version 'cerulean'

version '0.0.1'
author 'vxlurk <https://github.com/vxlurk>'
description 'A template for a resource'
repository 'https://github.com/vxfivem/vxtemplate'

-- locales
files {
    'locale/**/locale.shared.json',
    'locale/**/locale.client.json'
}

files {
    'configs/**/*/*.shared.json',
    'configs/**/*/*.client.json'
}

shared_scripts {
    '__vx/luang.lua',
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

-- current env
ENV 'some env'

-- if set to 'true' - enables the debug mode
IS_DEBUG 'true'

-- current language, VX loads locales from ./locale/{{LANGUAGE}}/locale.*.json
LANGUAGE 'en'

-- your shared scripts go there
shared_scripts {}

-- your client scripts go there
client_scripts {
    'client/main.lua'
}

-- your server scripts go there
server_script {
    'server/main.lua'
}

