MoonContextMenu.config_cmds = {
    {
        items = {
            {
                name = 'Админка',
                func = function()
                    RunConsoleCommand('sam', 'menu')
                end,
                icon = 'wrench'
            },
            {
                name = 'Логи',
                func = function()
                    RunConsoleCommand('say', '!plogs')
                end,
                icon = 'logs'
            }
        },
        check = function()
            return table.HasValue(DarkFated.admins_rank, LocalPlayer():GetUserGroup())
        end
    },
    {
        items = {
            {
                name = 'Банды',
                func = function()
                    RunConsoleCommand('fated_gang_open')
                end,
                icon = 'gangs'
            },
            {
                name = 'Расписание',
                func = function()
                    RunConsoleCommand('mantle_schedule')
                end,
                icon = 'schedule'
            },
            {
                name = 'Третье лицо',
                func = function()
                    RunConsoleCommand('third_person_menu')
                end,
                icon = 'camera'
            }
        }
    },
    {
        items = {
            {
                name = 'Выкинуть оружие',
                func = function()
                    RunConsoleCommand('darkrp', 'dropweapon')
                end,
                icon = 'gun'
            },
            {
                name = 'Выбросить деньги',
                func = function()
                    Mantle.ui.text_box('Выбросить деньги', 'Сколько желаете?', function(s)
                        RunConsoleCommand('darkrp', 'dropmoney', s)
                    end)
                end,
                icon = 'drop_money'
            },
            {
                name = 'Передать игроку деньги',
                func = function()
                    Mantle.ui.text_box('Передать деньги', 'Сколько желаете?', function(s)
                        RunConsoleCommand('darkrp', 'give', s)
                    end)
                end,
                icon = 'give_money'
            },
            {
                name = 'Сменить ник',
                func = function()
                    Mantle.ui.text_box('Сменить ник', 'Какой хотите поставить?', function(s)
                        RunConsoleCommand('darkrp', 'rpname', s)
                    end)
                end,
                icon = 'nick'
            },
            {
                name = 'Продать все двери',
                func = function()
                    RunConsoleCommand('darkrp', 'unownalldoors')
                end,
                icon = 'doors'
            },
            {
                name = 'Написать объявление',
                func = function()
                    Mantle.ui.text_box('Написать объявление', 'Что планируете рекламировать?', function(s)
                        RunConsoleCommand('say', '/advert ' .. s)
                    end)
                end,
                icon = 'advert'
            },
            {
                name = 'Кинуть ролл',
                func = function()
                    RunConsoleCommand('darkrp', 'roll', 100)
                end,
                icon = 'roll'
            }
        }
    },
    {
        items = {
            {
                name = 'Назначить розыск',
                func = function()
                    Mantle.ui.player_selector(function(pl)
                        Mantle.ui.text_box('Назначить розыск', 'Какова причина?', function(s)
                            RunConsoleCommand('darkrp', 'wanted', pl:Name(), s)
                        end)
                    end, function(pl)
                        return pl:getJobTable().adult
                    end)
                end,
                icon = 'wanted'
            },
            {
                name = 'Снять розыск',
                func = function()
                    Mantle.ui.player_selector(function(pl)
                        RunConsoleCommand('darkrp', 'unwanted', pl:Name())
                    end, function(pl)
                        return pl:getJobTable().adult
                    end)
                end,
                icon = 'unwanted'
            },
            {
                name = 'Получить орден',
                func = function()
                    Mantle.ui.player_selector(function(pl)
                        Mantle.ui.text_box('Получить орден', 'Какова причина?', function(s)
                            RunConsoleCommand('darkrp', 'warrant', pl:Name(), s)
                        end)
                    end, function(pl)
                        return pl:getJobTable().adult
                    end)
                end,
                icon = 'warrant'
            },
            {
                name = 'Устав',
                func = function()
                    RunConsoleCommand('simplelaws_open')
                end,
                icon = 'schedule'
            }
        },
        check = function()
            return LocalPlayer():getJobTable().adult
        end
    },
    {
        items = {
            {
                name = 'Вызвать админа',
                func = function()
                end,
                icon = 'help'
            },
            {
                name = 'Вкл/Выкл третье лицо',
                func = function()
                    RunConsoleCommand('third_person_toggle')
                end,
                icon = 'thirdperson_toggle'
            },
            {
                name = 'Остановить все звуки',
                func = function()
                    RunConsoleCommand('stopsound')
                end,
                icon = 'sounds'
            }
        }  
    }
}
