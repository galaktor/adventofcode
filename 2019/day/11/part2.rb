#!/usr/bin/env ruby

DEBUG=false
STDIN.sync = true
STDOUT.sync = true

class Panel
  attr_reader :x, :y, :colour

  def initialize(x:, y:, colour: :black)
    @x, @y = x, y
    @colour = colour
  end

  def to_s
    "#{@x}:#{@y}:#{@colour}"
  end
end

@panels = [Panel.new(x: 0, y: 0, colour: :white)]
@x,@y = ARGV[0].to_i, ARGV[1].to_i
@direction = :up

def paint(colour)
  p = Panel.new(x: @x, y: @y, colour: colour == 1 ? :white : :black)
  existing = @panels.find{ |other| other.x == p.x && other.y == p.y }
  @panels.delete(existing) unless existing.nil?
  @panels << p
  puts "painted #{p}" if DEBUG
end

def turn(direction)
  case @direction
  when :up
    @direction = direction == 0 ? :left : :right
  when :down
    @direction = direction == 0 ? :right : :left
  when :right
    @direction = direction == 0 ? :up : :down
  when :left
    @direction = direction == 0 ? :down : :up
  end
end

def move(steps = 1)
  case @direction
  when :up
    @y += steps
  when :down
    @y -= steps
  when :right
    @x += steps
  when :left
    @x -= steps
  end
  puts "moved to #{@x}:#{@y}" if DEBUG
end

def get_colour
  painted = @panels.find{ |p| p.x == @x && p.y == @y }
  return 0 if painted.nil?
  return painted.colour == :white ? 1 : 0
end

i=0
STDIN.each_line do |line|
  i += 1
  case (i%2 == 0) ? :turn : :paint
  when :paint
    paint(line.chomp.to_i)
  when :turn
    turn(line.chomp.to_i)
    move
    puts get_colour
  end
end

max_x = @panels.map(&:x).max
min_x = @panels.map(&:x).min
max_y = @panels.map(&:y).max
min_y = @panels.map(&:y).min

puts (min_y..max_y).map{ |y| (min_x..max_x).map{ |x| @panels.find{ |p| p.x == x && p.y == y && p.colour == :white } ? "#" : " " }.join }.reverse.join("\n")
