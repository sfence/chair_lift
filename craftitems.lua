
local S = chair_lift.translator

minetest.register_craftitem("chair_lift:wheel_part", {
    description = S("Part of Wheel for Steel Rope"),
    inventory_image = "chair_lift_wheel_part.png",
  })

minetest.register_craftitem("chair_lift:rope_wheel", {
    description = S("Wheel for Steel Rope"),
    inventory_image = "chair_lift_rope_wheel.png",
  })

if minetest.get_modpath("technic") or minetest.get_modpath("hades_technic") then
  minetest.register_craftitem("chair_lift:stainless_steel_wire", {
      description = S("Stainless Steel Wire"),
      inventory_image = "chair_lift_stainless_steel_wire.png",
    })
else
  if minetest.get_modpath("basic_materials") then
    minetest.register_alias("chair_lift:stainless_steel_wire", "basic_materials:steel_wire")
  end
  if minetest.get_modpath("hades_extramaterials") then
    minetest.register_alias("chair_lift:stainless_steel_wire", "basic_materials:hades_steel_wire")
  end
end

