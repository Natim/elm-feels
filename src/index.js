require('./main.css');
require('../node_modules/bulma/css/bulma.css');
require('../node_modules/font-awesome/css/font-awesome.min.css');
require('../node_modules/flatpickr/dist/flatpickr.airbnb.min.css');

var flatpickr = require('../node_modules/flatpickr/dist/flatpickr.js');

var Elm = require('./Main.elm');

var root  = document.getElementById('root');
var app = Elm.Main.embed(root);

app.ports.onTestLol.subscribe(function(id) {
    var picker = document.getElementById(id).flatpickr({
        onChange: function(dateObj, dateStr, instance) {
            app.ports.foobar.send(dateStr)
        }
    })
    picker.toggle()
});
