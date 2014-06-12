var express = require('express');
var http = require('http');
var fs = require('fs');
var exec = require('child_process').exec;

var config = require('./config.js').config;

var app = express();
app.configure(function () {
	app.set('views', __dirname + '/views');
	app.set('view engine', 'jade');
	app.locals.pretty = true;

	app.use(express.bodyParser());
	app.use(express.methodOverride());
	app.use(app.router);
	app.use(express.static(__dirname + '/static'));
});

var server = require('http').createServer(app);
server.listen(process.env.PORT || 8001, function() {
	console.log('Listening on port ' + server.address().port);
});

app.get('/', function(req, res) {
	res.render('index', { config: config });
});

app.get('/screens/:id', function(req, res) {
	var id = req.params.id;

	getScreen(res, id, function(data) {
		res.send(data);
	});
});

function getScreen(res, id, cb) {
	var cmd = config.screens[id].cmd;
	var child = exec(cmd, function (error, stdout, stderr) {
		if (error) {
			console.log("err while reading:")
			console.log(JSON.stringify(error));
			console.log(stderr)
		}
		console.log('stdout: ' + stdout);
		console.log('stderr: ' + stderr);

		cb(stdout);
	});
}
