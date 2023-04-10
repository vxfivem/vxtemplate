# VX resource template

The temlate that contains everything you may need for FiveM resource development

## Resource constants

### The resource constants are used by internal vx systems.

To set the variable you need to go to the `fxmanifest.lua` and change the values to whatever you want. However, there are some restrictions.  
There is the list of the variables.

- **ENV** - any value. No use for now.
- **IS_DEBUG** - 'true' or 'false'. Will start the resource in debug mode.
- **LANGUAGE** - 'en' by default. Tells VX from where to load the locales.

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
