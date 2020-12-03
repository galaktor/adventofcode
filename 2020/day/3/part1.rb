#!/usr/bin/env ruby

terrain = File.readlines(ARGV[0]).map(&:strip)
expand = ((3*terrain.length)/terrain.first.length)+1
terrain.map!{ |l| l * expand }

trees = 0
x = 3
terrain.drop(1).each do |l|
  trees += 1 if l[x] == "#"
  x += 3
end
puts trees
