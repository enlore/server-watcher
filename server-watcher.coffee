#! /usr/local/bin/coffee
#
# I get tired of setting up my frontend projects over and over,
# and I get tired of opening another terminal and running 
# a little server in it to serve the project, so this should
#
# 1. Crap out my dir structure
# 2. Set up a nodemon watcher to watch for file changes
# 3. Fire up a server to server the project locally
#

express     = require 'express'
app         = express()

nodemon     = require 'nodemon'

path        = require 'path'
fs          = require 'fs'

DEBUG = process.env.DEBUG || false

# create the dir structure for the app
basicDirStructure = [
    'public'
    ['public', 'img']
    ['public', 'css']
    ['public', 'js']
    'js'
    'styl'
    'templates'
]

for dirname in basicDirStructure
    if dirname instanceof Array
        dirname = path.join.apply null, dirname

    fs.mkdir dirname, (err) ->
        if err.code is 'EEXIST' and DEBUG
            console.log err.path + ' already exists! Makes my job easier.'

nodemon
    script: 'compile.sh'
    exec: 'sh'
    ignore: 'public'
    ext: 'coffee styl jade sh jpg jpeg gif png'

app.use express.static path.join __dirname, 'public'

app.listen 3000, ->
    console.log "~~~~~> Listening on 3000"
