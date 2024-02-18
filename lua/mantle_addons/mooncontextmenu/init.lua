--[[
    * MoonContextmenu *
    GitHub: https://github.com/darkfated/mooncontextmenu
    Author's discord: darkfated
]]--

local function run_scripts()
	Mantle.run_cl('config.lua')

	Mantle.run_cl('menu.lua')
	Mantle.run_cl('anim_menu.lua')
end

local function init()
	if SERVER then
		resource.AddWorkshop('3162225713')
	end

	MoonContextMenu = MoonContextMenu or {}

	run_scripts()
end

init()
