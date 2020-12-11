#!/usr/bin/env ruby

def step(before)
  after = Array.new(before.length){ |i| [] }
  before.each_with_index do |row, i|
    row.each_with_index do |column, j|
      check = []
      if (i-1).between?(0, before.length-1)
        check << before[i-1][j-1] if (j-1).between?(0,row.length-1)
        check << before[i-1][j] if j.between?(0,row.length-1)
        check << before[i-1][j+1] if (j+1).between?(0,row.length-1)
      end
      check << before[i][j-1] if (j-1).between?(0,row.length-1)
      check << before[i][j+1] if (j+1).between?(0,row.length-1)
      if (i+1).between?(0, before.length-1)
        check << before[i+1][j-1] if (j-1).between?(0,row.length-1)
        check << before[i+1][j] if j.between?(0,row.length-1)
        check << before[i+1][j+1] if (j+1).between?(0,row.length-1)
      end
      case before[i][j]
      when "."
        after[i][j] = "."
      when "L"
        after[i][j] = check.any?{ |s| s == "#" } ? "L" : "#"
      when "#"
        after[i][j] = check.count{ |s| s == "#" } >= 4 ? "L" : "#"
      end
    end
  end
  after
end

state = File.readlines(ARGV[0]).map(&:strip).map{ |l| l.split("") }
loop do
  after = step(state)
  break if after == state
  state = after
end
puts state.flatten.count("#")
