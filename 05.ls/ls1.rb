#!/usr/bin/env ruby
# frozen_string_literal: true

# コマンドライン引数使うため
require 'optparse'
# lオプションのオーナー名とグループ名出すのに必要
require 'etc'

params = ARGV.getopts('a', 'l', 'r')
# .や..を含まないfile
file = []
# .や..も含んだ全てのfile
files = []

# .や..を含まないfileを作成
Dir.glob('*') do |item|
  file << item
end
p file

# .や..も含んだ全てのfileを作成
Dir.foreach('.') do |item|
  files << item
end
p files

def loption
  block = 0
  file = []
  Dir.glob('*') do |item|
    file << item
  end

  file.each do |f|
    stat = File.stat(f)
    block += stat.blocks
    puts "total #{block}"
    print "#{stat.nlink}  "
    print "#{Etc.getpwuid(File.stat(f).uid).name}  "
    print "#{Etc.getgrgid(File.stat(f).gid).name}  "
    print "#{stat.size}  "
    print "#{stat.mtime.strftime('%m %d %H:%M')}  "
    print File.basename(f)
    print "\n"
  end
end

# files.each do |fs|
#   stats = File.stat(fs)
# end

if params['a'] && params['r']
  puts files.reverse
elsif params['r']
  puts file.reverse
elsif params['a']
  puts files
elsif params['l']
  puts loption
else
  puts file
end
