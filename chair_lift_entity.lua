
local S = chair_lift.translator

local player_set_animation = nil
local player_set_attached = nil

if minetest.get_modpath("player_api") then
  player_set_animation = player_api.set_animation
  player_set_attached = function(name, value)
      player_api.player_attached[name] = value
    end
elseif minetest.get_modpath("hades_player") then
  player_set_animation = hades_player.player_set_animation
  player_set_attached = function(name, value)
      hades_player.player_attached[name] = value
    end
end

local chair_pos_offset = vector.new(0, -2.5+3/16, 0) 

local function get_rotation(param2)
  local dir = minetest.facedir_to_dir(param2)
  local rot = vector.dir_to_rotation(dir)
  if param2>=20 then
    rot.z = math.pi
  end
  return rot
end

local chair_entity = {
  initial_properties = {
    physical = true,
    collisionbox = {-0.5,-0.5,-0.5,0.5,0.8,0,5},
    selectionbox = {-0.5,-0.5,-0.5,0.5,1.4,0,5},
    visual = "mesh",
    mesh = "chair_lift_seat.obj",
    visual_size = {x=1,y=1,z=1},
    textures = {"chair_lift_seat.png"},
  },
  driver = nil,
  prev_pos = nil,
}

function chair_entity:on_activate(staticdata, dtime_s)
  self.object:set_armor_groups({immortal=1})
  if staticdata and staticdata~="" then
    staticdata = minetest.deserialize(staticdata)
    self.powered_wheel = staticdata.powered_wheel
    self.forward = staticdata.forward
    self.prev_pos = staticdata.prev_pos
  else
    local pos = self.object:get_pos()
    self.prev_pos = vector.new(pos)
    pos = vector.subtract(pos, chair_pos_offset)
    --print("check powered_wheel: "..minetest.pos_to_string(pos))
    self.powered_wheel, self.forward = chair_lift.find_powered_wheel(pos, nil)
    --print("powered_wheel: "..dump(self.powered_wheel))
  end
  self.prev_pos = self.object:get_pos()
end

function chair_entity:get_staticdata()
  local staticdata = {
    powered_wheel = self.powered_wheel,
    forward = self.forward,
  }
  return minetest.serialize(staticdata)
end

function chair_entity:on_rightclick(clicker)
  local player_name = clicker:get_player_name()
  if self.driver==nil then
    -- attach
    clicker:set_attach(self.object, "", {x=0,y=0,z=0},{x=0,y=0,z=0})
    player_api.player_attached[player_name] = true
    player_set_attached(player_name, true)
    minetest.after(0.2, function() 
        player = minetest.get_player_by_name(player_name)
        if player then
          player_set_animation(player, "sit")
        end
      end)
    self.driver = player_name
  else
    if self.driver==player_name then
      -- detach
      clicker:set_detach()
      self.driver = nil
      player_set_attached(player_name, nil)
      player_set_animation(clicker, "stand")
    else
    end
  end
end

function chair_entity:on_punch(puncher)
  if self.driver==nil then
    local inv = puncher:get_inventory()
    inv:add_item("main", ItemStack("chair_lift:seat"))
    self.object:remove()
  end
end

function chair_entity:cause_fall(pos)
  -- update pos, cause fall
  --print("Cause fall pos:"..minetest.pos_to_string(pos))
  self.object:move_to(pos)
  self.object:set_velocity(vector.new(0,0,0))
  self.object:set_acceleration(vector.new(0,-9.81,0))
  if self.driver then
    local player = minetest.get_player_by_name(self.driver)
    if player then
      player:set_detach()
      minetest.after(0.1, function() player_set_animation(player, "stand") end)
    end
    self.driver = nil
  end
  self.fall = true
  return
end

function chair_entity:on_step(dtime)
  if self.fall then
    return
  end
  -- 
  local pos = self.object:get_pos()
  local rpos = vector.subtract(pos, chair_pos_offset)
  --print("start_pos: "..minetest.pos_to_string(pos))
  local act_speed = vector.length(self.object:get_velocity())
  local track = vector.distance(self.prev_pos, pos)
  if track>0 then
    -- one by one, to eliminate posibly problems with position on lagy servers
    local act_pos = vector.subtract(self.prev_pos, chair_pos_offset)
    local act_npos = vector.round(act_pos)
    local act_node = minetest.get_node(act_npos)
    local act_def = minetest.registered_nodes[act_node.name]
    if not act_def or not act_def._steel_rope then
      --print("Fall, missing steel rope at; "..minetest.pos_to_string(act_pos))
      act_pos = vector.add(act_pos, chair_pos_offset)
      self:cause_fall(act_pos)
      return
    end
    
    local act_offset
    if self.forward then
      act_offset = act_def._steel_rope.forward_offset
    else
      act_offset = act_def._steel_rope.backward_offset
    end
    -- reduce track
    local act_dir = minetest.facedir_to_dir(act_node.param2%32)
    local act_rot = get_rotation(act_node.param2%32)
    --print("dir: "..minetest.pos_to_string(act_dir).." param2: "..act_node.param2.." rot: "..minetest.pos_to_string(vector.dir_to_rotation(act_dir)).." rot2: "..minetest.pos_to_string(get_rotation(act_node.param2%32)))
    --print("offset: "..minetest.pos_to_string(act_offset).." from "..act_node.name.." forward "..dump(self.forward))
    act_offset = vector.rotate(act_offset, act_rot)
    --print("offset: "..minetest.pos_to_string(act_offset))
    local act_opos = vector.add(act_npos, act_offset)
    --print("act_pos: "..minetest.pos_to_string(act_pos))
    --print("act_opos: "..minetest.pos_to_string(act_opos))
    --print("track: "..track)
    
    local next_track = vector.distance(act_pos, act_opos)
    track = track - next_track
    --print("track: "..track)
    
    while track>0 do
      act_pos = act_opos
      local old_npos = act_npos
      local old_node = act_node
      local old_def = act_def
      
      if self.forward then
        act_npos = appliances.get_sides_pos(old_npos, old_node, old_def._steel_rope.forward)
      else
        act_npos = appliances.get_sides_pos(old_npos, old_node, old_def._steel_rope.backward)
      end
      act_node = minetest.get_node(act_npos)
      act_def = minetest.registered_nodes[act_node.name]
      if not act_def or not act_def._steel_rope then
        -- update pos, cause fall
        --print("Fall, missing steel rope while at; "..minetest.pos_to_string(act_pos))
        act_pos = vector.add(act_pos, chair_pos_offset)
        self:cause_fall(act_pos)
        return
      end
      local test_pos = appliances.get_sides_pos(act_npos, act_node, act_def._steel_rope.forward)
      local forward = not vector.equals(old_npos, test_pos)
      --print("old_npos: "..minetest.pos_to_string(old_npos).." test_pos"..minetest.pos_to_string(test_pos))
      
      if forward then
        act_offset = act_def._steel_rope.forward_offset
      else
        act_offset = act_def._steel_rope.backward_offset
      end
      
      act_dir = minetest.facedir_to_dir(act_node.param2%32)
      act_rot = get_rotation(act_node.param2%32)
      --print("dir: "..minetest.pos_to_string(act_dir).." param2: "..act_node.param2.." rot: "..minetest.pos_to_string(vector.dir_to_rotation(act_dir)))
      --print("offset: "..minetest.pos_to_string(act_offset).." from "..act_node.name)
      act_offset = vector.rotate(act_offset, act_rot)
      --print("offset: "..minetest.pos_to_string(act_offset))
      act_opos = vector.add(act_npos, act_offset)
      --print("old_npos: "..minetest.pos_to_string(old_npos).." act_npos"..minetest.pos_to_string(act_npos))
      --print("old_forward: "..dump(self.forward).." act_forward: "..dump(forward))
      --print("act_pos: "..minetest.pos_to_string(act_pos))
      --print("act_opos: "..minetest.pos_to_string(act_opos))
      
      track = track - vector.distance(act_pos, act_opos)
      --print("track: "..track)
      self.forward = forward
    end
    local old_pos = act_pos
    act_pos = act_opos
    
    local diff_pos = vector.subtract(act_pos, old_pos)
    if track<0 then
      --print("new_pos: "..minetest.pos_to_string(act_pos))
      --print("old_pos: "..minetest.pos_to_string(old_pos))
      --print("diff_pos: "..minetest.pos_to_string(diff_pos).." len: "..vector.length(diff_pos))
      act_pos = vector.add(act_pos, vector.multiply(diff_pos, track/vector.length(diff_pos)))
      --print("new_pos: "..minetest.pos_to_string(act_pos).." dis: "..vector.distance(old_pos, act_pos))
    end
    act_pos = vector.add(act_pos, chair_pos_offset)
    --print("new_pos: "..minetest.pos_to_string(act_pos))
    self.object:move_to(act_pos)
    self.prev_pos = act_pos
    self.object:set_velocity(vector.multiply(vector.normalize(diff_pos), act_speed))
    -- rotation should be corrected, depend on velocity direction
    self.object:set_rotation(vector.new(0,minetest.dir_to_yaw(diff_pos),0))
  end
  
  -- check powered wheel
  if self.powered_wheel then
    local node = minetest.get_node(self.powered_wheel)
    --print(dump(node))
    if minetest.get_item_group(node.name, "lift_powered_wheel")>0 then
      local meta = minetest.get_meta(self.powered_wheel)
      local lift_speed = meta:get_float("lift_speed")
      if (lift_speed==0) and act_speed>0 then
        -- stop and update self forward
        self.object:set_velocity(vector.new(0,0,0))
      elseif (lift_speed>0) then
        -- speed
        local dir = vector.rotate(vector.new(0,0,1), self.object:get_rotation())
        self.object:set_velocity(vector.multiply(dir, lift_speed))
        --print("new speed: "..lift_speed)
      end
    else
      self.object:set_velocity(vector.new(0,0,0))
    end
  else
    self.object:set_velocity(vector.new(0,0,0))
  end
end

minetest.register_entity("chair_lift:seat", chair_entity)

minetest.register_craftitem("chair_lift:seat", {
    description = S("Chair Lift Seat"),
    inventory_image = "chair_lift_seat_inv.png",
    
    on_place = function (itemstack, placer, pointed_thing)
      if pointed_thing.type~="node" then
        return itemstack
      end
      
      local pos = pointed_thing.under
      
      local node = minetest.get_node(pos)
      if minetest.get_item_group(node.name, "lift_steel_rope")<1 then
        return itemstack
      end
      
      pos = vector.add(pos, chair_pos_offset)
      --print("Chair to pos: "..minetest.pos_to_string(pos))
      minetest.add_entity(pos, "chair_lift:seat")
      
      itemstack:take_item()
      return itemstack
    end,
  })

