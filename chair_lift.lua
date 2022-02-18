
-- 

local S = chair_lift.translator

local metal_sounds = nil
if minetest.get_modpath("sounds") then
  metal_sounds = sounds.node_metal()
elseif minetest.get_modpath("default") then
  metal_sounds = default.node_sound_metal_defaults()
elseif minetest.get_modpath("hades_sounds") then
  metal_sounds = hades_sounds.node_sound_metal_defaults()
end

-- node box {x=0, y=0, z=0}
local pole_arm_end_box = {
  type = "fixed",
  fixed = {
    {-0.3125,-0.1875,-0.1875,-0.1875,-0.0625,0.4375},
    {0.1875,-0.1875,-0.1875,0.3125,-0.0625,0.4375},
    {-0.375,-0.3125,-0.125,-0.125,-0.1875,-0.0625},
    {0.125,-0.3125,-0.125,0.375,-0.1875,-0.0625},
    {-0.4375,-0.25,-0.125,-0.375,0.0,-0.0625},
    {-0.125,-0.25,-0.125,-0.0625,0.0,-0.0625},
    {0.0625,-0.25,-0.125,0.125,0.0,-0.0625},
    {0.375,-0.25,-0.125,0.4375,0.0,-0.0625},
    {-0.375,-0.1875,-0.125,-0.3125,0.0625,-0.0625},
    {-0.1875,-0.1875,-0.125,-0.125,0.0625,-0.0625},
    {0.125,-0.1875,-0.125,0.1875,0.0625,-0.0625},
    {0.3125,-0.1875,-0.125,0.375,0.0625,-0.0625},
    {-0.3125,-0.0625,-0.125,-0.1875,0.0625,-0.0625},
    {0.1875,-0.0625,-0.125,0.3125,0.0625,-0.0625},
    {-0.3125,-0.25,-0.0625,-0.1875,-0.1875,0.125},
    {0.1875,-0.25,-0.0625,0.3125,-0.1875,0.125},
    {-0.375,-0.1875,-0.0625,-0.3125,-0.0625,0.125},
    {-0.1875,-0.1875,-0.0625,-0.125,-0.0625,0.125},
    {0.125,-0.1875,-0.0625,0.1875,-0.0625,0.125},
    {0.3125,-0.1875,-0.0625,0.375,-0.0625,0.125},
    {-0.3125,-0.0625,-0.0625,-0.1875,0.0,0.125},
    {0.1875,-0.0625,-0.0625,0.3125,0.0,0.125},
    {-0.375,-0.3125,0.0625,-0.125,-0.25,0.125},
    {0.125,-0.3125,0.0625,0.375,-0.25,0.125},
    {-0.4375,-0.25,0.0625,-0.3125,-0.1875,0.125},
    {-0.1875,-0.25,0.0625,-0.0625,-0.1875,0.125},
    {0.0625,-0.25,0.0625,0.1875,-0.1875,0.125},
    {0.3125,-0.25,0.0625,0.4375,-0.1875,0.125},
    {-0.4375,-0.1875,0.0625,-0.375,0.0,0.125},
    {-0.125,-0.1875,0.0625,-0.0625,0.0,0.125},
    {0.0625,-0.1875,0.0625,0.125,0.0,0.125},
    {0.375,-0.1875,0.0625,0.4375,0.0,0.125},
    {-0.375,-0.0625,0.0625,-0.3125,0.0625,0.125},
    {-0.1875,-0.0625,0.0625,-0.125,0.0625,0.125},
    {0.125,-0.0625,0.0625,0.1875,0.0625,0.125},
    {0.3125,-0.0625,0.0625,0.375,0.0625,0.125},
    {-0.3125,0.0,0.0625,-0.1875,0.0625,0.125},
    {0.1875,0.0,0.0625,0.3125,0.0625,0.125},
    {-0.1875,-0.5,0.25,0.1875,0.5,0.5},
    {-0.4375,-0.3125,0.25,-0.1875,-0.1875,0.375},
    {0.1875,-0.3125,0.25,0.4375,-0.1875,0.375},
    {-0.4375,-0.1875,0.25,-0.3125,0.0625,0.375},
    {0.3125,-0.1875,0.25,0.4375,0.0625,0.375},
    {-0.3125,-0.0625,0.25,-0.1875,0.0625,0.375},
    {0.1875,-0.0625,0.25,0.3125,0.0625,0.375},
    {-0.375,-0.25,0.375,-0.1875,-0.1875,0.4375},
    {0.1875,-0.25,0.375,0.375,-0.1875,0.4375},
    {-0.375,-0.1875,0.375,-0.3125,0.0,0.4375},
    {0.3125,-0.1875,0.375,0.375,0.0,0.4375},
    {-0.3125,-0.0625,0.375,-0.1875,0.0,0.4375},
    {0.1875,-0.0625,0.375,0.3125,0.0,0.4375},
  },
}
-- node box {x=0, y=0, z=0}
local pole_arm_end_rope_box = {
  type = "fixed",
  fixed = {
    {-0.3125,-0.1875,-0.1875,-0.1875,-0.0625,0.4375},
    {0.1875,-0.1875,-0.1875,0.3125,-0.0625,0.4375},
    {-0.375,-0.3125,-0.125,-0.125,-0.1875,-0.0625},
    {0.125,-0.3125,-0.125,0.375,-0.1875,-0.0625},
    {-0.4375,-0.25,-0.125,-0.375,0.0,-0.0625},
    {-0.125,-0.25,-0.125,-0.0625,0.0,-0.0625},
    {0.0625,-0.25,-0.125,0.125,0.0,-0.0625},
    {0.375,-0.25,-0.125,0.4375,0.0,-0.0625},
    {-0.375,-0.1875,-0.125,-0.3125,0.0625,0.125},
    {-0.1875,-0.1875,-0.125,-0.125,0.0625,-0.0625},
    {0.125,-0.1875,-0.125,0.1875,0.0625,-0.0625},
    {0.3125,-0.1875,-0.125,0.375,0.0625,0.125},
    {-0.3125,-0.0625,-0.125,-0.1875,0.0625,0.125},
    {0.1875,-0.0625,-0.125,0.3125,0.0625,0.125},
    {-0.3125,-0.25,-0.0625,-0.1875,-0.1875,0.125},
    {0.1875,-0.25,-0.0625,0.3125,-0.1875,0.125},
    {-0.1875,-0.1875,-0.0625,-0.125,-0.0625,0.125},
    {0.125,-0.1875,-0.0625,0.1875,-0.0625,0.125},
    {-0.5,-0.0625,-0.0625,-0.375,0.0625,0.0625},
    {0.375,-0.0625,-0.0625,0.5,0.0625,0.0625},
    {-0.1875,0.0,-0.0625,0.1875,0.125,0.0625},
    {-0.3125,0.0625,-0.0625,-0.1875,0.125,0.0625},
    {0.1875,0.0625,-0.0625,0.3125,0.125,0.0625},
    {-0.375,-0.3125,0.0625,-0.125,-0.25,0.125},
    {0.125,-0.3125,0.0625,0.375,-0.25,0.125},
    {-0.4375,-0.25,0.0625,-0.3125,-0.1875,0.125},
    {-0.1875,-0.25,0.0625,-0.0625,-0.1875,0.125},
    {0.0625,-0.25,0.0625,0.1875,-0.1875,0.125},
    {0.3125,-0.25,0.0625,0.4375,-0.1875,0.125},
    {-0.4375,-0.1875,0.0625,-0.375,0.0,0.125},
    {-0.125,-0.1875,0.0625,-0.0625,0.0,0.125},
    {0.0625,-0.1875,0.0625,0.125,0.0,0.125},
    {0.375,-0.1875,0.0625,0.4375,0.0,0.125},
    {-0.1875,-0.0625,0.0625,-0.125,0.0625,0.125},
    {0.125,-0.0625,0.0625,0.1875,0.0625,0.125},
    {-0.1875,-0.5,0.25,0.1875,0.5,0.5},
    {-0.4375,-0.3125,0.25,-0.1875,-0.1875,0.375},
    {0.1875,-0.3125,0.25,0.4375,-0.1875,0.375},
    {-0.4375,-0.1875,0.25,-0.3125,0.0625,0.375},
    {0.3125,-0.1875,0.25,0.4375,0.0625,0.375},
    {-0.3125,-0.0625,0.25,-0.1875,0.0625,0.375},
    {0.1875,-0.0625,0.25,0.3125,0.0625,0.375},
    {-0.375,-0.25,0.375,-0.1875,-0.1875,0.4375},
    {0.1875,-0.25,0.375,0.375,-0.1875,0.4375},
    {-0.375,-0.1875,0.375,-0.3125,0.0,0.4375},
    {0.3125,-0.1875,0.375,0.375,0.0,0.4375},
    {-0.3125,-0.0625,0.375,-0.1875,0.0,0.4375},
    {0.1875,-0.0625,0.375,0.3125,0.0,0.4375},
  },
}

local rope_wheel_steel_rope = {
    forward = {"right"},
    backward = {"left"},
    forward_offset = vector.new(-0.5,0,0),
    backward_offset = vector.new(0.5,0,0),
  }
local rope_wheel_steel_rope_place = {
    right = {
      sides={"right"},
      name="chair_lift:steel_rope",
      param2 = {
        [0] = 1,
        [1] = 0,
        [2] = 3,
        [3] = 2,
      },
    },
    left = {
      sides={"left"},
      name="chair_lift:steel_rope",
      param2 = {
        [0] = 3,
        [1] = 2,
        [2] = 1,
        [3] = 0,
      },
    },
    front = {
      nearest = {"right","left",front_right={"front","right"},front_left={"front","left"}},
      right = {
        sides={"right"},
        name="chair_lift:steel_rope_hor",
        param2 = {
          [0] = 23,
          [1] = 22,
          [2] = 21,
          [3] = 20,
        },
      },
      left = {
        sides={"left"},
        name="chair_lift:steel_rope_hor",
        param2 = {
          [0] = 3,
          [1] = 0,
          [2] = 1,
          [3] = 2,
        },
      },
      front_right = {
        sides={"right"},
        name="chair_lift:steel_rope_hor_2",
        param2 = {
          [0] = 0,
          [1] = 1,
          [2] = 2,
          [3] = 3,
        },
      },
      front_left = {
        sides={"left"},
        name="chair_lift:steel_rope_hor_2",
        param2 = {
          [0] = 1,
          [1] = 2,
          [2] = 3,
          [3] = 0,
        },
      },
    },
    back = {
      nearest = {"right","left",back_right={"back","right"},back_left={"back","left"}},
      right = {
        sides={"right"},
        name="chair_lift:steel_rope_hor",
        param2 = {
          [0] = 1,
          [1] = 2,
          [2] = 3,
          [3] = 0,
        },
      },
      left = {
        sides={"left"},
        name="chair_lift:steel_rope_hor",
        param2 = {
          [0] = 21,
          [1] = 20,
          [2] = 23,
          [3] = 22,
        },
      },
      back_right = {
        sides={"right"},
        name="chair_lift:steel_rope_hor_2",
        param2 = {
          [0] = 3,
          [1] = 0,
          [2] = 1,
          [3] = 2,
        },
      },
      back_left = {
        sides={"left"},
        name="chair_lift:steel_rope_hor_2",
        param2 = {
          [0] = 2,
          [1] = 3,
          [2] = 0,
          [3] = 1,
        },
      },
    },
    top = {
      nearest = {"right","left"},
      right = {
        sides={"right"},
        name="chair_lift:steel_rope_ver",
        param2 = {
          [0] = 23,
          [1] = 22,
          [2] = 21,
          [3] = 20,
        },
      },
      left = {
        sides={"left"},
        name="chair_lift:steel_rope_ver",
        param2 = {
          [0] = 21,
          [1] = 20,
          [2] = 23,
          [3] = 22,
        },
      },
    },
    bottom = {
      nearest = {"right","left"},
      right = {
        sides={"right"},
        name="chair_lift:steel_rope_ver",
        param2 = {
          [0] = 1,
          [1] = 2,
          [2] = 3,
          [3] = 0,
        },
      },
      left = {
        sides={"left"},
        name="chair_lift:steel_rope_ver",
        param2 = {
          [0] = 3,
          [1] = 0,
          [2] = 1,
          [3] = 2,
        },
      },
    },
  }

minetest.register_node("chair_lift:pole_body", {
    description = S("Tow Pole Body"),
    tiles = {"chair_lift_pole_steel.png"},
    paramtype = "light",
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5,-0.5,-3/16, 0.5,0.5,3/16},
        {-7/16,-0.5,-5/16, 7/16,0.5,5/16},
        {-6/16,-0.5,-6/16, 6/16,0.5,6/16},
        {-5/16,-0.5,-7/16, 5/16,0.5,7/16},
        {-3/16,-0.5,-0.5, 3/16,0.5,0.5},
      },
    },
    collision_box = {
      type = "fixed",
      fixed = {{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }},
    },
    groups = {cracky = 1, level = 2},
    sounds = metal_sounds,
  })

minetest.register_node("chair_lift:pole_arm", {
    description = S("Tow Pole Arm"),
    tiles = {"chair_lift_pole_steel.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-3/16,-0.5,-0.5, 3/16,0.5,0.5},
      },
    },
    groups = {cracky = 1, level = 2},
    sounds = metal_sounds,
  })

minetest.register_node("chair_lift:pole_arm_shaft", {
    description = S("Tow Pole Arm with Shaft"),
    tiles = {"chair_lift_pole_steel.png","chair_lift_pole_steel.png","chair_lift_pole_steel.png","chair_lift_pole_steel.png","chair_lift_pole_arm_shaft.png","chair_lift_pole_arm_shaft.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-3/16,-0.5,-0.5, 3/16,0.5,0.5},
      },
    },
    groups = {cracky = 1, level = 2, shaft = 2},
    sounds = metal_sounds,
    
    _shaft_sides = {"front","back"},
    
    on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      meta:set_float("I", 1)
      meta:set_float("fric", 0.5)
    end,
  })

minetest.register_node("chair_lift:pole_arm_end", {
    description = S("Tow Pole Arm End"),
    tiles = {"chair_lift_pole_steel.png", "chair_lift_wheel_steel.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_pole_arm_end.obj",
    selection_box = pole_arm_end_box,
    collision_box = pole_arm_end_box,
    groups = {cracky = 1, level = 2},
    sounds = metal_sounds,
    
    _steel_rope_node = "chair_lift:pole_arm_end_rope",
  })

minetest.register_node("chair_lift:pole_arm_end_rope", {
    description = S("Tow Pole Arm End Rope"),
    tiles = {"chair_lift_pole_steel.png", "chair_lift_wheel_steel.png", "chair_lift_steel_rope.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_pole_arm_end_rope.obj",
    selection_box = pole_arm_end_rope_box,
    collision_box = pole_arm_end_rope_box,
    groups = {cracky = 1, level = 2, lift_steel_rope = 1, not_in_creative_inventory = 1},
    sounds = metal_sounds,
    
    drop = {
      max_items = 2,
      items = {
        rarity = 1,
        items = {"chair_lift:pole_arm_end", "chair_lift:steel_rope"},
      }
    },
    
    _steel_rope = rope_wheel_steel_rope,
    _steel_rope_place = rope_wheel_steel_rope_place,
    
    _I = 10,
    _friction = 0.75,
  })

