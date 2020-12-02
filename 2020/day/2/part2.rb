#!/usr/bin/env ruby

count = 0
File.readlines(ARGV[0]).map{ |l| l.split(":").map(&:strip) }.select do |policy, password|
  range, character = policy.split(" ")
  a, b = range.split("-").map{ |n| n.to_i - 1 }
  count += 1 if (password[a] == character) ^ (password[b] == character)
end

puts count
