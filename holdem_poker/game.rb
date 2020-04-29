load 'card.rb'

# This class contains logic for poker game
# Object recieves 'hand' and 'table' cards
# Than it calculates winning combo and it's name
class Game
  attr_reader :hand, :table, :win_combo_name, :win_cards

  COMBOS = { high_card: 1,
             one_pair: 2,
             two_pairs: 3,
             three_of_a_kind: 4,
             straight: 5,
             flush: 6,
             full_house: 7,
             four_of_a_kind: 8,
             straight_flush: 9 }.freeze

  COMBOS_NAMES = { 1 => 'High Card',
                   2 => 'One Pair',
                   3 => 'Two Pairs',
                   4 => 'Three of a Kind',
                   5 => 'Straight',
                   6 => 'Flush',
                   7 => 'Full House',
                   8 => 'Four of a Kind',
                   9 => 'Straight Flush' }.freeze

  PATTERNS = { [1, 1, 1, 1, 1] => :high_card,
               [1, 1, 1, 2] => :one_pair,
               [1, 2, 2] => :two_pairs,
               [1, 1, 3] => :three_of_a_kind,
               [2, 3] => :full_house,
               [1, 4] => :four_of_a_kind }.freeze

  def initialize(hand, table)
    @hand = hand
    @table = table
    winner = combo_comparator(best_combo(combo_eval(hand_table_mix)))
    @win_combo_name = winner[0]
    @win_cards = winner[1]
  end

  private

  def hand_table_mix
    (@hand + @table).sort_by(&:value).combination(5)
  end

  # This method compares already chosen highest combos and picks best one
  def combo_comparator(cards)
    return [COMBOS_NAMES[cards[0]], cards[1]] if cards[1].size == 1

    best_combo = []

    # Since cards have value we just sum values of each combo and compare with each other
    cards[1].each_cons(2) do |c1, c2|
      c1.map(&:value).sum > c2.map(&:value).sum ? best_combo = c1 : best_combo = c2
    end

    [COMBOS_NAMES[cards[0]], best_combo]
  end

  # This method choose combos that rated highest using array of numbers
  def best_combo(cards)
    best_cards = [0, []]

    cards[0].each_with_index do |value, index|
      if value == cards[0].max
        best_cards[0] = value
        best_cards[1].push(cards[1][index])
      end
    end

    best_cards
  end

  # This method evaluates combos
  def combo_eval(cards)
    # First element of this array contains numerical values of each combo
    # Second element contains cards of each combo
    valid_combos = [[], []]

    cards.each do |i|
      # Sort cards for convenience
      temp_hand = i.sort_by(&:value)

      # Here we push numerical values into first element of array
      valid_combos[0].push(COMBOS[combo_name(temp_hand)])
      # Here we push set of cards into second element
      valid_combos[1].push(temp_hand)
    end

    valid_combos
  end

  # This method returns symbolic name of combo
  def combo_name(cards)
    return :straight_flush if check_consecutive(cards) && check_one_suit(cards)

    return :flush if check_one_suit(cards)

    return :straight if check_consecutive(cards)

    pattern_combo_eval(cards)
  end

  # Method check if all cards is consecutive in its values
  def check_consecutive(cards)
    cards.each_cons(2).all? { |c1, c2| c2.value - c1.value == 1 }
  end

  # This method checks if cards have same suit
  # If array contains same elements it will return array of size one
  def check_one_suit(cards)
    cards.map(&:suit).uniq.size == 1
  end

  # This method evaluate only COMBOS that can be represented by pattern
  def pattern_combo_eval(cards)
    # Sorting by value of card for convenience
    cards.sort_by(&:value)
    # Group cards value
    grouped = cards.group_by(&:value).values
    # Here we create new array by using map and size of 'grouped' as reference
    pattern = grouped.map(&:size).sort
    # Depending on content of 'pattern' function return one of the sumbols
    PATTERNS[pattern]
  end
end
