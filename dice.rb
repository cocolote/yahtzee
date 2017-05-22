class Dice
  attr_reader :top_bottom, :current_side

  def initialize(starting_side)
    @top_bottom = " ----- " 
    @sides = {
      1 => { top: "|     |", middle: "|  x  |", bottom: "|     |" },
      2 => { top: "|x    |", middle: "|     |", bottom: "|    x|" },
      3 => { top: "|x    |", middle: "|  x  |", bottom: "|    x|" },
      4 => { top: "|x   x|", middle: "|     |", bottom: "|x   x|" },
      5 => { top: "|x   x|", middle: "|  x  |", bottom: "|x   x|" },
      6 => { top: "|x x x|", middle: "|     |", bottom: "|x x x|" }
    }
    @rand = Random.new
    @current_side = starting_side
  end

  def get_side(num)
    return @sides[num]
  end

  def roll
    @current_side = @rand.rand(6) + 1
    return self.get_side(@current_side)
  end
end
