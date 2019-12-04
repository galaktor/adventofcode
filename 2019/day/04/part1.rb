#!/usr/bin/env ruby

start, finish = File.read(ARGV[0]).split("-").map(&:to_i)

def checkseq(digits)
  dupes = false
  digits.each_with_index do |d, i|
    next if i == 0
    dupes = true if digits[i-1] == d
    return false if digits[i-1] < d
  end
  dupes
end

puts (start..finish).map(&:digits).count{ |n| n.length == 6 && checkseq(n) }
