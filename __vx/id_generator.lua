IdGenerator = class('IdGenerator')

function IdGenerator:__construct()
    self.value = math.mininteger
    self.stack = {}
end

function IdGenerator:generate()
    local value = table.remove(self.stack)
    if value ~= nil then
        return value
    end
    self.value = self.value + 1
    return self.value
end

function IdGenerator:release(value)
    table.insert(self.stack, value)
end
