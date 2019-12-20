#!/usr/bin/env ruby

Ingredient = Struct.new(:q, :m)
@reactions = File.readlines(ARGV[0]).map{ |l| l.strip.split("=>").map{ |t| t.split(",").map{ |i| Ingredient.new(*i.split(" ")) }.each{ |i| i.q = i.q.to_i }}}.inject({}){ |hash,r| hash[r[1].first.m] = r.flatten; hash }
@waste = {}

def ore(q, m)
  @waste[m] = 0 unless @waste.key?(m)
  r = @reactions[m]
  return q if r.nil?

  case @waste[m]
  when q..Float::INFINITY
    @waste[m] -= q
	return 0
  when 1..Float::INFINITY
    q -= @waste[m]
	@waste[m] = 0
	return ore(q, m)
  end

  batches = (q-1)/r.last.q+1
  @waste[m] += batches*r.last.q - q if batches*r.last.q-q > 0
  r.take(r.length-1).map{ |r| ore(r.q*batches, r.m) }.reduce(&:+)
end

puts ore(1, "FUEL")
