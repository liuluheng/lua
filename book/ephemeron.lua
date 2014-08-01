do
    local mem = {}
    setmetatable(mem, {__mode = "k"})
    function factory (o)
        local res = mem[o]
        if not res then
            res = function () return o end
            mem[o] = res
        end
        return res
    end
end

--???????????????

