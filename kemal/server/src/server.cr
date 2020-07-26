# TODO: Write documentation for `Server`
module Server
  VERSION = "0.1.0"
end

require "kemal"

# Matches GET "http://host:port/"
get "/" do |env|
  env.response.content_type = "application/json"
  {"Message": "Hello World!"}.to_json
end

# Creates a WebSocket handler.
# Matches "ws://host:port/socket"
# ws "/socket" do |socket|
#   socket.send "Hello from Kemal!"
# end

Kemal.run
