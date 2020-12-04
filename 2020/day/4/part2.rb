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
  (p.keys.count == 7 && !p.key?("cid")) || p.keys.count == 8
end

valid = valid.select do |p|
  (p["byr"].to_i.between?(1920,2002)) &&
    (p["iyr"].to_i.between?(2010,2020)) &&
    (p["eyr"].to_i.between?(2020,2030)) &&
    ((p["hgt"].end_with?("cm") && p["hgt"][0..2].to_i.between?(150,193)) || (p["hgt"].end_with?("in") && p["hgt"][0..1].to_i.between?(59,76))) &&
    (p["hcl"].length == 7 && p["hcl"] =~ /#[0-9a-f]{6}/) &&
    (["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(p["ecl"])) &&
    (p["pid"].length == 9 && p["pid"] =~ /[0-9]{9}/)
end

puts valid.length
