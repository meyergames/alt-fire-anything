afa = {
    {
	    id                  = "ND2D_ALT_FIRE_ANYTHING",
	    name 		        = "$spell_alt_fire_anything_name",
	    description         = "$spell_alt_fire_anything_desc",
	    sprite 		        = "mods/alt_fire_anything/files/gfx/alt_fire_anything.png",
	    type 		        = ACTION_TYPE_PASSIVE,
        subtype     		= { altfire = true },
		spawn_level         = "1,2,3,4,5,6,10",
		spawn_probability   = "0.2,0.4,0.6,0.8,1,1,1",
		custom_xml_file 	= "mods/alt_fire_anything/files/entities/card_alt_fire_anything.xml",
		-- spawn_requires_flag = "card_unlocked_alt_fire_anything",
	    price               = 400,
	    mana                = 10,
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

if ( actions ~= nil ) then
    for k, v in pairs( afa ) do
	    table.insert( actions, v )
    end

    if ModSettingGet( "alt_fire_anything.disable_other_alt_fire_spells" ) then
	    for k, v in pairs( actions ) do
	    	if string.find( v.id, "ALT_FIRE" ) and not v.id == "ALT_FIRE_ANYTHING" then
		    	table.remove( actions, k )
		    end
	    end
    end
end