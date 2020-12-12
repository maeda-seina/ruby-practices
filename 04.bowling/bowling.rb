#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.chars
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

if frames[10]
  a = frames[9]
  b = frames[10]
  a.concat(b)
  frames.delete(b)
end
p frames

point = 0
frames.each_with_index do |frame, i|
  if i < 9 && frames[i] == [10, 0] && frames[i+1] == [10,0]
    point += frame.sum + frames[i+1][0] + frames[i+2][0]
  elsif frame == [10,0] && i < 9
    point += frame.sum + frames[i+1][0] + frames[i+1][1]
  elsif frame.sum == 10 && frame[0] != 10 && i < 9
    point += frame.sum + frames[i+1][0]
  else
    point += frame.sum
  end
  p point
end


