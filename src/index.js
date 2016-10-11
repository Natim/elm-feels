// Babel & fetch polyfills
require('babel-polyfill')
require('whatwg-fetch/fetch')

// Setup global styles
require('./main.css')
require('../node_modules/bulma/css/bulma.css')
require('../node_modules/font-awesome/css/font-awesome.min.css')

// Client for featheres API
const feathersClient = require('./js/feathers-client')

// Bootstrap Elm app
const Elm = require('./Main.elm')
const root = document.getElementById('root')

Elm.Main.embed(root)
