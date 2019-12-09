#!/usr/bin/env ruby

floor = 0
answer = -1
File.read(ARGV[0]).chomp.split("").map{ |b| (b == "(") ? 1 : -1 }.each_with_index do |d,i|
  floor += d
  answer = i+1
  break if floor == -1
end
puts answer
