
var fs = require("fs"), 
	os = require("os");
var pp = function(o) { return JSON.stringify(o,null,'  ')};


var u = require("./b2gutils");

u.get_latest_build(function(results) {
	console.log(pp(results));
});