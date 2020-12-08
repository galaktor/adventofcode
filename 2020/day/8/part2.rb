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

def toggle(i)
  case @input[i][0]
  when "jmp"
    puts "hacking #{i}: jmp->nop"
    @input[i][0] = "nop"
  when "nop"
    puts "hacking #{i}: nop->jmp"
    @input[i][0] = "jmp"
  end
end

@acc = 0
@inst = 0
@history = []

@i = 0

@hacks = []
@input.each_with_index{ |e,i| @hacks << i if  %w[jmp nop].include?(e[0]) }

@bug = false
@hacks.each do |hack|
  toggle(hack)

  while @i < @input.length
    if @history.include?(@i)
      puts "loop detected. already ran this instruction: #{@i}. acc: #{@acc}"
      @bug = true
      break
    end
    @history << @i
    @i = process(@i, @input[@i][0], @input[@i][1])
  end

  unless @bug
    puts "program completed. bug at line #{hack}. final acc: #{@acc}"
    exit
  end

  toggle(hack)
  @history = []
  @i = 0
  @bug = false
  @acc = 0
end
