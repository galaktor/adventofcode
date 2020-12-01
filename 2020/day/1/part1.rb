#!/usr/bin/env ruby

numbers = File.readlines(ARGV[0]).map{ |l| l.chomp.to_i }
numbers.each do |n|
  next unless numbers.any?(2020-n)
  puts n * (2020-n)
  break
end
