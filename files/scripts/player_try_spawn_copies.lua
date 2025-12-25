dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

function is_within_bounds( xl, xr, yt, yb )
    local x, y = EntityGetTransform( entity_id )
    return x > xl and x < xr and y > yt and y < yb
end



function try_spawn_copy_1()
    if GameHasFlagRun( "nd2d_afa_copy_1_spawned" ) then return end
    if not is_within_bounds( -4600, -4000, 3500, 4200 ) then return end
    -- in the orb room next to the early Magical Temple

    CreateItemActionEntity( "ND2D_ALT_FIRE_ANYTHING", -4324, 3859 )

    GameAddFlagRun( "nd2d_afa_copy_1_spawned" )
end

function try_spawn_copy_2()
    if GameHasFlagRun( "nd2d_afa_copy_2_spawned" ) then return end
    if not is_within_bounds( -4250, -3500, 9700, 10300 ) then return end
    -- in the orb room at the bottom of the Lukki Lair

    CreateItemActionEntity( "ND2D_ALT_FIRE_ANYTHING", -3810, 10102 )
    
    GameAddFlagRun( "nd2d_afa_copy_2_spawned" )
end

function try_spawn_copy_3()
    if GameHasFlagRun( "nd2d_afa_copy_3_spawned" ) then return end
    if not is_within_bounds( 10100, 11000, 15750, 16500 ) then return end
    -- in the orb room at the bottom of the Wizards' Den

    CreateItemActionEntity( "ND2D_ALT_FIRE_ANYTHING", 10526, 16160 )
    
    GameAddFlagRun( "nd2d_afa_copy_3_spawned" )
end



try_spawn_copy_1()
try_spawn_copy_2()
try_spawn_copy_3()
