slats = {}

local MP = core.get_modpath("slats")
dofile(MP .. "/api.lua")

if core.get_modpath("default") then
	-- register default slats
	dofile(MP .. "/default.lua")
end