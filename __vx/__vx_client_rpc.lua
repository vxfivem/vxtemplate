local ERROR_EVENT = ('__vx::rpc::%s::error'):format(vx.CURRENT_RESOURCE)
local REPLY_EVENT = ('__vx::rpc::%s::reply'):format(vx.CURRENT_RESOURCE)
local REQUEST_EVENT = ('__vx::rpc::%s::request'):format(vx.CURRENT_RESOURCE)

local handlers = {}
local idGen = IdGenerator()
local promises = {}

RegisterNetEvent(ERROR_EVENT, function(id, name)
    local promise = promises[id]
    if not promise then
        return
    end
    promises[id] = nil
    idGen:release(id)
    promise:reject(('An error has occured during execution of an rpc handler %s'):format(name))
end)

RegisterNetEvent(REPLY_EVENT, function(id, result)
    local promise = promises[id]
    if not promise then
        return
    end
    promises[id] = nil
    idGen:release(id)
    promise:resolve(result)
end)

RegisterNetEvent(REQUEST_EVENT, function(name, id, args)
    local handler = handlers[name]
    if not handler then
        return TriggerServerEvent(ERROR_EVENT, id, string.format("Rpc event %s is not registered", name))
    end
    local success, result = pcall(handler, table.unpack(args))

    if IsPromise(result) then
        success, result = pcall(Citizen.Await, result)
    end

    if not success then
        TriggerServerEvent(ERROR_EVENT, id, string.format("Rpc event %s is failed with error. %s", name, result))
        error(result)
    end

    TriggerServerEvent(REPLY_EVENT, id, result)
end)

function vx.RegisterRpc(name, callback)
    assert(type(name) == 'string' and name ~= "", "name should be a non-empty string")
    assert(Isfunction(callback), 'callback should be a function')
    assert(not IsDefined(handlers[name]), string.format("rpc handler %s is already defined", name))

    handlers[name] = callback
end

function vx.InvokeRpc(name, ...)
    local id = idGen:generate()
    local promise = promise.new()
    promises[id] = promise
    TriggerServerEvent(REQUEST_EVENT, name, id, table.pack(...))
    return Citizen.Await(promise)
end
