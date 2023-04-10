print('hello server')

RegisterCommand('c', function(source)
    print('qwe')
    local val = vx.InvokeRpc('qwe', source, 1, 2, 3, 4)
    print(val)
end, false)
