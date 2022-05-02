
local find_limit = 1000

function chair_lift.find_powered_wheel(pos, node)
  if not node then
    node = minetest.get_node(pos)
  end
  if minetest.get_item_group(node.name, "lift_steel_rope")<=0 then
    print("rope missing. "..minetest.pos_to_string(pos))
    return nil, nil
  end
  if minetest.get_item_group(node.name, "lift_powered_wheel")>0 then
    return pos, 1
  end
  
  local prev_pos = vector.new(35000,35000,35000) -- out of the owrld
  local act_pos = pos
  local act_node = node
  local act_def
  local next_pos
  for _=0,find_limit do
    act_def = minetest.registered_nodes[act_node.name]
    if not act_def or not act_def._steel_rope then
      return nil, nil
    end
    next_pos = appliances.get_sides_pos(act_pos, act_node, act_def._steel_rope.forward)
    if vector.equals(prev_pos, next_pos) then
      next_pos = appliances.get_sides_pos(act_pos, act_node, act_def._steel_rope.backward)
    end
    --print(dump(next_pos))
    -- switch
    prev_pos = act_pos
    act_pos = next_pos
    act_node = minetest.get_node(act_pos)
    
    -- cycle check
    if vector.equals(act_pos, pos) then
      print("Cyclic without powered wheel.")
      return nil, nil
    end
    
    -- steel rope check
    if minetest.get_item_group(act_node.name, "lift_steel_rope")<=0 then
      print("Not a rope.")
      return nil, nil
    end
    if minetest.get_item_group(act_node.name, "lift_powered_wheel")>0 then
      act_def = minetest.registered_nodes[act_node.name]
      next_pos = appliances.get_sides_pos(act_pos, act_node, act_def._steel_rope.forward)
      if vector.equals(prev_pos, next_pos) then
        return act_pos, false
      else
        return act_pos, true
      end
    end
  end
  return nil, nil
end

function chair_lift.measure_rope(pos, node)
  if not node then
    node = minetest.get_node(pos)
  end
  if minetest.get_item_group(node.name, "lift_steel_rope")<=0 then
    return nil, nil
  end
  if minetest.get_item_group(node.name, "lift_powered_wheel")<=0 then
    return nil, nil
  end
  
  local rope_Isum = 0
  local rope_friction = 0
  local prev_pos = vector.new(35000,35000,35000) -- out of the world
  local act_pos = pos
  local act_node = node
  local act_def
  local next_pos
  for _=0,find_limit do
    act_def = minetest.registered_nodes[act_node.name]
    if not act_def or not act_def._steel_rope then
      return nil, nil
    end
    next_pos = appliances.get_sides_pos(act_pos, act_node, act_def._steel_rope.forward)
    if vector.equals(prev_pos, next_pos) then
      next_pos = appliances.get_sides_pos(act_pos, act_node, act_def._steel_rope.backward)
    end
    --print(dump(next_pos))
    -- switch
    prev_pos = act_pos
    act_pos = next_pos
    act_node = minetest.get_node(act_pos)
    
    -- steel rope check
    if minetest.get_item_group(act_node.name, "lift_steel_rope")<=0 then
      return nil, nil
    end
    act_def = minetest.registered_nodes[act_node.name]
    rope_Isum = rope_Isum + act_def._I
    rope_friction = rope_friction + act_def._friction
    if minetest.get_item_group(act_node.name, "lift_powered_wheel")>0 then
      return rope_Isum, rope_friction
    end
    
    -- cycle check
    if vector.equals(act_pos, pos) then
      return nil, nil
    end
    
  end
  return nil, nil
end

