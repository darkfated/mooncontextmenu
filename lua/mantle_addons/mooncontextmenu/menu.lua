local scrw, scrh = ScrW(), ScrH()

local function Create()
    MoonContextMenu.menu = vgui.Create('DFrame')
    Mantle.ui.frame(MoonContextMenu.menu, '', 300, 500, false)

    if MoonContextMenu.pos_save then
        MoonContextMenu.menu:SetPos(MoonContextMenu.pos_save[1], MoonContextMenu.pos_save[2])
    else
        MoonContextMenu.menu:SetPos(10, 0)
        MoonContextMenu.menu:CenterVertical()
    end

    MoonContextMenu.menu:MakePopup()
    MoonContextMenu.menu.center_title = 'Список команд'

    MoonContextMenu.menu.sp = vgui.Create('DScrollPanel', MoonContextMenu.menu)
    Mantle.ui.sp(MoonContextMenu.menu.sp)
    MoonContextMenu.menu.sp:Dock(FILL)

    for _, cat in ipairs(MoonContextMenu.config_cmds) do
        if cat.check and !cat.check() then
            continue
        end

        for _, cmd in ipairs(cat.items) do
            local btn_cmd = vgui.Create('DButton', MoonContextMenu.menu.sp)
            Mantle.ui.btn(btn_cmd)
            btn_cmd:Dock(TOP)
            btn_cmd:DockMargin(0, 0, 0, 4)
            btn_cmd:SetTall(24)
            btn_cmd:SetText(cmd.name)
            btn_cmd.DoClick = function()
                Mantle.func.sound()

                cmd.func()
            end
            btn_cmd.DoRightClick = function()
                local DM = Mantle.ui.derma_menu()
                DM:AddOption('Сбросить позицию', function()
                    MoonContextMenu.pos_save = nil
                    MoonContextMenu.menu:Remove()
                end, 'icon16/arrow_out.png')
            end

            if cmd.icon then
                btn_cmd.mat = Material('materials/mooncontextmenu/' .. cmd.icon .. '.png')

                btn_cmd.PaintOver = function(self, w, h) 
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(self.mat)
                    surface.DrawTexturedRect(4, 4, 16, 16)
                end
            end
        end

        local panel_split = vgui.Create('DPanel', MoonContextMenu.menu.sp)
        panel_split:Dock(TOP)
        panel_split:DockMargin(0, 0, 0, 4)
        panel_split:SetTall(8)
        panel_split.Paint = function(_, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Mantle.color.panel_alpha[2])
        end
    end
end

local function Close()
    if !IsValid(MoonContextMenu.menu) then
        return
    end

    MoonContextMenu.pos_save = {}
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
