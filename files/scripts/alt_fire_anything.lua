local me = GetUpdatedEntityID()
local caster = EntityGetRootEntity(me)
local controls = EntityGetFirstComponent(caster, "ControlsComponent")
if not controls then return end
---@type boolean
local alt_fire = ComponentGetValue2(controls, "mButtonDownThrow")
if not alt_fire then return end

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
