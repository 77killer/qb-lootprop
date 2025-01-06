local QBCore = exports['qb-core']:GetCoreObject()

-- Define lootable props and their states
local lootableProps = {
    {
        model = `prop_crate_01a`,
        coords = vector3(123.45, 456.78, 789.01),
        heading = 0.0,
        lootCooldown = 300, -- Cooldown in seconds
        lastLooted = 0      -- Timestamp of last loot
    }
}

-- Register loot interaction event
RegisterNetEvent('loot:interact', function(entity)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    -- Find the corresponding prop
    for _, prop in pairs(lootableProps) do
        if entity == prop.entity then
            -- Check cooldown
            if (os.time() - prop.lastLooted) < prop.lootCooldown then
                TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'This crate is empty. Try again later!' })
                return
            end

            -- Update the last looted time
            prop.lastLooted = os.time()

            -- Generate random loot
            local rewards = {
                { item = 'bread', amount = 1, chance = 50 },
                { item = 'water', amount = 1, chance = 50 },
                { item = 'goldbar', amount = 1, chance = 10 } -- Example rare loot
            }

            local foundLoot = false
            for _, reward in pairs(rewards) do
                if math.random(1, 100) <= reward.chance then
                    exports.ox_inventory:AddItem(src, reward.item, reward.amount)
                    TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = 'You found ' .. reward.item .. '!' })
                    foundLoot = true
                end
            end

            -- Notify player if nothing was found
            if not foundLoot then
                TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You found nothing.' })
            end

            return
        end
    end
end)
