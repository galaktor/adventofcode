#!/usr/bin/env ruby

def fuel(mass)
  f = (mass / 3).to_i - 2
  return 0 unless f > 0
  f + fuel(f)
end

puts File.readlines(ARGV[0]).map{ |l| fuel(l.to_f) }.reduce(:+)
