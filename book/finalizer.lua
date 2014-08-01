o = {x = "hi"}
setmetatable(o, {__gc = function (o) print(o.x) end})
o = nil
collectgarbage() --> hi

o = {x = "hi"}
mt = {}
setmetatable(o, mt)
mt.__gc = function (o) print(o.x) end
o = nil
collectgarbage() --> (prints nothing)

o = {x = "hi"}
mt = {__gc = true}
setmetatable(o, mt)
mt.__gc = function (o) print(o.x) end
o = nil
collectgarbage() --> hi

mt = {__gc = function (o) print(o[1]) end}
list = nil
for i = 1, 3 do
    --setmetatable return the table
    list = setmetatable({i, link = list}, mt) 
end
print("---")
--list = nil
collectgarbage()

