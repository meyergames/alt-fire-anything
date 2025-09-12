---@class (exact) partial_action
---@field action fun(recursion: integer?, iter: integer?): iteration: integer?
---@field id string
---@field type integer
---@field recursive boolean?
---@field spawn_level string
---@field spawn_probability string
---@field spawn_requires_flag string?
---@field spawn_manual_unlock boolean?
---@field max_uses integer?
---@field custom_xml_file string?
---@field ai_never_uses boolean?
---@field never_unlimited boolean?
---@field is_dangerous_blast boolean?
---@field sound_loop_tag string?
---@field mana number?
---@field sprite_unidentified string?
---@field deck_index integer?
---@field uses_remaining integer?

---@type partial_action[]
local new_actions = {
	{
		id 					= "ALT_FIRE",
	    name 		        = "$spell_alt_fire_anything_name",
	    description         = "$spell_alt_fire_anything_desc",
	    sprite 		        = "mods/alt_fire_anything/files/gfx/alt_fire_anything.png",
		type 				= ACTION_TYPE_PASSIVE,
		spawn_level 		= "1,2,3,4,5,6,10",
		spawn_probability 	= "0.1,0.2,0.3,0.4,0.5,0.6,1.0",
		mana 				= 10,
		custom_xml_file 	= "mods/alt_fire_anything/files/entities/card_alt_fire_anything.xml",
		action 				= function()
								while #deck > 0 do
									local data = deck[1]
									---@diagnostic disable-next-line: inject-field
									data.in_fake_hand = true
									table.insert(hand, data)
									table.remove(deck, 1)
								end
								draw_actions(1, true)
							end,
	},
}

---@param partial partial_action
---@return action
local function to_real_action(partial)
	local id = partial.id:lower()
	---@type action
	local action = {
		action = partial.action,
		id = "NATHAN-ALT_FIRE_" .. partial.id,
		name = "$nathan-alt_fire_actionname_" .. id,
		description = "$nathan-alt_fire_actiondesc_" .. id,
		sprite = "mods/nathan-alt_fire/files/sprites/" .. id .. ".png",
		type = partial.type,
		recursive = partial.recursive,
		spawn_level = partial.spawn_level,
		spawn_probability = partial.spawn_probability,
		spawn_requires_flag = partial.spawn_requires_flag,
		spawn_manual_unlock = partial.spawn_manual_unlock,
		max_uses = partial.max_uses,
		custom_xml_file = partial.custom_xml_file,
		ai_never_uses = partial.ai_never_uses,
		never_unlimited = partial.never_unlimited,
		is_dangerous_blast = partial.is_dangerous_blast,
		sound_loop_tag = partial.sound_loop_tag,
		mana = partial.mana,
		sprite_unidentified = partial.sprite_unidentified,
		deck_index = partial.deck_index,
		uses_remaining = partial.uses_remaining,
	}
	return action
end

for _, action in ipairs(new_actions) do
	table.insert(actions, to_real_action(action))
end
