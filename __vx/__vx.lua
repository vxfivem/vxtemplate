_G.vx = {}

vx.IS_SERVER = IsDuplicityVersion()
vx.IS_CLIENT = not vx.IS_SERVER
vx.CURRENT_RESOURCE = GetCurrentResourceName()
vx.IS_DEBUG = GetResourceMetadata(vx.CURRENT_RESOURCE, 'IS_DEBUG', 0) == 'true'
vx.LANGUAGE = GetResourceMetadata(vx.CURRENT_RESOURCE, 'LANGUAGE', 0) or 'en'

if not vx.IS_DEBUG then
    Logger.debug = function()

    end
end

vx.ENV = GetResourceMetadata(vx.CURRENT_RESOURCE, 'ENV', 0)

vx.logger = Logger("VX")

if not vx.ENV then
    vx.logger:warn("ENV metadata is not defined")
end

if not vx.IS_DEBUG then
    vx.logger:info("The current resource is set to release mode")
else
    vx.logger:info("The current resource is set to debug mode")
end

-- load locales
(function()
    local side = vx.IS_SERVER and 'server' or 'client'

    local sharedPath = string.format('locale/%s/locale.shared.json', vx.LANGUAGE)
    local localPath = string.format('locale/%s/locale.%s.json', vx.LANGUAGE, side)

    local toLoad = {
        {
            name = "shared",
            path = sharedPath
        },
        {
            name = side,
            path = localPath
        }
    }

    local locale = Luang()

    for i, v in ipairs(toLoad) do
        local fileContent = LoadResourceFile(vx.CURRENT_RESOURCE, v.path)
        local parse = true
        if fileContent == nil or fileContent == "" then
            parse = false
            vx.logger:debug(string.format("Missing %s locale. Language = %s.", v.name, vx.LANGUAGE))
        end

        if parse then
            local content = json.decode(fileContent)
            locale:load(content)
            vx.logger:debug(string.format("Loaded %s locale. Lang = %s", v.name, vx.LANGUAGE))
        end

    end

    vx.locale = locale.lang

end)()

