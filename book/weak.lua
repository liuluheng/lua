a = {}
b = {__mode = "k"}
setmetatable(a, b) -- now 'a' has weak keys
key = {} -- creates first key
a[key] = 1
key = {} -- creates second key
a[key] = 2
collectgarbage() -- forces a garbage collection cycle
for k, v in pairs(a) do print(v) end --> 2

print("------------")
n = 2 a[n] = 3
n = 3 a[n] = 4
collectgarbage()
for k, v in pairs(a) do print(type(k), k, v) end

a1 = {}
c = {__mode = "v"}
setmetatable(a1, c)

print("------------")
t = {}
n = 2 a1[n] = t
t = {}
n = 3 a1[n] = t
collectgarbage()
for k, v in pairs(a1) do print(type(k), k, type(v), v) end


