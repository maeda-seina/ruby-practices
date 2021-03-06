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

frames = shots.to_a.each_slice(2).to_a

if frames[10]
  a = frames[9]
  b = frames[10]
  a.concat(b)
  frames.delete(b)
end

frames.each_with_index.sum do |frame, i|
  if i < 9 && frames[i] == [10, 0] && frames[i + 1] == [10, 0]
    frame.sum + frames[i + 1][0] + frames[i + 2][0]
  elsif frame == [10, 0] && i < 9
    frame.sum + frames[i + 1][0] + frames[i + 1][1]
  elsif frame.sum == 10 && frame[0] != 10 && i < 9
    frame.sum + frames[i + 1][0]
  else
    frame.sum
  end
end
