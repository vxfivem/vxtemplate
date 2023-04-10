-- inspiration https://github.com/pitermcflebor/pmc-keybinds
local registeredKeys = {}

local function noop()

end

local COMMAND_NAME = 'keypress::' .. vx.CURRENT_RESOURCE

local function RegisterKey(layout, key, description, onPress, onRelease)
    assert(type(layout) == 'string', 'Invalid Lua type, layout argument expected string')
    assert(type(key) == 'string', 'Invalid Lua type, keyname argument expected string')
    assert(type(description) == 'string', 'Invalid Lua type, description argument expected string')

    if not onPress and not onRelease then
        error('At least onPress or onRelease callback has to be provided')
    end

    if registeredKeys[layout] == nil then
        registeredKeys[layout] = {}
    end
    if registeredKeys[layout][key] == nil then
        registeredKeys[layout][key] = {}
    end
    local _isDisabled = false

    local disable = function(v)
        _isDisabled = v
    end

    local isDisabled = function()
        return _isDisabled
    end

    table.insert(registeredKeys[layout][key], {
        onPress = onPress or noop,
        onRelease = onRelease or noop,
        isDisabled = isDisabled,
        disable = disable
    })

    RegisterKeyMapping(('+%s %s %s'):format(COMMAND_NAME, layout, key), description, layout:upper(), key:upper())

    return {
        layout = layout,
        keyname = key,
        isDisabled = isDisabled,
        disable = disable
    }
end

RegisterCommand('+' .. COMMAND_NAME, function(s, args)
    local layout = args[1]
    local keyname = args[2]
    if not layout or not keyname then
        return
    end

    local layoutLower, keynameLower = layout:lower(), keyname:lower()
    local cbs = registeredKeys[layoutLower] and registeredKeys[layoutLower][keynameLower]
    if not cbs then
        return
    end
    for i, v in ipairs(cbs) do
        if not v.isDisabled() then
            v.onPress(layoutLower, keynameLower, 'press')
        end
    end
end, false)

RegisterCommand('-' .. COMMAND_NAME, function(s, args)
    local layout = args[1]
    local keyname = args[2]
    if not layout or not keyname then
        return
    end

    local layoutLower, keynameLower = layout:lower(), keyname:lower()
    local cbs = registeredKeys[layoutLower] and registeredKeys[layoutLower][keynameLower]
    if not cbs then
        return
    end
    for i, v in ipairs(cbs) do
        if not v.isDisabled() then
            v.onRelease(layoutLower, keynameLower, 'release')
        end
    end

end, false)

vx.RegisterKey = RegisterKey
