#!/usr/bin/env ruby
# frozen_string_literal: true

# コマンドライン引数使うため
require 'optparse'

# aオプションの時は'orange'を代入する
# rオプションの時はfruits配列を逆表示にする
# lオプションの時は'strawberry'を代入する
params = ARGV.getopts('a', 'l', 'r')

fruits = %w[apple banana grape]

fruits << 'orange' if params['a']

sorted_files = fruits.sort

sorted_files = fruits.reverse if params['r']

loption = sorted_files
loption << 'strawberry' if params['l']

puts loption

# require 'optparse'

# params = ARGV.getopts('a', 'l', 'r')

# fruits = ["apple"]

# if params['a']
#   # a オプションありのときは、こちらだけ通る
#   fruits << "banana"
#   puts "aオプションありだよ"
# else
#   # aオプションありのときは、こちらは通らない
#   puts "aオプションなしだよ"
# end

# if params['r']
#   fruits << "melon"
#   puts "rオプションありだよ"
# else
#   puts "rオプションなしだよ"
# end

# puts fruits
