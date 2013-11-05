module Guesser
  class Game

    def initialize(output)
      @output = output
    end

    def start
      @output.puts 'Welcome to Guesser !'

      server = Guesser::Server.new(@output)
      server.start
    end
  end
end
