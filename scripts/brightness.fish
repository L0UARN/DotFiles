#!/bin/fish

set current $(brightnessctl | egrep -o '[0-9]{1,3}%' | rev | cut -c 2- | rev)

if test $argv[1] = "+" || test $argv[1] = "-"
    set new $(expr $current $argv[1] 5)
    exec brightnessctl -q s {$new}%
end