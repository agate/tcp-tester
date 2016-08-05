require "socket"

class Server
  def initialize( port, ip )
    @server = TCPServer.open( ip, port )
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

Server.new( 3000, "localhost" )
