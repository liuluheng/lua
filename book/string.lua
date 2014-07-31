s = "hello world from Lua"
for w in string.gmatch(s, "%a+") do
    print(w)
end
