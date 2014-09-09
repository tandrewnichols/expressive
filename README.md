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

app.development.use('/dev-only-route', function(req, res, next) {
  next();
});
```

When you call expressive and pass in an express app, it will add environment specific hooks that you can use to add routes only in certain environments. By default, it will use `['development']` as the environment list, but you can pass a list of environments as a second argument.
