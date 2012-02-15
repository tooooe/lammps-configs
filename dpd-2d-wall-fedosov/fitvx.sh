#! /bin/bash

(gnuplot 2>&1 | awk '/grep_a/{print $2, $3}') <<EOF
file_hi="$1"
set macros
lim="$3"

set term dumb
f(x) = a*x + b
fit @lim f(x) file_hi u 1:4  via a, b
plot @lim \
     file_hi u 1:4 w lp, \
     f(x)

call "saver.gp" "$2"
print 'grep_a: ', a, b
EOF
