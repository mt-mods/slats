slats = {}

local MP = minetest.get_modpath("slats")
dofile(MP .. "/api.lua")

if minetest.get_modpath("default") then
	-- register default slats
	dofile(MP .. "/default.lua")
end