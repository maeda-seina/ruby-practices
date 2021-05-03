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

class Game
  attr_reader :game_score

  def initialize(game_score)
    @game_score = game_score
    create_frame(game_score)
  end

  # ここで、Frame.newを使い、frameを完成させる。
  def create_frame(game_score)
    @frames = []
    frame = []
    game_score.each do |score|
      frame << score
      next unless @frames.count < 9 && (frame.count >= 2 || score == 'X')

      @frames << Frame.new(frame[0], frame[1])
      frame.clear
    end
    @frames << Frame.new(frame[0], frame[1], frame[2])
  end

  # 最終はここでボーナス分と合わせた計算ができるようにする
  def calculate_game_score
    point = 0
    10.times do |frame_number|
      point += @frames[frame_number].calculate_frame_score
    end
    point
  end

  # ここでstrikeとspareの得点調整をする
  def calculate_bonus_score
    point = 0
    p @frames[9].first_shot.score + @frames[9].second_shot.score
    @frames.each_with_index do |frame, i|
      # 9フレームがストライクの時、10フレームはfirst_shot,second_shotがいるので、別で処理
      if i == 8 && @frames[8].first_shot.score == 10
        point += @frames[9].first_shot.score + @frames[9].second_shot.score
      elsif i < 8 && @frames[i].first_shot.score == 10 && @frames[i+1].first_shot.score == 10
        point += @frames[i+1].first_shot.score + @frames[i+2].first_shot.score
      elsif i < 9 && @frames[i].first_shot.score == 10
        point += @frames[i+1].first_shot.score + @frames[i+1].second_shot.score
      elsif i < 9 && @frames[i].first_shot.score + @frames[i].second_shot.score == 10
        point += @frames[i+1].first_shot.score
      end
    end
    p point
  end
end

# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
score = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(",")
# score = '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'.split(",")
Game.new(score).calculate_bonus_score

# ゴール
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
# Game.new(score).calculate_game_score
#=> 139
