chemistry = {}
chemistry.substances = {}
chemistry.reactions = {}
chemistry.nodes = {}

local modpath = minetest.get_modpath("chemistry")

dofile(modpath.."/api.lua")
dofile(modpath.."/flask.lua")
dofile(modpath.."/workbench.lua")
dofile(modpath.."/substances.lua")
