dofile_once( "data/scripts/lib/utilities.lua" )

-- config variables
local config_recharge_scales_with_mana = true
local config_shared_recharge_time = ModSettingGet("alt_fire_anything.shared_recharge_time")
local config_mana_cost_to_recharge_time = ModSettingGet("alt_fire_anything.mana_cost_to_recharge_time")
local config_wrap_payload = ModSettingGet("alt_fire_anything.wrap_payload")

-- spell + player entity ids and transform
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local owner = EntityGetRootEntity( entity_id )

-- spell + player component entity ids
local var_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local ctrl_comp = EntityGetFirstComponent( owner, "ControlsComponent" )

-- wand variables
local actionid = "action_alt_fire_anything"
local aim_x, aim_y = ComponentGetValue2( ctrl_comp, "mAimingVectorNormalized")
local cooldown_frames = 60
local cooldown_frame = ComponentGetValue2( var_comp, "value_int" )
local manacost = 0

-- ezwand
local EZWand = dofile_once( "mods/alt_fire_anything/files/scripts/lib/ezwand.lua" )
local wand = EZWand(EntityGetParent(entity_id))

-- spell logic
if GameGetFrameNum() >= cooldown_frame then
    if InputIsMouseButtonDown( 2 ) then -- is the right mouse button pressed?
        local mana = wand.mana
        local spells_left_to_add = wand.spellsPerCast

		local spell_sequence = {}
    	local spells_added = 0
    	local spells_before = 0
		local acomp = EntityGetFirstComponentIncludingDisabled( wand.entity_id, "AbilityComponent" )
		local next_usable_frame = ComponentGetValue2( acomp, "mReloadNextFrameUsable" )
		if ( GameGetFrameNum() < next_usable_frame and config_shared_recharge_time ) then return end -- cancel if the wand is reloading

		local afa_index = 999
		if config_wrap_payload then afa_index = -1 end -- this seems to enable wrapping... interesting!

		local total_mana_drain = 0
        local spells, attached_spells = wand:GetSpells()
        for i,spell in ipairs( spells ) do
            if ( spell.action_id == "ALT_FIRE_ANYTHING" ) then
            	afa_index = i
            	spells_before = afa_index - 1
            elseif ( i > afa_index ) then
		        local spell_data = nil
				dofile_once( "data/scripts/gun/gun_actions.lua" )
				for k,v in pairs( actions ) do
					if ( v.id == spells[i].action_id ) then
						spell_data = v
						-- GamePrint( tostring(v.gunaction_config) ) -- would be nice to incur the correct cast delay and recharge time
						-- after the alt-fire action, but getting those stats from the actions seems impossible as of my current understanding
					end
				end

		        local icomp = EntityGetFirstComponentIncludingDisabled( spells[i].entity_id, "ItemComponent" )
		        local uses_remaining = ComponentGetValue2( icomp, "uses_remaining" ) or -1

		        if wand.mana >= total_mana_drain + spell_data.mana then
		        	if ( uses_remaining ~= 0 ) then -- either it is -1 for infinite, or >0 for actual remaining uses
		        		total_mana_drain = total_mana_drain + spell_data.mana
		        		spell_sequence[i-afa_index] = spells[i].action_id
		        		spells_added = spells_added + 1

			        	if uses_remaining > 0 then
	                    	ComponentSetValue2( icomp, "uses_remaining", uses_remaining - 1 )
	                    end
                    else
                    	break
		        	end
		        else
        			GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/not_enough_mana_for_action", x, y)
		        	break
		        end
		    end
        end

        local were_spells_added = spells_added > 0
        if config_wrap_payload then
        	were_spells_added = spells_added - spells_before > 0
        end

    	if ( were_spells_added and wand.mana >= total_mana_drain ) then
			EZWand.ShootSpellSequenceInherit( spell_sequence, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, wand )
			wand.mana = wand.mana - total_mana_drain

			-- local action_cast_delay = ComponentObjectGetValue2( acomp, "gunaction_config", "fire_rate_wait" )
			-- local action_recharge_time = ComponentObjectGetValue2( acomp, "gunaction_config", "reload_time" )
			local wand_recharge_time = ComponentObjectGetValue2( acomp, "gun_config", "reload_time" )
			local total_recharge_time = math.max( wand_recharge_time, 60 )
			if config_recharge_scales_with_mana then
				total_recharge_time = wand_recharge_time + ( total_mana_drain * config_mana_cost_to_recharge_time * 0.01 )
			end

			if config_shared_recharge_time then
		        ComponentSetValue2( acomp, "mNextFrameUsable", GameGetFrameNum() + total_recharge_time )
		        ComponentSetValue2( acomp, "mReloadNextFrameUsable", GameGetFrameNum() + total_recharge_time )
		        ComponentSetValue2( acomp, "mReloadFramesLeft", total_recharge_time )
		        ComponentSetValue2( acomp, "reload_time_frames", total_recharge_time )
		    end

			ComponentSetValue2( var_comp, "value_int", GameGetFrameNum() + total_recharge_time )
	        if HasFlagPersistent( actionid ) == false then
	            GameAddFlagRun( table.concat( { "new_", actionid } ) )
	            AddFlagPersistent( actionid )
	        end
            -- if ModIsEnabled("quant.ew") then
            --     CrossCall("afa_ew_alt_fire", owner, x, y, aim_x, aim_y, "???.xml")
            -- end=
	    end
    end
end
