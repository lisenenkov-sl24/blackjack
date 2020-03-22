require_relative 'deck'

class Hand
  attr_reader :cards

  def initialize(deck)
    @deck = deck
    @cards = [deck.draw, deck.draw]
  end

  def draw
    @cards.push(@deck.draw) if @cards.length < 3
  end

  def calculate_points
    points, aces = @cards.each_with_object [0, 0] do |card, memo|
      points = card.points
      memo[0] += points
      memo[1] += 1 if points == 1
    end

    while points <= 11 && aces > 0
      points += 10
      aces -= 1
    end

    points
  end

  def to_s
    @cards.join(', ')
  end
end
