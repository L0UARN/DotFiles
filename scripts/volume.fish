#!/bin/fish

if test $argv[1] = "i"
    set volume (pactl get-source-volume @DEFAULT_SOURCE@ | egrep -o "[0-9]{1,3}%" | head -1 | rev | cut -c 2- | rev)
    echo $volume
    if test $argv[2] = "+"
        if test $volume -lt 96
            exec pactl set-source-volume @DEFAULT_SOURCE@ +5%
        else
            exec pactl set-source-volume @DEFAULT_SOURCE@ 100%
        end
    else if test $argv[2] = "-"
        exec pactl set-source-volume @DEFAULT_SOURCE@ -5%
    else if test $argv[2] = "m"
        exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
    end
else if test $argv[1] = "o"
    set volume (pactl get-sink-volume @DEFAULT_SINK@ | egrep -o "[0-9]{1,3}%" | head -1 | rev | cut -c 2- | rev)
    echo $volume
    if test $argv[2] = "+"
        if test $volume -lt 96
            exec pactl set-sink-volume @DEFAULT_SINK@ +5%
        else
            exec pactl set-sink-volume @DEFAULT_SINK@ 100%
        end
    else if test $argv[2] = "-"
        exec pactl set-sink-volume @DEFAULT_SINK@ -5%
    else if test $argv[2] = "m"
        exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    end
end
