
-- Alt Fire Anything is guaranteed on the first wand ghost spawned, 50% chance on wand ghosts thereafter
-- local was_added_before = GlobalsGetValue( "AFA_SPAWNED_ON_WAND_GHOST", "false" ) == "false"
-- if was_added_before and Random( 0, 1 ) ~= 0 then
-- 	GamePrint("/ spell was added before, but chance was right ")
-- 	return
-- elseif not was_added_before then
-- 	GamePrint("/ spell was not added before")
-- 	GlobalsSetValue( "AFA_SPAWNED_ON_WAND_GHOST", "true" )
-- end

local EZWand = dofile_once( "mods/alt_fire_anything/files/scripts/lib/ezwand.lua" )
local wand = EZWand( entity_pick_up_this_item )
-- if wand:GetFreeSlotsCount() == 0 then wand.capacity = wand.capacity + 1 end
wand:AddSpells("ALT_FIRE_ANYTHING")
GamePrint("/ spell should be added now" )
