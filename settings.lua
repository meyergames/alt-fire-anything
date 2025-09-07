dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "alt_fire_anything" -- This should match the name of your mod's folder.
mod_settings_version = 1      -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value.
mod_settings =
{
    {
        category_id = "default_settings",
        ui_name = "",
        ui_description = "",
        settings = {
            {
                id = "spawn_at_start",
                ui_name = "Spawn at start",
                ui_description = "Spawns a copy of the spell at the mountain entrance.\nUseful if you just want to try it out.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
            {
                id = "disable_other_alt_fire_spells",
                ui_name = "Disable other Alt Fire spells",
                ui_description = "Cleans up the spell pool by attempting to disable\nother mods' Alt Fire spells, since their regular\nvariants can now be put behind Alt Fire Anything.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
        }
    },
    {
        category_id = "experimental_settings",
        ui_name = "Experimental",
        ui_description = "Settings that change the spell's variables",
        settings = {
            {
                id = "shared_recharge_time",
                ui_name = "Shared recharge time",
                ui_description = "While using \"Alt Fire Anything\" with this setting enabled, your\nwand's normal and alt fire payloads share the same recharge time.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "mana_cost_to_recharge_time",
                ui_name = "Mana cost : Recharge time",
                ui_description = "How much the mana cost of alt-fired spells\naffects the recharge time of \"Alt Fire Anything\".\n(100% seems most balanced)",
                value_default = 100,
                value_min = 0,
                value_max = 100,
                value_display_formatting = " $0%",
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "wrap_payload",
                ui_name = "Wrap payload",
                ui_description = "Makes \"Alt Fire Anything\" wrap around your wand's spell slots in search\nfor spells to add to its payload, at the cost of considerably more mana\n(and thus recharge time).",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
        },
    },
}

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
