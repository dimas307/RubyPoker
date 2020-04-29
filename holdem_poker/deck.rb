load 'card.rb'

# This class generates deck
# Along deck generates hand (player card) and table (table cards)
class Deck
  attr_reader :hand, :table

  FACES = %i[two three four five six seven eight nine ten jack queen king ace].freeze
  SUITS = %i[spades clubs hearts diamonds].freeze

  def initialize
    deck = FACES.flat_map.with_index { |f, v| SUITS.map { |s| Card.new(v + 2, f, s) } }
    @hand = deck.sample(2)
    deck -= @hand
    @table = deck.sample(5)
  end
end
