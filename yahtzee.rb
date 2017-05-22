require_relative "./player"
require_relative "./dice_beaker"
require 'pry'

# game variables ==
count = 0
d_beaker = DiceBeaker.new
player_1 = Player.new
#==================


# game helpers ====
def game_banner()
"""
 $$      $$         $$          $$                                 
  $$    $$          $$          $$                                 
   $$  $$  $$$$$$   $$$$$$$   $$$$$$   $$$$$$$$   $$$$$$    $$$$$$ 
    $$$$        $$  $$    $$    $$          $$   $$    $$  $$    $$
     $$    $$$$$$$  $$    $$    $$       $$$$    $$$$$$$$  $$$$$$$$
     $$   $$    $$  $$    $$    $$  $$  $$       $$        $$      
     $$    $$$$$$$  $$    $$     $$$$  $$$$$$$$   $$$$$$$   $$$$$$$


   Date:   27 August 2016
   Author: Ezequiel Lopez
"""
end

def status_line(player)
  line = "   Player: #{player.name}         Turn: #{player.turn += 1}\n"
end

def options_str
"""
   Options:
     1. roll <1,2,5> <times (5..20)>
     2. stay
     3. exit

"""
end

def play_options(player)
  plays = (1..6).each_with_object({}) do |side, res|
    dic_count = player.play.count(side)
    if dic_count > 0
      res[side] = {
        'count' => dic_count,
        'score' => dic_count != 1 ? side * dic_count : nil
      }
    end
  end

  lower_play = plays.keys.sort

  case true
  when lower_play.size == 5
    # ls
    prob = lower_play.reduce(:+) 
    if prob == 15 || prob == 20
      plays['ls'] = { 'score' => 50 }
    end
  when lower_play.size == 4
    prob = lower_play.reduce(:+) 
    if prob == 10 || prob == 14 || prob == 18
      plays['ss'] = { 'score' => 40 }
    end
  when lower_play.size == 3
    prob = lower_play.map { |key| plays[key]['count'] if plays[key]['count'] > 1 }.join()
    plays['22'] = { 'score' => 35 } if prob == '22'
    if prob == '23'
      plays['23'] = { 'score' => 40 }
      plays['3']  = { 'score' => 20 }
    end
    plays['3']  = { 'score' => 20 } if prob == '3'
  when lower_play.size == 2 || lower_play.size == 1
    prob = lower_play.map { |key| plays[key]['count'] if plays[key]['count'] > 1 }.join()
    plays['4'] = { 'score' => 35 } if prob == '4'
    plays['5'] = { 'score' => 35 } if prob == '5'
  end
  plays
end
#==================

while true
  system 'clear'
  menu = ''
  puts game_banner
  puts "#{d_beaker.roll_dices player_1.dices}\n"
  if count >= 20 or count >= player_1.roll_times
    if player_1.name
      # player play
      menu << status_line(player_1)
      menu << player_1.show_points
      menu << options_str
      puts menu
      print '   Next move? '
      option = gets.chomp.downcase.strip
      player_1.move, in_dices, in_roll_times = option.split(' ')
      # player choise
      case player_1.move
        when 'roll'
          count = 0
          player_1.dices = in_dices.split(',').map { |d| d.to_i - 1 }
          player_1.roll_times = in_roll_times.to_i < 5 ? 5 : in_roll_times.to_i
        when 'exit'
          puts "\n   Bye Bye!\n"
          exit
        when 'stay' || player_1.turn > 3
          player_1.dices = []
          player_1.roll_times = 0
          player_1.turn = 0
          player_1.play = d_beaker.current_play
          score_plays = play_options(player_1)
          show_plays = player_1.points.each_with_object([]) do |sec, res|
            sec.keys.each do |key|
              if score_plays.keys.include? key
                res << "#{ key } =>  #{ sec[key][0] } #{ score_plays[key]['score'].to_i }"
              else
                res << "#{ key } =>  #{ sec[key][0] } #{ sec[key][1].to_i }"
              end
            end
          end
          puts show_plays.join("\n   ") 
          option = gets.chomp
        else
          puts "\n   Not a valid move"
          sleep 0.2
      end
    else
      puts '   Redy Player One?'
      print '   Hi! '
      player_1.name = gets.chomp[/[A-z0-9]{1,8}/]
    end
  end
  count += 1
  sleep 0.2
end
