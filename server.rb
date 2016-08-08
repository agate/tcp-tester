require "socket"

class Server
  def initialize(host, port)
    @server = TCPServer.open(host, port)
    run
  end

  def run
    loop {
      Thread.start(@server.accept) do | client |
        nick_name = client.gets.chomp.to_sym
				puts nick_name
        client.puts nick_name
				client.close
      end
    }.join
  end
end

host="localhost"
port=3000
puts "Running TCPServer on #{host}:#{port}"
Server.new(host, port)
