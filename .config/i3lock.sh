#!/bin/sh

B='#00000000'
P='#33dd56ff'
S='#23993aff'
E='#dd3533ff'

i3lock \
--insidevercolor=$B   \
--ringvercolor=$P     \
\
--insidewrongcolor=$B \
--ringwrongcolor=$E   \
\
--insidecolor=$B      \
--ringcolor=$P        \
--linecolor=$B        \
--separatorcolor=$P   \
\
--verifcolor=$P       \
--wrongcolor=$E       \
--timecolor=$P        \
--layoutcolor=$P      \
--keyhlcolor=$S       \
--bshlcolor=$S        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M"			\
--datestr=""					\

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
 --timefont=Roboto
# etc
