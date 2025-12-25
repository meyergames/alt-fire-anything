ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/alt_fire_anything/files/scripts/actions.lua" )
ModLuaFileAppend( "data/scripts/gun/gun.lua", "mods/alt_fire_anything/files/scripts/gun_append.lua" )

local config_spawn_at_start = ModSettingGet( "alt_fire_anything.spawn_at_start" )

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
function OnPlayerSpawned( player )
    if GameHasFlagRun( "nd2d_afa_init_happened" ) then return end
    GameAddFlagRun( "nd2d_afa_init_happened" )

    for _, message in ipairs(messages) do
        _print(message)
    end

    -- add a script that tries to spawn copies of the spell where they belong
    EntityAddComponent2( player, "LuaComponent", 
    {
        script_source_file = "mods/alt_fire_anything/files/scripts/player_try_spawn_copies.lua",
        execute_every_n_frame = 60,
    } )

    -- if enabled in mod settings, also spawn copies at the mountain entrance
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
