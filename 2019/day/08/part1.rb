#!/usr/bin/env ruby

width=ARGV[1].to_i
height=ARGV[2].to_i

layers = []
File.read(ARGV[0]).chomp.split("").map(&:to_i).each_slice(width*height){ |l| layers << l }
fewest_zeroes = layers.sort{ |l1, l2| l1.count{ |p| p == 0 } <=> l2.count{ |p| p == 0 } }.first
ones = fewest_zeroes.count{ |p| p == 1 }
twos = fewest_zeroes.count{ |p| p == 2 }
puts "answer: #{ones*twos}"
