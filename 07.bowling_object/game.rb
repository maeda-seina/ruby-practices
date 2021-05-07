# frozen_string_literal: true

class Game
  FRAME_NUMBER = 10

  def initialize(game_score)
    create_frame(game_score)
  end

  def calculate_game_score
    point = calculate_bonus_score
    FRAME_NUMBER.times do |frame_number|
      point += @frames[frame_number].calculate_frame_score
    end
    point
  end

  def calculate_bonus_score
    point = 0
    @frames.each_with_index do |_frame, i|
      if i < 8 && @frames[i].strike? && @frames[i + 1].strike?
        point += @frames[i + 1].first_shot.score + @frames[i + 2].first_shot.score
      elsif i < 9 && @frames[i].strike?
        point += @frames[i + 1].first_shot.score + @frames[i + 1].second_shot.score
      elsif i < 9 && @frames[i].spare?
        point += @frames[i + 1].first_shot.score
      end
    end
    point
  end

  private

  def create_frame(game_score)
    @frames = []
    frame = []
    split_game_score = game_score.split(',')
    split_game_score.each do |score|
      frame << score
      next unless @frames.count < 9 && (frame.count >= 2 || score == 'X')

      @frames << Frame.new(frame[0], frame[1])
      frame.clear
    end
    @frames << Frame.new(frame[0], frame[1], frame[2])
  end
end
