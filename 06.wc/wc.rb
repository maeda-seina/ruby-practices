#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

params = ARGV.getopts('l')

def print_file(file)
  file = File.read(file)
  print file.lines.count.to_s.rjust(8)
  print file.split(/\s+/).size.to_s.rjust(8)
  print file.bytesize.to_s.rjust(8)
end

# パイプラインを使った時の処理 & 標準入力受け取る処理
if !params['l'] && ARGV.count.zero?
  file = ARGF.read
  print file.lines.count.to_s.rjust(8)
  print file.split(/\s+/).size.to_s.rjust(8)
  print file.bytesize.to_s.rjust(8)
  print "\n"
end

# -lオプションの時の処理
if params['l']
  if ARGV.count == 1
    file = File.read(ARGV[0])
    print file.lines.count.to_s.rjust(8)
    print ARGV[0].rjust(6)
    print "\n"
  elsif ARGV.count > 1
    lines_sum = 0
    ARGV.each do |f|
      file = File.read(f)
      print file.lines.count.to_s.rjust(8)
      print f.rjust(6)
      print "\n"
      lines_sum += file.lines.count
    end
    print lines_sum.to_s.rjust(8)
    print 'total'.rjust(6)
    print "\n"
  end
end

# 引数にファイル名が1つの時の処理
if ARGV.count == 1 && !params['l']
  print_file(ARGV[0])
  print ARGV[0].rjust(6)
  print "\n"
end

# 引数にファイル名が2つ以上の時の処理
if ARGV.count > 1 && !params['l']
  lines_sum = 0
  words_sum = 0
  bytes_sum = 0
  ARGV.each do |f|
    print_file(f)
    print f.rjust(6)
    print "\n"
    file = File.read(f)
    lines_sum += file.lines.count
    words_sum += file.split(/\s+/).size
    bytes_sum += file.bytesize
  end
  print lines_sum.to_s.rjust(8)
  print words_sum.to_s.rjust(8)
  print bytes_sum.to_s.rjust(8)
  print 'total'.rjust(6)
  print "\n"
end
