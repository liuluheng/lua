local mylib = require "mylib"

dir = mylib.dir("./")

for i,v in pairs(dir) do
    print(i,v)
end

for _, name in pairs(dir) do
    print(name)
end
