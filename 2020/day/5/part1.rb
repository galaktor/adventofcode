#!/usr/bin/env ruby

def find_row(code)
  rows = (0..127)
  code.split("").each do |c|
    rows = rows.take(rows.count/2) if c == "F"
    rows = rows.drop(rows.count/2) if c == "B"
  end
  rows.first.to_i
end

def find_col(code)
  cols = (0..7)
  code.split("").each do |c|
    cols = cols.take(cols.count/2) if c == "L"
    cols = cols.drop(cols.count/2) if c == "R"
  end
  cols.first.to_i
end

max = 0
File.readlines(ARGV[0]).map(&:strip).map do |l|
  row, col = l.slice!(0..6), l
  seat = find_row(row)*8+find_col(col)
  max = seat if seat > max
end

puts max
