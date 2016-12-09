chemistry = {}
chemistry.substances = {}
chemistry.reactions = {}
chemistry.nodes = {}

function chemistry.register_substance(name, def)
	chemistry.substances[name] = def
	
	if def.solid then
		minetest.register_craftitem(name .. "_solid", {
			description = def.solid.description,
			inventory_image = def.solid.texture,
		})
		
		if def.solid.nodes then
			for i, n in ipairs(def.solid.nodes) do
				chemistry.nodes[n] = name .. "_solid"
			end
		end
	end
	
	if def.liquid then
		minetest.register_craftitem(name .. "_liquid", {
			description = def.liquid.description,
			inventory_image = def.liquid.texture,
		})
		
		if def.liquid.nodes then
			for i, n in ipairs(def.liquid.nodes) do
				chemistry.nodes[n] = name .. "_liquid"
			end
		end
	end
	
	if def.gaseous then
		minetest.register_craftitem(name .. "_gaseous", {
			description = def.gaseous.description,
			inventory_image = def.gaseous.texture,
		})
		
		if def.gaseous.nodes then
			for i, n in ipairs(def.gaseous.nodes) do
				chemistry.nodes[n] = name .. "_gaseous"
			end
		end
	end
	
	if def.solid and def.liquid and def.melting < 200 then
		minetest.register_craft({
			type = "cooking",
			output = name .. "_liquid",
			recipe = name .. "_solid",
		})
	end
	
	if def.liquid and def.gaseous and def.boiling < 200 then
		minetest.register_craft({
			type = "cooking",
			output = name .. "_gaseous",
			recipe = name .. "_liquid",
		})
	end
end

function chemistry.register_reaction(name, def)
	chemistry.reactions[name] = def
end

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

chemistry.register_substance("chemistry:water", {
	solid = {
		description = "Ice",
		texture = "chemistry_flask_blue_3.png",
		
		nodes = {"default:ice"}
	},
	liquid = {
		description = "Water",
		texture = "chemistry_flask_blue_2.png",
		
		nodes = {
			"default:water_source",
			"default:water_flowing",
			"default:river_water_source", 
			"default:river_water_flowing",
			"default:snow"
		}
	},
	gaseous = {
		description = "Water",
		texture = "chemistry_flask.png",
	},
	
	melting = 0,
	boiling = 100
})
