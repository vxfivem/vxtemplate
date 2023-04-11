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

#### vx uses [Luang](https://github.com/ImagicTheCat/Luang) package for localization porpuses.

Both `server` and `client` sides load `locale/<vx.LANUGAGE>/locale.shared.json`.
After that, `server` loads `locale/<vx.LANUGAGE>/locale.server.json`, and `client` loads `locale/<vx.LANUGAGE>/locale.client.json`.
If `shared` locale has values by the same key as `server` or `client`, the shared value gets overwritten by `server` or `client` value, depending on what side the script is loaded

## OOP

vx uses [Luaoop](https://github.com/ImagicTheCat/Luaoop) package for oop porpuses

## UI

The repository contains a custom react-vite-typescript-redux-toolkit [template](./ui-src).

#### Client integration

To call any callback that is registered by `vx.RegisterUiHandler(name, handler)` or [SendNUIMessage](https://docs.fivem.net/docs/scripting-manual/nui-development/nui-callbacks/) function look at the example below

```ts
import { gameEmitter } from "relative.path/game.emitter";

// ...

const payload = { someValue: 42 };
const value = await gameEmitter.emitAsync<number>("nuiCallbackName", payload); // 21
```

```lua
vx.RegisterUiHandler("nuiCallbackName", function(data)
    local valueFromUI = data.someValue -- same object you passed as payload to gameEmitter.emit
    return valueFromUI / 2
end)

-- OR

RegisterNUICallback("nuiCallbackName", function(data, cb)
    local valueFromUI = data.someValue -- same object you passed as payload to gameEmitter.emit
    cb(valueFromUI / 2)
end)
```

if you dont need the result, you can just simply replicate the following example

```ts
import { gameEmitter } from "relative.path/game.emitter";

// ...

const payload = { someValue: 42 };
gameEmitter.emit("nuiCallbackName", payload); // returns void
```

It is also possible to listen for client-triggered events on browser's side

```ts
import { gameEmitter } from "relative.path/game.emitter";

const handler = (value: number) => {
  console.log(value); // 42
};

gameEmitter.on("someNuiEventName", handler);
```

Invoking it from client

```lua
vx.InvokeUi("someNuiEventName", 42)
```

You can unlisten any event as well

```ts
import { gameEmitter } from "relative.path/game.emitter";

const handler = (value: number) => {
  console.log(value); // 42
};

gameEmitter.on("someNuiEventName", handler);

// do some logic

gameEmitter.off("someNuiEventName", handler);
```

## Used solutions

- **Luaoop** - https://github.com/ImagicTheCat/Luaoop
- **Luang** - https://github.com/ImagicTheCat/Luang
