#!/usr/bin/env ruby

DEBUG=false

require "pry" if DEBUG

STDIN.sync = true
STDOUT.sync = true

class Tile
  attr_accessor :x, :y, :colour

  def initialize(x:, y:, colour: :empty)
    @x, @y = x, y
    @colour = colour
  end

  def to_s
    "#{@x}:#{@y}:#{@colour}"
  end
end

@width, @height = ARGV[0].to_i, ARGV[1].to_i
@grid = (1..@height).map{ |y| (1..@width).map{ |x| "." }}

def render(tile)
  c=tile.colour
  case c
  when :empty
    c="."
  when :wall
    c="W"
  when :block
    c="B"
  when :paddle
    c="P"
  when :ball
    c="O"
  else
    raise "invalid colour: #{c}"
  end
  @grid[tile.y][tile.x] = c
end

p=Tile.new(x: 0, y: 0)
i=0
STDIN.each_line do |line|
  l=line.strip.to_i
  puts l if DEBUG
  case i
  when 0
    p.x = l-1
    i += 1
  when 1
    p.y = l-1
    i += 1
  when 2
    case l
    when 0
      p.colour = :empty
    when 1
      p.colour = :wall
    when 2
      p.colour = :block
    when 3
      p.colour = :paddle
    when 4
      p.colour = :ball
    else
      raise "invalid colour code: #{l}"
    end
    render(p)
    i = 0
    puts "next frame" if DEBUG
  else
    raise "invalid instruction: #{i}"
  end
end

puts @grid.map(&:join) if DEBUG
puts @grid.flatten.count("B")
