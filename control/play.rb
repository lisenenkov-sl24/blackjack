require_relative '..\model\hand'
require_relative '..\model\deck'

class Play
  def initialize(player)
    @deck = Deck.new
    @dealerset = Hand.new(@deck)
    @playerset = Hand.new(@deck)
    @player = player
    player.make_stake(10)
  end

  def turn(player_answer)
    case player_answer
    when :add_card
      @playerset.draw if @playerset.cards.size < 3
      return false if check_3_all
    when :open_cards
      return false
    end
    yield dealer_turn
    return false if check_3_all
    true
  end

  def cards(show_dealer)
    dealerset = show_dealer ? @dealerset : ('*' * @dealerset.cards.size)
    "Дилер: #{dealerset} #{@player.name}: #{@playerset}"
  end

  def open_cards
    playerpoints = @playerset.calculate_points
    if playerpoints > 21
      @player.procede :dealer
      return "У #{@player.name} перебор: #{playerpoints}"
    end

    dealerpoints = @dealerset.calculate_points
    if dealerpoints > 21
      @player.procede :player
      "У дилера перебор: #{dealerpoints}"
    elsif playerpoints == dealerpoints
      @player.procede nil
      'Ничья'
    elsif playerpoints > dealerpoints
      @player.procede :player
      "Выиграл #{@player.name}"
    else
      @player.procede :dealer
      'Выиграл дилер'
    end
  end

  def player_can_add_card?
    @playerset.cards.size < 3
  end

  private

  def dealer_turn
    if @dealerset.calculate_points >= 17
      'Дилер пропускает ход'
    else
      @dealerset.draw
      'Дилер берет карту'
    end
  end

  def check_3_all
    @dealerset.cards.size >= 3 && @playerset.cards.size >= 3
  end
end
