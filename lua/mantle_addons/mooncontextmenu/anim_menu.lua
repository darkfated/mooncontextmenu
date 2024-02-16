local scrw, scrh = ScrW(), ScrH()
local anims = {}
anims[ACT_GMOD_GESTURE_BOW] = 'Поклон'
anims[ACT_GMOD_TAUNT_MUSCLE] = 'Сексуальный танец'
anims[ACT_GMOD_GESTURE_BECON] = 'За мной!'
anims[ACT_GMOD_TAUNT_LAUGH] = 'Смех'
anims[ACT_GMOD_TAUNT_PERSISTENCE] = 'Поза льва'
anims[ACT_GMOD_GESTURE_DISAGREE] = 'Нет'
anims[ACT_GMOD_GESTURE_AGREE] = 'Палец вверх'
anims[ACT_GMOD_GESTURE_WAVE] = 'Помахать'
anims[ACT_GMOD_TAUNT_DANCE] = 'Танец'

local function Create()
    MoonContextMenuScrollPosAnim = MoonContextMenuScrollPosAnim or 0

    MoonContextMenu.anim_menu = vgui.Create('DFrame', g_ContextMenu)
    Mantle.ui.frame(MoonContextMenu.anim_menu, '', 220, 340, false)

    if !MoonContextMenu.pos_save_anim then
        MoonContextMenu.pos_save_anim = {scrw - MoonContextMenu.anim_menu:GetWide() - 10, scrh * 0.5 - MoonContextMenu.anim_menu:GetTall() * 0.5}
    end

    MoonContextMenu.anim_menu:SetPos(MoonContextMenu.pos_save_anim[1], MoonContextMenu.pos_save_anim[2])
    MoonContextMenu.anim_menu:SetMouseInputEnabled(true)
    MoonContextMenu.anim_menu.center_title = 'Анимации'

    MoonContextMenu.anim_menu.sp = vgui.Create('DScrollPanel', MoonContextMenu.anim_menu)
    Mantle.ui.sp(MoonContextMenu.anim_menu.sp)
    MoonContextMenu.anim_menu.sp:Dock(FILL)

    for anim, anim_text in pairs(anims) do
        local btn_anim = vgui.Create('DButton', MoonContextMenu.anim_menu.sp)
        Mantle.ui.btn(btn_anim)
        btn_anim:Dock(TOP)
        btn_anim:DockMargin(0, 0, 0, 4)
        btn_anim:SetTall(30)
        btn_anim:SetText(anim_text)
        btn_anim.DoClick = function()
            Mantle.func.sound()

            RunConsoleCommand('_DarkRP_DoAnimation', anim)
        end
        btn_anim.DoRightClick = function()
            local DM = Mantle.ui.derma_menu()
            DM:AddOption('Сбросить позицию', function()
                MoonContextMenu.pos_save_anim = nil
                MoonContextMenu.anim_menu:Remove()
            end, 'icon16/arrow_out.png')
        end
    end

    MoonContextMenu.anim_menu.sp:GetVBar():AnimateTo(MoonContextMenuScrollPosAnim, 0, 0)
end

local function Close()
    if !IsValid(MoonContextMenu.anim_menu) then
        return
    end

    MoonContextMenuScrollPosAnim = MoonContextMenu.anim_menu.sp:GetVBar():GetScroll()

    MoonContextMenu.pos_save_anim[1], MoonContextMenu.pos_save_anim[2] = MoonContextMenu.anim_menu:GetPos()
    MoonContextMenu.anim_menu:Remove()
end

hook.Add('OnContextMenuOpen', 'Mantle.MoonContextMenuAnim', function()
    if !IsValid(MoonContextMenu.anim_menu) then
        Create()
    end
end)

hook.Add('OnContextMenuClose', 'Mantle.MoonContextMenuAnim', function()
    Close()
end)
