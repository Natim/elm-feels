require('./main.css');
require('../node_modules/bulma/css/bulma.css');
require('../node_modules/font-awesome/css/font-awesome.min.css');

var Elm = require('./Main.elm');

var root  = document.getElementById('root');

Elm.Main.embed(root);
