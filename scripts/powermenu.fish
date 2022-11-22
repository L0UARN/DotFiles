set choice (echo " Lock
 Reboot
⏻ Shutdown" | wofi -c /home/louarn/.config/scripts/powermenu)

switch $choice
    case " Lock"
        exec swaylock
    case " Reboot"
        exec systemctl reboot
    case "⏻ Shutdown"
        exec systemctl poweroff
end