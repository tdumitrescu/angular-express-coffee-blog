'use strict'

path    = require 'path'
request = require 'request'
expect  = require 'expect.js'

serverPath = path.join(__dirname, '..', '..', 'server')
server     = require "#{serverPath}/server"
models     = require "#{serverPath}/models"
posts      = models.posts
PORT       = 3434

before (done) ->
  server.startServer PORT
  done()

describe "server API", ->
  describe "GET /posts", ->
    getPosts = (callback) -> request "http://localhost:#{PORT}/api/posts", callback

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
