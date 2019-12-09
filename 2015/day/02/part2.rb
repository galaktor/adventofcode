#!/usr/bin/env ruby

puts File.readlines(ARGV[0]).map{ |l| l.split("x").map(&:to_i) }.map{ |b| { l: b[0], w: b[1], h: b[2] } }.map{ |b| b.values.sort.take(2).map{ |s| 2*s }.reduce(&:+) + b.values.reduce(&:*)}.reduce(&:+)
