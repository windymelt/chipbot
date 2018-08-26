module.exports = (robot) ->
  robot.hear /(.*)/i, (msg) ->
    keyword = msg.match[1]
    sender = msg.message.user.name
    request = msg.http('http://core:5000/api/hear')
                          .header('accept', 'application/json')
                          .query(q: keyword, sender: sender)
                          .get()
    request (err, res, body) ->
      json = JSON.parse body
      msg.send json.answer if res.statusCode == 200 && json.answer != null
