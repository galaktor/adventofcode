#!/usr/bin/env bash

INTCODE="input-test.txt"

PHASES=$1

P1="${PHASES:0:1}"
P2="${PHASES:1:1}"
P3="${PHASES:2:1}"
P4="${PHASES:3:1}"
P5="${PHASES:4:1}"

FIFODIR=$(mktemp -d)
AMP1="$FIFODIR/amp1.in"
AMP2="$FIFODIR/amp2.in"
AMP3="$FIFODIR/amp3.in"
AMP4="$FIFODIR/amp4.in"
AMP5="$FIFODIR/amp5.in"

mkfifo $AMP1
mkfifo $AMP2
mkfifo $AMP3
mkfifo $AMP4
mkfifo $AMP5

while read line <$AMP1; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee $AMP2 &
while read line <$AMP2; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee $AMP3 &
while read line <$AMP3; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee $AMP4 &
while read line <$AMP4; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee $AMP5 &
while read line <$AMP5; do echo $line; done | ./compute.rb $INTCODE | grep --line-buffered -v ">" | tee $AMP1 &

echo $P1 >> $AMP1
echo $P2 >> $AMP2
echo $P3 >> $AMP3
echo $P4 >> $AMP4
echo $P5 >> $AMP5

echo 0 >> $AMP1

wait

rm -rf $FIFODIR
