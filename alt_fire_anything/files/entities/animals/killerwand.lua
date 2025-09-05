dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

GamePrint("killerwand spawned!")


local entity_pick_up_this_item = EntityLoad( "data/entities/items/wand_level_06.xml", pos_x, pos_y )

local EZWand = dofile_once( "mods/alt_fire_anything/files/scripts/lib/ezwand.lua" )
local wand = EZWand( entity_pick_up_this_item )
if wand:GetFreeSlotsCount() == 0 then wand.capacity = wand.capacity + 1 end
wand:AddSpells("ALT_FIRE_ANYTHING")
-- spawn a custom wand instead? one that will pose a reasonable challenge, with "alt fire anything" on it for unlocking

local entity_ghost = entity_id
local itempickup = EntityGetFirstComponent( entity_ghost, "ItemPickUpperComponent" )
if( itempickup ) then
	ComponentSetValue2( itempickup, "only_pick_this_entity", entity_pick_up_this_item )
	GamePickUpInventoryItem( entity_ghost, entity_pick_up_this_item, false )
end

-- check that we hold the item
local items = GameGetAllInventoryItems( entity_ghost )
local has_item = false

if( items ~= nil ) then
	for i,v in ipairs(items) do
		if( v == entity_pick_up_this_item ) then
			has_item = true
		end
	end
end

-- if we don't have the item kill us for we are too dangerous to be left alive
if( has_item == false ) then
	EntityKill( entity_ghost )
end

