#!/usr/bin/env ruby
# frozen_string_literal: true

a = []
ARGF.each do |line|
    a << line
    p line
    p a
end
print "       #{a.count}      "
b = a.to_s.split(/\s+/).size
puts "#{b}     "
puts "#{a.to_s.delete("[],\\n,\\")}  "
puts "#{a.to_s.delete("[],\\n,\\").bytesize}  "
puts "#{a.to_s.bytesize}"
print "\n"


require 'optparse'

params = ARGV.getopts('l')

if params['l']
  if ARGV.count == 1
    file = File.read(ARGV[0])
    print "     #{file.lines.count}  "
    print ARGV[0]
    print "\n"
  elsif ARGV.count > 1
    lines_sum = 0
    ARGV.each do |f|
      file = File.read(f)
      print "     #{file.lines.count}  "
      print f
      print "\n"
      lines_sum += file.lines.count
    end
    print "     #{lines_sum}  "
    print 'total'
    print "\n"
  end
end

if ARGV.count == 1 && !params['l']
  file = File.read(ARGV[0])
  print "     #{file.lines.count}  "
  word_count = file.split(/\s+/)
  print "   #{word_count.size} "
  print "   #{file.bytesize} "
  print ARGV[0]
  print "\n"
end

if ARGV.count > 1 && !params['l']
  lines_sum = 0
  words_sum = 0
  bytes_sum = 0
  ARGV.each do |f|
    file = File.read(f)
    print "     #{file.lines.count}  "
    word_count = file.split(/\s+/)
    print "   #{word_count.size} "
    print "   #{file.bytesize} "
    print f
    print "\n"
    lines_sum += file.lines.count
    words_sum += word_count.size
    bytes_sum += file.bytesize
  end
  print "     #{lines_sum}  "
  print "   #{words_sum} "
  print "   #{bytes_sum} "
  print 'total'
  print "\n"
end
