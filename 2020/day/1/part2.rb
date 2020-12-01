#!/usr/bin/env ruby

numbers = File.readlines(ARGV[0]).map{ |l| l.chomp.to_i }
numbers.each do |n|
  numbers.each do |m|
    numbers.each do |o|
      next unless n+m+o == 2020
      puts n*m*o
      exit
    end
  end
end
