#!/usr/bin/env ruby
# frozen_string_literal: true

# コマンドライン引数使うため
require 'optparse'
# lオプションのオーナー名とグループ名出すのに必要
require 'etc'

params = ARGV.getopts('a', 'l', 'r')

def file
  file = []
  Dir.glob('*') do |item|
    file << item
  end
  file
end

def file_with_a_option
  file = []
  Dir.foreach('.') do |item|
    file << item
  end
  file
end

def loption_output_processing(file)
  stat = File.stat(file)
  permissions = format('0%o', stat.mode).to_i % 1000
  permission = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
  permission_of_hundreds_place = permission[permissions / 100 % 10]
  permission_of_tens_place = permission[permissions / 10 % 10]
  permission_of_ones_place = permission[permissions % 10]
  filetype = stat.ftype
  file_hash = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's',
                'unknown' => 'u' }
  print file_hash[filetype] + permission_of_hundreds_place + permission_of_tens_place + permission_of_ones_place
  print stat.nlink.to_s.rjust(3)
  print Etc.getpwuid(stat.uid).name.rjust(11)
  print Etc.getgrgid(stat.gid).name.rjust(7)
  print stat.size.to_s.rjust(6)
  print (stat.mtime.strftime('%-m %d %H:%M')).rjust(12)
  print File.basename(file).rjust(6)
  print "\n"
end

# aオプション条件分岐
files = params['a'] ? file_with_a_option : file
files.sort

# rオプション条件分岐
sorted_file = params['r'] ? files.reverse : files

# lオプション条件分岐
if params['l']
  block = 0
  sorted_file.each do |file|
    stat = File.stat(file)
    block += stat.blocks
  end
  puts "total #{block}"
  sorted_file.each do |file|
    loption_output_processing(file)
  end
else
  sorted_file.each.with_index(1) do |file, index|
    print file.ljust(10)
    puts "\n" if (index % 3).zero?
  end
  print "\n"
end
