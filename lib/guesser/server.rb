module Guesser
  class Server
    require 'socket' # Get sockets from stdlib

    IP_ADDRESS = '127.0.0.1' # default Server IP Address
    PORT = '2000' # default Server Port

    def initialize(output = STDOUT)
      @server = TCPServer.open(IP_ADDRESS, PORT)
      @output = output
      @output.puts "# Guesser::Server is listening on: #{IP_ADDRESS}:#{PORT}"
      @magic = rand 1..10         # Magic number (number to guess)
      @players = []
    end

    def start
      @output.puts "# Number to guess: #{@magic}"

      loop do   # Servers run forever
        @output.puts "# Players: #{@players.map(&:player_name).join(', ')}" if @players.length > 0

        Thread.start(@server.accept) do |client|
          @output.puts "## Client connected !"
          player = Guesser::Player.new
          while line = client.gets   # Read lines from the client
            if line.chop == "<b>"
              break
            elsif line.chop.scan(/[\d]+/) != []
              guess = line.chop.scan(/[\d]+/)[0]
              @output.puts "## #{player.player_name} guesses #{guess}"
            else
              player.player_name = line.chop
              @players << player
              @output.puts "## Client Name: #{player.player_name}"
            end
          end
          if guess.to_i == @magic
            client.puts "## Congratulations! You've guessed right!"
            @output.puts "## #{player.player_name} guesses right!"
          else
            client.puts "## Wrong number! Please try again!"
            @output.puts "## #{player.player_name} guesses wrong!"
          end
          client.close  # Disconnect from the client
        end
      end
    end
  end
end
