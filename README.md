[![Build Status](https://travis-ci.org/mantacode/expressive.png)](https://travis-ci.org/mantacode/expressive) [![downloads](http://img.shields.io/npm/dm/expressive.svg)](https://npmjs.org/package/expressive) [![npm](http://img.shields.io/npm/v/expressive.svg)](https://npmjs.org/package/expressive) [![Code Climate](https://codeclimate.com/github/mantacode/expressive/badges/gpa.svg)](https://codeclimate.com/github/mantacode/expressive) [![Test Coverage](https://codeclimate.com/github/mantacode/expressive/badges/coverage.svg)](https://codeclimate.com/github/mantacode/expressive) [![dependencies](https://david-dm.org/mantacode/expressive.png)](https://david-dm.org/mantacode/expressive)

[![NPM info](https://nodei.co/npm/expressive.png?downloads=true)](https://nodei.co/npm/expressive.png?downloads=true)

# Expressive

## Installation

`npm install --save expressive`

## Usage

```javascript
var expressive = require('expressive');
var express = require('express');
var app = express();
expressive(app);

app.use('/normal-route', function(req, res, next) {
  next();
});

app.development.get('/dev-only-route', function(req, res, next) {
  next();
});
```

When you call `expressive` and pass in an express app, it will add environment specific hooks that you can use for specific environments only. By default, it will use `['development']` as the environment list, but you can pass an array of environments as a second argument (or a single string if you only setting up one environment), or an options object (outlined below).

This is similar to wrapping `app` calls in checks against the environment, but I've found that this method makes an app easier to read because all the route definitions are parallel.

### With an array

```javascript
expressive(app, ['development', 'test']);
```

### With a string

```javascript
expressive(app, 'development');
```

### With Options

You can specify the following options to change the default behavior:

#### Envs

The aforementioned list of environments

```javascript
// "envs" can also be a string here
expressive(app, { envs: ['development', 'test'] });
```

#### Env

The current environment. Defaults to `process.env.NODE_ENV`.

```javascript
expressive(app, { env: nconf.get('NODE_ENV') });
```

Additionally, you can pass this env as a third parameter, which can help keep the syntax short.

```javascript
expressive(app, 'development', nconf.get('NODE_ENV'));
```

#### Alias

If `app.development.use` seems long, you can provide environment aliases to shorten it.

```javascript
expressive(app, { alias: { development: 'dev' } });
```

Then you can just use

```javascript
app.dev.use(/*args*/);
```
