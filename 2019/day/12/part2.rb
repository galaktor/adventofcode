#!/usr/bin/env ruby

require "matrix"
require "pry"

class Moon
  attr_reader :pos, :vel, :pos0, :vel0

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

  def energy
    pot = @pos.map(&:abs).reduce(&:+)
    kin = @vel.map(&:abs).reduce(&:+)
    pot * kin
  end

  def to_s
    "#{@pos}->#{@vel}[#{energy}]"
  end
end

history = [[],[],[]]
moons = File.readlines(ARGV[0]).map{ |l| l.tr("<", "").tr(">", "").split(",").map(&:strip).map{ |c| c.split("=")[1] } }.map{ |v| Moon.new(v[0].to_i, v[1].to_i, v[2].to_i) }

300_000.times do |i|
  history.each.with_index do |_, i|
    history[i] << moons.map{ |m| m.pos[i] } + moons.map{ |m| m.vel[i] }
  end

  moons.permutation(2).each{ |m1,m2| m1.gravitate(m2) }
  moons.each(&:move)
end

periods = []
history.each.with_index do |points, i|
  periods << points.each_index.select {|i| points[i] == points[0]}[1]
end

puts periods.inject(:lcm)
