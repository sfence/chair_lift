
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
local rope_vertical_box = {
  type = "fixed",
  fixed = {
    {-0.0625,-0.5,-0.5,0.0625,-0.375,-0.4375},
    {-0.0625,-0.4375,-0.4375,0.0625,-0.3125,-0.3125},
    {-0.0625,-0.375,-0.3125,0.0625,-0.25,-0.1875},
    {-0.0625,-0.3125,-0.1875,0.0625,-0.1875,-0.0625},
    {-0.0625,-0.25,-0.0625,0.0625,-0.125,0.0625},
    {-0.0625,-0.1875,0.0625,0.0625,-0.0625,0.1875},
    {-0.0625,-0.125,0.1875,0.0625,0.0,0.3125},
    {-0.0625,-0.0625,0.3125,0.0625,0.0625,0.4375},
    {-0.0625,0.0,0.4375,0.0625,0.125,0.5},
  },
}
for _,data in pairs(rope_vertical_box.fixed) do
  data[2] = data[2] - 1/16
  data[5] = data[5] - 1/16
end
local rope_horizontal_box = {
  type = "fixed",
  fixed = {
    {-0.5,-0.0625,-0.5,-0.375,0.0625,-0.4375},
    {-0.4375,-0.0625,-0.4375,-0.3125,0.0625,-0.3125},
    {-0.375,-0.0625,-0.3125,-0.25,0.0625,-0.1875},
    {-0.3125,-0.0625,-0.1875,-0.1875,0.0625,-0.0625},
    {-0.25,-0.0625,-0.0625,-0.125,0.0625,0.0625},
    {-0.1875,-0.0625,0.0625,-0.0625,0.0625,0.1875},
    {-0.125,-0.0625,0.1875,0.0,0.0625,0.3125},
    {-0.0625,-0.0625,0.3125,0.0625,0.0625,0.4375},
    {0.0,-0.0625,0.4375,0.125,0.0625,0.5},
  },
}
for _,data in pairs(rope_horizontal_box.fixed) do
  data[1] = data[1] - 1/16
  data[4] = data[4] - 1/16
end

-- node box {x=0, y=0, z=0}
local rope_horizontal_2_box = {
  type = "fixed",
  fixed = {
    {-0.0625,-0.0625,-0.5,0.0625,0.0625,-0.4375},
    {0.0,-0.0625,-0.4375,0.125,0.0625,-0.375},
    {0.0625,-0.0625,-0.375,0.1875,0.0625,-0.3125},
    {0.125,-0.0625,-0.3125,0.25,0.0625,-0.25},
    {0.1875,-0.0625,-0.25,0.3125,0.0625,-0.1875},
    {0.25,-0.0625,-0.1875,0.375,0.0625,-0.125},
    {0.3125,-0.0625,-0.125,0.4375,0.0625,-0.0625},
    {0.375,-0.0625,-0.0625,0.5,0.0625,0.0},
    {0.4375,-0.0625,0.0,0.5,0.0625,0.0625},
  },
}

minetest.register_node("chair_lift:steel_rope", {
    description = S("Steel Rope"),
    tiles = {"chair_lift_steel_rope.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_steel_rope.obj",
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.0625,-0.0625,-0.5,0.0625,0.0625,0.5},
      },
    },
    collision_box = {
      type = "fixed",
      fixed = {
        {-0.0625,-0.0625,-0.5,0.0625,0.0625,0.5},
      },
    },
    groups = {cracky = 1, level = 2, lift_steel_rope = 1},
    sounds = metal_sounds,
    sunlight_propagates = true,
    walkable = false,
    
    _steel_rope = {
      forward = {"front"},
      backward = {"back"},
      forward_offset = vector.new(0,0,-0.5),
      backward_offset = vector.new(0,0,0.5),
    },
    _steel_rope_place = {
      front = {
        sides={"front"},
        name="chair_lift:steel_rope",
        param2={
          [0] = 0,
          [1] = 1,
          [2] = 2,
          [3] = 3,
        },
      },
      back = {
        sides={"back"},
        name="chair_lift:steel_rope",
        param2={
          [0] = 0,
          [1] = 1,
          [2] = 2,
          [3] = 3,
        },
      },
    },
    _I = 2,
    _friction = 0.01,
    
    node_placement_prediction = "",
    
    on_rotate = screwdriver.disallow,
    on_place = function(itemstack, placer, pointed_thing)
      local pos = pointed_thing.under
      local node = minetest.get_node(pos)
      local def = minetest.registered_nodes[node.name]
      if not def then
        return itemstack
      end
      if def._steel_rope_node then
        node.name = def._steel_rope_node
        minetest.set_node(pos, node)
        itemstack:take_item()
        return itemstack
      end
      if minetest.get_item_group(node.name, "lift_steel_rope")>0 then
        -- based on click side
        -- click down/up add vertical going steel rope
        -- click from/back in direction add straight steel rope
        -- click side add horizotnal going steel rope
        local click_side = appliances.is_connected_to(pos, node, pointed_thing.above, {"front","back", "right", "left", "top", "bottom"})
        if not click_side then
          local distance = 10000
          local placer_pos = placer:get_pos()
          local best_side
          local test_pos
          for _,test_side in pairs({"front","back","left","top","bottom"}) do
            test_pos = appliances.get_side_pos(pos, node, test_side)
            local test_dist = vector.distance(test_pos, placer_pos)
            if test_dist<=distance then
              distance = test_dist
              best_side = test_side
            end
          end
          click_side = best_side
        end
        local rope = def._steel_rope
        local place = def._steel_rope_place[click_side]
        local target_pos
        local new_node
        if place then
          if place.nearest then
            local distance = 10000
            local placer_pos = placer:get_pos()
            local best_side
            local test_pos
            for key,test_side in pairs(place.nearest) do
              if type(test_side)=="string" then
                test_pos = appliances.get_side_pos(pos, node, test_side)
              else
                test_pos = appliances.get_sides_pos(pos, node, test_side)
                test_side = key
              end
              local test_dist = vector.distance(test_pos, placer_pos)
              if test_dist<=distance then
                distance = test_dist
                best_side = test_side
              end
            end
            if best_side then
              place = place[best_side]
            else
              return itemstack
            end
          end
          local param2 = place.param2[node.param2]
          if param2 then
            target_pos = appliances.get_sides_pos(pos, node, place.sides)
            new_node = {
              name = place.name,
              param2 = param2
            }
          end
        end
        if target_pos then
          local above_node = minetest.get_node(target_pos)
          local above_def = minetest.registered_nodes[above_node.name]
          if above_def and above_def.buildable_to then
            minetest.set_node(target_pos, new_node)
            itemstack:take_item()
            return itemstack
          end
        end
      end
      
      return itemstack
    end,
  })

minetest.register_node("chair_lift:steel_rope_ver", {
    description = S("Steel Rope Vertical"),
    tiles = {"chair_lift_steel_rope.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_steel_rope_vertical.obj",
    selection_box = rope_vertical_box,
    collision_box = rope_vertical_box,
    groups = {cracky = 1, level = 2, lift_steel_rope = 1, not_in_creative_inventory = 1},
    sounds = metal_sounds,
    sunlight_propagates = true,
    walkable = false,
    drop = "chair_lift:steel_rope",
    
    _steel_rope = {
      forward = {"front","bottom"},
      backward = {"back"},
      offset = vector.new(0,0.25,0),
      forward_offset = vector.new(0,-0.5,-0.5),
      backward_offset = vector.new(0,0,0.5),
    },
    _steel_rope_place = {
      front = {
        sides={"front","bottom"},
        name="chair_lift:steel_rope_ver",
        param2={
          [0] = 22,
          [1] = 21,
          [2] = 20,
          [3] = 23,
          [20] = 2,
          [21] = 1,
          [22] = 0,
          [23] = 3,
        },
      },
      back = {
        sides={"back"},
        name="chair_lift:steel_rope_ver",
        param2={
          [0] = 22,
          [1] = 21,
          [2] = 20,
          [3] = 23,
          [20] = 2,
          [21] = 1,
          [22] = 0,
          [23] = 3,
        },
      },
    },
    _I = 2,
    _friction = 0.02,
    
    on_rotate = screwdriver.disallow,
  })
minetest.register_node("chair_lift:steel_rope_hor", {
    description = S("Steel Rope Horizontal"),
    tiles = {"chair_lift_steel_rope.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_steel_rope_horizontal.obj",
    selection_box = rope_horizontal_box,
    collision_box = rope_horizontal_box,
    groups = {cracky = 1, level = 2, lift_steel_rope = 1, not_in_creative_inventory = 1},
    sounds = metal_sounds,
    sunlight_propagates = true,
    walkable = false,
    drop = "chair_lift:steel_rope",
    
    _steel_rope = {
      forward = {"front","right"},
      backward = {"back"},
      forward_offset = vector.new(-0.5,0,-0.5),
      backward_offset = vector.new(0,0,0.5),
    },
    _steel_rope_place = {
      front = {
        sides={"front","right"},
        name="chair_lift:steel_rope_hor",
        param2={
          [0] = 2,
          [1] = 3,
          [2] = 0,
          [3] = 1,
          [20] = 22,
          [21] = 23,
          [22] = 20,
          [23] = 21,
        },
      },
      back = {
        sides={"back"},
        name="chair_lift:steel_rope_hor",
        param2={
          [0] = 2,
          [1] = 3,
          [2] = 0,
          [3] = 1,
          [20] = 22,
          [21] = 23,
          [22] = 20,
          [23] = 21,
        },
      },
    },
    _I = 2,
    _friction = 0.01,
    
    on_rotate = screwdriver.disallow,
  })
minetest.register_node("chair_lift:steel_rope_hor_2", {
    description = S("Steel Rope Horizontal 2"),
    tiles = {"chair_lift_steel_rope.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "chair_lift_steel_rope_horizontal_2.obj",
    selection_box = rope_horizontal_2_box,
    collision_box = rope_horizontal_2_box,
    groups = {cracky = 1, level = 2, lift_steel_rope = 1, not_in_creative_inventory = 1},
    sounds = metal_sounds,
    sunlight_propagates = true,
    walkable = false,
    drop = "chair_lift:steel_rope",
    
    _steel_rope = {
      forward = {"front"},
      backward = {"left"},
      forward_offset = vector.new(0,0,-0.5),
      backward_offset = vector.new(0.5,0,0),
    },
    _steel_rope_place = {
      front = {
        sides={"front"},
        name="chair_lift:steel_rope_hor_2",
        param2={
          [0] = 2,
          [1] = 3,
          [2] = 0,
          [3] = 1,
        },
      },
      left = {
        sides={"left"},
        name="chair_lift:steel_rope_hor_2",
        param2={
          [0] = 2,
          [1] = 3,
          [2] = 0,
          [3] = 1,
        },
      },
    },
    _I = 2,
    _friction = 0.01,
    
    on_rotate = screwdriver.disallow,
  })

