#!/usr/bin/env ruby

orbits =  File.readlines(ARGV[0]).map{ |l| l.chomp.split(")").reverse }.to_h

path1, path2 = [], []

o = orbits["YOU"]
path1 << o
loop do
  o = orbits[o]
  break if o.nil?
  path1 << o
end

o = orbits["SAN"]
path2 << o
loop do
  o = orbits[o]
  break if o.nil?
  path2 << o
end

puts (path1.reject{ |p| path2.include?(p) } + path2.reject{ |p| path1.include?(p) }).count
