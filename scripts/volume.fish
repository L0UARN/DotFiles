#!/bin/fish

set increment 5

if test $argv[1] = "i"
    set target0 "source"
    set target1 "SOURCE"
    set current (pactl get-source-volume @DEFAULT_SOURCE@ | grep -Eo "[0-9]{1,3}%" | head -1 | rev | cut -c 2- | rev)
else if test $argv[1] = "o"
    set target0 "sink"
    set target1 "SINK"
    set current (pactl get-sink-volume @DEFAULT_SINK@ | grep -Eo "[0-9]{1,3}%" | head -1 | rev | cut -c 2- | rev)
else
    exit
end

if test $argv[2] = "+"
    set command "volume"
    if test (echo "$current + $increment" | bc) -gt 100
        set modifier "100%"
    else
        set modifier "+$increment%"
    end
else if test $argv[2] = "-"
    set command "volume"
    set modifier "-$increment%"
else if test $argv[2] = "m"
    set command "mute"
    set modifier "toggle"
else
    exit
end

eval "pactl set-$target0-$command @DEFAULT_$target1@ $modifier"