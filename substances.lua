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
			"default:snowblock"
		}
	},
	gaseous = {
		description = "Water",
		texture = "chemistry_flask.png",
	},
	
	melting = 0,
	boiling = 100
})
