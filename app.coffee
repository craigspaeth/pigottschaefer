http = require 'http'
fs = require 'fs'
jade = require 'jade'
stylus = require 'stylus'
coffee = require 'coffee-script'
global.nap = require 'nap'
_ = require 'underscore'
connect = require 'connect'

# Config assets
nap
  embedFonts: true
  assets:
    js:
      all: ['/assets/main.coffee']
    css:
      all: ['/assets/main_embed.styl']

# Make function that either compiles the template in dev or caches in production
html = ->
  unless process.env.NODE_ENV is 'production'
    jade.compile(fs.readFileSync './assets/main.jade')()
  else
    @html ?= jade.compile(fs.readFileSync './assets/main.jade')()
  
# Start a server that just serves up static assets and the compiled html
console.log process.env.NODE_ENV
port = if process.env.NODE_ENV is 'production' then 80 else 4000
app = connect().use(nap.middleware).use(connect.static("public")).use((req, res) ->
  res.writeHead 200, "Content-Type": "text/HTML"
  res.end html()
).listen(port)
console.log "NODE_ENV is #{process.env.NODE_ENV}, listening on #{port}"