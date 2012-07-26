fs = require 'fs'
{exec} = require 'child_process'
util = require 'util'
os = require('os')
path = require('path')

# quick aliases
L = util.puts
D = util.inspect
F = util.format

u = require("./lib/b2gutils")
bin_dir = path.join(process.cwd(), 'bin')
tmp_dir = path.join(process.cwd(), 'tmp')

platform = os.platform()

task 'run', 'run b2g desktop', ->
	exec 'make run', (err, stdout, stderr) ->
		throw err if err
		console.log stdout + stderr

task 'update_osx', 'Update on OS X', ->
	# ...
	L "Downloading..."
	u.get_latest_build bin_dir, (result) -> 
		filename = path.basename(result)
		L F "Downloaded file %s", filename
		mounted = '/Volumes/B2G/B2G.app'

		# mount the dmg
		exec 'cd ./tmp && hdiutil mount '+result, (err, stdout, stderr) ->
			throw err if err
			console.log stdout + stderr
			if fs.existsSync(mounted)
				cmd = F 'cp -r %s ./bin', mounted 
				# copy the .app
				exec cmd, (err, stdout, stderr) ->
					throw err if err
					console.log stdout + stderr
					# unmount the dmg
					unmount_cmd = F 'hdiutil unmount %s', path.dirname(mounted)
					exec unmount_cmd, (err, stdout, stderr) ->
						L "Updated B2G.app"

task 'update_linux', 'Update on Linux', ->
	# ...
	u.get_latest_build bin_dir, (result) -> 
		filename = path.basename(result)
		untar_cmd = F 'cd ./bin && tar xfz %s', result
		exec untar_cmd, (err, stdout, stdout) ->
			throw err if err
			console.log stdout + stderr
			cleanup_cmd = F 'rm -fr %s', result 
			exec cleanup_cmd, (err, stdout, stderr) ->
				L "Updated B2G desktop"

task 'update_windows', 'Update on Windows', ->
	# ...
	u.get_latest_build bin_dir, (result) -> 
		filename = path.basename(result)
		unzip_cmd = F 'cd \bin && unzip %s', result
		exec unzip_cmd, (err, stdout, stdout) ->
			throw err if err
			console.log stdout + stderr
			cleanup_cmd = F 'rd /s /q %s', result 
			exec cleanup_cmd, (err, stdout, stderr) ->
				L "Updated B2G desktop"




task 'update', 'Install or update the local copy of B2G Desktop', ->
	L "Updating B2G"
	if platform == 'darwin'
		L "Detected OS X platform..."
		invoke 'update_osx'
	else if platform == 'linux'
		invoke 'update_linux'
	else if platform == 'win32'
		invoke 'update_windows'
	# else
	# 	L F 'unsupported platform: %s' platform

