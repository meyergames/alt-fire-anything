dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "alt_fire_anything" -- This should match the name of your mod's folder.
mod_settings_version = 1      -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value.
mod_settings =
{
    {
        category_id = "default_settings",
        ui_name = "General",
        ui_description = "",
        settings = {
            {
                id = "spawn_at_start",
                ui_name = "Spawn at start",
                ui_description = "Spawns a copy of the spell at the mountain entrance.\nUseful if you just want to try it out.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
        },
        category_id = "experimental_settings",
        ui_name = "Experimental",
        ui_description = "",
        settings = {
            {
                id = "scale_recharge_time_with_mana_cost",
                ui_name = "Scale recharge time with mana cost",
                ui_description = "Due to a technical limitation, the recharge time after using\nAlt Fire Everything does currently not consider the reload\ntimes of the spells it fires. As a workaround to make the\nreload time feel more natural, you can enable this option\nto scale the recharge time with the mana cost of the fired\nspells. When disabled, reload time defaults to 1 second.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "wrap_payload",
                ui_name = "Wrap payload",
                ui_description = "Due to another technical limitation, Alt Fire Everything currently\nincurs the mana cost of all spells that come after it.\nEnabling this setting may alleviate some of this.",
                -- ui_description = "Due to a technical limitation, the recharge time after using\nAlt Fire Everything does currently not consider the reload\ntimes of the spells it fires. As a workaround to make the\nreload time feel more natural, you can enable this option\nto scale the recharge time with the mana cost of the fired\nspells. When disabled, reload time is always 1 second.",
                value_default = true,
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
