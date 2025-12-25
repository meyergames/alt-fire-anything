dofile("data/scripts/lib/mod_settings.lua")


--Key binding data
local listening = false
local there_has_been_input = false
local key_inputs ={}
local mouse_inputs = {}
local joystick_inputs = {}
local old_binding = 0
local current_keybind = ""

--Keybinds
local keybind_name = "Keybind"
local keybind_desc = "Edit your Alt Fire keybind"
local keybind_tutorial_altfire = "\nHit the prompt below to input a new alt-fire binding.\nThe default setting is right mouse button."
local keybind_newbinding = "SET NEW BINDING"
local keybind_current_altfire = "Current binding: "

mouse_codes = {
  MOUSE_LEFT = 1,
  MOUSE_RIGHT = 2,
  MOUSE_MIDDLE = 3,
  MOUSE_WHEEL_UP = 4,
  MOUSE_WHEEL_DOWN = 5,
  MOUSE_X1 = 6,
  MOUSE_X2 = 7,
}

key_codes = {
  A = 4,
  B = 5,
  C = 6,
  D = 7,
  E = 8,
  F = 9,
  G = 10,
  H = 11,
  I = 12,
  J = 13,
  K = 14,
  L = 15,
  M = 16,
  N = 17,
  O = 18,
  P = 19,
  Q = 20,
  R = 21,
  S = 22,
  T = 23,
  U = 24,
  V = 25,
  W = 26,
  X = 27,
  Y = 28,
  Z = 29,
  ONE = 30,
  TWO = 31,
  THREE = 32,
  FOUR = 33,
  FIVE = 34,
  SIX = 35,
  SEVEN = 36,
  EIGHT = 37,
  NINE = 38,
  ZERO = 39,
  RETURN = 40,
  ESCAPE = 41,
  BACKSPACE = 42,
  TAB = 43,
  SPACE = 44,
  MINUS = 45,
  EQUALS = 46,
  LEFTBRACKET = 47,
  RIGHTBRACKET = 48,
  BACKSLASH = 49,
  NONUSHASH = 50,
  SEMICOLON = 51,
  APOSTROPHE = 52,
  GRAVE = 53,
  COMMA = 54,
  PERIOD = 55,
  SLASH = 56,
  CAPSLOCK = 57,
  F1 = 58,
  F2 = 59,
  F3 = 60,
  F4 = 61,
  F5 = 62,
  F6 = 63,
  F7 = 64,
  F8 = 65,
  F9 = 66,
  F10 = 67,
  F11 = 68,
  F12 = 69,
  PRINTSCREEN = 70,
  SCROLLLOCK = 71,
  PAUSE = 72,
  INSERT = 73,
  HOME = 74,
  PAGEUP = 75,
  DELETE = 76,
  END = 77,
  PAGEDOWN = 78,
  RIGHT = 79,
  LEFT = 80,
  DOWN = 81,
  UP = 82,
  NUMLOCKCLEAR = 83,
  KP_DIVIDE = 84,
  KP_MULTIPLY = 85,
  KP_MINUS = 86,
  KP_PLUS = 87,
  KP_ENTER = 88,
  KP_1 = 89,
  KP_2 = 90,
  KP_3 = 91,
  KP_4 = 92,
  KP_5 = 93,
  KP_6 = 94,
  KP_7 = 95,
  KP_8 = 96,
  KP_9 = 97,
  KP_0 = 98,
  KP_PERIOD = 99,
  NONUSBACKSLASH = 100,
  APPLICATION = 101,
  POWER = 102,
  KP_EQUALS = 103,
  F13 = 104,
  F14 = 105,
  F15 = 106,
  F16 = 107,
  F17 = 108,
  F18 = 109,
  F19 = 110,
  F20 = 111,
  F21 = 112,
  F22 = 113,
  F23 = 114,
  F24 = 115,
  EXECUTE = 116,
  HELP = 117,
  MENU = 118,
  SELECT = 119,
  STOP = 120,
  AGAIN = 121,
  UNDO = 122,
  CUT = 123,
  COPY = 124,
  PASTE = 125,
  FIND = 126,
  MUTE = 127,
  VOLUMEUP = 128,
  VOLUMEDOWN = 129,
  KP_COMMA = 133,
  KP_EQUALSAS400 = 134,
  INTERNATIONAL1 = 135,
  INTERNATIONAL2 = 136,
  INTERNATIONAL3 = 137,
  INTERNATIONAL4 = 138,
  INTERNATIONAL5 = 139,
  INTERNATIONAL6 = 140,
  INTERNATIONAL7 = 141,
  INTERNATIONAL8 = 142,
  INTERNATIONAL9 = 143,
  LANG1 = 144,
  LANG2 = 145,
  LANG3 = 146,
  LANG4 = 147,
  LANG5 = 148,
  LANG6 = 149,
  LANG7 = 150,
  LANG8 = 151,
  LANG9 = 152,
  ALTERASE = 153,
  SYSREQ = 154,
  CANCEL = 155,
  CLEAR = 156,
  PRIOR = 157,
  RETURN2 = 158,
  SEPARATOR = 159,
  OUT = 160,
  OPER = 161,
  CLEARAGAIN = 162,
  CRSEL = 163,
  EXSEL = 164,
  KP_00 = 176,
  KP_000 = 177,
  THOUSANDSSEPARATOR = 178,
  DECIMALSEPARATOR = 179,
  CURRENCYUNIT = 180,
  CURRENCYSUBUNIT = 181,
  KP_LEFTPAREN = 182,
  KP_RIGHTPAREN = 183,
  KP_LEFTBRACE = 184,
  KP_RIGHTBRACE = 185,
  KP_TAB = 186,
  KP_BACKSPACE = 187,
  KP_A = 188,
  KP_B = 189,
  KP_C = 190,
  KP_D = 191,
  KP_E = 192,
  KP_F = 193,
  KP_XOR = 194,
  KP_POWER = 195,
  KP_PERCENT = 196,
  KP_LESS = 197,
  KP_GREATER = 198,
  KP_AMPERSAND = 199,
  KP_DBLAMPERSAND = 200,
  KP_VERTICALBAR = 201,
  KP_DBLVERTICALBAR = 202,
  KP_COLON = 203,
  KP_HASH = 204,
  KP_SPACE = 205,
  KP_AT = 206,
  KP_EXCLAM = 207,
  KP_MEMSTORE = 208,
  KP_MEMRECALL = 209,
  KP_MEMCLEAR = 210,
  KP_MEMADD = 211,
  KP_MEMSUBTRACT = 212,
  KP_MEMMULTIPLY = 213,
  KP_MEMDIVIDE = 214,
  KP_PLUSMINUS = 215,
  KP_CLEAR = 216,
  KP_CLEARENTRY = 217,
  KP_BINARY = 218,
  KP_OCTAL = 219,
  KP_DECIMAL = 220,
  KP_HEXADECIMAL = 221,
  LCTRL = 224,
  LSHIFT = 225,
  LALT = 226,
  LGUI = 227,
  RCTRL = 228,
  RSHIFT = 229,
  RALT = 230,
  RGUI = 231,
  MODE = 257,
  AUDIONEXT = 258,
  AUDIOPREV = 259,
  AUDIOSTOP = 260,
  AUDIOPLAY = 261,
  AUDIOMUTE = 262,
  MEDIASELECT = 263,
  WWW = 264,
  MAIL = 265,
  CALCULATOR = 266,
  COMPUTER = 267,
  AC_SEARCH = 268,
  AC_HOME = 269,
  AC_BACK = 270,
  AC_FORWARD = 271,
  AC_STOP = 272,
  AC_REFRESH = 273,
  AC_BOOKMARKS = 274,
  BRIGHTNESSDOWN = 275,
  BRIGHTNESSUP = 276,
  DISPLAYSWITCH = 277,
  KBDILLUMTOGGLE = 278,
  KBDILLUMDOWN = 279,
  KBDILLUMUP = 280,
  EJECT = 281,
  SLEEP = 282,
  APP1 = 283,
  APP2 = 284,
  SPECIAL_COUNT = 512,
}

joystick_codes = {
  ANALOG_00_MOVED = 1,
  ANALOG_01_MOVED = 2,
  ANALOG_02_MOVED = 3,
  ANALOG_03_MOVED = 4,
  ANALOG_04_MOVED = 5,
  ANALOG_05_MOVED = 6,
  ANALOG_06_MOVED = 7,
  ANALOG_07_MOVED = 8,
  ANALOG_08_MOVED = 9,
  ANALOG_09_MOVED = 10,
  DPAD_UP = 11,
  DPAD_DOWN = 12,
  DPAD_LEFT = 13,
  DPAD_RIGHT = 14,
  START = 15,
  BACK = 16,
  LEFT_THUMB = 17,
  RIGHT_THUMB = 18,
  LEFT_SHOULDER = 19,
  RIGHT_SHOULDER = 20,
  LEFT_STICK_MOVED = 21,
  RIGHT_STICK_MOVED = 22,
  BUTTON_0 = 23,
  BUTTON_1 = 24,
  BUTTON_2 = 25,
  BUTTON_3 = 26,
  BUTTON_4 = 27,
  BUTTON_5 = 28,
  BUTTON_6 = 29,
  BUTTON_7 = 30,
  BUTTON_8 = 31,
  BUTTON_9 = 32,
  BUTTON_10 = 33,
  BUTTON_11 = 34,
  BUTTON_12 = 35,
  BUTTON_13 = 36,
  BUTTON_14 = 37,
  BUTTON_15 = 38,
  LEFT_STICK_LEFT = 39,
  LEFT_STICK_RIGHT = 40,
  LEFT_STICK_UP = 41,
  LEFT_STICK_DOWN = 42,
  RIGHT_STICK_LEFT = 43,
  RIGHT_STICK_RIGHT = 44,
  RIGHT_STICK_UP = 45,
  RIGHT_STICK_DOWN = 46,
  ANALOG_00_DOWN = 47,
  ANALOG_01_DOWN = 48,
  ANALOG_02_DOWN = 49,
  ANALOG_03_DOWN = 50,
  ANALOG_04_DOWN = 51,
  ANALOG_05_DOWN = 52,
  ANALOG_06_DOWN = 53,
  ANALOG_07_DOWN = 54,
  ANALOG_08_DOWN = 55,
  ANALOG_09_DOWN = 56,
  A = 23,
  B = 24,
  X = 25,
  Y = 26
}


local mod_id = "alt_fire_anything" -- This should match the name of your mod's folder.
mod_settings_version = 1      -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value.
mod_settings =
{
    {
        category_id = "keybinds",
        ui_name = "Keybind",
        ui_description = "Which button should be used to alt-fire?",
        foldable = true,
        _folded = true,
        settings = {
        {
            id = "bind_altfire",
            ui_name = "",
            value_default = "key_code,mouse_code,2,joystick_code",
            ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                        if listening then
                            input_listen(key_inputs,mouse_inputs,joystick_inputs)
                        end

                        local _id = 0
                        local function id()
                          _id = _id + 1
                          return _id
                        end

                        local keybind_string = ""
                        local keybind_setting = ModSettingGet("alt_fire_anything.bind_altfire")
                        local mode = "key_code"
                        for code in string.gmatch(keybind_setting, "[^,]+") do
                          if code == "mouse_code" or code == "key_code" or code == "joystick_code" then
                              mode = code
                          else
                              if keybind_string ~= "" then
                                  keybind_string = keybind_string .. " + "
                              end
                              code = tonumber(code)
                              if mode == "key_code" then
                                  for key, value in pairs(key_codes) do
                                      if value == code then
                                          keybind_string = keybind_string .. key
                                          ModSettingSet("alt_fire_anything.bind_altfire_translated",key)
                                      end
                                  end
                              elseif mode == "mouse_code" then
                                  for key, value in pairs(mouse_codes) do
                                      if value == code then
                                          keybind_string = keybind_string .. key
                                          ModSettingSet("alt_fire_anything.bind_altfire_translated",key)
                                      end
                                  end
                              elseif mode == "joystick_code" then
                                  for key, value in pairs(joystick_codes) do
                                      if value == code then
                                          keybind_string = keybind_string .. key
                                          ModSettingSet("alt_fire_anything.bind_altfire_translated",key)
                                      end
                                  end
                              end
                          end
                        end

                        GuiColorSetForNextWidget(gui, 1, 1, 1, 0.5)
                        GuiText(gui, 5, 0, keybind_tutorial_altfire)
                        if listening then
                          GuiColorSetForNextWidget(gui, 1, 0, 0, 1)
                          GuiOptionsAdd(gui, GUI_OPTION.NonInteractive)
                        end
                        if GuiButton(gui, id(), 10, 5, keybind_newbinding) then
                          key_inputs = {}
                          mouse_inputs = {}
                          joystick_inputs = {}
                          listening = true
                          there_has_been_input = false
                          old_binding = ModSettingGet("alt_fire_anything.bind_altfire")
                        end
                        GuiColorSetForNextWidget(gui, 1, 1, 1, 0.5)
                        GuiText(gui, 5, 5, keybind_current_altfire .. keybind_string)
                        GuiText(gui, 0, -5, " ")
                        end
      },
      {
          id = "bind_altfire_translated",
          ui_name = "Secret setting",
          value_default = "MOUSE_RIGHT",
          text_max_length = 20,
          allowed_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789",
          hidden = true,
      },
      {
          id = "always_enable_right_click",
          ui_name = "Always enable right-click",
          ui_description = "If enabled, Alt Fire Anything can always be triggered\nwith a right-click, regardless of the configured keybind.",
          value_default = true,
          scope = MOD_SETTING_SCOPE_RUNTIME,
      },
    }
  },

    {
        category_id = "default_settings",
        ui_name = "",
        ui_description = "",
        settings = {
            {
                id = "spawn_at_start",
                ui_name = "Spawn at start",
                ui_description = "Spawns this many copies of the spell at the mountain\nentrance. Recommended value is 1.",
                value_default = 0,
                value_min = 0,
                value_max = 4,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
            {
                id = "disable_other_alt_fire_spells",
                ui_name = "Disable other Alt Fire spells",
                ui_description = "Cleans up the spell pool by attempting to disable\nother mods' Alt Fire spells, since their regular\nvariants can now be put behind Alt Fire Anything.\nDo note that Alt Fire Anything may not spawn as\noften as, for example, Alt Fire Teleport Bolt.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
        }
    },
}

function input_listen(key_inputs,mouse_inputs,joystick_inputs)
  local there_is_input = false
  for _, code in pairs(key_codes) do
      if InputIsKeyDown(code) then
          there_is_input = true
          there_has_been_input = true
          if has_value(key_inputs, code) == false then
              table.insert(key_inputs, code)
          end
      end
  end
  for _, code in pairs(mouse_codes) do
      if InputIsMouseButtonDown(code) then
          there_is_input = true
          there_has_been_input = true
          if has_value(mouse_inputs, code) == false then
              table.insert(mouse_inputs, code)
          end
      end
  end
  for _, code in pairs(joystick_codes) do
      if InputIsJoystickButtonDown(0, code) then
          there_is_input = true
          there_has_been_input = true
          if has_value(joystick_inputs, code) == false then
              table.insert(joystick_inputs, code)
          end
      end
  end

  --Decided variable forces only a single keybind for input and blocks combo inputs, can be remove to disable this limiter
  local decided = false
  local binding = "key_code,"
  for _, code in pairs(key_inputs) do
    if decided == true then break end
    binding = table.concat({binding,tostring(code),","})
    decided = true
  end
  binding = binding .. "mouse_code,"
  for _, code in pairs(mouse_inputs) do
    if decided == true then break end
    binding = table.concat({binding,tostring(code),","})
    decided = true
  end
  binding = binding .. "joystick_code,"
  for _, code in pairs(joystick_inputs) do
    if decided == true then break end
    binding = table.concat({binding,tostring(code),","})
    decided = true
  end
  binding = binding:sub(1, -2)
  ModSettingSet( "alt_fire_anything.bind_altfire", binding )

  if there_has_been_input and not there_is_input then
      listening = false
      there_has_been_input = false
      key_inputs = {}
      mouse_inputs = {}
      joystick_inputs = {}
      if ModSettingGet( "alt_fire_anything.bind_altfire" ) == "key_code,mouse_code,joystick_code" then
          ModSettingSet( "alt_fire_anything.bind_altfire", old_binding )
      end
  end
end

function has_value (table, value)
  for _, v in ipairs(table) do
      if v == value then
          return true
      end
  end
  return false
end

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






-- WORK IN PROGRESS CODE BELOW: disabling individual alt fire spells from other mods (credits to Evaisa)

-- function HasSettingFlag(name)
--     return ModSettingGet(name) or false
-- end

-- function AddSettingFlag(name)
--     ModSettingSet(name, true)
--   --  ModSettingSetNextValue(name, true)
-- end

-- function RemoveSettingFlag(name)
--     ModSettingRemove(name)
-- end

-- dofile_once( "data/scripts/gun/gun_actions.lua" )
-- if ( actions ~= nil ) then
--     crossed_index = 1
--     for k, v in pairs( actions )do

--       if string.find( v.id, "ALT_FIRE" ) and not v.id == "ND2D_ALT_FIRE_ANYTHING" then
--         GuiLayoutBeginHorizontal( gui, 0, 0, false, 2, 2 )

--         if GuiImageButton( gui, new_id(), 0, 0, "", v.sprite ) then
--           if(HasSettingFlag(v.id.."_disabled"))then
--             RemoveSettingFlag(v.id.."_disabled")
--           else
--             AddSettingFlag(v.id.."_disabled")
--           end
--         end

--         if(HasSettingFlag(v.id.."_disabled"))then
--           GuiTooltip( gui, GameTextGetTranslatedOrNot(v.description), "[ Click to enable ]" );
--         else
--           GuiTooltip( gui, GameTextGetTranslatedOrNot(v.description), "[ Click to disable] " );
--         end

--         GuiImage( gui, new_id(), -20.2, -1.2, "mods/spellbound_bundle/files/gfx/ui_gfx/square.png", 1, 1.2, 0 )
--         if(HasSettingFlag(v.id.."_disabled"))then
--           GuiZSetForNextWidget( gui, -80 )
--           GuiOptionsAddForNextWidget(gui, GUI_OPTION.NonInteractive)
--           GuiImage( gui, new_id(), -20.2, -1.2, "mods/spellbound_bundle/files/gfx/ui_gfx/overlay.png", 1, 1.2, 0 )
--           GuiZSetForNextWidget( gui, -90 )
--           GuiOptionsAddForNextWidget(gui, GUI_OPTION.NonInteractive)
--           GuiImage( gui, new_id(), -20, 0, "mods/spellbound_bundle/files/gfx/ui_gfx/crossed"..crossed_index..".png", 1, 1, 0 )
--         end

--         if(HasSettingFlag(v.id.."_disabled"))then
--           GuiTooltip( gui, GameTextGetTranslatedOrNot(v.description), "[ Click to enable ]" );
--         else
--           GuiTooltip( gui, GameTextGetTranslatedOrNot(v.description), "[ Click to disable] " );
--         end

--         if(crossed_index < 5)then
--           crossed_index = crossed_index + 1
--         else
--           crossed_index = 1
--         end

--         GuiText( gui, 0, 3, GameTextGetTranslatedOrNot(v.name) )

--         GuiLayoutEnd(gui)
--       end
--     end
-- end