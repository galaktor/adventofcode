#!/usr/bin/env ruby

require "matrix"

class Asteroid
  attr_reader :x, :y, :neighbours

  def initialize(x, y)
    @x, @y = x.to_f, y.to_f
    @neighbours = {}
  end

  def scan(asteroids)
    neighbours = {}
    asteroids.reject{ |a| equal(a) }.each_with_object({}) do |a,h|
      d=dir(a)
      @neighbours[d] = a unless @neighbours.key?(d)
    end
  end

  def dist(other)
    (Vector[other.x,other.y]-Vector[@x,@y]).magnitude.round(2)
  end

  def dir(b)
    d=Vector[b.x,b.y]-Vector[@x,@y]
    (Math.atan2(d[1], d[0])*180/Math::PI).round(2)
  end

  def equal(other)
    @x == other.x && @y == other.y
  end

  def to_s
    "(#{@x}:#{@y})"
  end
end

asteroids = []
File.readlines(ARGV[0]).each_with_index{ |row,y| row.chomp.split("").each_with_index{ |c,x| asteroids << Asteroid.new(x, y) if c == "#" }}
asteroids.each{ |a| a.scan(asteroids) }
best = asteroids.select{ |a| a.x == ARGV[1].to_f && a.y == ARGV[2].to_f }.first
after = best.neighbours.keys.sort.take_while{ |d| d < -90 }
before = best.neighbours.keys.sort.drop_while{ |d| d < -90 }
target = best.neighbours[(before + after)[199]]

#puts before + after
puts target
puts target.x*100 + target.y
