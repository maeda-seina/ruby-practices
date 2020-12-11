#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

date = Date.today
month = date.mon
year = date.year
youbi = %w[日 月 火 水 木 金 土]

opt = OptionParser.new
opt.on('-m value') { |v| month = v.to_i }
opt.on('-y value') { |v| year = v.to_i }
opt.parse!(ARGV)

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
day_youbi = Date.new(year, month, 1).wday

puts ("#{month}月" "#{year}").center(20)
puts youbi.join(' ')
print '   ' * day_youbi
(first_date..last_date).each do |d|
  print "#{d.day.to_s.rjust(2)} "
  puts "\n" if d.saturday?
end
print "\n"
