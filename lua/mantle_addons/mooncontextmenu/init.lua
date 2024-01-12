--[[
    * MoonContextmenu *
    GitHub: https://github.com/darkfated/mooncontextmenu
    Author's discord: darkfated
]]

local function run_scripts()
	Mantle.run_cl('config.lua')
	Mantle.run_cl('menu.lua')
end

local function init()
	if SERVER then
		local folderPath = 'materials/mooncontextmenu'
		local files = file.Find(folderPath .. '/*.png', 'GAME')

		for _, fileName in ipairs(files) do
			local filePath = folderPath .. '/' .. fileName

			resource.AddFile(filePath)
		end
	end

	MoonContextMenu = MoonContextMenu or {}

	run_scripts()
end

init()
