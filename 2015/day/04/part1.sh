#!/usr/bin/env bash

seq -f "%06g" 1 999999 | xargs -I '{}' -n1 -P8 bash -c 'if md5 -qs yzbqklnj{} | grep -q ^00000; then echo {}; fi'
