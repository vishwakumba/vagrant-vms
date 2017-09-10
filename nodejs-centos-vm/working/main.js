var http = require('http');
var url = require('url');
var fs = require('fs');

const { URL } = require('url');

console.log("Welcome to the node app..")

http.createServer(function (req, res) {
  var q = url.parse(req.url, true);
  console.log("pathname=" + q.pathname);

 if ( q.pathname == '/') {
   fs.readFile('./index.html', function(err, data) {
     if (err) {
       console.log("Error has occurred, err=" + err);
       res.writeHead(404, {'Content-Type': 'text/html'});
       return res.end("404 Not Found");
     }

     res.writeHead(200, {'Content-Type': 'text/html'});
     res.write(data);
     return res.end();
   });
 }

 if ( q.pathname == '/process') {
   var query = url.parse(req.url, true).query;
   var json = JSON.stringify(query);
   console.log("json=" + json);

   var jsonObj = JSON.parse(json);
   console.log("firstname=" + jsonObj.firstname);
   console.log("lastname=" + jsonObj.lastname);

   res.writeHead(200, {'Content-Type': 'text/html'});
   return res.end("details=" + json);
 }


}).listen(8100);

