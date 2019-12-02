#!/usr/bin/env ruby

def fuel(mass)
  (mass / 3).to_i - 2
end

puts File.readlines("./input.txt").map{ |l| fuel(l.to_f) }.reduce(:+)
