-- create the prototype with default values
prototype = {x = 0, y = 0, width = 100, height = 100}
mt = {} -- create a metatable
-- declare the constructor function
function new (o)
    setmetatable(o, mt)
    return o
end

--[=[
mt.__index = function (_, key)
    return prototype[key]
end
--]=]

mt.__index = prototype

w = new{x=10, y=20}
print(w.width)

function setDefault (t, d)
    local mt = {__index = function () return d end}
    setmetatable(t, mt)
end

tab = {x=10, y=20}
print(tab.x, tab.z)
setDefault(tab, 0)
print(tab.x, tab.z)

--the metatable has the default value d wired
--into its metamethod, so the function cannot use a single metatable for 
--all tables.To allow the use of a single metatable for tables with 
--different default values,we can store the default value of each table 
--in the table itself, using an exclusive field. 
--If we are not worried about name clashes, we can use a key like “___
--for our exclusive field
--not worried about name clash
local mt = {__index = function (t) return t.___ end}
function setDefault (t, d)
    t.___ = d
    setmetatable(t, mt)
end

--worried about name clash
local key = {}
-- unique key
local mt = {__index = function (t) return t[key] end}
function setDefault (t, d)
    t[key] = d
    setmetatable(t, mt)
end

t = {} -- original table (created somewhere)
-- keep a private access to the original table
local _t = t
-- create proxy
t = {}
-- create metatable
local mt = {
    __index = function (t, k)
        print("*access to element " .. tostring(k))
        return _t[k]        -- access the original table
    end,
    __newindex = function (t, k, v)
        print("*update of element " .. tostring(k) ..
        " to " .. tostring(v))
        _t[k] = v           -- update original table
    end,
    __pairs = function ()
        return function (_, k)
            return next(_t, k)
        end
    end
}
setmetatable(t, mt)

t[2] = "hello"
print(t[2])


local index = {} -- create private index
local mt = {
    -- create metatable
    __index = function (t, k)
        print("*access to element " .. tostring(k))
        return t[index][k] -- access the original table
    end,
    __newindex = function (t, k, v)
        print("*update of element " .. tostring(k) ..
              " to " .. tostring(v))
        t[index][k] = v -- update original table
    end,
    __pairs = function (t)
        return function (t, k)
            return next(t[index], k)
        end, t
    end
}
t = {}
function track (t)
    local proxy = {}
    proxy[index] = t
    setmetatable(proxy, mt)
    return proxy
end

t = track(t)
t[2] = "hello"
t[3] = "world"
print(t[2])
for k, v in pairs(t) do
    print(k, v)
end
