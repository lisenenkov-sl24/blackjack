require_relative 'control/player'
require_relative 'control/play'

class Interop
  attr_accessor :player

  def self.init_game
    puts 'Ваше имя'
    name = gets.chomp

    interop = Interop.new
    interop.player = Player.new(name, 100, 100)

    interop.show_state

    interop
  end

  def play_game
    play = Play.new(player)

    loop do
      puts play.cards(false)
      player_answer = ask_player play
      puts player_answer
      next if play.turn(player_answer) { |message| puts message }

      puts play.cards(true)
      puts play.open_cards
      break
    end

    show_state
  end

  def ask_player(play)
    puts '0 Пропустить'
    puts '1 Добавить карту' if play.player_can_add_card?
    puts '2 Открыть карты'
    loop do
      input = gets.chomp.to_i
      return :skip_turn if input == 0
      return :add_card if input == 1 && play.player_can_add_card?
      return :open_cards if input == 2
    end
  end

  def should_continue?
    puts 'Продожить (д/Н)'
    gets.chomp.upcase == 'Д'
  end

  def show_state
    puts player.state
  end
end
