require 'eventmachine'
require 'em-websocket'
require 'serialport'

SERIALPORT_DEVICE = ENV["SERIALPORT_DEVICE"] || "/dev/ttyACM0"
SERIALPORT_BAUDRATE = ENV["SERIALPORT_BAUDRATE"]&.to_i || 9600

HOST = ENV["HOST"] || "0.0.0.0"
PORT = ENV["PORT"]&.to_i || 8000

EM.run do
  connections = []

  EM.attach SerialPort.new(SERIALPORT_DEVICE, SERIALPORT_BAUDRATE, 8, 1, 0) do |sp|
    sp.define_singleton_method :receive_data do |data|
      connections.each do |conn|
        conn.send data
      end
    end
  end

  EM::WebSocket.start host: HOST, port: PORT do |ws|
    ws.onopen do
      connections << ws
    end
  end

end
