#!/usr/bin/env sh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR=HDMI-0 polybar coding &
MONITOR=DP-0 polybar coding2 &

echo "bars launched..."

# To run the same polybar on all monitors without knowing which monitors will
# be connected:
#
#if type "xrandr"; then
#  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload example &
#  done
#else
#  polybar --reload example &
#fi
