#!/usr/bin/env ruby

require 'readline'

@input = File.read(ARGV[0]).split(",").map(&:to_i)

def add(p1, p2)
  @input[p1] + @input[p2]
end

def mult(p1, p2)
  @input[p1] * @input[p2]
end

def read
  Readline::readline("> ", false).to_i
end

def halt
  puts @input.first
  exit 0
end

def process(op, p1, p2, dest)
  case op
  when 1
    @input[dest] = add(p1, p2)
    return 4
  when 2
    @input[dest] = mult(p1, p2)
    return 4
  when 3
    @input[dest] = read
    return 2
  when 4
    puts @input[p1]
    return 2
  when 99
    halt
  else
    raise "unknown operation"
  end
end


i = 0

while i < @input.length
  i += process(@input[i], @input[i+1], @input[i+2], @input[i+3])
end
