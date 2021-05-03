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
end

class Game
  attr_reader :game_score

  def initialize(game_score)
    @game_score = game_score
    create_frame(game_score)
  end

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

  def calculate_game_score
    point = calculate_bonus_score
    10.times do |frame_number|
      point += @frames[frame_number].calculate_frame_score
    end
    point
  end

  def calculate_bonus_score
    point = 0
    @frames.each_with_index do |_frame, i|
      # 9フレームがストライクの時、10フレームはfirst_shot,second_shotがいるので、別で処理
      if i == 8 && @frames[8].first_shot.score == 10
        point += @frames[9].first_shot.score + @frames[9].second_shot.score
      elsif i < 8 && @frames[i].first_shot.score == 10 && @frames[i + 1].first_shot.score == 10
        point += @frames[i + 1].first_shot.score + @frames[i + 2].first_shot.score
      elsif i < 9 && @frames[i].first_shot.score == 10
        point += @frames[i + 1].first_shot.score + @frames[i + 1].second_shot.score
      elsif i < 9 && @frames[i].first_shot.score + @frames[i].second_shot.score == 10
        point += @frames[i + 1].first_shot.score
      end
    end
    point
  end
end
score = ARGV[0].split(',')
puts Game.new(score).calculate_game_score
