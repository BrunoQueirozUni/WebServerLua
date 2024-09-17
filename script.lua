local socket = require("socket")

local server = assert(socket.bind("*", 8080))
local ip, port = server:getsockname()

print("Please connect to localhost on port " .. port)

while true do
    local client = server:accept()
    client:settimeout(10)

    local request, err = client:receive()
    if not err then
        print("Received request: " .. request)

        local response = "HTTP/1.1 200 OK\r\n" .. "Content-Type: text/html\r\n" .. "Connection: close\r\n\r\n" ..
                             "<html><body><h1>Hello, World!</h1></body></html>"

        client:send(response)
    end

    client:close()
end
