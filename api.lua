local mod_storage = canonical_name.mod_storage
local cache = {}

if not mod_storage:get(":initialized") then
	minetest.register_on_mods_loaded(function()
		local auth_handler = minetest.get_auth_handler()
		for name in auth_handler:iterate() do
			local lower = name:lower()
			mod_storage:set_string(lower, name)
			cache[lower] = name
		end

		mod_storage:set_string(":initialized", "true")
	end)
end

minetest.register_on_authplayer(function(name, ip, is_success)
	if is_success then
		local lower = name:lower()
		if not cache[lower] then
			cache[lower] = name

			if not mod_storage:get(lower) then
				mod_storage:set_string(lower, name)
			end
		end
	end
end)

function canonical_name.get(name)
	local lower = name:lower()
	local cached = cache[lower]
	if cached then
		return cached
	end
	cached = mod_storage:get(lower)
	if cached then
		cache[lower] = name
		return cached
	end
end
