
local has_default_mod = minetest.get_modpath("default")

-- main crafting ingredient for the slat recipe
local base_recipe_ingredient
if has_default_mod then
	base_recipe_ingredient = "default:paper"
end

-- legacy register function with parameters
function slats.register_slat(subname, recipeitem, groups, image, description, sounds)
	-- call new api with table
	slats.register(subname, {
		recipeitem = recipeitem,
		groups = groups,
		image = image, -- NOTE: full texture-string with modifiers
		description = description,
		sounds = sounds
	})
end

-- new register function, with a table as second option
function slats.register(subname, opts)
	-- provide defaults
	assert(type(opts) == "table", "invalid options")
	assert(type(opts.image) == "string" or type(opts.base_texture) == "string", "no image or base_texture defined")
	opts.groups = opts.groups or {}
	if opts.base_texture then
		-- create texture with base-texture
		opts.image = opts.base_texture .. "^slats_slat_overlay.png^[makealpha:255,126,126"
	end

	local nodename = "slats:slat_" .. subname
	-- check for duplication
	assert(not minetest.registered_nodes[nodename], "slat already registered: " .. subname)

	opts.groups.slab = 1

	-- nodebox limits
	local nb1 = 0.5
	local nb2 = 0.49

	minetest.register_node(":" .. nodename, {
		description = opts.description,
		drawtype = "nodebox",
		tiles = {opts.image},
		inventory_image = opts.image,
		wield_image = opts.image,
		paramtype = "light",
		paramtype2 = "wallmounted",
		is_ground_content = false,
		sunlight_propagates = true,
		groups = opts.groups,
		sounds = opts.sounds,
		node_box = {
			type = "wallmounted",
			wall_top    = {-nb1, nb2, -nb1, nb1, nb2, nb1},
			wall_bottom = {-nb1, -nb2, -nb1, nb1, -nb2, nb1},
			wall_side   = {-nb2, -nb1, -nb1, -nb2, nb1, nb1},
		},
	})

	if opts.recipeitem then
		if base_recipe_ingredient then
			minetest.register_craft({
				type = "shapeless",
				output = 'slats:slat_' .. subname .. ' 12',
				recipe = {opts.recipeitem, base_recipe_ingredient},
			})
		end

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {opts.recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = 'slats:slat_' .. subname,
				burntime = math.floor(baseburntime * 0.5),
			})
		end
	end
end
