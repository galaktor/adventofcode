#!/usr/bin/env ruby

@adapters = [0] + File.readlines(ARGV[0]).map(&:strip).map(&:to_i).sort
@adapters << @adapters.max+3

counts = [0]*@adapters.size

def children(val)
  @adapters.each_index.select { |idx| val < @adapters[idx] && @adapters[idx] <= val+3 }
end

(@adapters.size-1).downto(0) do |i|
  c = children(@adapters[i])
  counts[i] = [1, counts.values_at(*c).sum].max
end

puts counts.values_at(*children(0)).sum
