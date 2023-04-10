
# VX resource template

The temlate that contains everything you may need for FiveM resource development 


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
   vx.RegisterRpc("testRpc", function(source -- [[always passed as the first argument]], argOne, argTwo)
        return argOne + argTwo 
    end)
```

#### To invoke it from the client side you need to call `vx.InvokeRpc(name, ...)` method
```lua
    local result = vx.InvokeRpc("testRpc", 5, 15) -- 20
```
#### To invoke it from the server side use `vx.InvokeRpc(name, target, ...)` method
```lua
    local result = vx.InvokeRpc("testRpc", source -- [[the target client that has to execute the rpc handler]], 5, 15) -- 20
```



