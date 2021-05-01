# frozen_string_literal: true

class Game
  attr_reader :game_score
  
  def initialize(game_score)
    @game_score = game_score
  end

  # 最終はここでボーナス分と合わせた計算ができるようにする
  def calc_game_score
    @game_score.sum
  end

  # ここで、Frame.newを使い、frameを完成させる。
  def to_frame
  end

  # ここでstrikeとspareの得点調整をする
  def bonus_score
  end

end

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def calc_frame_score
    @first_shot.mark.to_i + @second_shot.mark.to_i + @third_shot.mark.to_i
  end
end

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

# frame = Frame.new(1, 2)
# puts frame.calc_frame_score
score = "2,3"
p s = score.split(",")
game = Game.new(s)
p game.game_score
# @game_score => ["2", "3"]



# game = Game.new(score).split(",")
# p game.game_score
# puts game.calc_game_score


# ゴール
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
# Game.new(score).calc_game_score
#=> 139
