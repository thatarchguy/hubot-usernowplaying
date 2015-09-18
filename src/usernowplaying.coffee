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
    song = robot.brain.get("#{user}_nowplaying")
    res.status(202).send("#{song}").end()
    return

  robot.respond /nowplaying (.*)/, (msg) ->
    user = msg.match[1].trim()
    song = robot.brain.get("#{user}_nowplaying") or 0
    if song == 0
      song = "Justin Bieber - Never say Never"
    msg.send song
