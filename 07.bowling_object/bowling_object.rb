# frozen_string_literal: true

require './shot'
require './frame'
require './game'
puts Game.new(ARGV[0]).calculate_game_score
