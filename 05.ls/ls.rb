#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
opt = OptionParser.new

stat = File.stat($0)

permissions = ("0%o" % stat.mode).to_i % 1000
per1 =
    case permissions % 10
    when 0
      '---'
    when 1
      '--x'
    when 2 
      '-w-'
    when 3
      '-wx'
    when 4
      'r--'
    when 5
      'r-x'
    when 6
      'rw-'
    when 7
      'rwx'
    end

per2 =
    case permissions/10 % 10
    when 0
      '---'
    when 1
      '--x'
    when 2 
      '-w-'
    when 3
      '-wx'
    when 4
      'r--'
    when 5
      'r-x'
    when 6
      'rw-'
    when 7
      'rwx'
    end

per3 =
    case permissions/100 % 10
    when 0
      '---'
    when 1
      '--x'
    when 2 
      '-w-'
    when 3
      '-wx'
    when 4
      'r--'
    when 5
      'r-x'
    when 6
      'rw-'
    when 7
      'rwx'
    end

filetype = stat.ftype
file =
    case filetype
    when "file"
      "-"
    when "directory"
      "d"
    when "characterSpecial"
      "c"
    when "blockSpecial"
      "b"
    when "fifo"
      "p"
    when "link"
      "l"
    when "socket"
      "s"
    when "unknown"
      "u"
    end


Dir.glob('**/*') do |item|
    puts item
  end

opt.on('-a', desk = 'カレントディレクトリのファイルやフォルダを全て表示します。') { Dir.foreach('.') do |item|
    puts item
  end}

opt.on('-l', desk = 'カレントディレクトリのファイルやフォルダの詳細を表示します。') {
    puts "total #{stat.blocks}"
    print file + per3 + per2 + per1 + "  "
    print stat.nlink.to_s + " "
    print Etc.getpwuid(File.stat($0).uid).name + "  "
    print Etc.getgrgid(File.stat($0).gid).name + "  "
    print stat.size.to_s + " "
    print stat.mtime.strftime("%m %d %H:%M") + " "
    print File.basename($0)
    print "\n"
}

opt.parse!(ARGV)

