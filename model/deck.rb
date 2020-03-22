require_relative 'card'

class Deck
  def initialize
    @deck = Card::RANKS.flat_map do |rank, _|
      Card::SUITS.map { |suit| Card.new(rank, suit) }
    end
    @random = Random.new
  end

  def draw
    raise 'Empty deck' if @deck.empty?

    card_index = @random.rand(@deck.length)
    @deck.delete_at(card_index)
  end
end
