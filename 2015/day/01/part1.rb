#!/usr/bin/env ruby

puts File.read(ARGV[0]).chomp.split("").map{ |b| (b == "(") ? 1 : -1 }.reduce(&:+)
