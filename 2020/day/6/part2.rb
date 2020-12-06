#!/usr/bin/env ruby

groups = []
current = []
File.readlines(ARGV[0]).map(&:strip).map do |l|
  current << l.split("") unless l == ""
  if l == ""
    groups << current.reduce(&:&)
    current = []
  end
end
groups << current.reduce(&:&)

puts groups.sum{ |g| g.length }
