ignore = {
  -- only spaces on lines
  "611",
  -- two long line
  "631",
  -- ignore unused self variable in methods
  "212/self"
}

read_globals = {
  -- minetest
  "AreaStore",
  "dump",
  "minetest",
  "vector",
  "VoxelManip",
  "VoxelArea",
  "ItemStack",
  -- special minetest functions
  "table.copy",
  -- mods
  "default",
  "player_api",
  "hades_sounds",
  "hades_player",
  "sounds",
  "screwdriver",
  "appliances",
}

globals = {
  "chair_lift",
  "player_api.player_attached",
  "hades_player.player_attached",
}

exclude_files = {
  "data/",
}
