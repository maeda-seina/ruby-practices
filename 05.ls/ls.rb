#!/usr/bin/env ruby
# frozen_string_literal: true

# コマンドライン引数使うため
require 'optparse'
# lオプションのオーナー名とグループ名出すのに必要
require 'etc'

params = ARGV.getopts('a', 'l', 'r')

# aオプションなしの時のfile
def file_method
  file = []
  Dir.glob('*') do |item|
    file << item
  end
  file
end

# aオプションありの時のfile
def files_method
  file = []
  Dir.foreach('.') do |item|
    file << item
  end
  file
end

# aオプション条件分岐
file_a_method = if params['a']
                  files_method
                else
                  file_method
                end

file_a_method = file_a_method.sort

# rオプション条件分岐
sorted_file = if params['r']
                file_a_method.reverse
              else
                file_a_method
              end

# lオプションblock数
block = 0
sorted_file.each do |f|
  stat = File.stat(f)
  block += stat.blocks
end

# lオプション条件分岐
if params['l']
  puts "total #{block}"
  sorted_file.each do |f|
    stat = File.stat(f)
    permissions = format('0%o', stat.mode).to_i % 1000
    permission = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
    filetype = stat.ftype
    file = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's',
             'unknown' => 'u' }
    print "#{file[filetype] + permission[permissions / 100 % 10] + permission[permissions / 10 % 10] + permission[permissions % 10]}  "
    print "#{stat.nlink} "
    print "#{Etc.getpwuid(File.stat(f).uid).name}  "
    print "#{Etc.getgrgid(File.stat(f).gid).name}  "
    print "#{stat.size}  "
    print "#{stat.mtime.strftime('%-m %d %H:%M')}  "
    print File.basename(f)
    print "\n"
  end
else
  count = 0
  sorted_file.each do |f|
    count += 1
    print "#{f}  "
    puts "\n" if (count % 3).zero?
  end
  print "\n"
end
