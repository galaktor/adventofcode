#!/usr/bin/env bash

echo -e {0..99}" "{0..99}"\n" | xargs -I{} -L1 -P16 bash -c 'if [[ $(./part1.rb input.txt {}) -eq "19690720" ]]; then echo {}; fi'
