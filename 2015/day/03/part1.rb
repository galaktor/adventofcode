#!/usr/bin/env ruby

houses = [[0,0]]
x,y = 0,0
File.read(ARGV[0]).chomp.split("").each do |d|
  case d
  when "^"
    y += 1
  when "v"
    y -= 1
  when ">"
    x += 1
  when "<"
    x -= 1
  end
  houses << [x,y]
end
puts houses.uniq.count
