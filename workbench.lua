local workbench_formspec = "size[8,8.85]"
local workbench_formspec = workbench_formspec .. default.gui_bg
local workbench_formspec = workbench_formspec .. default.gui_bg_img
local workbench_formspec = workbench_formspec .. default.gui_slots

local workbench_formspec = workbench_formspec .. "list[current_name;main;1,1;2,2;]"
local workbench_formspec = workbench_formspec .. "image[3.5,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]]"
local workbench_formspec = workbench_formspec .. "list[current_name;output;5,1;2,2;]"

local workbench_formspec = workbench_formspec .. "list[current_player;main;0,4.85;8,1;]"
local workbench_formspec = workbench_formspec .. "list[current_player;main;0,6.08;8,3;8]"
local workbench_formspec = workbench_formspec .. default.get_hotbar_bg(0,4.85)

local workbench_formspec = workbench_formspec .. "listring[current_name;main]"
local workbench_formspec = workbench_formspec .. "listring[current_name;output]"
local workbench_formspec = workbench_formspec .. "listring[current_player;main]"

minetest.register_node("chemistry:workbench", {
	description = "Chemistry Workbench",
	tiles = {"default_stone.png"},
	groups = {cracky = 2},
	sounds =  default.node_sound_stone_defaults(),
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, -6/16, 6/16, -6/16},
			{-8/16, -8/16, 6/16, -6/16, 6/16, 8/16},
			{6/16, -8/16, -8/16, 8/16, 6/16, -6/16},
			{6/16, -8/16, 6/16, 8/16, 6/16, 8/16},
			
			{-8/16, 6/16, -8/16, 8/16, 7/16, 8/16},
			
			{-8/16, 7/16, -8/16, 8/16, 8/16, -6/16},
			{-8/16, 7/16, -8/16, -6/16, 8/16, 8/16},
			
			{6/16, 7/16, -8/16, 8/16, 8/16, 8/16},
			{-8/16, 7/16, 6/16, 8/16, 8/16, 8/16}
		}
	},
		
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", workbench_formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 2*2)
		inv:set_size("output", 2*2)
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	
	on_punch = function(pos, node, player, pt)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		
		local found = false
		for _, def in ipairs(chemistry.reactions) do
			local count = 0
			for i, item in ipairs(inv:get_list("main")) do
				if item ~= "" then
					count = count + 1
				end
			end
			
			--if count ~= #def.input then
			--	found = false
			--	break
			--end
			
			for _, item in ipairs(def.input) do
				if inv:contains_item("main", item) then
					found = true
				else
					found = false
					break
				end
			end
			
			if found then
				for _, item in ipairs(def.input) do
					inv:remove_item("main", item)
				end
				
				for _, item in ipairs(def.output) do
					inv:add_item("output", item)
				end
				
				break
			end
		end
	end,
})
