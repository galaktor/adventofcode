#!/usr/bin/env bash

INTCODE="input-test.txt"
PHASES=$1

P1="${PHASES:0:1}"
P2="${PHASES:1:1}"
P3="${PHASES:2:1}"
P4="${PHASES:3:1}"
P5="${PHASES:4:1}"

echo -e  "$P1\n0"                  | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$P2" '{print p "\n" $0}' | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$P3" '{print p "\n" $0}' | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$P4" '{print p "\n" $0}' | ./compute.rb $INTCODE | tail -n1 | \
awk -v p="$P5" '{print p "\n" $0}' | ./compute.rb $INTCODE | tail -n1
