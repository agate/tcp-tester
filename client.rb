require "socket"
require "benchmark"

HOST="marathon-services.la.prod.factual.com"
PORT=10089

class Client
  def initialize(idx, host=HOST, port=PORT)
    @idx = idx
    @host = host
    @port = port
  end

	def server
    @server ||= TCPSocket.open(@host, @port)
  end

  def send
    server.puts @idx
  end

  def get
    server.gets
  end

  def close
    server.close
  end
end

idx = 0

loop do
  # c = Client.new(idx, 'localhost', 3000)
  c = Client.new(idx)
  puts "=========== #{idx} ==========="
  time = Benchmark.measure do
    c.send
  end
  puts "req: #{time.inspect}"
  time = Benchmark.measure do
    puts c.get
  end
  puts "res: #{time.inspect}"
  c.close
  idx+=1
  sleep 1
end
