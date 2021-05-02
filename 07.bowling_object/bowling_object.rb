# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == 'X'

    mark.to_i
  end
end

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def calculate_frame_score
    @first_shot.score + @second_shot.score + @third_shot.score
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    @first_shot.score + @second_shot.score == 10 && @first_shot.score != 10
  end
end
p Frame.new("2").first_shot.mark
p Frame.new("2").first_shot.score
p Frame.new('X').first_shot.score
p Frame.new('0', 'X').strike?

class Game
  attr_reader :game_score

  def initialize(game_score)
    @game_score = game_score
  end

  # 最終はここでボーナス分と合わせた計算ができるようにする
  def calculate_game_score
    point = 0
    10.times do |frame_number|
      point += @frames[frame_number].calculate_frame_score
      point += calculate_bonus_score(frame_number)
    end
    point
  end

  # ここで、Frame.newを使い、frameを完成させる。
  def create_frame
    frames = []
    frame = []
    game_score.each do |score|
      frame << score
      next unless frames.count < 9 && (frame.count >= 2 || score == 'X')

      frames << Frame.new(frame[0], frame[1])
      frame.clear
    end
    frames << Frame.new(frame[0], frame[1], frame[2])
  end

  # ここでstrikeとspareの得点調整をする
  def calculate_bonus_score(_frame_number)
    point = 0
  end
end

score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
# score = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(",")
# score = '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'.split(",")
Game.new(score).create_frame

# ゴール
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
# Game.new(score).calculate_game_score
#=> 139
