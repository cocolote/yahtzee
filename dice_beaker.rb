require_relative "./dice"

class DiceBeaker
  attr_reader :dices

  def initialize
    @dices = [
      Dice.new(1),
      Dice.new(2),
      Dice.new(3),
      Dice.new(4),
      Dice.new(5)
    ]
  end

  def roll_dices(dices)
    sides = []
    (0..4).to_a.each do |dice|
      if dices.include? dice
        sides.push @dices[dice].roll
      else
        sides.push @dices[dice].get_side(@dices[dice].current_side)
      end
    end
  
    return(
"""
    #{ @dices[0].top_bottom } #{ @dices[1].top_bottom } #{ @dices[2].top_bottom } #{ @dices[3].top_bottom } #{ @dices[4].top_bottom }
    #{ sides[0][:top] } #{ sides[1][:top] } #{ sides[2][:top] } #{ sides[3][:top] } #{ sides[4][:top] }
    #{ sides[0][:middle] } #{ sides[1][:middle] } #{ sides[2][:middle] } #{ sides[3][:middle] } #{ sides[4][:middle] }
    #{ sides[0][:bottom] } #{ sides[1][:bottom] } #{ sides[2][:bottom] } #{ sides[3][:bottom] } #{ sides[4][:bottom] }
    #{ @dices[0].top_bottom } #{ @dices[1].top_bottom } #{ @dices[2].top_bottom } #{ @dices[3].top_bottom } #{ @dices[4].top_bottom }
""")
  end

  def current_play
    @dices.map { |dice| dice.current_side }
  end
end
