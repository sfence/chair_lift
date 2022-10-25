
chair_lift.adaptation = {}
local adaptation = chair_lift.adaptation

-- items
adaptation.empty_spool = adaptation_lib.get_item({"spool_empty"})
adaptation.steel_gear = adaptation_lib.get_item({"gear_steel"})
adaptation.steel_wire = adaptation_lib.get_item({"wire_stainless_steel","wire_steel"})
adaptation.steel_block = adaptation_lib.get_item({"block_carbon_steel","block_steel", "block_iron"})
adaptation.wheel_ingot = adaptation_lib.get_item({"ingot_stainless_steel_ingot","ingot_steel", "ingot_iron"})
adaptation.seat_block = adaptation_lib.get_item({"block_carbon_steel","block_steel", "block_iron"})
adaptation.seat_ingot = adaptation_lib.get_item({"ingot_carbon_steel","ingot_steel", "block_iron"})
adaptation.seat_glass = adaptation_lib.get_item({"glass"})

-- mods
adaptation.player_mod = adaptation_lib.get_mod("player")
adaptation.screwdriver_mod = adaptation_lib.get_mod("screwdriver") or {}

