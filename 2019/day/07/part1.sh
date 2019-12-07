#!/usr/bin/env bash

echo -e {0..4}{0..4}{0..4}{0..4}{0..4}"\n" | grep 0 | grep 1 | grep 2 | grep 3 | grep 4 | xargs -n1 -P16 ./amp.sh | sort -n | tail -n1
