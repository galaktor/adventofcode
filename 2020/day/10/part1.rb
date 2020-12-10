#!/usr/bin/env ruby

adapters = [0] + File.readlines(ARGV[0]).map(&:strip).map(&:to_i).sort
adapters << adapters.max+3

ones = 0
threes = 0

adapters.each_cons(2) do |a,b|
  ones += 1 if b-a == 1
  threes += 1 if b-a == 3
end

puts "#{ones} 1-jolt x #{threes} 3-jolt = #{ones * threes}"
