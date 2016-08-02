require 'eventmachine'
require 'em-websocket'
require 'serialport'

EM.run do
  connections = []

  EM.attach SerialPort.new(ENV["SERIAL_PORT_DEVICE"], 38400, 8, 1, 0) do |sp|
    sp.define_singleton_method :receive_data do |data|
      connections.each do |conn|
        conn.send data
      end
    end
  end

  EM::WebSocket.start host: "0.0.0.0",port: 8000 do |ws|
    ws.onopen do
      connections << ws
    end
  end

end
