#!/usr/bin/env ruby

puts File.readlines(ARGV[0]).map{ |l| l.split("x").map(&:to_i) }.map{ |b| { l: b[0], w: b[1], h: b[2] } }.map{ |b| [b[:l]*b[:w], b[:w]*b[:h], b[:h]*b[:l]] }.map{ |b| 2*b[0] + 2*b[1] + 2*b[2] + b.min }.reduce(&:+)
