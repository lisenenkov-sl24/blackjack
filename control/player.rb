class Player
  attr_reader :name

  def initialize(name, player_money, dealer_money)
    @name = name
    @player_money = player_money
    @dealer_money = dealer_money
    @stake = 0
  end

  def make_stake(sum)
    raise 'У дилера кончились деньги' if @dealer_money < sum
    raise 'У игрока кончились деньги' if @player_money < sum

    @stake = sum
  end

  def procede(winner)
    case winner
    when :player
      @player_money += @stake
      @dealer_money -= @stake
    when :dealer
      @player_money -= @stake
      @dealer_money += @stake
    end
    @stake = 0
  end

  def state
    "Сумма игрока #{@player_money}"
  end
end
