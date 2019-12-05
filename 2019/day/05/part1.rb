#!/usr/bin/env ruby

require 'readline'
require 'pry'

@input = File.read(ARGV[0]).split(",").map(&:to_i)

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
  else
    @input[p]
  end
end

def halt
  exit 0
end

def process(op, p1, p2, dest)
  pm = op.digits.drop(2)
  op = op.digits.take(2).reverse.join.to_i
  case op
  when 1
    @input[dest] = add(param(p1, pm[0]), param(p2, pm[1]))
    return 4
  when 2
    @input[dest] = mult(param(p1, pm[0]), param(p2, pm[1]))
    return 4
  when 3
    @input[dest] = read
    return 2
  when 4
    print(param(p1, pm[0]))
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
