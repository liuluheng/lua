--first version
local defaults = {}
setmetatable(defaults, {__mode = "k"})

local mt = {__index = function (t) return defaults[t] end}
function setDefault (t, d)
    defaults[t] = d
    setmetatable(t, mt)
end

t = {}
d = 2
setDefault(t, d)

print(t[3], key, t[key], t.key) --2 nil 2 2
t = {}
collectgarbage()
print(t[3], key, t[key], t.key) --nil nil nil nil 


--second version
local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault (t, d)
    local mt = metas[d]
    if mt == nil then
        mt = {__index = function () return d end}
        metas[d] = mt -- memorize
    end
    setmetatable(t, mt)
end
        
t = {}
d = 2
setDefault(t, d)

print(t[3], key, t[key], t.key) --2 nil 2 2
t = {}
collectgarbage()
--why collected ??
print(t[3], key, t[key], t.key) --nil nil nil nil 


