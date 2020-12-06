#!/usr/bin/env ruby

groups = []
current = []
File.readlines(ARGV[0]).map(&:strip).map do |l|
  current += l.split("")
  if l == ""
    groups << current.uniq
    current = []
  end
end
groups << current.uniq

puts groups.sum{ |g| g.length }
