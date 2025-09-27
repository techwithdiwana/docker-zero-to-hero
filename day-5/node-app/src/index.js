const http = require("http");
const port = process.env.PORT || 3000;
const server = http.createServer((req,res)=>{ if(req.url==="/health"){ res.end("ok"); } else res.end("Hello from Node app"); });
server.listen(port, ()=>console.log("Listening on",port));