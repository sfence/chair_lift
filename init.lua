
chair_lift = {
  translator = minetest.get_translator("chair_lift")
}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/chair_lift.lua")
dofile(modpath.."/steel_rope.lua")
dofile(modpath.."/chair_lift_entity.lua")

