#!/usr/bin/env ruby

terrain = File.readlines(ARGV[0]).map(&:strip)
stepx=ARGV[1].to_i
stepy=ARGV[2].to_i

expand = ((stepx*terrain.length)/terrain.first.length)+1
terrain.map!{ |l| l * expand }

trees = 0
x = stepx
terrain.drop(stepy).each_slice(stepy) do |l, *_|
  trees += 1 if l[x] == "#"
  x += stepx
end
puts trees
