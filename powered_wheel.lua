
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
local wheel_powered_box = {
  type = "fixed",
  fixed = {
    {-0.0625,-0.25,-0.1875,0.0625,-0.125,0.5},
    {-0.125,-0.4375,-0.125,0.125,-0.25,-0.0625},
    {-0.1875,-0.375,-0.125,-0.125,0.0,-0.0625},
    {0.125,-0.375,-0.125,0.1875,0.0,-0.0625},
    {-0.25,-0.3125,-0.125,-0.1875,-0.0625,-0.0625},
    {0.1875,-0.3125,-0.125,0.25,-0.0625,-0.0625},
    {-0.125,-0.25,-0.125,-0.0625,0.0625,-0.0625},
    {0.0625,-0.25,-0.125,0.125,0.0625,-0.0625},
    {-0.4375,-0.1875,-0.125,-0.3125,0.0,-0.0625},
    {0.3125,-0.1875,-0.125,0.4375,0.0,-0.0625},
    {-0.0625,-0.125,-0.125,0.0625,0.0625,-0.0625},
    {-0.0625,-0.375,-0.0625,0.0625,-0.25,0.125},
    {-0.125,-0.3125,-0.0625,-0.0625,-0.0625,0.125},
    {0.0625,-0.3125,-0.0625,0.125,-0.0625,0.125},
    {-0.1875,-0.25,-0.0625,-0.125,-0.125,0.125},
    {0.125,-0.25,-0.0625,0.1875,-0.125,0.125},
    {-0.4375,-0.1875,-0.0625,-0.3125,-0.0625,0.375},
    {0.3125,-0.1875,-0.0625,0.4375,-0.0625,0.375},
    {-0.0625,-0.125,-0.0625,0.0625,0.0,0.125},
    {-0.125,-0.4375,0.0625,0.125,-0.375,0.125},
    {-0.1875,-0.375,0.0625,-0.0625,-0.3125,0.125},
    {0.0625,-0.375,0.0625,0.1875,-0.3125,0.125},
    {-0.25,-0.3125,0.0625,-0.125,-0.25,0.125},
    {0.125,-0.3125,0.0625,0.25,-0.25,0.125},
    {-0.25,-0.25,0.0625,-0.1875,-0.0625,0.125},
    {0.1875,-0.25,0.0625,0.25,-0.0625,0.125},
    {-0.1875,-0.125,0.0625,-0.125,0.0,0.125},
    {0.125,-0.125,0.0625,0.1875,0.0,0.125},
    {-0.4375,-0.0625,0.0625,-0.3125,0.0,0.375},
    {-0.125,-0.0625,0.0625,-0.0625,0.0625,0.125},
    {0.0625,-0.0625,0.0625,0.125,0.0625,0.125},
    {0.3125,-0.0625,0.0625,0.4375,0.0,0.375},
    {-0.0625,0.0,0.0625,0.0625,0.0625,0.125},
    {-0.1875,-0.5,0.25,0.1875,-0.25,0.5},
    {-0.4375,-0.3125,0.25,-0.1875,-0.1875,0.375},
    {0.1875,-0.3125,0.25,0.4375,-0.1875,0.375},
    {-0.1875,-0.25,0.25,-0.0625,0.25,0.5},
    {0.0625,-0.25,0.25,0.1875,0.25,0.5},
    {-0.3125,-0.1875,0.25,-0.1875,0.0625,0.375},
    {0.1875,-0.1875,0.25,0.3125,0.0625,0.375},
    {-0.0625,-0.125,0.25,0.0625,0.25,0.5},
    {-0.4375,0.0,0.25,-0.3125,0.0625,0.375},
    {0.3125,0.0,0.25,0.4375,0.0625,0.375},
    {-0.375,-0.25,0.375,-0.1875,0.0,0.4375},
    {0.1875,-0.25,0.375,0.375,0.0,0.4375},
  },
}
-- node box {x=0, y=0, z=0}
local wheel_powered_rope_box = {
  type = "fixed",
  fixed = {
    {-0.0625,-0.25,-0.1875,0.0625,-0.125,0.5},
    {-0.125,-0.4375,-0.125,0.125,-0.25,-0.0625},
    {-0.1875,-0.375,-0.125,-0.125,0.0,-0.0625},
    {0.125,-0.375,-0.125,0.1875,0.0,-0.0625},
    {-0.25,-0.3125,-0.125,-0.1875,-0.0625,-0.0625},
    {0.1875,-0.3125,-0.125,0.25,-0.0625,-0.0625},
    {-0.125,-0.25,-0.125,-0.0625,0.0625,-0.0625},
    {0.0625,-0.25,-0.125,0.125,0.0625,-0.0625},
    {-0.4375,-0.1875,-0.125,-0.3125,0.0,0.375},
    {0.3125,-0.1875,-0.125,0.4375,0.0,0.375},
    {-0.0625,-0.125,-0.125,0.0625,0.0625,0.125},
    {-0.0625,-0.375,-0.0625,0.0625,-0.25,0.125},
    {-0.125,-0.3125,-0.0625,-0.0625,-0.0625,0.125},
    {0.0625,-0.3125,-0.0625,0.125,-0.0625,0.125},
    {-0.1875,-0.25,-0.0625,-0.125,-0.125,0.125},
    {0.125,-0.25,-0.0625,0.1875,-0.125,0.125},
    {-0.5,-0.0625,-0.0625,-0.4375,0.0625,0.0625},
    {0.4375,-0.0625,-0.0625,0.5,0.0625,0.0625},
    {-0.4375,0.0,-0.0625,-0.0625,0.0625,0.0625},
    {0.0625,0.0,-0.0625,0.4375,0.0625,0.0625},
    {-0.3125,0.0625,-0.0625,0.3125,0.125,0.0625},
    {-0.125,-0.4375,0.0625,0.125,-0.375,0.125},
    {-0.1875,-0.375,0.0625,-0.0625,-0.3125,0.125},
    {0.0625,-0.375,0.0625,0.1875,-0.3125,0.125},
    {-0.25,-0.3125,0.0625,-0.125,-0.25,0.125},
    {0.125,-0.3125,0.0625,0.25,-0.25,0.125},
    {-0.25,-0.25,0.0625,-0.1875,-0.0625,0.125},
    {0.1875,-0.25,0.0625,0.25,-0.0625,0.125},
    {-0.1875,-0.125,0.0625,-0.125,0.0,0.125},
    {0.125,-0.125,0.0625,0.1875,0.0,0.125},
    {-0.125,-0.0625,0.0625,-0.0625,0.0625,0.125},
    {0.0625,-0.0625,0.0625,0.125,0.0625,0.125},
    {-0.1875,-0.5,0.25,0.1875,-0.25,0.5},
    {-0.4375,-0.3125,0.25,-0.1875,-0.1875,0.375},
    {0.1875,-0.3125,0.25,0.4375,-0.1875,0.375},
    {-0.1875,-0.25,0.25,-0.0625,0.25,0.5},
    {0.0625,-0.25,0.25,0.1875,0.25,0.5},
    {-0.3125,-0.1875,0.25,-0.1875,0.0625,0.375},
    {0.1875,-0.1875,0.25,0.3125,0.0625,0.375},
    {-0.0625,-0.125,0.25,0.0625,0.25,0.5},
    {-0.4375,0.0,0.25,-0.3125,0.0625,0.375},
    {0.3125,0.0,0.25,0.4375,0.0625,0.375},
    {-0.375,-0.25,0.375,-0.1875,0.0,0.4375},
    {0.1875,-0.25,0.375,0.375,0.0,0.4375},
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

minetest.register_node("chair_lift:wheel_powered", {
    description = S("Ski Lift Powered Wheel"),
    tiles = {"chair_lift_pole_steel.png", "chair_lift_wheel_steel.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_wheel_powered.obj",
    selection_box = wheel_powered_box,
    collision_box = wheel_powered_box,
    groups = {cracky = 1, level = 2},
    sounds = metal_sounds,
    
    _steel_rope_node = "chair_lift:wheel_powered_rope",
  })

chair_lift.wheel_powered = appliances.appliance:new(
    {
      node_name_inactive = "chair_lift:wheel_powered_rope",
      node_name_active = "chair_lift:wheel_powered_rope_active",
      
      node_description = S("Chair Lift Powered Wheel Rope"),
    	node_help = S("Connect to power (@1).", "25 EU").."\n"..S("Use this for generate 150 unit of energy.").."\n"..S("Startup and Shutdown by punch."),
      
      input_stack_size = 0,
      have_input = false,
      use_stack_size = 0,
      have_usage = false,
      output_stack_size = 0,
      
      power_connect_sides = {"back"},
      
      sounds = {
        active_running = {
          sound = "chair_lift_wheel_powered_running",
          sound_param = {max_hear_distance = 16, gain = 1},
          repeat_timer = 3,
        },
        waiting_running = {
          sound = "chair_lift_wheel_powered_running",
          sound_param = {max_hear_distance = 16, gain = 1},
          repeat_timer = 3,
        },
        running = {
          sound = "chair_lift_wheel_powered_running",
          sound_param = {max_hear_distance = 16, gain = 1},
          repeat_timer = 1,
        },
      },
    })

local wheel_powered = chair_lift.wheel_powered

wheel_powered:power_data_register(
  {
    ["power_generators_shaft_power"] = {
        run_speed = 1,
        friction = 5,
        I = 50,
        qgrease_max = 3,
        qgrease_eff = 2,
        rpm_deactivate = true,
        demand = 1,
        disable = {}
      },
  })

--------------
-- Formspec --
--------------

function wheel_powered:get_formspec(meta, production_percent, consumption_percent)
  return "";
end

---------------
-- Callbacks --
---------------

function wheel_powered:update_state(pos, meta, state)
  local old_state = self:get_state(meta)
  if (state=="running") and (old_state~="running") then
    local Isum, friction = chair_lift.measure_rope(pos, nil)
    if Isum then
      --print("Rope measure Isum: "..Isum.." minT:"..friction*2000)
      meta:set_int("_Isum", Isum)
      meta:set_int("_minT", friction*2000)
    else
      --print("Rope measure failed.")
      meta:set_int("_Isum", self._I)
      meta:set_int("_minT", 0)
      meta:set_float("lift_speed", 0)
    end
  elseif (state~="running") and (old_state=="running") then
    meta:set_int("_Isum", self._I)
    meta:set_int("_minT", 0)
    meta:set_float("lift_speed", 0)
  end
  self:set_state(meta, state)
end

function wheel_powered:cb_on_production(timer_step)
  --power_generators.shaft_step(self, timer_step.pos, timer_step.meta, timer_step.use_usage)
  timer_step.meta:set_float("lift_speed", math.min(math.max(timer_step.meta:get_int("L")/timer_step.meta:get_int("Isum")/120,0),10))
  timer_step.meta:set_int("Isum", timer_step.meta:get_int("_Isum"))
  timer_step.meta:set_int("minT", timer_step.meta:get_int("_minT"))
  
end

--[[
function wheel_powered:cb_waiting(pos, meta)
  power_generators.shaft_step(self, pos, meta, nil)
end

function wheel_powered:cb_no_power(pos, meta)
  power_generators.shaft_step(self, pos, meta, nil)
end

function wheel_powered:cb_deactivate(pos, meta)
  power_generators.shaft_step(self, pos, meta, nil)
end
--]]

minetest.register_node("chair_lift:wheel_powered_rope", {
    description = S("Ski Lift Powered Wheel with Rope"),
  })

local node_def = {
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_wheel_powered_rope.obj",
    selection_box = wheel_powered_rope_box,
    collision_box = wheel_powered_rope_box,
    groups = {cracky = 1, level = 2, lift_steel_rope = 1, lift_powered_wheel= 1, shaft = 1, not_in_creative_inventory = 1},
    sounds = metal_sounds,
    
    drop = {
      items = {
        {
          rariry = 1,
          items = {"chair_lift:wheel_powered", "chair_lift:steel_rope"},
        }
      }
    },
    
    _steel_rope = rope_wheel_steel_rope,
    _steel_rope_place = rope_wheel_steel_rope_place,
    
    _shaft_sides = {"front"},
    
 }

local node_inactive = {
    tiles = {
        "chair_lift_pole_steel.png",
        "chair_lift_wheel_steel.png",
        "power_generators_shaft_steel.png",
        "chair_lift_steel_rope.png",
    },
  }

local node_active = {
    tiles = {
        "chair_lift_pole_steel.png",
        "chair_lift_wheel_steel.png",
        "power_generators_shaft_steel.png",
        "chair_lift_steel_rope.png",
    },
  }

wheel_powered:register_nodes(node_def, node_inactive, node_active)

