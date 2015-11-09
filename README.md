
# Hubot: Hubot-usernowplaying [![Build Status](https://travis-ci.org/thatarchguy/hubot-usernowplaying.svg)](https://travis-ci.org/thatarchguy/hubot-usernowplaying)

A hubot script to show what users are listening to.   
It can also handle an **optional** URL field.  

```
Klaw  > hubot nowplaying klaw
Hubot > Justin Beiber - Never say Never
        https://open.spotify.com/track/5GYbkDveRD2I8M5ZJ14hWn
```

## Installation
    npm install hubot-usernowplaying
    # Add "hubot-usernowplaying" to external-scripts.json

It works off of hubot-brain, but I believe that's default in Hubot now?

## Updating your now playing
Figure out a way to post "song=Justin Bieber - Never say Never" "url=https://open.spotify.com/track/5GYbkDveRD2I8M5ZJ14hWn"
```
curl --data "song=Justin Beiber - Never Say Never" --data "url=https://open.spotify.com/track/5GYbkDveRD2I8M5ZJ14hWn" http://[hubot-instance]:8080/hubot/nowplaying?user=klaw
```

I included a guide on how to get scripts to do this with Spotify on Linux and OSX
