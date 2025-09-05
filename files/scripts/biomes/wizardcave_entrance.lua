
if ( g_small_enemies ~= nil ) then
	table.insert( g_small_enemies, {
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "mods/alt_fire_anything/animals/killerwand.xml"
	} )
	GamePrintImportant("killerwand added!")
}
