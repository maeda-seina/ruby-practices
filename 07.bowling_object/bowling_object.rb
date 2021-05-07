# frozen_string_literal: true

require './shot'
require './frame'
require './game'
score = ARGV[0].split(',')
puts Game.new(score).calculate_game_score
