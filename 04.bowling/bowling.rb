#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.chars
shots = []
throw_count = 0
scores.each do |s|
  throw_count += 1
  throw_count = 1 if throw_count > 2
  if s == 'X' && throw_count == 1 && shots.count < 17
    shots << 10
    shots << 0
    throw_count += 1
  elsif s == 'X' && throw_count == 2 && shots.count < 17
    shots << 10
  elsif s == 'X' && shots.count >= 18
    shots << 10
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

if frames[10]
  a = frames[9]
  b = frames[10]
  a.concat(b)
  frames.delete(b)
end

point = 0
frames.each_with_index do |frame, i|
  point += if i < 9 && frames[i] == [10, 0] && frames[i + 1] == [10, 0]
             frame.sum + frames[i + 1][0] + frames[i + 2][0]
           elsif frame == [10, 0] && i < 9
             frame.sum + frames[i + 1][0] + frames[i + 1][1]
           elsif frame.sum == 10 && frame[0] != 10 && i < 9
             frame.sum + frames[i + 1][0]
           else
             frame.sum
           end
end
