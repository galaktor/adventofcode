#!/usr/bin/env ruby

class Santa
  attr_reader :x, :y, :houses, :name

  def initialize(name)
    @name = name
    @x, @y = 0, 0
    @houses = [[0,0]]
  end

  def up
    @y += 1
  end

  def down
    @y -= 1
  end

  def left
    @x -= 1
  end

  def right
    @x += 1
  end

  def visit
    @houses << [@x,@y]
  end
end

santa = Santa.new("santa")
robo = Santa.new("robo-santa")
File.read(ARGV[0]).chomp.split("").each_with_index do |d,i|
  s = (i%2 == 0) ? santa : robo
  case d
  when "^"
    s.up
  when "v"
    s.down
  when ">"
    s.right
  when "<"
    s.left
  end
  s.visit
end

puts (santa.houses + robo.houses).uniq.count
