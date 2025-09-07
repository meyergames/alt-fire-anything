afa = {
    {
	    id                  = "ALT_FIRE_ANYTHING",
	    name 		        = "$spell_d2d_alt_fire_anything_name",
	    description         = "$spell_d2d_alt_fire_anything_desc",
	    sprite 		        = "mods/alt_fire_anything/files/gfx/alt_fire_anything.png",
	    type 		        = ACTION_TYPE_PASSIVE,
        subtype     		= { altfire = true },
		spawn_level         = "1,2,3,4,5,6,10",
		spawn_probability   = "0.2,0.4,0.6,0.8,1,1,1",
		custom_xml_file 	= "mods/alt_fire_anything/files/entities/card_alt_fire_anything.xml",
		-- spawn_requires_flag = "card_unlocked_alt_fire_anything",
	    price               = 500,
	    mana                = 10,
	    action              = function()
								if reflecting then return end
								
								for i,v in ipairs( hand ) do
									table.insert( discarded, v )
								end

								for i,v in ipairs( deck ) do
									table.insert( discarded, v )
								end

								hand = {}
								deck = {}

								if ( force_stop_draws == false ) then
									force_stop_draws = true
									move_discarded_to_deck()
									draw_actions( 1, true )
									start_reload = true
								end
	                        end,
    },
}

if ( actions ~= nil ) then
    for k, v in pairs( afa ) do
	    table.insert( actions, v )
    end

    if ModSettingGet( "alt_fire_anything.disable_other_alt_fire_spells" ) then
	    for k, v in pairs( actions ) do
	    	if string.find( v.id, "ALT_FIRE" ) and not string.find( v.id, "ALT_FIRE_ANYTHING" ) then
		    	table.remove( actions, k )
		    end
	    end
    end
end