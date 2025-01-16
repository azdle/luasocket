local socket = require "socket"

local server = assert(socket.tcp())
assert(server:bind("localhost", 0))
assert(server:listen())
local addr, port = assert(server:getsockname())
print("Server Listening:", addr, port)

local client = assert(socket.tcp())
assert(client:settimeout(0))
local res, err = client:connect(addr,port)
assert(res == nil, "connect worked too fast")
assert(err == "timeout", "connect didn't timeout, instead: "..err)

assert(socket.select({}, {client}, 5))

assert(client:connect(addr, port))


