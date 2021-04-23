# frozen_string_literal: true

def shot(pin)
  pin.split(',').map { |p| p == 'X' ? 10 : p.to_i }
end

def frame
  scores = shot(pin)
  frame = []
  count = 0
  scores.each do |score|
    count += 1
    count = 1 if count > 2
    if score == 10 && count == 1 && frame.count < 17
      frame << 10
      frame << 0
      count += 1
    elsif score == 10 && count == 2 && frame.count < 17
      frame << 10
    elsif score == 10 && frame.count >= 17
      frame << 10
    else
      frame << score.to_i
    end
  end
  frame
end

def calc
  point = 0
  frames = frame.each_slice(2).to_a
  if frames[10]
    a = frames[9]
    b = frames[10]
    a.concat(b)
    frames.delete(b)
  end
  frames.each_with_index do |frame, i|
    if frames[i] == [10, 0] && frames[i+1] == [10, 0] && i < 9
      point += frames[i+1][0] + frames[i+2][0] + frame.sum
    elsif frame == [10, 0] && i < 9
      point += frames[i+1][0] + frames[i+1][1] + frame.sum
    elsif frame.sum == 10 && frame[0] != 10 && i < 9
      point += frames[i+1][0] + frame.sum
    else
      point += frame.sum
    end
  end
  point
end
