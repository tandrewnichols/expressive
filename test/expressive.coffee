describe 'expressive', ->
  Given -> @app =
    use: sinon.stub()
  Given -> @subject = require '../lib/expressive'

  describe 'no env list', ->
    context 'use is a function', ->
      When -> @subject @app
      Then -> expect(@app.development.use).to.be.a 'function'

    context '[env].use calls main use', ->
      Given -> @env = process.env.NODE_ENV
      afterEach -> process.env.NODE_ENV = @env
      Given -> process.env.NODE_ENV = 'development'
      When -> @subject @app
      And -> @app.development.use 'foo', 'bar'
      Then -> expect(@app.use).to.have.been.calledWith 'foo', 'bar'

    context 'not the right env', ->
      Given -> @env = process.env.NODE_ENV
      afterEach -> process.env.NODE_ENV = @env
      Given -> process.env.NODE_ENV = 'banana'
      When -> @subject @app
      And -> @app.development.use 'foo', 'bar'
      Then -> expect(@app.use.called).to.be.false()

  describe 'with env list', ->
    context 'use is a function', ->
      When -> @subject @app, { envs: ['dev', 'test'] }
      Then -> expect(@app.dev.use).to.be.a 'function'
      And -> expect(@app.test.use).to.be.a 'function'

    context '[env].use calls main use', ->
      Given -> @env = process.env.NODE_ENV
      afterEach -> process.env.NODE_ENV = @env
      Given -> process.env.NODE_ENV = 'dev'
      When -> @subject @app, { envs: ['dev', 'test'] }
      And -> @app.dev.use 'foo', 'bar'
      Then -> expect(@app.use).to.have.been.calledWith 'foo', 'bar'

    context 'not the right env', ->
      Given -> @env = process.env.NODE_ENV
      afterEach -> process.env.NODE_ENV = @env
      Given -> process.env.NODE_ENV = 'banana'
      When -> @subject @app, { envs: ['dev', 'test'] }
      And -> @app.dev.use 'foo', 'bar'
      Then -> expect(@app.use.called).to.be.false()

  describe 'with env', ->
    context 'use is a function', ->
      When -> @subject @app, { env: 'development' }
      Then -> expect(@app.development.use).to.be.a 'function'

    context '[env].use calls main use', ->
      When -> @subject @app, { env: 'development' }
      And -> @app.development.use 'foo', 'bar'
      Then -> expect(@app.use).to.have.been.calledWith 'foo', 'bar'

    context 'not the right env', ->
      When -> @subject @app, { env: 'banana' }
      And -> @app.development.use 'foo', 'bar'
      Then -> expect(@app.use.called).to.be.false()

  describe 'with aliass', ->
    context 'use is a function', ->
      When -> @subject @app,
        envs: ['development', 'testing']
        alias:
          development: 'dev'
          testing: 'test'
      Then -> expect(@app.dev.use).to.be.a 'function'

    context '[env].use calls main use', ->
      When -> @subject @app,
        env: 'development'
        envs: ['development', 'testing']
        alias:
          development: 'dev'
          testing: 'test'
      And -> @app.dev.use 'foo', 'bar'
      Then -> expect(@app.use).to.have.been.calledWith 'foo', 'bar'

    context 'not the right env', ->
      When -> @subject @app,
        env: 'banana'
        envs: ['development', 'testing']
        alias:
          development: 'dev'
          testing: 'test'
      And -> @app.dev.use 'foo', 'bar'
      Then -> expect(@app.use.called).to.be.false()
