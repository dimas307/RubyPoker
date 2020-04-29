# This class will contain all required information about card: value, face, suit
class Card
  attr_reader :value, :face, :suit

  def initialize(value, face, suit)
    @value = value
    @face = face
    @suit = suit
  end

  def <=>(other)
    @value <=> other.value
  end

  def to_s
    "#{face.capitalize} of #{suit.capitalize}"
  end
end