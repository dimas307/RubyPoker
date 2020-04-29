load 'card.rb'
load 'deck.rb'
load 'game.rb'

# Main module for game
# Shows hand, table and winning combo
module Poker
  class Error < StandardError; end

  deck = Deck.new
  hand = deck.hand
  table = deck.table

  puts 'HAND:'
  puts '-'
  puts hand
  puts '-'
  puts 'TABLE:'
  puts '-'
  puts table
  puts '-'

  new_game = Game.new(hand, table)

  puts 'WINNER!'
  puts '-'
  puts new_game.win_combo_name
  puts '-'
  puts new_game.win_cards
end
