local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

canonical_name = {
	author = "flux",
	license = "AGPL_v3",
	version = {year = 2022, month = 9, day = 15},
	fork = "flux",

	modname = modname,
	modpath = modpath,
    mod_storage = minetest.get_mod_storage(),
	S = S,

	has = {
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

canonical_name.dofile("api")
