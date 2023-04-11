# VX resource template

The temlate that contains everything you may need for FiveM resource development

## Resource constants

### The resource constants are used by internal vx systems.

To set custom value to any constant you need to go to the `fxmanifest.lua` and change the values to whatever you want. However, there are some restrictions.  
There is the list of the constant.

- **ENV** - any value. No use for now. Exposed through `vx.ENV`
- **IS_DEBUG** - 'true' or 'false'. Will start the resource in debug mode. Exposed throught `vx.IS_DEBUG`
- **LANGUAGE** - 'en' by default. Tells VX from where to load the locales. Exposed throught `vx.LANGUAGE`



## RPC system

### To register an RPC handler you need to call `vx.RegisterRpc(name, handler)` method

client side rpc handling

```lua
vx.RegisterRpc("testRpc", function(argOne, argTwo)
    return argOne + argTwo
end)
```

server side rpc handling

```lua
vx.RegisterRpc("testRpc", function(source --[[always passed as the first argument]], argOne, argTwo)
    return argOne + argTwo
end)
```

#### To invoke it from the client side you need to call `vx.InvokeRpc(name, ...)` method

```lua
local result = vx.InvokeRpc("testRpc", 5, 15) -- 20
```

#### To invoke it from the server side use `vx.InvokeRpc(name, target, ...)` method

```lua
local result = vx.InvokeRpc("testRpc", source --[[the target client that has to execute the rpc handler]], 5, 15) -- 20
```

## Logging

There is a logger class

```lua
Logger = class('Logger')

-- Only works in debug mode
function Logger:debug(message)
    -- ...
end

function Logger:error(error, message)
    -- ...
end

function Logger:info(message)
    -- ...
end

function Logger:log(message)
    -- ...
end

function Logger:warn(message)
    -- ...
end
```

To create a logger use the following syntax
```lua
local logger = Logger(context)
```
The context argument is a prefix before all the logs

For now, the only out used is **console**.
## Localization
vx uses [Luang](https://github.com/ImagicTheCat/Luang) package for localization porpuses
## OOP
vx uses [Luaoop](https://github.com/ImagicTheCat/Luaoop) package for oop porpuses
## Used solutions

- **Luaoop** - https://github.com/ImagicTheCat/Luaoop
- **Luang** - https://github.com/ImagicTheCat/Luang