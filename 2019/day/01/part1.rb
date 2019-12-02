#!/usr/bin/env ruby

puts File.readlines(ARGV[0]).map{ |l| (l.to_f / 3).to_i - 2 }.reduce(:+)
