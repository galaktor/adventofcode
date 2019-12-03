#!/usr/bin/env ruby

class Point
  attr_reader :x, :y

  def initialize(x: 0, y: 0)
    @x, @y = x, y
  end

  def self.copy(other)
    Point.new(x: other.x, y: other.y)
  end

  def update!(dir, len)
    case dir
    when "u"
      @y += len
    when "d"
      @y -= len
    when "l"
      @x -= len
    when "r"
      @x += len
    else
      raise "unknown direction: #{step}"
    end
    self
  end

  def distance
    x.abs + y.abs
  end

  def to_s
    "#{@x}:#{@y}[#{distance}]"
  end

  def equal(other)
    other.x == @x && other.y == @y
  end
end

class Wire
  attr_reader :points

  def initialize(steps)
    @points = [Point.new]
    steps.each{ |s| interpolate(s) }
  end

  def jump(step)
    dir = step[0].downcase
    len = step[1..-1].to_i
    @points << Point.copy(@points.last).update!(dir, len)
  end

  def interpolate(step)
    dir = step[0].downcase
    len = step[1..-1].to_i
    len.times{ |i| self.jump("#{dir}1") }
  end

  def to_s
    @points.drop(1).join("->")
  end
end

wire1, wire2 = File.readlines(ARGV[0]).map{ |l| Wire.new(l.split(",")) }
puts wire2.points.drop(1).select{ |p2| wire1.points.drop(1).any?{ |p1| p1.equal(p2) }}.map{ |p| p.distance }.sort.first
