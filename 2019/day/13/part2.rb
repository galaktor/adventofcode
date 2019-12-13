#!/usr/bin/env ruby

DEBUG=false
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

@score=0
p=Tile.new(x: 0, y: 0)
i=0
STDIN.each_line do |line|
  puts line if DEBUG
  l=line.strip.to_i
  case i
  when 0
    p.x = l
    puts "x=#{p.x}" if DEBUG
    i += 1
  when 1
    p.y = l
    puts "y=#{p.y}" if DEBUG
    i += 1
  when 2
    if p.x == -1 && p.y == 0
      @score = l
      puts "score: #{@score}" if DEBUG
    else
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
      puts "colour=#{p.colour}" if DEBUG
    end
    render(p) unless p.x < 0
    i = 0
    puts @grid.map(&:join)
    puts "next frame" if DEBUG
  else
    raise "invalid instruction: #{i}"
  end
end

puts @score
