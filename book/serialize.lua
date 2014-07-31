function serialize (o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
            --io.write(" ", k, " = ")
            io.write("["); serialize(k); io.write("] = ")
            serialize(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end

modbus_devs = { 
    {
        dev_id = 0,
        ip = "127.0.0.1",
        port = 1502,
        sim_r_addr = 0,
        dig_r_addr = 0,
        sim_rw_addr = 0,
        dig_rw_addr = 0
    },
    {
        dev_id = 1,
        ip = "192.168.1.102",
        port = 1503,
        sim_r_addr = 0,
        dig_r_addr = 0,
        sim_rw_addr = 0,
        dig_rw_addr = 0
    }
}

print("-------")
serialize(modbus_devs)
print("-------")

serialize{key = "value", 123, "hello",
          key2 = "val2"}
serialize("hello")
serialize{a=12, b='Lua', key='another "one"'}


function basicSerialize (o)
    if type(o) == "number" then
        return tostring(o)
    else        -- assume it is a string
        return string.format("%q", o)
    end
end
function save (name, value, saved)
    saved = saved or {}    -- initial value
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then
        io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then            -- value already saved?
            io.write(saved[value], "\n")  -- use its previous name
        else
            saved[value] = name            -- save name for next time
            io.write("{}\n")
            -- create a new table
            for k,v in pairs(value) do
                -- save its fields
                k = basicSerialize(k)
                local fname = string.format("%s[%s]", name, k)
                save(fname, v, saved)
            end
        end
    else
        error("cannot save a " .. type(value))
    end
end


a = {x=1, y=2; {3,4,5}}
a[2] = a   -- cycle
a.z = a[1] -- shared subtable

save("a", a)

print("-------")
a = {{"one", "two"}, 3}
b = {k = a[1]}
save("a", a)
save("b", b)

print("-------")
local t = {}
save("a", a, t)
save("b", b, t)
