#!/bin/bash

rofi_command="rofi -theme powermenu.rasi"


power_off=""
reboot=""
lock=""
suspend=""
log_out=""

options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
	$power_off)
		systemctl poweroff
		;;
	$reboot)
		systemctl reboot
		;;
	$lock)
		~/.config/i3lock.sh
		;;
	$suspend)
		systemctl suspend
		;;
	$log_out)
		i3-msg exit
		;;
esac
