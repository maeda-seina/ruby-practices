#!/usr/bin/env ruby
require 'optparse'
require 'date'
 

year = Date.today.year
month = Date.today.mon
day = Date.today.mday
youbi = ["日", "月", "火", "水", "木", "金", "土"]
puts "#{month}月 #{year}".center(20)
puts youbi.join(' ')

wday = Date.new(2020, 11, 1).wday
lastday = Date.new(year, month, -1).day
firstwday = Date.new(year, month, 1).wday

(1..lastday).each do |day|
    print day.to_s.rjust(3)
    firstwday += 1
    if firstwday % 7 == 0
       print "\n"
    end
end


