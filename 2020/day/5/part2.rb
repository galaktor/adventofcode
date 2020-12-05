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

seats = []
File.readlines(ARGV[0]).map(&:strip).map do |l|
  row, col = l.slice!(0..6), l
  seats << find_row(row)*8+find_col(col)
end

my_seat = 0
seats.sort.each_cons(3) do |a, b, c|
  my_seat = a+1 unless a+1 == b
end

puts my_seat
