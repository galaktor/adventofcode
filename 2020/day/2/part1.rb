#!/usr/bin/env ruby

count = 0
File.readlines(ARGV[0]).map{ |l| l.split(":").map(&:strip) }.select do |policy, password|
  range, character = policy.split(" ")
  min, max = range.split("-").map(&:to_i)
  count += 1 if password.count(character).between?(min,max)
end

puts count
