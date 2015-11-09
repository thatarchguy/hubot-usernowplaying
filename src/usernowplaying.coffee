# See what people are listening to in chat
#
# Configuration:
#   None
#
# Commands:
#   hubot nowplaying "user" - Show what they are listening to
#
# URLS:
#   POST /<robot-name>/nowplaying?user=<user>
#
# Authors:
#   Kevin L <kevin@stealsyour.pw>

songs = [
  "Shakira - Hips Don't Lie",
  "R. Kelly - Trapped in the Closet",
  "Spice Girls - Wannabe",
  "Backstreet Boys - I Want It That Way"
]


module.exports = (robot) ->
  robot.router.post "/hubot/nowplaying", (req, res) ->
    user = req.query.user

    unless user?
      res.status(400).send("Bad Request").end()
      return

    console.log req.query.user
    console.log req.body

    data = req.body

    robot.brain.set "#{user}_nowplaying", data.song
    if (data.url?)
      robot.brain.set "#{user}_nowplaying_url", data.url
    song = robot.brain.get("#{user}_nowplaying")
    res.status(202).send("#{song}").end()
    return

  robot.respond /nowplaying (.*)/, (msg) ->
    user = msg.match[1].trim()
    song = robot.brain.get("#{user}_nowplaying") or 0
    url = robot.brain.get("#{user}_nowplaying_url") or 0
    if song == 0
      song = msg.random songs
    msg.send song
    if url != 0
      msg.send url
