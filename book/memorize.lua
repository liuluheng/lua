local results = {}
setmetatable(results, {__mode = "kv"})
function mem_loadstring (s)
    local res = results[s]
    if res == nil then -- result not available?
        res = assert(load(s)) -- compute new result
        results[s] = res -- save for later reuse
    end
    return res
end

--[[
function createRGB (r, g, b)
    return {red = r, green = g, blue = b}
end
--]]

local results = {}
setmetatable(results, {__mode = "v"}) -- make values weak
function createRGB (r, g, b)
    local key = r .. "-" .. g .. "-" .. b
    local color = results[key]
    if color == nil then
        color = {red = r, green = g, blue = b}
        results[key] = color
    end
    return color
end

