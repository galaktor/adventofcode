#!/usr/bin/env bash

INTCODE="input-test.txt"

PHASES=$1

P1="${PHASES:0:1}"
P2="${PHASES:1:1}"
P3="${PHASES:2:1}"
P4="${PHASES:3:1}"
P5="${PHASES:4:1}"

echo "deleting fifos"
rm *.in

echo "making fifos"
mkfifo amp1.in
mkfifo amp2.in
mkfifo amp3.in
mkfifo amp4.in
mkfifo amp5.in

echo "starting amps"
while read line <amp1.in; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee amp2.in &
while read line <amp2.in; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee amp3.in &
while read line <amp3.in; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee amp4.in &
while read line <amp4.in; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee amp5.in &
while read line <amp5.in; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee amp1.in &

echo "configuring amps"
echo $P1 >> amp1.in
echo $P2 >> amp2.in
echo $P3 >> amp3.in
echo $P4 >> amp4.in
echo $P5 >> amp5.in

echo "starting pipeline"
echo 0 >> amp1.in

echo "waiting"
wait
