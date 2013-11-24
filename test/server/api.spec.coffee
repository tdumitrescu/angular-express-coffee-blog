'use strict'

path    = require 'path'
request = require 'request'
expect  = require 'expect.js'

serverPath = path.join(__dirname, '..', '..', 'server')
server     = require "#{serverPath}/server"
models     = require "#{serverPath}/models"
posts      = models.posts
PORT       = 3434
API_BASE   = "http://localhost:#{PORT}/api"

before (done) ->
  server.startServer PORT
  done()

describe "server API", ->
  describe "GET /posts", ->
    getPosts = (callback) -> request "#{API_BASE}/posts", callback

    it "returns data for all posts", (done) ->
      getPosts (error, response, body) ->
        expect(JSON.parse(body).posts).to.have.length(posts.length)
        done()

    it "creates an ID for each post", (done) ->
      getPosts (error, response, body) ->
        expect(JSON.parse(body).posts[0].id).to.eql(0)
        done()

    it "includes the title of each post", (done) ->
      getPosts (error, response, body) ->
        expect(JSON.parse(body).posts[0].title).to.eql(posts[0].title)
        done()

  describe "POST /post", ->
    postData = {title: 'bla', text: 'blablabla'}
    postPost = (callback) -> request.post "#{API_BASE}/post", form: postData, callback

    it "creates a new post", (done) ->
      postLengthBefore = posts.length
      postPost (error, response, body) ->
        expect(posts).to.have.length(postLengthBefore + 1)
        done()

    it "assigns the correct post data", (done) ->
      newPostIndex = posts.length
      postPost (error, response, body) ->
        expect(posts[newPostIndex].title).to.eql(postData.title)
        expect(posts[newPostIndex].text).to.eql(postData.text)
        done()
