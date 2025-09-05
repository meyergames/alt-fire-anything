dofile_once("data/scripts/lib/utilities.lua")

local old_death = death
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	old_death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	AddFlagPersistent( "card_unlocked_alt_fire_anything" )
	CreateItemActionEntity( "ALT_FIRE_ANYTHING", x, y )
end