#!/usr/bin/env ruby

start, finish = File.read(ARGV[0]).split("-").map(&:to_i)

def checkseq(digits)
  pairs = []
  digits.each_with_index do |d, i|
    next if i == 0
    pairs << d if digits[i-1] == d
    pairs.delete(d) if i > 1 && digits[i-2] == d
    return false if digits[i-1] < d
  end
  pairs.count > 0
end

puts (start..finish).map(&:digits).count{ |n| n.length == 6 && checkseq(n) }
