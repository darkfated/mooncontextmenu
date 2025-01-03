local function Create()
    MoonContextMenuScrollPos = MoonContextMenuScrollPos or 0

    MoonContextMenu.menu = vgui.Create('MantleFrame', g_ContextMenu)
    MoonContextMenu.menu:SetSize(300, 500)
    MoonContextMenu.menu:SetTitle('')
    MoonContextMenu.menu:DisableCloseBtn()
    MoonContextMenu.menu:SetAlphaBackground(true)

    if !MoonContextMenu.pos_save then
        MoonContextMenu.pos_save = {10, Mantle.func.sh * 0.5 - MoonContextMenu.menu:GetTall() * 0.5}
    end

    MoonContextMenu.menu:SetPos(MoonContextMenu.pos_save[1], MoonContextMenu.pos_save[2])
    MoonContextMenu.menu:SetMouseInputEnabled(true)
    MoonContextMenu.menu:SetCenterTitle('Список команд')

    MoonContextMenu.menu.sp = vgui.Create('MantleScrollPanel', MoonContextMenu.menu)
    MoonContextMenu.menu.sp:Dock(FILL)

    for _, cat in ipairs(MoonContextMenu.config_cmds) do
        if cat.check and !cat.check() then
            continue
        end

        for _, cmd in ipairs(cat.items) do
            local btnCommand = vgui.Create('MantleBtn', MoonContextMenu.menu.sp)
            btnCommand:Dock(TOP)
            btnCommand:DockMargin(0, 0, 0, 4)
            btnCommand:SetTall(24)
            btnCommand:SetTxt(cmd.name)
            btnCommand.DoClick = function()
                Mantle.func.sound()

                cmd.func()
            end
            btnCommand.DoRightClick = function()
                local DM = Mantle.ui.derma_menu()
                DM:AddOption('Сбросить позицию', function()
                    MoonContextMenu.pos_save = nil
                    MoonContextMenu.menu:Remove()
                end, 'icon16/arrow_out.png')
            end

            if cmd.icon then
                btnCommand.mat = Material('materials/mooncontextmenu/' .. cmd.icon .. '.png')

                btnCommand.PaintOver = function(self, w, h) 
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(self.mat)
                    surface.DrawTexturedRect(4, 4, 16, 16)
                end
            end
        end

        local panelSplit = vgui.Create('DPanel', MoonContextMenu.menu.sp)
        panelSplit:Dock(TOP)
        panelSplit:DockMargin(0, 0, 0, 4)
        panelSplit:SetTall(8)
        panelSplit.Paint = function(_, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Mantle.color.panel_alpha[2])
        end
    end

    MoonContextMenu.menu.sp:GetVBar():AnimateTo(MoonContextMenuScrollPos, 0, 0)
end

local function Close()
    if !IsValid(MoonContextMenu.menu) then
        return
    end

    MoonContextMenuScrollPos = MoonContextMenu.menu.sp:GetVBar():GetScroll()

    MoonContextMenu.pos_save[1], MoonContextMenu.pos_save[2] = MoonContextMenu.menu:GetPos()
    MoonContextMenu.menu:Remove()
end

hook.Add('OnContextMenuOpen', 'Mantle.MoonContextMenu', function()
    if !IsValid(MoonContextMenu.menu) then
        Create()
    end
end)

hook.Add('OnContextMenuClose', 'Mantle.MoonContextMenu', function()
    Close()
end)
