#!/usr/bin/env ruby

inv = ARGV[1].to_i

add = []
File.readlines(ARGV[0]).map(&:strip).map(&:to_i).each do |n|
  add << n
  add = add.drop(1) while add.sum > inv
  break if add.sum == inv
end
puts "#{add.min} + #{add.max} = #{add.min + add.max}"
