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
      @neighbours[dir(a)] = dist(a)
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
puts asteroids.each{ |a| a.scan(asteroids) }.max{ |a,b| a.neighbours.count <=> b.neighbours.count }.neighbours.count
