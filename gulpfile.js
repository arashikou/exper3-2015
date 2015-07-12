// This is just a small script that loads the Node.js CoffeeScript support and then passes
// execution to the real gulpfile: gulpfile.coffee
require('coffee-script/register');
require('./gulpfile.coffee');
