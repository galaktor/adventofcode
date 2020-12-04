#!/usr/bin/env ruby

passports = [{}]
File.readlines(ARGV[0]).each do |line|
  if line.strip == ""
    passports << {}
    next
  end
  line.strip.split(" ").map{ |d| d.split(":") }.each{ |d| passports.last[d[0]] = d[1] }
end

valid = passports.select do |p|
  (p.keys.count == 7 && !p.key?("cid")) || (other = p.keys.count == 8)
end

puts valid.length
