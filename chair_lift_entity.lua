
local S = chair_lift.translator

local player_set_animation = nil

if minetest.get_modpath("player_api") then
  player_set_animation = player_api.set_animation
elseif minetes.get_modpath("hades_player") then
  player_set_animation = hades_player.player_set_animation
end

local chair_entity = {
  initial_properties = {
    physical = true,
    collisionbox = {-0.4,-0.4,-0.4,0.4,0.4,0,4},
    selectionbox = {-0.4,-0.4,-0.4,0.4,0.8,0,4},
    visual = "mesh",
    visual = "cube",
    mesh = "chair_lift_chair.obj",
    visual_size = {x=1,y=1,z=1},
    textures = {"chair_lift_chair.png"},
  },
  driver = nil,
  old_pos = nil,
}

function chair_entity:on_activate(staticdata, dtime_s)
  self.object:set_armor_groups({immortal=1})
  if staticdata then
  end
end

function chair_entity:get_staticdata()
end

function chair_entity:on_rightclick(clicker)
  local player_name = clicker:get_player_name()
  if self.driver==nil then
    -- attach
    clicker:set_attach(self.object, "", {x=0,y=0,z=0},{x=0,y=0,z=0})
    minetest.after(0.1, function() player_set_animation(clicker, "set", 30) end)
    self.driver = player_name
  else
    if self.driver==player_name then
      -- detach
      clicker:set_detach()
      self.driver = nil
      minetest.after(0.1, function() player_set_animation(clicker, "stand") end)
    else
    end
  end
end

function chair_entity:on_punch(puncher)
  if self.driver==nil then
    local inv = puncher:get_inventory()
    inv:add_item("main", ItemStack("chair_lift:chair"))
    self.object:remove()
  end
end

minetest.register_entity("chair_lift:chair", chair_entity)

minetest.register_craftitem("chair_lift:chair", {
    description = S("Chair Lift Chair"),
    inventory_image = "chair_lift_chair_inv.png",
    
    on_place = function (itemstack, placer, pointed_thing)
      if pointed_thing.type~="node" then
        return itemstack
      end
      
      local pos = pointed_thing.under
      
      local node = minetest.get_node(pos)
      if minetest.get_item_group(node.name, "lift_steel_rope")<1 then
        return itemstack
      end
      
      pos.y = pos.y - 2.5
      minetest.add_entity(pos, "chair_lift:chair")
      
      itemstack:take_item()
      return itemstack
    end,
  })

