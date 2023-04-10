local ERROR_EVENT = ('__vx::rpc::%s::error'):format(vx.CURRENT_RESOURCE)
local REPLY_EVENT = ('__vx::rpc::%s::reply'):format(vx.CURRENT_RESOURCE)
local REQUEST_EVENT = ('__vx::rpc::%s::request'):format(vx.CURRENT_RESOURCE)
local logger = Logger("VX_RPC")
local handlers = {}
local playerPromises = {}

RegisterNetEvent(ERROR_EVENT, function(id, name, error)
    local source = source
    if not playerPromises[source] then
        return
    end

    local promises = playerPromises[source].promises
    local idGen = playerPromises[source].idGen

    local promise = promises[id]
    if not promise then
        return
    end

    promises[id] = nil
    idGen:release(id)
    promise:reject(('An error has occured during execution of an rpc handler %s. Error = %s'):format(name, error))
end)

RegisterNetEvent(REPLY_EVENT, function(id, result)
    local source = source
    if not playerPromises[source] then
        return
    end

    local promises = playerPromises[source].promises
    local idGen = playerPromises[source].idGen

    local promise = promises[id]
    if not promise then
        return
    end

    promises[id] = nil
    idGen:release(id)
    promise:resolve(result)
end)

RegisterNetEvent(REQUEST_EVENT, function(name, id, args)
    local source = source
    local handler = handlers[name]
    if not handler then
        logger:debug(string.format("Rpc event %s is not registered", name))
        return TriggerClientEvent(ERROR_EVENT, source, id, name)
    end
    local success, result = pcall(handler, source, table.unpack(args))

    if IsPromise(result) then
        success, result = pcall(Citizen.Await, result)
    end

    if not success then
        TriggerClientEvent(ERROR_EVENT, source, id, string.format("Rpc event %s is failed with error.", name))
        error(result)
    end

    TriggerClientEvent(REPLY_EVENT, source, id, result)
end)

AddEventHandler('playerDropped', function(source)
    local source = source
    if not playerPromises[source] then
        return
    end
    local promises = playerPromises[source].promises
    playerPromises[source] = nil
    local reason = ("Player %s is dropped. Aborting the promise"):format(source)
    for k, v in pairs(promises) do
        v:reject((reason))
    end
end)

function vx.RegisterRpc(name, callback)
    assert(type(name) == 'string' and name ~= "", "name should be a non-empty string")
    assert(Isfunction(callback), 'callback should be a function')
    assert(not IsDefined(handlers[name]), string.format("rpc handler %s is already defined", name))
    handlers[name] = callback
end

function vx.InvokeRpc(name, target, ...)
    if not playerPromises[target] then
        playerPromises[target] = {
            idGen = IdGenerator(),
            promises = {}
        }
    end
    local promises = playerPromises[target].promises
    local idGen = playerPromises[target].idGen
    local id = idGen:generate()
    local promise = promise.new()
    promises[id] = promise
    TriggerClientEvent(REQUEST_EVENT, target, name, id, table.pack(...))
    return Citizen.Await(promise)
end

