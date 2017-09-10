var http = require('http');
var url = require('url');
var fs = require('fs');

console.log("Welcome to the node app..")

http.createServer(function (req, res) {
  var q = url.parse(req.url, true);
  var filename = "." + q.pathname;
  fs.readFile(filename, function(err, data) {
  if (err) {
    console.log("Error has occurred, err=" + err);
    res.writeHead(404, {'Content-Type': 'text/html'});
    return res.end("404 Not Found");
   }

   console.log("Ok, err=" + err);
   res.writeHead(200, {'Content-Type': 'text/html'});
   res.write(data);
   return res.end();
  });
}).listen(8100);

