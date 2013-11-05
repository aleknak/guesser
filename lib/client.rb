module Guesser
  class Client
    require 'socket'      # Sockets are in standard library

    IP_ADDRESS = '127.0.0.1'    # default Server IP Address
    PORT = '2000'     # default Server Port

    def initialize(output)
      @client = TCPSocket.open(IP_ADDRESS, PORT)
      @output = output
      @output.puts "# Guesser::Client is connecting to: #{IP_ADDRESS}:#{PORT}"
    end

    def start
      @output.puts "# Hi Client!"
      @output.puts "# Please enter your name:"
      name = gets.chop
      @output.puts "# Please enter a number between 1-10"
      number = gets.chop

      @client.puts "#{name}"
      @client.puts "I'm guessing #{number}"
      @client.puts "<b>"    # break character

      while line = @client.gets   # Read lines from the socket
        @output.puts line.chop      # And print with platform line terminator
      end

      @client.close               # Close the socket when done
    end
  end
end
