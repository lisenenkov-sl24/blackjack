class Card
  RANKS = { "A": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7,
            "8": 8, "9": 9, "T": 10, "J": 10, "Q": 10, "K": 10 }.freeze
  SUITS = %i[♣ ♦ ♥ ♠].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank}#{@suit}"
  end

  def points
    @points ||= RANKS[@rank]
  end
end
