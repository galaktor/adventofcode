
#!/usr/bin/env bash

echo -e {5..9}{5..9}{5..9}{5..9}{5..9}"\n" | grep 5 | grep 6 | grep 7 | grep 8 | grep 9 | xargs -n1 ./amp.sh | tee thrusters.out
sort -n thrusters.out | tail -n1
