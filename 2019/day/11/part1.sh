#!/usr/bin/env bash

mkfifo colours
while read line <colours; do echo $line; done | ./compute.rb input.txt | grep --line-buffered -v ">" | ./part1.rb 0 0 | tee colours &
echo "0" >> colours
