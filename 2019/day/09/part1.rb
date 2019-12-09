#!/usr/bin/env ruby

require 'readline'

STDIN.sync = true
STDOUT.sync = true

@input = File.read(ARGV[0]).split(",").map(&:to_i) + Array.new(10000){ 0 }

def add(p1, p2)
  p1 + p2
end

def mult(p1, p2)
  p1 * p2
end

def read
  Readline::readline("> ", false).to_i
end

def print(p1)
  puts p1
end

def param(p, mode)
  case mode
  when 1
    p
  when 2
    @input[p+@base]
  else
    @input[p]
  end
end

def store(dest, mode, val)
  case mode
  when 1
    raise "illegal write"
  when 2
    @input[dest+@base] = val
  else
    @input[dest] = val
  end
end

def halt
  exit 0
end

def process(ptr, op, p1, p2, p3)
  pm = op.digits.drop(2) + Array.new(4){ 0 }
  op = op.digits.take(2).reverse.join.to_i
  case op
  when 1
    store(p3, pm[2], add(param(p1, pm[0]), param(p2, pm[1])))
    return ptr+4
  when 2
    store(p3, pm[2], mult(param(p1, pm[0]), param(p2, pm[1])))
    return ptr+4
  when 3
    store(p1, pm[0], read)
    return ptr+2
  when 4
    print(param(p1, pm[0]))
    return ptr+2
  when 5
    return (param(p1, pm[0]) != 0) ? param(p2, pm[1]) : ptr+3
  when 6
    return (param(p1, pm[0]) == 0) ? param(p2, pm[1]) : ptr+3
  when 7
    store(p3, pm[2], (param(p1, pm[0]) < param(p2, pm[1])) ? 1 : 0)
    return ptr+4
  when 8
    store(p3, pm[2], (param(p1, pm[0]) == param(p2, pm[1])) ? 1 : 0)
    return ptr+4
  when 9
    @base += param(p1, pm[0])
    return ptr+2
  when 99
    halt
  else
    raise "unknown operation: #{op}"
  end
end

@base = 0
i = 0
while i < @input.length
  i = process(i, @input[i], @input[i+1], @input[i+2], @input[i+3])
end
