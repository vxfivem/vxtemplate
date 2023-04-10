function Isfunction(f)
    if type(f) == 'table' then
        local mt = getmetatable(f)
        return mt ~= nil and type(mt.__call) == 'function'
    end
    return type(f) == 'function'
end

function IsPromise(p)
    if type(p) ~= 'table' then
        return false
    end

    return type(p.next) == 'function' and type(p.state) == 'number' and type(p.queue) == 'table'
end

function IsDefined(val)
    return val ~= nil
end
