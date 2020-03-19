require_relative '..\model\cardset'
require_relative '..\model\carddeck'

class Play
  def initialize(playername)
    @deck = CardDeck.new
    @dealerset = CardSet.new(@deck)
    @playerset = CardSet.new(@deck)
    @playername = playername
  end

  def turn
    loop do
      show_cards
      case ask_player
      when :add_card
        @playerset.draw if @playerset.cards.size < 3
        return open_cards if check_3_all
      when :open_cards
        return open_cards
      end
      ask_dealer
      return open_cards if check_3_all
    end
  end

  private

  def show_cards
    puts "Дилер: #{'*' * @dealerset.cards.size} #{@playername}: #{@playerset}"
  end

  def open_cards
    puts "Дилер: #{@dealerset} #{@playername}: #{@playerset}"

    playerpoints = @playerset.calculate_points
    if playerpoints > 21
      puts "У #{@playername} перебор: #{playerpoints}"
      return :dealer
    end

    dealerpoints = @dealerset.calculate_points
    if dealerpoints > 21
      puts "У дилера перебор: #{dealerpoints}"
      :player
    elsif playerpoints == dealerpoints
      puts 'Ничья'
      nil
    elsif playerpoints > dealerpoints
      puts "Выиграл #{@playername}"
      :player
    else
      puts 'Выиграл дилер'
      :dealer
    end
  end

  def ask_player
    puts '0 Пропустить'
    puts '1 Добавить карту' if @playerset.cards.size < 3
    puts '2 Открыть карты'
    loop do
      input = gets.chomp.to_i
      return :skip_turn if input == 0
      return :add_card if input == 1 && @playerset.cards.size < 3
      return :open_cards if input == 2
    end
  end

  def ask_dealer
    if @dealerset.calculate_points >= 17
      puts 'Дилер пропускает ход'
    else
      puts 'Дилер берет карту'
      @dealerset.draw
    end
  end

  def check_3_all
    @dealerset.cards.size >= 3 && @playerset.cards.size >= 3
  end
end
