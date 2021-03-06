# Description
#   A hubot script that does the things
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   naichilab <naichilab@live.jp>

module.exports = (robot) ->
  links = []

  robot.router.get '/hubot-homepage', (req,res) ->
    li = links.map (i) ->
      """
        <li><a href="#{i.url}" target="_blank">#{i.text}</a></li>
      """
    .join '\n'
    html = """
      <html>
      <head><title>Links</title></head>
      <body>
        <h1>Links</h1>
        <ul>
        #{li}
        </ul>
      </body>
      </html>
    """
    res.type 'html'
    res.send html

  robot.respond /homepage li?st?/, (msg) ->
    msg.send links.map((i, index) -> "[#{index}] #{i.text} #{i.url}").join('\n')

  robot.respond /homepage add (.+) (https?:\/\/.+)/, (msg) ->
    text = msg.match[1]
    url = msg.match[2]
    item = { text, url }
    links.push item
    msg.send "added #{item.text} #{item.url}"

  robot.respond /homepage re?m(?:ove)? (\d+)/, (msg) ->
    index = msg.match[1]
    item = links.splice(index, 1)[0]
    msg.send "removed #{item.text} #{item.url}" if item?
