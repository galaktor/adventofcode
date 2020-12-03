#!/usr/bin/env bash

a=$(./part2.rb input.txt 1 1)
b=$(./part2.rb input.txt 3 1)
c=$(./part2.rb input.txt 5 1)
d=$(./part2.rb input.txt 7 1)
e=$(./part2.rb input.txt 1 2)
echo $((a*b*c*d*e))
