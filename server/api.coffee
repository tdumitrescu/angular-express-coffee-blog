# initialize our faux database
data =
  posts: [
    {
      title: "Lorem ipsum"
      text:  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    {
      title: "Sed egestas"
      text:  "Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus."
    }
  ]

# GET

exports.posts = (req, res) ->
  res.json posts: ({id: i, title: post.title, text: "#{post.text[0..50]}..."} for post, i in data.posts)

exports.post = (req, res) ->
  id = req.params.id
  res.json(
    if id >= 0 and id < data.posts.length
      post: data.posts[id]
    else
      false
  )
