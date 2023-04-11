vx.logger:debug(vx.locale.test.client({
    testVal = "TEST 1"
}))
vx.logger:debug(vx.locale.test.shared({
    testVal = "TEST 2"
}))

RegisterNUICallback("nuiCallbackName", function(data, cb)
    local valueFromUI = data.someValue -- same object you passed as payload to gameEmitter.emit
    cb(valueFromUI / 2)
end)
