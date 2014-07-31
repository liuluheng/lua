Set = {}
local mt = {} -- metatable for sets

-- create a new set with the values of a given list
function Set.new (l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do set[v] = true end
    return set
end
function Set.union (a, b)
    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
        error("attempt to 'add' a set with a non-set value", 2)
    end

    local res = Set.new{}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end
function Set.intersection (a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end
-- presents a set as a string
function Set.tostring (set)
    local l = {}
    -- list to put all elements from the set
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}"
end
-- print a set
function Set.print (s)
    print(Set.tostring(s))
end

mt.__le = function (a, b)
    -- set containment
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end
mt.__lt = function (a, b)
    return a <= b and not (b <= a)
end
mt.__eq = function (a, b)
    return a <= b and b <= a
end
mt.__mul = Set.intersection
mt.__add = Set.union
mt.__tostring = Set.tostring

s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
print(s1 <= s2)
print(s1 < s2)
print(s1 >= s1)
print(s1 > s1)
print(s1 == s2 * s1) 


s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
print(getmetatable(s1))
print(getmetatable(s2))

s = s1 + s2
print(s)

mt.__metatable = "not your business"
s1 = Set.new{}
print(getmetatable(s1))
setmetatable(s1, {})

--------
