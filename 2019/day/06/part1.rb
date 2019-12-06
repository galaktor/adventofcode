#!/usr/bin/env ruby

orbits =  File.readlines(ARGV[0]).map{ |l| l.chomp.split(")").reverse }.to_h

total = 0
orbits.values.each do |center|
  while true
	total += 1
	satellite = orbits[center]
    break if satellite.nil?
	center = satellite
  end
end
puts total
