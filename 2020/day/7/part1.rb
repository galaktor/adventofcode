#!/usr/bin/env ruby

require 'json'

class Bag
  attr_accessor :outer
  attr_accessor :inner
  attr_reader :colour

  def initialize(colour)
    @colour = colour
    @inner = []
    @outer = []
  end
end

bags = {}
File.readlines(ARGV[0]).map(&:strip).map{ |l| l.chomp(".") }.each do |l|
  outer, inner = l.split(/bags contain \d+/)
  outer = outer&.split(/bags contain no other bags/).map(&:strip).first
  inner = inner&.split(/bag[s]*, \d+/)&.map{ |i| i.chomp("bags").chomp("bag").strip }
  bags[outer] ||= Bag.new(outer)
  inner&.each do |i|
    bags[i] ||= Bag.new(i)
    bags[outer].inner << bags[i]
    bags[i].outer << bags[outer]
  end
end

def outer_colours(bag)
  return bag.colour if bag.outer.empty?
  bag.outer.map{ |b| outer_colours(b) } << [bag.colour]
end

puts outer_colours(bags["shiny gold"]).flatten.reject{ |c| c == "shiny gold" }.uniq.count
