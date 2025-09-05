ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/alt_fire_anything/files/scripts/actions.lua")

local config_spawn_at_start = ModSettingGet("alt_fire_anything.spawn_at_start")

function OnPlayerSpawned(player)
    -- spawn a guaranteed "Alt Fire Anything" card in the orb room next to the early magical temple
    CreateItemActionEntity( "ALT_FIRE_ANYTHING", -4324, 3859 )

    -- if the player enabled this mod setting, also spawn a copy at the mountain entrance
    if ( config_spawn_at_start ) then
        CreateItemActionEntity( "ALT_FIRE_ANYTHING", 800, -100 )
    end
end



local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/alt_fire_anything/translations.csv")
translations = translations .. "\n" .. new_translations .. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)
