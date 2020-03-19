require_relative 'control/bank'
require_relative 'control/play'

puts 'Ваше имя'
name = gets.chomp

bank = Bank.new(100, 100)
bank.show_state

loop do
  play = Play.new(name)
  bank.make_stake 10
  bank.procede play.turn
  bank.show_state

  puts 'Продожить (д/Н)'
  break if gets.chomp.upcase != 'Д'
end
