ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/alt_fire_anything/files/scripts/actions.lua" )
ModLuaFileAppend( "data/scripts/gun/gun.lua", "mods/alt_fire_anything/files/scripts/gun_append.lua" )

local config_spawn_at_start = ModSettingGet("alt_fire_anything.spawn_at_start")

local messages = {}
local _print = print
---@diagnostic disable-next-line: unused-function
local function print(...)
    local s = ""
    for _, v in ipairs({ ... }) do
        s = s .. tostring(v) .. "\t"
    end
    -- why did it lose the type??
    ---@cast s string
    table.insert(messages, s:sub(1, s:len() - 1))
end

---@type OnPlayerSpawned
function OnPlayerSpawned(_)
    for _, message in ipairs(messages) do
        _print(message)
    end
    
    if ( GameHasFlagRun( "alt_fire_anything_spawned" ) == false ) then
        -- spawn a guaranteed "Alt Fire Anything" card in the orb room next to the early magical temple
        CreateItemActionEntity( "ND2D_ALT_FIRE_ANYTHING", -4324, 3859 )

        -- spawn a guaranteed 3x "Alt Fire Anything" in the orb room near Mestarien Mestari
        for i=1, 3 do
            CreateItemActionEntity( "ND2D_ALT_FIRE_ANYTHING", 10512 + ( i * 5 ), 16160 )
        end

        GameAddFlagRun( "alt_fire_anything_spawned" )
    end

    -- if the player enabled this mod setting, also spawn a copy at the mountain entrance
    if ( config_spawn_at_start > 0 ) then
        for i=1, math.floor( config_spawn_at_start + 0.5 ) do
            CreateItemActionEntity( "ND2D_ALT_FIRE_ANYTHING", 800, -100 )
        end
    end
end

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/alt_fire_anything/translations.csv")
translations = translations .. "\n" .. new_translations .. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)
