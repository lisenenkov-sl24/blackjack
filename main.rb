require_relative 'interop'

interop = Interop.init_game
loop do
  interop.play_game
  break unless interop.should_continue?
end
