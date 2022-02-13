
chair_lift = {
  translator = minetest.get_translator("chair_lift")
}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/functions.lua")

dofile(modpath.."/chair_lift.lua")
dofile(modpath.."/steel_rope.lua")
dofile(modpath.."/powered_wheel.lua")
dofile(modpath.."/chair_lift_entity.lua")

dofile(modpath.."/craftitems.lua")
dofile(modpath.."/crafting.lua")

