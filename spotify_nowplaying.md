## Send Spotify's nowplaying to api route


### Linux (Arch tested)
nowplaying.sh
```
#!/bin/bash
# This script will print and send nowplaying from spotify
# requires dbus session stuff for cron to work
# This works on arch, mil
#!/bin/bash
dbus_session_file=~/.dbus/session-bus/$(cat /var/lib/dbus/machine-id)-0
if [ -e "$dbus_session_file" ]
then
        . "$dbus_session_file"
        [ $? == 0 ] || ((allan++))
        export DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_PID
        export DISPLAY=:0
else
        error "could not do anything with $dbus_session_file."
fi
PLAYING="$( bash <<EOF
echo `dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$` "-" `dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
EOF
)"
URL=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "url"| egrep -v "url"| cut -b 44-|cut -d '"' -f1`
echo "$PLAYING"
echo "$URL"
curl --data "song=$PLAYING" --data "url=$URL" http://[hubot-instance]:8080/hubot/nowplaying?user=klaw
```

cronjob:
```
*/2 * * * * /usr/bin/nowplaying.sh
```


### OSX (Yosemite 10.10.5 tested)
thanks @samuelchristian for hooking this up.  
applescript
```
-- Main flow
postToHubotTrack()

-- Method to get the currently playing track
on postToHubotTrack()
    tell application "Spotify"
        set currentArtist to artist of current track as string
        set currentTrack to name of current track as string
        set currentUrl to spotify url of current track as string

        do shell script "curl --data song='" & currentArtist & " - " & currentTrack & "' --data url='" & currentUrl & "' http://[hubot-instance]:8080/hubot/nowplaying?user=schristian"
    end tell
end postToHubotTrack

```

cronjob:
```
*/2 * * * * /usr/bin/osascript /usr/bin/spotify-now-playing.scpt > /dev/null 2>&1
```
