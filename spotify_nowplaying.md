## Send Spotify's nowplaying to api route


nowplaying.sh
```
#!/bin/bash
# This script will print nowplaying from spotify
# requires dbus session stuff for cron to work
# This works on arch, mil
dbus_session_file=~/.dbus/session-bus/$(cat /var/lib/dbus/machine-id)-0
if [ -e "$dbus_session_file" ]
then
        . "$dbus_session_file"
        [ $? == 0 ] || ((allan++))
        export DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_PID
        export DISPLAY=:0
else
        error "could not do anything with  $dbus_session_file."
fi
echo `dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$` "-" `dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
```


nowplaying-shipit.sh
```
#!/bin/bash
# This script will send nowplaying.sh output to somewhere (hubot-usernowplaying)
#!/bin/bash
PLAYING=$(/usr/bin/nowplaying.sh)
curl --data "song=$PLAYING" http://[hubot-instance]:8080/hubot/nowplaying?user=klaw
```

cronjob:
```
*/2 * * * * /usr/bin/nowplaying.sh
```
