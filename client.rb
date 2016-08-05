require "socket"
require "benchmark"

class Client
  def initialize(idx)
    @idx = idx
  end

	def server
    @server ||= TCPSocket.open( "localhost", 3000 )
  end

  def send
    server.puts @idx
  end

  def get
    server.gets.chomp.to_sym
  end

  def close
    server.close
  end
end

idx = 0

loop do
  c = Client.new(idx)
  puts idx
  time = Benchmark.measure do
    c.send
  end
  puts "req: #{time.inspect}"
  time = Benchmark.measure do
    c.get
  end
  puts "res: #{time.inspect}"
  c.close
  idx+=1
  sleep 1
end
