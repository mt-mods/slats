
slats

![](https://github.com/mt-mods/slats/workflows/luacheck/badge.svg)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%203.0-green.svg)](license.txt)
[![Download](https://img.shields.io/badge/Download-ContentDB-blue.svg)](https://content.minetest.net/packages/mt-mods/slats)


# Overview

Adds decorative slats that have a lot of uses

![](./screenshot.png)

# Api

Modding api

## slats.register_slat(subname, recipeitem, groups, image, description, sounds)

Example: stone block registration from the `default` mod:
```lua
slats.register_slat(
	"stone_block",
	"default:stone_block", -- optional, can be nil
	{cracky = 2}, -- optional, can be nil
	"default_stone_block.png^slats_slat_overlay.png^[makealpha:255,126,126",
	"Stone Block Slat", -- optional
	default.node_sound_stone_defaults() -- optional
)
```

# License

* Code: `MIT`
* Textures: `CC BY-SA 3.0`
