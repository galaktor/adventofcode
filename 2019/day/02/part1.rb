#!/usr/bin/env ruby

@input = File.read(ARGV[0]).split(",").map(&:to_i)

def add(p1, p2)
  @input[p1] + @input[p2]
end

def mult(p1, p2)
  @input[p1] * @input[p2]
end

def halt
  puts @input.first
  exit 0
end

def process(op, p1, p2, dest)
  case op
  when 1
    @input[dest] = add(p1, p2)
  when 2
    @input[dest] = mult(p1, p2)
  when 99
    halt
  else
    raise "unknown operation"
  end
end


i = 0

@input[1] = ARGV[1]&.to_i || 12
@input[2] = ARGV[2]&.to_i || 2

while i < @input.length
  process(@input[i], @input[i+1], @input[i+2], @input[i+3])
  i += 4
end
