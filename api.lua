
local has_default_mod = minetest.get_modpath("default")

-- main crafting ingredient for the slat recipe
local base_recipe_ingredient
if has_default_mod then
	base_recipe_ingredient = "default:paper"
end

function slats.register_slat(subname, recipeitem, groups, image, description, sounds)
	groups.slab = 1

	-- nodebox limits
	local nb1 = 0.5
	local nb2 = 0.49

	minetest.register_node(":slats:slat_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = {image},
		inventory_image = image,
		wield_image = image,
		paramtype = "light",
		paramtype2 = "wallmounted",
		is_ground_content = false,
		sunlight_propagates = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "wallmounted",
				wall_top    = {-nb1, nb2, -nb1, nb1, nb2, nb1},
				wall_bottom = {-nb1, -nb2, -nb1, nb1, -nb2, nb1},
				wall_side   = {-nb2, -nb1, -nb1, -nb2, nb1, nb1},
		},
	})

	if recipeitem then
		if base_recipe_ingredient then
			minetest.register_craft({
				type = "shapeless",
				output = 'slats:slat_' .. subname .. ' 12',
				recipe = {recipeitem, base_recipe_ingredient},
			})
		end

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
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
