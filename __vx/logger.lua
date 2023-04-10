local colors
local IS_SERVER = IsDuplicityVersion()

if IS_SERVER then
    colors = {
        Orange = '\x1b[33m',
        Green = '\x1b[32m',
        Yellow = '\x1b[93m',
        Blue = '\x1b[34m',
        LightBlue = '\x1b[94m',
        Purple = '\x1b[35m',
        Reset = '\x1b[0m',
        Red = '\x1b[31m'
    }
else
    colors = {
        Orange = "^1",
        Green = "^2",
        Yellow = "^3",
        Blue = "^4",
        LightBlue = "^5",
        Purple = "^6",
        Reset = "^7",
        Red = "^9"
    }

end

Logger = class('Logger')

local function getTimestamp()
    local ts = os.date('%Y-%m-%d %H:%M:%S', os.time())
    return ' [' .. ts .. ']'
end

if not IS_SERVER then
    getTimestamp = function()
        local year, month, day, hour, minute, second = GetLocalTime()

        local ts = ('%04d-%02d-%02d %02d:%02d:%02d'):format(year, month, day, hour, minute, second)
        return ' [' .. ts .. ']'

    end
end

local function write(self, color, prefix, message)
    local ts = getTimestamp()
    message = message or "nil"
    print(string.format("%s[%s] [%s]%s - %s%s", color, self.context, prefix, ts, message, colors.Reset))
end

function Logger:__construct(context)
    assert(context ~= nil, "context is required")
    self.context = context
    return self
end

function Logger:debug(message)
    write(self, colors.LightBlue, 'DEBUG', message);
end

function Logger:error(error, message)
    if message then
        write(self, colors.Red, 'ERROR', message);
    end
    write(self, colors.Red, 'ERROR', error);
end

function Logger:info(message)
    write(self, colors.Green, 'INFO', message);
end

function Logger:log(message)
    write(self, colors.Blue, 'LOG', message);
end

function Logger:warn(message)
    write(self, colors.Orange, 'WARN', message);
end

