_G.vx = {}

vx.IS_SERVER = IsDuplicityVersion()
vx.IS_CLIENT = not vx.IS_SERVER
vx.CURRENT_RESOURCE = GetCurrentResourceName()
vx.IS_DEBUG = GetResourceMetadata(vx.CURRENT_RESOURCE, 'IS_DEBUG', 0) == 'true'

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

