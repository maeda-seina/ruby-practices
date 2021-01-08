#!/usr/bin/env ruby

# frozen_string_literal: true

# コマンドライン引数使うため
require 'optparse'
# lオプションのオーナー名とグループ名出すのに必要
require 'etc'

params = ARGV.getopts('a', 'l', 'r')

# オプションなしの時の横に最大3列を維持して表示するメソッド
def filefile
  file = []
  Dir.glob('*') do |item|
    file << item
  end
  count = 0
  file.each do |f|
    count += 1
    print "#{f}  "
    puts "\n" if (count % 3).zero?
  end
  print ''
end

# rオプションの時に横に最大3列を維持して表示するメソッド
def filefile_reverse
  file = []
  Dir.glob('*') do |item|
    file << item
  end
  count = 0
  file.reverse_each do |f|
    count += 1
    print "#{f}  "
    puts "\n" if (count % 3).zero?
  end
  print ''
end

# aオプションの時に横に最大3列を維持して表示するメソッド
def filesfiles
  files = []
  Dir.foreach('.') do |item|
    files << item
  end
  count = 0
  files.each do |fs|
    count += 1
    print "#{fs}  "
    puts "\n" if (count % 3).zero?
  end
  print ''
end

# arオプションの時に横に最大3列を維持して表示するメソッド
def filesfiles_reverse
  files = []
  Dir.foreach('.') do |item|
    files << item
  end
  count = 0
  files.reverse_each do |fs|
    count += 1
    print "#{fs}  "
    puts "\n" if (count % 3).zero?
  end
  print ''
end

# .や..を含まないfileメソッド
def file
  file = []
  Dir.glob('*') do |item|
    file << item
  end
  file
end

# .や..も含んだ全てのfileメソッド
def files
  files = []
  Dir.foreach('.') do |item|
    files << item
  end
  files
end

# lオプションのブロック数の合計値を表すメソッド
def block
  block = 0
  file.each do |f|
    stat = File.stat(f)
    block += stat.blocks
  end
  puts "total #{block}"
end

# alオプションのブロック数の合計値を表すメソッド
def blocks
  block = 0
  files.each do |f|
    stat = File.stat(f)
    block += stat.blocks
  end
  puts "total #{block}"
end

# lオプションのメソッド
def loption
  print block
  file.each do |f|
    stat = File.stat(f)
    permissions = format('0%o', stat.mode).to_i % 1000
    permission = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
    filetype = stat.ftype
    file = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's',
             'unknown' => 'u' }
    print "#{file[filetype] + permission[permissions / 100 % 10] + permission[permissions / 10 % 10] + permission[permissions % 10]}  "
    print "#{stat.nlink}  "
    print "#{Etc.getpwuid(File.stat(f).uid).name}  "
    print "#{Etc.getgrgid(File.stat(f).gid).name}  "
    print "#{stat.size}  "
    print "#{stat.mtime.strftime('%m %d %H:%M')}  "
    print File.basename(f)
    print "\n"
  end
  # 戻り値にファイルが入った配列が表示されてしまうため書いた。何かいい方法ないか。
  print ''
end

# alオプションのメソッド
def loptions
  print blocks
  files.each do |f|
    stat = File.stat(f)
    permissions = format('0%o', stat.mode).to_i % 1000
    permission = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
    filetype = stat.ftype
    file = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's',
             'unknown' => 'u' }
    print "#{file[filetype] + permission[permissions / 100 % 10] + permission[permissions / 10 % 10] + permission[permissions % 10]}  "
    print "#{stat.nlink}  "
    print "#{Etc.getpwuid(File.stat(f).uid).name}  "
    print "#{Etc.getgrgid(File.stat(f).gid).name}  "
    print "#{stat.size}  "
    print "#{stat.mtime.strftime('%m %d %H:%M')}  "
    print File.basename(f)
    print "\n"
  end
  # 戻り値にファイルが入った配列が表示されてしまうため書いた。何かいい方法ないか。
  print ''
end

# arオプションのメソッド
def loption_reverse
  print block
  file.reverse_each do |f|
    stat = File.stat(f)
    permissions = format('0%o', stat.mode).to_i % 1000
    permission = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
    filetype = stat.ftype
    file = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's',
             'unknown' => 'u' }
    print "#{file[filetype] + permission[permissions / 100 % 10] + permission[permissions / 10 % 10] + permission[permissions % 10]}  "
    print "#{stat.nlink}  "
    print "#{Etc.getpwuid(File.stat(f).uid).name}  "
    print "#{Etc.getgrgid(File.stat(f).gid).name}  "
    print "#{stat.size}  "
    print "#{stat.mtime.strftime('%m %d %H:%M')}  "
    print File.basename(f)
    print "\n"
  end
  # 戻り値にファイルが入った配列が表示されてしまうため書いた。何かいい方法ないか。
  print ''
end

# alrオプションのメソッド
def loptions_reverse
  print blocks
  files.reverse_each do |f|
    stat = File.stat(f)
    permissions = format('0%o', stat.mode).to_i % 1000
    permission = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
    filetype = stat.ftype
    file = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's',
             'unknown' => 'u' }
    print "#{file[filetype] + permission[permissions / 100 % 10] + permission[permissions / 10 % 10] + permission[permissions % 10]}  "
    print "#{stat.nlink}  "
    print "#{Etc.getpwuid(File.stat(f).uid).name}  "
    print "#{Etc.getgrgid(File.stat(f).gid).name}  "
    print "#{stat.size}  "
    print "#{stat.mtime.strftime('%m %d %H:%M')}  "
    print File.basename(f)
    print "\n"
  end
  # 戻り値にファイルが入った配列が表示されてしまうため書いた。何かいい方法ないか。
  print ''
end

if params['a'] && params['l'] && params['r']
  puts loptions_reverse
elsif params['r'] && params['l']
  puts loption_reverse
elsif params['a'] && params['r']
  puts filesfiles_reverse
elsif params['a'] && params['l']
  puts loptions
elsif params['r']
  puts filefile_reverse
elsif params['a']
  puts filesfiles
elsif params['l']
  puts loption
else
  puts filefile
end
