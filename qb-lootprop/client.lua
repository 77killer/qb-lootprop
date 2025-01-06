print('Config Loaded:', Config ~= nil) -- This should print "Config Loaded: true" if config.lua is loaded.
if Config then
    print('Lootable Props:', json.encode(Config.lootableProps))
end


CreateThread(function()
    for _, prop in pairs(Config.lootableProps) do
        print('Prop:', prop.model) -- Debug print each prop's model
        local model = GetHashKey(prop.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        local obj = CreateObject(model, prop.coords.x, prop.coords.y, prop.coords.z, false, false, true)
        SetEntityHeading(obj, prop.heading)
        FreezeEntityPosition(obj, true)
        SetModelAsNoLongerNeeded(model)

        -- Add ox_target interaction
        exports.ox_target:addLocalEntity(obj, {
            {
                name = 'loot_prop_' .. obj,
                event = 'loot:clientInteract',
                icon = 'fas fa-box',
                label = 'Search Crate',
            }
        })
    end
end)
