module Guesser
  class Player
    attr_accessor :player_name

    def initialize(name = 'John Doe')
      @player_name = name
    end
  end
end
