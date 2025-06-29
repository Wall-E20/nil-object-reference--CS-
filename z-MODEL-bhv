-- MODEL-bhv --
--[[
    Auto converts `E_MODEL`s to `MODEL`s and `id_bhv`s to `bhv`s
]]

for i, k in pairs(_ENV) do
    if i:find("E_MODEL") then
        _ENV[(i:gsub("E_", "", 1))] = k
    end
    if i:find("id_bhv") then
        _ENV[(i:gsub("id_", "", 1))] = get_behavior_from_id(k)
    end
end

for i, k in pairs(_G) do
    if i:find("E_MODEL") then
        _ENV[(i:gsub("E_", "", 1))] = k
    end
    if i:find("id_bhv") then
        _ENV[(i:gsub("id_", "", 1))] = get_behavior_from_id(k)
    end
end
