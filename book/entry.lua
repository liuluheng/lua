local count = 0
function Entry () count = count + 1 end
dofile("data.lua")
print("number of entries: " .. count)


--[=[
print("--------")
local authors = {} -- a set to collect authors
function Entry (b) authors[b[1]] = true end
dofile("data.lua")
for name in pairs(authors) do 
    print(name) 
end
--]=]

print("--------")
local authors = {} -- a set to collect authors
function Entry (b) 
    if b.author then
        authors[b.author] = true 
    end
end
dofile("data.lua")
for name in pairs(authors) do print(name) end

