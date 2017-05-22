class Player
  attr_accessor :name, :dices, :roll_times, :move, :turn, :play, :points

  def initialize()
    @name = nil
    @dices = []
    @roll_times = 0
    @move = ''
    @turn = 0
    @play = nil
    @points = [
      {
        1 => ['aces', ''],
        2 => ['twos', ''],
        3 => ['threes', ''],
        4 => ['fours', ''],
        5 => ['fives', ''],
        6 => ['sixes', ''],
      },
      {
        'ls' => ['long stright', ''],
        'ss' => ['small stright', ''],
        '3'  => ['3 of a kind', ''],
        '4'  => ['4 of a kind', ''],
        '5'  => ['yahtzee', ''],
        '22' => ['double pair', ''],
        '23' => ['full house', ''],
        'chance' => ['chance', ''],
      }
    ]
  end

  def show_points
    upper_points = @points[0].values.map { |e| "#{ "#{ e[0] } ".ljust(20, '.') } #{ e[1] }" }
    lower_points = @points[1].values.map { |e| "#{ "#{ e[0] } ".ljust(20, '.') } #{ e[1] }" }
    return(
"""
   UPPER SECTION =========
   #{ upper_points.join("\n   ") }
   =======================
   UPPER TOT: #{ @points[0].values[1].inject(0) { |res, n|  res + n.to_i } }

   LOWER SECTION =========
   #{ lower_points.join("\n   ") }
   =======================
   LOWER TOT: #{ @points[1].values[1].inject(0) { |res, n|  res + n.to_i } }
""")
  end
end
