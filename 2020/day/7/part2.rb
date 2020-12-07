#!/usr/bin/env ruby

require 'pry'

@bags = {}
File.readlines(ARGV[0]).map(&:strip).map{ |l| l.chomp(".") }.each do |l|
  outer, inner = l.split(/\s*bags contain\s*/)
  inner = inner.split(",").map(&:strip).map{ |i| { quantity: i[/^\d+/].to_i, colour: i[/[a-z ]+$/].chomp("bags").chomp("bag").strip } }.reject{ |i| i[:quantity] == 0 }
  @bags[outer] = inner
end

def total(colour)
  return 1 if @bags[colour].empty?
  @bags[colour].sum{ |i| i[:quantity] * total(i[:colour]) } + 1
end

puts total("shiny gold")-1
