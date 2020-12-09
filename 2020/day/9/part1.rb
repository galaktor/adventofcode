#!/usr/bin/env ruby

plen = ARGV[1].to_i
File.readlines(ARGV[0]).map(&:strip).map(&:to_i).each_cons(plen+1) do |range|
  n = range.last
  range = range.take(plen)
  unless range.combination(2).any?{ |pair| pair.sum == n }
    puts n
    break
  end
end
