#!/usr/bin/env bash

while true; do echo 0; done | ./compute.rb input-hacked.txt | grep --line-buffered -v ">" | ./part2.rb 44 26
