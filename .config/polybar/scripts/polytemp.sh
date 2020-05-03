#!/bin/sh

temp=$(acpi -t | grep "Thermal 1" | sed 's/.*, //;s/ degrees //;s/C//')

if [ 1 -eq "$(echo "$temp > 85" | bc)" ]; then
	echo %{F#dd3533}%{u#dd3533}  "$temp"°C%{F- u-}
elif [ 1 -eq "$(echo "$temp > 75" | bc)" ]; then
	echo %{F#ff5C21}%{u#ff5C21}  "$temp"°C%{F- u-}
else
	echo   "$temp"°C
fi
