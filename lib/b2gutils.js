var request = require('request'), 
	os = require('os'),
	http = require('http'), 
	fs = require('fs'),
	util = require('util'),
	url = require('url'),
	path = require('path');

var L = util.puts,
	D = util.inspect,
	F = util.format;

/*
 * Fetch the content of the latest build directory and return the latest, highest-version builds
 * Aside: nothing is more dependable than file listing markup on a production web server.
 */
exports.get_latest_build = function(target_dir, callback) {
	var platforms = {
		'dmg': 	'darwin', 
		'bz2': 	'linux', 
		'zip': 	'win32'
	};
	var url = 'http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/'
	request(url, function (error, response, body) {
		if (!error && response.statusCode == 200) {
			
			var results = {},
			 	regex = /href=\"(b2g-([\d]{2})[\w\.\-]*?\.(dmg|zip|bz2))\"/g;

			while ((myArray = regex.exec(body)) !== null) {
				// there are zip files with test in them
				if (/\.tests\./.test(myArray[1])) {
					continue;
				}

				var tmp_platform = platforms[myArray[3]];
				var tmp = {
					file: myArray[1],
					version: myArray[2],
					file_ext: myArray[3],
				};

				if (!results[myArray[2]]) {
					results[myArray[2]] = {};
				}
				results[myArray[2]][tmp_platform] = tmp;
			}

			var keys = Object.keys(results);
			keys.sort();
			var result = results[keys.pop()];
			var filename = result[os.platform()].file;
			var file_url = F('%s/%s', url, filename);
			var target_path = path.join(target_dir, filename);
			var stream = fs.createWriteStream(target_path);

			stream.on('close', function() {
				callback(target_path);
			});

			request(file_url).pipe(stream);

		} else {
			throw error;
		}
	});
}