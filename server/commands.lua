local config = require 'config.server'.commandPerms

lib.addCommand('admin', {
    help = 'Opens Adminmenu',
    restricted = config.useMenu,
}, function(source)
    TriggerClientEvent('qbx_admin:client:openMenu', source)
end)

lib.addCommand('noclip', {
    help = 'Toggle NoClip',
    restricted = config.noclip,
}, function(source)
    TriggerClientEvent('qbx_admin:client:noclip', source)
end)

lib.addCommand('names', {
    help = 'Toggle Player Names',
    restricted = config.names,
}, function(source)
    TriggerClientEvent('qbx_admin:client:names', source)
end)

lib.addCommand('blips', {
    help = 'Toggle Player Blips',
    restricted = config.blips,
}, function(source)
    TriggerClientEvent('qbx_admin:client:blips', source)
end)

lib.addCommand('admincar', {
    help = 'Buy Vehicle',
    restricted = config.saveVeh,
}, function(source)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local vehicles = exports.qbx_core:GetVehiclesByName()
    local vehModel, vehicle, props = lib.callback.await('qbx_admin:client:GetVehicleInfo', src)

    if vehicle == 0 then
        return exports.qbx_core:Notify(src, "You have to be in a vehicle, to use this", 'error')
    end

    if vehicles[vehModel] == nil then
        return exports.qbx_core:Notify(src, "Unknown vehicle, please contact your developer to register it.", 'error')
    end

    local isVehicleOwned = MySQL.scalar.await('SELECT count(*) from player_vehicles WHERE plate = ?', {props.plate})
    
    if isVehicleOwned > 0 then
        return exports.qbx_core:Notify(src, "This vehicle is already owned.", 'error')
    end

    MySQL.insert(
        'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            player.PlayerData.license,
            player.PlayerData.citizenid, vehModel,
            GetHashKey(vehModel),
            json.encode(props),
            props.plate,
            0
        })
    exports.qbx_core:Notify(src, "This vehicle is now yours.", 'success')
end)

lib.addCommand('setmodel', {
    help = 'Sets your model to the given model',
    restricted = config.setModel,
    params = {
        {name = 'model', help = 'NPC Model', type = 'string'},
        {name = 'id', help = 'Player ID', type = 'number', optional = true},
    }
}, function(source, args)
    local Target = args.id or source

    if not exports.qbx_core:GetPlayer(Target) then return end

    TriggerClientEvent('qbx_admin:client:setModel', Target, args.model)
end)

lib.addCommand('vec2', {
    help = 'Copy vector2 to clipboard (Admin only)',
    restricted = config.dev,
}, function(source)
    TriggerClientEvent('qbx_admin:client:copyToClipboard', source, 'coords2')
end)

lib.addCommand('vec3', {
    help = 'Copy vector3 to clipboard (Admin only)',
    restricted = config.dev,
}, function(source)
    TriggerClientEvent('qbx_admin:client:copyToClipboard', source, 'coords3')
end)

lib.addCommand('vec4', {
    help = 'Copy vector4 to clipboard (Admin only)',
    restricted = config.dev,
}, function(source)
    TriggerClientEvent('qbx_admin:client:copyToClipboard', source, 'coords4')
end)

lib.addCommand('heading', {
    help = 'Copy heading to clipboard (Admin only)',
    restricted = config.dev,
}, function(source)
    TriggerClientEvent('qbx_admin:client:copyToClipboard', source, 'heading')
end)