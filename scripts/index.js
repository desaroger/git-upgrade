#! /usr/bin/env node
/**
 * Created by desaroger on 14/01/17.
 */

var args = process.argv.splice(2);
var spawn = require('child_process').spawn;
var path = require('path');
var script = path.resolve(__dirname, './main.sh');

spawn(script, args, {stdio: 'inherit'});
