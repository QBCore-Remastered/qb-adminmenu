local selectedPlayer
local playerOptions = {
    function()
        lib.showMenu('qbx_adminmenu_player_general_menu', MenuIndexes.qbx_adminmenu_player_general_menu)
    end,
    function()
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    end,
    function()
        lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
    end,
    function()
        local input = lib.inputDialog('Name Change', {'Firstname', 'Lastname'})
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'name', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Food', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'food', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Thirst', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'thirst', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Stress', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'stress', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Armor', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'armor', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Phone', {'Number'})
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'phone', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Crafting', {
            {type = 'number', label = 'Reputation'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'crafting', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Dealer', {
            {type = 'number', label = 'Reputation'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'dealer', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Money', {
            {type = 'number', label = 'Cash'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'cash', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Money', {
            {type = 'number', label = 'Bank'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'bank', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Job', {
            {type = 'input', label = 'Name'},
            {type = 'number', label = 'Grade'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'job', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Gang', {
            {type = 'input', label = 'Name'},
            {type = 'number', label = 'Grade'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'gang', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Radio', {
            {type = 'number', label = 'Frequency'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'radio', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local license = selectedPlayer.license:gsub('license:', '')
        lib.setClipboard(license)
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id)])
    end,
    function()
        local discord = selectedPlayer.discord:gsub('discord:', '')
        lib.setClipboard(discord)
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id)])
    end,
    function()
        local steam = selectedPlayer.steam:gsub('steam:', '')
        lib.setClipboard(steam)
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id)])
    end,
}

function GeneratePlayersMenu()
    local players = lib.callback.await('qbx_admin:server:getPlayers', false)
    if not players then
        lib.showMenu('qbx_adminmenu_main_menu', MenuIndexes.qbx_adminmenu_main_menu)
        return
    end
    local optionsList = {}
    for i = 1, #players do
        optionsList[#optionsList + 1] = {label = string.format('ID: %s | Name: %s', players[i].id, players[i].name), description = string.format('CID: %s | %s', players[i].cid, players[i].license), args = {players[i]}}
    end
    lib.registerMenu({
        id = 'qbx_adminmenu_players_menu',
        title = Lang:t('title.players_menu'),
        position = 'top-right',
        onClose = function(keyPressed)
            closeMenu(false, keyPressed, 'qbx_adminmenu_main_menu')
        end,
        onSelected = function(selected)
            MenuIndexes.qbx_adminmenu_players_menu = selected
        end,
        options = optionsList
    }, function(_, _, args)
        local player = lib.callback.await('qbx_admin:server:getPlayer', false, args[1].id)
        if not player then
            lib.showMenu('qbx_adminmenu_main_menu', MenuIndexes.qbx_adminmenu_main_menu)
            return
        end
        lib.registerMenu({
            id = ('qbx_adminmenu_player_menu_%s'):format(args[1].id),
            title = player.name,
            position = 'top-right',
            onClose = function(keyPressed)
                closeMenu(false, keyPressed, 'qbx_adminmenu_players_menu')
            end,
            onSelected = function(selected)
                MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(args[1].id)] = selected
            end,
            options = {
                {label = Lang:t('player_options.label1'), description = Lang:t('player_options.desc1'), icon = 'fas fa-wrench'},
                {label = Lang:t('player_options.label2'), description = Lang:t('player_options.desc2'), icon = 'fas fa-file-invoice'},
                {label = Lang:t('player_options.label3'), description = Lang:t('player_options.desc3'), icon = 'fas fa-gamepad'},
                {label = string.format('Name: %s', player.name)},
                {label = string.format('Food: %s', player.food)},
                {label = string.format('Water: %s', player.water)},
                {label = string.format('Stress: %s', player.stress)},
                {label = string.format('Armor: %s', player.armor)},
                {label = string.format('Phone: %s', player.phone)},
                {label = string.format('Crafting Rep: %s', player.craftingrep)},
                {label = string.format('Dealer Rep: %s', player.dealerrep)},
                {label = string.format('Cash: %s', CommaValue(player.cash))},
                {label = string.format('Bank: %s', CommaValue(player.bank))},
                {label = string.format('Job: %s', player.job)},
                {label = string.format('Gang: %s', player.gang)},
                {label = string.format('Radio: %s', Player(args[1].id).state.radioChannel)},
                {label = string.format('%s', player.license), description = 'License'},
                {label = string.format('%s', player.discord), description = 'Discord'},
                {label = string.format('%s', player.steam), description = 'Steam'}
            }
        }, function(selected)
            playerOptions[selected]()
        end)
        selectedPlayer = player
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(args[1].id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(args[1].id)])
    end)
    lib.showMenu('qbx_adminmenu_players_menu', MenuIndexes.qbx_adminmenu_players_menu)
end

lib.registerMenu({
    id = 'qbx_adminmenu_player_general_menu',
    title = Lang:t('player_options.label1'),
    position = 'top-right',
    onClose = function(keyPressed)
        closeMenu(false, keyPressed, ('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id))
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_player_general_menu = selected
    end,
    options = {
        {label = Lang:t('player_options.general.labelkill'), description = Lang:t('player_options.general.desckill'), icon = 'fas fa-skull', close = false},
        {label = Lang:t('player_options.general.labelrevive'), description = Lang:t('player_options.general.descrevive'), icon = 'fas fa-cross', close = false},
        {label = Lang:t('player_options.general.labelfreeze'), description = Lang:t('player_options.general.descfreeze'), icon = 'fas fa-icicles', close = false},
        {label = Lang:t('player_options.general.labelgoto'), description = Lang:t('player_options.general.descgoto'), icon = 'fas fa-arrow-right-long', close = false},
        {label = Lang:t('player_options.general.labelbring'), description = Lang:t('player_options.general.descbring'), icon = 'fas fa-arrow-left-long', close = false},
        {label = Lang:t('player_options.general.labelsitinveh'), description = Lang:t('player_options.general.descsitinveh'), icon = 'fas fa-chair', close = false},
        {label = Lang:t('player_options.general.labelrouting'), description = Lang:t('player_options.general.descrouting'), icon = 'fas fa-bucket'},
    }
}, function(selected)
    if selected == 7 then
        local input = lib.inputDialog(selectedPlayer.name, {
            {type = 'number', label = Lang:t('player_options.general.labelrouting'), placeholder = '25'}
        })
        if not input then return end if not input[1] then return end
        TriggerServerEvent('qbx_admin:server:playerOptionsGeneral', selected, selectedPlayer, input[1])
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id)])
    else
        TriggerServerEvent('qbx_admin:server:playerOptionsGeneral', selected, selectedPlayer)
    end
end)

lib.registerMenu({
    id = 'qbx_adminmenu_player_administration_menu',
    title = Lang:t('player_options.label2'),
    position = 'top-right',
    onClose = function(keyPressed)
        closeMenu(false, keyPressed, ('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id))
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_player_administration_menu = selected
    end,
    options = {
        {label = Lang:t('player_options.administration.labelkick'), description = Lang:t('player_options.administration.desckick'), icon = 'fas fa-plane-departure'},
        {label = Lang:t('player_options.administration.labelban'), description = Lang:t('player_options.administration.descban'), icon = 'fas fa-gavel'},
        {label = Lang:t('player_options.administration.labelperm'), description = Lang:t('player_options.administration.descperm'), values = {Lang:t('player_options.administration.permvalue1'),
        Lang:t('player_options.administration.permvalue2'), Lang:t('player_options.administration.permvalue3'), Lang:t('player_options.administration.permvalue4')}, args = {'remove', 'mod', 'admin', 'god'}, icon = 'fas fa-book-bookmark'},
    }
}, function(selected, scrollIndex, args)
    if selected == 1 then
        local input = lib.inputDialog(selectedPlayer.name, {Lang:t('player_options.administration.inputkick')})
        if not input then lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu) return end if not input[1] then return end
        TriggerServerEvent('qbx_admin:server:playerAdministration', selected, selectedPlayer, input[1])
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    elseif selected == 2 then
        local input = lib.inputDialog(selectedPlayer.name, {
            { type = 'input', label = Lang:t('player_options.administration.inputkick'), placeholder = 'VDM'},
            { type = 'number', label = Lang:t('player_options.administration.input1ban')},
            { type = 'number', label = Lang:t('player_options.administration.input2ban')},
            { type = 'number', label = Lang:t('player_options.administration.input3ban')}
        })
        if not input then lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_general_menu) return end if not input[1] or not input[2] and not input[3] and not input[4] then return end
        TriggerServerEvent('qbx_admin:server:playerAdministration', selected, selectedPlayer, input)
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    else
        TriggerServerEvent('qbx_admin:server:playerAdministration', selected, selectedPlayer, args[scrollIndex])
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    end
end)

lib.registerMenu({
    id = 'qbx_adminmenu_player_extra_menu',
    title = Lang:t('player_options.label2'),
    position = 'top-right',
    onClose = function(keyPressed)
        closeMenu(false, keyPressed, ('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id))
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_player_extra_menu = selected
    end,
    options = {
        {label = 'Open Inventory'},
        {label = 'Give Clothing Menu'},
        {label = 'Give Item'},
        {label = 'Play Sound'},
        {label = 'Mute'}
    }
}, function(selected)
    if selected == 1 then
        ExecuteCommand(('viewinv %s'):format(selectedPlayer.id))
    elseif selected == 2 then
        local succeeded = lib.callback.await('qbx_admin:server:clothingMenu', false, selectedPlayer.id)
        if succeeded then return end
        lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
    elseif selected == 3 then
        local dialog = lib.inputDialog('Give Item', {
            {type = 'input', label = 'Item', placeholder = 'phone'},
            {type = 'number', label = 'Amount', default = 1}
        })
        if not dialog or not dialog[1] or dialog[1] == '' or not dialog[2] or dialog[2] < 1 then
            lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
            return
        end
        ExecuteCommand('giveitem ' .. selectedPlayer.id .. ' ' .. dialog[1] .. ' ' .. dialog[2])
    elseif selected == 4 then
        local sounds = lib.callback.await('qbx_admin:server:getSounds', false)
        if not sounds then
            lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
            return
        end

        for i = 1, #sounds do
            lib.setMenuOptions('qbx_adminmenu_play_sounds_menu', {label = sounds[i], description = 'Press enter to play this sound', args = {sounds[i]}, close = false}, i + 2)
        end

        lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
    elseif selected == 5 then
        exports['pma-voice']:toggleMutePlayer(selectedPlayer.id)
    end
end)

local volume = {1, 0.1}
local radius = {1, 10}

lib.registerMenu({
    id = 'qbx_adminmenu_play_sounds_menu',
    title = 'Play Sounds',
    position = 'top-right',
    onClose = function(keyPressed)
        closeMenu(false, keyPressed, 'qbx_adminmenu_player_extra_menu')
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_play_sounds_menu = selected
    end,
    onSideScroll = function(_, scrollIndex, args)
        if args == 'volume' then
            if scrollIndex == 11 then return end
            volume[2] = scrollIndex / 10
            lib.setMenuOptions('qbx_adminmenu_play_sounds_menu', {label = 'Volume', args = {'volume'}, values = {'0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', 'input'}, defaultIndex = scrollIndex, close = false}, 1)
        elseif args == 'radius' then
            if scrollIndex == 11 then return end
            radius[2] = scrollIndex * 10
            lib.setMenuOptions('qbx_adminmenu_play_sounds_menu', {label = 'Radius', args = {'radius'}, values = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', 'input'}, defaultIndex = scrollIndex, close = false}, 2)
        end
    end,
    options = {
        {label = 'Volume', description = 'Volume to play the sound at', args = {'volume'}, values = {'0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', 'input'}, defaultIndex = volume[1], close = false},
        {label = 'Radius', description = 'The higher this number, the further away the sound can be heard from', args = {'radius'}, values = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', 'input'}, defaultIndex = radius[1], close = false}
    }
}, function(_, scrollIndex, args)
    if args[1] == 'volume' then
        if scrollIndex ~= 11 then return end
        lib.hideMenu(false)
        local dialog = lib.inputDialog('Set Volume Manually', {'Volume (0.00 - 1.00'})
        if not dialog or not dialog[1] or dialog[1] == '' or not tonumber(dialog[1]) then
            Wait(200)
            lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
            return
        end

        local result = tonumber(dialog[1])

        if result < 0 or result > 1 then
            exports.qbx_core:Notify('The number has to be between 0.00 and 1.00', 'error')
            Wait(200)
            lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
            return
        end

        volume[2] = result --[[@as number]]
        lib.setMenuOptions('qbx_adminmenu_play_sounds_menu', {label = 'Volume', args = {'volume'}, values = {'0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', 'input'}, defaultIndex = scrollIndex, close = false}, 1)
        Wait(200)
        lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
        return
    elseif args[1] == 'radius' then
        if scrollIndex ~= 11 then return end
        lib.hideMenu(false)
        local dialog = lib.inputDialog('Set Radius Manually', {'Radius (1 - 100'})
        if not dialog or not dialog[1] or dialog[1] == '' or not tonumber(dialog[1]) then
            Wait(200)
            lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
            return
        end

        local result = tonumber(dialog[1])

        if result < 1 or result > 100 then
            exports.qbx_core:Notify('The number has to be between 1 and 100', 'error')
            Wait(200)
            lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
            return
        end

        radius[2] = result --[[@as number]]
        lib.setMenuOptions('qbx_adminmenu_play_sounds_menu', {label = 'Radius', args = {'radius'}, values = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', 'input'}, defaultIndex = scrollIndex, close = false}, 2)
        Wait(200)
        lib.showMenu('qbx_adminmenu_play_sounds_menu', MenuIndexes.qbx_adminmenu_play_sounds_menu)
        return
    end

    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', radius[2], args[1], volume[2])
end)
