
local items = {
  empty_spool = "basic_materials:empty_spool",
  steel_gear = "basic_materials:gear_steel",
  steel_block = "default:steelblock",
  wheel_ingot = "default:steel_ingot",
  seat_block = "default:steelblock",
  seat_ingot = "default:steel_ingot",
  seat_glass = "default:glass",
}

if minetest.get_modpath("hades_core") then
  items.steel_block = "hades_core:steelblock"
  items.wheel_ingot = "hades_core:steel_ingot"
  items.seat_block = "hades_core:steelblock"
  items.seat_ingot = "hades_core:steel_ingot"
  items.seat_glass = "hades_core:glass"
end

if minetest.get_modpath("technic") then
  items.steel_block = "technic:carbon_steel_block"
  items.wheel_ingot = "technic:stainless_steel_ingot"
  items.seat_block = "technic:carbon_steel_block"
  items.seat_ingot = "technic:carbon_steel_ingot"
end

if minetest.get_modpath("hades_technic") then
  items.steel_block = "hades_technic:carbon_steel_block"
  items.wheel_ingot = "hades_technic:stainless_steel_ingot"
  items.seat_block = "hades_technic:carbon_steel_block"
  items.seat_ingot = "hades_technic:carbon_steel_ingot"
end

if minetest.get_modpath("technic") or minetest.get_modpath("hades_technic") then
  minetest.register_craft({
      output = "chair_lift:stainless_steel_wire 2",
      recipe = {
        {items.wheel_ingot,items.empty_spool},
        {items.empty_spool,""},
      },
    })
end

minetest.register_craft({
    output = "chair_lift:steel_rope 2",
    recipe = {
        {"chair_lift:stainless_steel_wire","chair_lift:stainless_steel_wire"},
        {"chair_lift:stainless_steel_wire","chair_lift:stainless_steel_wire"},
        {"chair_lift:stainless_steel_wire","chair_lift:stainless_steel_wire"},
      },
    replacements = {
        {"chair_lift:stainless_steel_wire",items.empty_spool},
        {"chair_lift:stainless_steel_wire",items.empty_spool},
        {"chair_lift:stainless_steel_wire",items.empty_spool},
        {"chair_lift:stainless_steel_wire",items.empty_spool},
        {"chair_lift:stainless_steel_wire",items.empty_spool},
        {"chair_lift:stainless_steel_wire",items.empty_spool},
      },
  })

minetest.register_craft({
    output = "chair_lift:pole_body 9",
    recipe = {
        {items.steel_block, items.steel_block},
        {items.steel_block, items.steel_block},
        {items.steel_block, items.steel_block},
      },
  })

minetest.register_craft({
    output = "chair_lift:pole_arm 9",
    recipe = {
        {items.steel_block},
        {items.steel_block},
        {items.steel_block},
      },
  })

minetest.register_craft({
    output = "chair_lift:pole_arm_shaft",
    recipe = {
        {"chair_lift:pole_arm", "power_generators:shaft"},
      },
  })

minetest.register_craft({
    output = "chair_lift:wheel_part",
    recipe = {
        {"",items.wheel_ingot,""},
        {items.wheel_ingot,"",items.wheel_ingot},
        {"",items.wheel_ingot,""},
      },
  })

minetest.register_craft({
    output = "chair_lift:rope_wheel",
    recipe = {
        {"chair_lift:wheel_part"},
        {items.wheel_ingot},
        {"chair_lift:wheel_part"},
      },
  })

minetest.register_craft({
    output = "chair_lift:pole_arm_end",
    recipe = {
        {"","chair_lift:pole_arm",""},
        {"chair_lift:rope_wheel","power_generators:shaft","chair_lift:rope_wheel"}
      },
  })

minetest.register_craft({
    output = "chair_lift:wheel_powered",
    recipe = {
        {"","chair_lift:pole_arm",""},
        {items.steel_gear,"power_generators:shaft",items.steel_gear},
        {"","chair_lift:rope_wheel",""},
      },
  })

minetest.register_craft({
    output = "chair_lift:seat",
    recipe = {
        {"chair_lift:rope_wheel",items.seat_ingot,"chair_lift:rope_wheel"},
        {items.seat_ingot,"power_generators:shaft",""},
        {items.seat_block,items.seat_glass,""},
      },
  })

