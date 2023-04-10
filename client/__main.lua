print('hello client')

vx.RegisterRpc('qwe', function(...)
    local res = 0
    for i, v in ipairs({
        ...
    }) do
        res = res + v
    end
    return res
end)

vx.RegisterKey('keyboard', 'q', 'Test', function()
    print('press')
end, function()
    vx.InvokeUiHandler('qeq', 1)
end)

