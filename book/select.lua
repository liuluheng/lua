function receive (connection)
    connection:settimeout(0) -- do not block
    local s, status, partial = connection:receive(2^10)
    if status == "timeout" then
        coroutine.yield(connection)
    end
    return s or partial, status
end

function download (host, file)
    local c = assert(socket.connect(host, 80))
    local count = 0 -- counts number of bytes read
    c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s, status = receive(c)
        count = count + #s
        if status == "closed" then break end
    end
    c:close()
    print(file, count)
end

threads = {} -- list of all live threads
function get (host, file)
    -- create coroutine
    local co = coroutine.create(function ()
        download(host, file)
    end)
    -- insert it in the list
    table.insert(threads, co)
end

--[[
function dispatch ()
    local i = 1
    while true do
        if threads[i] == nil then -- no more threads?
            if threads[1] == nil then break end -- list is empty?
            i = 1
            -- restart the loop
        end
        local status, res = coroutine.resume(threads[i])
        if not res then -- thread finished its task?
            table.remove(threads, i)
        else
            i = i + 1 -- go to next thread
        end
    end
end
--]]

function dispatch ()
    local i = 1
    local timedout = {}
    while true do
        if threads[i] == nil then -- no more threads?
            if threads[1] == nil then break end
            i = 1 -- restart the loop
            timedout = {}
        end
        local status, res = coroutine.resume(threads[i])
        if not res then -- thread finished its task?
            table.remove(threads, i)
        else            -- time out
            i = i + 1
            timedout[#timedout + 1] = res
            if #timedout == #threads then -- all threads blocked?
                socket.select(timedout)
            end
        end
    end
end

host = "http://www.baidu.com"
get(host,"/index.php?tn=10018801_hao")
dispatch() -- main loop




