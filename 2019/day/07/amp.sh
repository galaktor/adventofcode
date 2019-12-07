#!/usr/bin/env bash

INTCODE="input-test.txt"

echo -e "$1\n0"                     | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$2" '{print p "\n" $0}'   | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$3" '{print p "\n" $0}'   | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$4" '{print p "\n" $0}'   | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$5" '{print p "\n" $0}'   | ./compute.rb $INTCODE | tail -n1
