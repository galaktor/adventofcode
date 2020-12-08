#!/usr/bin/env ruby

@input = File.readlines(ARGV[0]).map(&:strip).map{ |i| i.split(" ") }

def process(ptr, op, p1)
  case op
  when "nop"
    return ptr+1
  when "acc"
    @acc += p1.to_i
    return ptr+1
  when "jmp"
    return ptr + p1.to_i
  end
end

@acc = 0
@inst = 0
@history = []

i = 0
while i < @input.length
  if @history.include?(i)
    puts "already ran this instruction: #{i}. acc: #{@acc}"
    break
  end
  @history << i
  i = process(i, @input[i][0], @input[i][1])
end
