require 'websocket-client-simple'

ws = WebSocket::Client::Simple.connect 'ws://localhost:8000'

ws.on :message do |msg|
	puts msg.data
end

ws.on :open do
	ws.send "Test"
end

ws.on :close do |e|
	p e
end

loop do
end

