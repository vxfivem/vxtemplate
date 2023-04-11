function vx.RegisterUiHandler(name, handler)
    assert(type(name) == 'string' and name ~= "", "name should be a non-empty string")
    assert(Isfunction(handler), 'callback should be a function')
    assert(not IsDefined(handlers[name]), string.format("rpc handler %s is already defined", name))

    RegisterNUICallback(name, function(data, cb)
        local success, result = pcall(handler, data)

        if IsPromise(result) then
            success, result = pcall(Citizen.Await, result)
        end

        if not success then
            cb({
                __error = result
            })
        end

        cb({
            __result = result
        })
    end)
end

function vx.InvokeUi(name, payload)
    SendNUIMessage({
        eventName = name,
        payload = payload
    })
end
