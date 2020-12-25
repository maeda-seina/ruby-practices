#!/usr/bin/env ruby
# frozen_string_literal: true

number = (1..100)
number.each do |n|
  if  (n % 15).zero?
    n = 'FizzBuzz'
  elsif (n % 5).zero?
    n = 'Buzz'
  elsif (n % 3).zero?
    n = 'Fizz'
  end
  puts n
end
