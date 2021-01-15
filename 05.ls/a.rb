#!/usr/bin/env ruby

# frozen_string_literal: true

# コマンドライン引数使うため
require 'optparse'
# lオプションのオーナー名とグループ名出すのに必要
require 'etc'

params = ARGV.getopts('a', 'l', 'r')

if params['a']
    puts 1
end

if params['l']
    puts 2
end

if params['r']
    puts 3
end