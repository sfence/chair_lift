
local adaptation = chair_lift.adaptation

local N = adaptation_lib.get_item_name

adaptation_lib.check_keys_aviable("[chair_lift] Crafting: ", adaptation, {"steel_wire", "empty_spool", "steel_block", "steel_gear", "wheel_ingot", "seat_ingot", "seat_block", "seat_glass"})

minetest.register_craft({
    output = "chair_lift:steel_rope 2",
    recipe = {
        {N(adaptation.steel_wire),N(adaptation.steel_wire)},
        {N(adaptation.steel_wire),N(adaptation.steel_wire)},
        {N(adaptation.steel_wire),N(adaptation.steel_wire)},
      },
    replacements = {
        {N(adaptation.steel_wire),N(adaptation.empty_spool)},
        {N(adaptation.steel_wire),N(adaptation.empty_spool)},
        {N(adaptation.steel_wire),N(adaptation.empty_spool)},
        {N(adaptation.steel_wire),N(adaptation.empty_spool)},
        {N(adaptation.steel_wire),N(adaptation.empty_spool)},
        {N(adaptation.steel_wire),N(adaptation.empty_spool)},
      },
  })

minetest.register_craft({
    output = "chair_lift:pole_body 9",
    recipe = {
        {N(adaptation.steel_block), N(adaptation.steel_block)},
        {N(adaptation.steel_block), N(adaptation.steel_block)},
        {N(adaptation.steel_block), N(adaptation.steel_block)},
      },
  })

minetest.register_craft({
    output = "chair_lift:pole_arm 9",
    recipe = {
        {N(adaptation.steel_block)},
        {N(adaptation.steel_block)},
        {N(adaptation.steel_block)},
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
        {"",N(adaptation.wheel_ingot),""},
        {N(adaptation.wheel_ingot),"",N(adaptation.wheel_ingot)},
        {"",N(adaptation.wheel_ingot),""},
      },
  })

minetest.register_craft({
    output = "chair_lift:rope_wheel",
    recipe = {
        {"chair_lift:wheel_part"},
        {N(adaptation.wheel_ingot)},
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
        {N(adaptation.steel_gear),"power_generators:shaft",N(adaptation.steel_gear)},
        {"","chair_lift:rope_wheel",""},
      },
  })

minetest.register_craft({
    output = "chair_lift:seat",
    recipe = {
        {"chair_lift:rope_wheel",N(adaptation.seat_ingot),"chair_lift:rope_wheel"},
        {N(adaptation.seat_ingot),"power_generators:shaft",""},
        {N(adaptation.seat_block),N(adaptation.seat_glass),""},
      },
  })

