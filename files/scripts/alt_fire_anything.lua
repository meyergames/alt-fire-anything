local me = GetUpdatedEntityID()
local caster = EntityGetRootEntity(me)
local controls = EntityGetFirstComponent(caster, "ControlsComponent")
if not controls then return end

function is_alt_fire_pressed()
  local binding = ModSettingGet( "alt_fire_anything.bind_altfire" )
  local mode = "key_code"
  for code in string.gmatch(binding, "[^,]+") do
      if code == "mouse_code" or code == "key_code" or code == "joystick_code" then
          mode = code
      else
          code = tonumber(code)
          if mode == "key_code" then
              if InputIsKeyDown(code) then
                return true
              end
          elseif mode == "mouse_code" then
              if InputIsMouseButtonDown(code) then
                return true
              end
          elseif mode == "joystick_code" then
              if InputIsJoystickButtonDown(0, code) then
                return true
              end
          end
      end
  end
end

local alt_fire_pressed = is_alt_fire_pressed()
local always_enable_right_click = ModSettingGet( "alt_fire_anything.always_enable_right_click" )
if alt_fire_pressed or ( always_enable_right_click and InputIsMouseButtonDown( 2 ) ) then

  local platform_shooter = EntityGetFirstComponent(caster, "PlatformShooterPlayerComponent")
  if not platform_shooter then return end
  ComponentSetValue2(platform_shooter, "mForceFireOnNextUpdate", true)
  local vscs = EntityGetComponent(caster, "VariableStorageComponent") or {}
  for _, vsc in ipairs(vscs) do
  	if ComponentGetValue2(vsc, "name") == "alt_fire_cause" then
  		EntityRemoveComponent(caster, vsc)
  	end
  end
  EntityAddComponent2(
  	caster,
  	"VariableStorageComponent",
  	{ name = "alt_fire_cause", value_string = "alt_fire", value_int = GameGetFrameNum() }
  )

end
