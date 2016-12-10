minetest.register_craftitem("chemistry:flask", {
	description = "Flask",
	inventory_image = "chemistry_flask.png",
	liquids_pointable = true,
	
	on_use = function(itemstack, user, pt)
		if pt.type == "node" then
			local item = chemistry.nodes[minetest.get_node(pt.under).name]
			
			if item and user:get_inventory():room_for_item("main", item) then
				user:get_inventory():add_item("main", item)
				itemstack:take_item()
			end
		end
		
		return itemstack
	end,
})
