
# Hubot: Hubot-usernowplaying [![Build Status](https://travis-ci.org/thatarchguy/hubot-usernowplaying.svg)](https://travis-ci.org/thatarchguy/hubot-usernowplaying)

A hubot script to show what users are listening to.

```
Klaw  > hubot nowplaying klaw
Hubot > Justin Beiber - Never say Never
```

## Installation
    npm install hubot-usernowplaying
    # Add "hubot-usernowplaying" to external-scripts.json

It works off of hubot-brain, but I believe that's default in Hubot now?

## Updating your now playing
Figure out a way to post "song=Justin Bieber - Never say Never" 
```
curl --data "song=Justin Beiber - Never Say Never" http://[hubot-instance]:8080/hubot/nowplaying?user=klaw
```

I included a guide on how to get scripts to do this with spotify on linux
