#!/usr/bin/env ruby
require 'date'
require 'optparse'

date = Date.today
month = date.mon
year = date.year
youbi = ["日", "月", "火", "水", "木", "金", "土"]

opt = OptionParser.new
opt.on('-m value') {|v| month = v.to_i }
opt.on('-y value') {|v| year = v.to_i }
opt.parse!(ARGV)

last_date = Date.new(year, month, -1).day
day_youbi = Date.new(year, month, 1).wday

puts ("#{month}月" "#{year}").center(20)
puts youbi.join(' ')
print "   " * day_youbi
(1..last_date).each do |day|
    print day.to_s.rjust(2) + " "
    day_youbi += 1
    if day_youbi.saturday?
        puts "\n"
    end
end
print "\n"

