#!/bin/sh
set -eu

Xvfb :99 -screen 0 800x600x24 -nolisten tcp &
for attempt in 1 2 3 4 5 6 7 8 9 10; do
    if [ -S /tmp/.X11-unix/X99 ]; then
        break
    fi
    sleep 1
done
if [ ! -S /tmp/.X11-unix/X99 ]; then
    echo "virt display did not startup (ask babaoboa)." >&2
    exit 1
fi

openbox >/tmp/openbox.log 2>&1 &
x11vnc -display :99 -localhost -forever -shared -nopw -rfbport 5900 -quiet >/tmp/x11vnc.log 2>&1 &
websockify --web=/usr/share/novnc 0.0.0.0:6080 localhost:5900 >/tmp/websockify.log 2>&1 &

mkdir -p /work
cp -a /input/. /work/
cd /work
rm -rf bin .d .cache
make CXX_STANDARD=gnu++2c C_STANDARD=gnu23

echo "ya sim is here: http://localhost:6080/vnc.html?autoconnect=true"
exec /opt/simulator/client-cli \
    --kernel /opt/simulator/kernel \
    --pros=hot-cold \
    --program /work

