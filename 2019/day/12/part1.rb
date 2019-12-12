#!/usr/bin/env ruby

require "matrix"
require "pry"

class Moon
  attr_reader :pos, :vel

  def initialize(x, y, z)
    @pos = Vector[x, y, z]
    @vel = Vector[0, 0, 0]
  end

  def gravitate(other)
    @vel += Vector[other.pos[0] <=> @pos[0], 0, 0]
    @vel += Vector[0, other.pos[1] <=> @pos[1], 0]
    @vel += Vector[0, 0, other.pos[2] <=> @pos[2]]
  end

  def move
    @pos += @vel
  end

  def to_s
    "#{@pos}->#{@vel}"
  end
end

moons = File.readlines(ARGV[0]).map{ |l| l.tr("<", "").tr(">", "").split(",").map(&:strip).map{ |c| c.split("=")[1] } }.map{ |v| Moon.new(v[0].to_i, v[1].to_i, v[2].to_i) }
(1..ARGV[1].to_i).each do |t|
  moons.permutation(2).each{ |m1,m2| m1.gravitate(m2) }
  moons.each(&:move)
end
puts moons
