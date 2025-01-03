local anims = {
    {ACT_GMOD_TAUNT_DANCE, 'Обычный танец', 'dance.png'},
    {ACT_GMOD_TAUNT_SALUTE, 'Есть, сэр', 'salute.png'},
    {ACT_SIGNAL_FORWARD, 'Нам туда!', 'forward.png'},
    {ACT_GMOD_TAUNT_CHEER, 'Я здесь', 'cheer.png'},
    {ACT_GMOD_GESTURE_DISAGREE, 'Нет', 'no.png'},
    {ACT_GMOD_GESTURE_BOW, 'Поклон', 'bow.png'},
    {ACT_GMOD_GESTURE_AGREE, 'Палец вверх', 'agree.png'},
    {ACT_GMOD_TAUNT_MUSCLE, 'Секси-танец', 'sexi.png'},
    {ACT_SIGNAL_HALT, 'Кулак', 'halt.png'},
    {ACT_GMOD_TAUNT_ROBOT, 'Робо-танец', 'robo.png'},
    {ACT_GMOD_TAUNT_PERSISTENCE, 'Поза льва', 'lion.png'},
    {ACT_GMOD_GESTURE_BECON, 'Ко мне!', 'here.png'},
    {ACT_GMOD_TAUNT_LAUGH, 'Смех', 'laugh.png'},
    {ACT_GMOD_GESTURE_WAVE, 'Помахать', 'wave.png'},
    {ACT_GMOD_GESTURE_ITEM_GIVE, 'Передать', 'give.png'},
    {ACT_SIGNAL_GROUP, 'Группировка', 'group.png'}
}

local function Create()
    MoonContextMenuScrollPosAnim = MoonContextMenuScrollPosAnim or 0

    MoonContextMenu.anim_menu = vgui.Create('MantleFrame', g_ContextMenu)
    MoonContextMenu.anim_menu:SetSize(200, 340)
    MoonContextMenu.anim_menu:SetTitle('')
    MoonContextMenu.anim_menu:DisableCloseBtn()
    MoonContextMenu.anim_menu:SetAlphaBackground(true)

    if !MoonContextMenu.pos_save_anim then
        MoonContextMenu.pos_save_anim = {Mantle.func.sw - MoonContextMenu.anim_menu:GetWide() - 10, Mantle.func.sh * 0.5 - MoonContextMenu.anim_menu:GetTall() * 0.5}
    end

    MoonContextMenu.anim_menu:SetPos(MoonContextMenu.pos_save_anim[1], MoonContextMenu.pos_save_anim[2])
    MoonContextMenu.anim_menu:SetMouseInputEnabled(true)
    MoonContextMenu.anim_menu:SetCenterTitle('Анимации')

    MoonContextMenu.anim_menu.sp = vgui.Create('MantleScrollPanel', MoonContextMenu.anim_menu)
    MoonContextMenu.anim_menu.sp:Dock(FILL)

    for _, anim_table in pairs(anims) do
        local btn_anim = vgui.Create('DButton', MoonContextMenu.anim_menu.sp)
        Mantle.ui.btn(btn_anim, Material('mooncontextmenu/animations/' .. anim_table[3]), 24, nil, nil, nil, Color(140, 97, 97))
        btn_anim:Dock(TOP)
        btn_anim:DockMargin(0, 0, 0, 4)
        btn_anim:SetTall(30)
        btn_anim:SetText(anim_table[2])
        btn_anim.DoClick = function()
            Mantle.func.sound()

            RunConsoleCommand('_DarkRP_DoAnimation', anim_table[1])
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
