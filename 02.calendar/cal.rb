#!/usr/bin/env ruby
require 'date'


date = Date.today

month = date.mon
year = date.year
youbi = ["日", "月", "火", "水", "木", "金", "土"]

last_date = Date.new(year, month, -1).day
day_youbi = Date.new(year, month, 1).wday

puts ("#{date.month}月" "#{date.year}").center(20)
puts youbi.join(' ')

(1..last_date).each do |day|
    print day.to_s.rjust(3)
    day_youbi += 1
    if day_youbi % 7 == 0
        puts "\n"
    end
end