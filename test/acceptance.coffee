express = require 'express'
request = require 'supertest'

describe 'acceptance', ->
  Given -> @expressive = require '../lib/expressive'
  Given -> @app = express()
  Given -> @route = (req, res, next) =>
    res.status(200).end()
  Given -> sinon.spy @, 'route'
  describe 'no env list', ->
    Given -> process.env.NODE_ENV = 'development'
    Given -> @expressive @app
    Given -> @app.development.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called

  describe 'with env list', ->
    Given -> process.env.NODE_ENV = 'dev'
    Given -> @expressive @app,
      envs: [ 'dev', 'test' ]
    Given -> @app.dev.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called

  describe 'with env', ->
    Given -> @expressive @app,
      env: 'dev'
      envs: ['dev', 'test']
    Given -> @app.dev.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called

  describe 'with aliass', ->
    Given -> @expressive @app,
      env: 'development'
      envs: ['development', 'test']
      alias:
        development: 'dev'
    Given -> @app.dev.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called

  describe '2nd arg is an array', ->
    Given -> process.env.NODE_ENV = 'development'
    Given -> @expressive @app, ['development', 'test']
    Given -> @app.development.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called

  describe 'envs is string', ->
    Given -> process.env.NODE_ENV = 'development'
    Given -> @expressive @app, 'development'
    Given -> @app.development.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called

  describe 'envs is string in opts', ->
    Given -> process.env.NODE_ENV = 'development'
    Given -> @expressive @app,
      envs: 'development'
    Given -> @app.development.use '/foo', @route
    When (done) -> request(@app).get('/foo').end (err, res, body) -> done()
    Then -> expect(@route).to.be.have.been.called
