require 'serialport'
require 'em-websocket'
require 'thread'

connection = []

sp = SerialPort.new('/dev/ttyACM0',9600,8,1,0)

@locker = Mutex::new 

t = Thread.new do
	loop do
		line  = sp.gets
		@locker.synchronize do
			connection.each{|con| con.send(line)}
		end
	end
end

EM::WebSocket.start({:host => "0.0.0.0",:port => 8000}) do |ws|
	puts "Websocket Server Start"
	ws.onopen do
		@locker.synchronize do
			connection << ws
		end	
	end
end

