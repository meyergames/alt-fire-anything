ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/alt_fire_anything/files/scripts/actions.lua")
ModLuaFileAppend("data/entities/animals/boss_pit/boss_pit_death.lua", "mods/alt_fire_anything/files/entities/animals/boss_pit_death.lua")
ModLuaFileAppend("data/scripts/animals/wand_ghost.lua", "mods/alt_fire_anything/files/scripts/animals/wand_ghost.lua")
ModLuaFileAppend("data/scripts/biomes/wizardcare_entrance.lua", "mods/alt_fire_anything/files/scripts/biomes/wizardcave_entrance.lua")

-- local config_auto_unlock = ModSettingGet("alt_fire_anything.auto_unlock")
local config_spawn_at_start = ModSettingGet("alt_fire_anything.spawn_at_start")

function OnPlayerSpawned(player)
    CreateItemActionEntity( "ALT_FIRE_ANYTHING", -4324, 3959 )

    if ( config_auto_unlock ) then
        AddFlagPersistent( "card_unlocked_alt_fire_anything" )
    elseif ( config_spawn_at_start ) then
        CreateItemActionEntity( "ALT_FIRE_ANYTHING", 800, -100 )
    end
end



local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/alt_fire_anything/translations.csv")
translations = translations .. "\n" .. new_translations .. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)
