#!/usr/bin/env ruby

width=ARGV[1].to_i
height=ARGV[2].to_i

layers = []
File.read(ARGV[0]).chomp.split("").map(&:to_i).each_slice(width*height){ |l| layers << l }
flat = layers.reverse.reduce{ |flat, l| l.each_with_index{ |p,i| flat[i] = p if p != 2 }; flat }
flat.each_slice(width){ |r| puts r.join(" ") }
