const http = require('http');
const url = require('url');
const fs = require('fs');
const qs = require("qs");
const { promisify } = require('util');
const PORT = 3000;
let handlers = {}
const readFileAsync = promisify(fs.readFile);

const BaseController = require("./src/controllers/base.controller");
const homeController = require('./src/controllers/home.controller')



let mimeTypes = {
    'jpg': 'images/jpg',
    'png': 'images/png',
    'js': 'text/javascript',
    'css': 'text/css',
    'svg': 'image/svg+xml',
    'ttf': 'font/ttf',
    'woff': 'font/woff',
    'woff2': 'font/woff2',
    'eot': 'application/vnd.ms-fontobject'
}

const server = http.createServer((req, res) => {
    let urlPath = url.parse(req.url).pathname;
    let trimPath = urlPath.replace(/^\/+|\/+$/g, '');

    const filesDefences = urlPath.match(/\.js|\.css|\.png|\.svg|\.jpg|\.ttf|\.woff|\.woff2|\.eot/);
    if (filesDefences) {
        const extension = mimeTypes[filesDefences[0].toString().split('.')[1]];
        res.writeHead(200, { 'Content-Type': extension });
        fs.createReadStream(__dirname + req.url).pipe(res)
    } else {
        let chosenHandler = (typeof (router[urlPath]) !== 'undefined') ? router[urlPath] : handlers.notFound;
        chosenHandler(req, res);
    }

})

handlers.notFound = async (req, res) => {
    try {
        const data = await readFileAsync('./src/views/notfound.html', 'utf-8');
        res.writeHead(200, 'Success', { 'Content-type': 'text/html' });
        res.write(data);
        res.end();
    } catch (err) {
        console.log(err);
        res.writeHead(500, 'Internal Server Error');
        res.end();
    }
};

handlers.notFound = async (req, res) => {
    try {
        const data = await readFileAsync('./src/views/notfound.html', 'utf-8');
        res.writeHead(200, 'Success', { 'Content-type': 'text/html' });
        res.write(data);
        res.end();
    } catch (err) {
        console.log(err);
        res.writeHead(500, 'Internal Server Error');
        res.end();
    }
};

handlers.home = async (req, res)=>{
    await homeController.getHomePage(req, res).catch((err) => {
        console.log(err.message);
    });
    
};

handlers.new = async (req, res)=>{
    await homeController.newHome(req, res).catch((err) => {
        console.log(err.message);
    });
};

handlers.deleteHome = async (req, res)=>{
    await homeController.deleteHome(req, res).catch((err) => {
        console.log(err.message);
    });
};
handlers.detailHome = async (req, res)=>{
    await homeController.detailHome(req, res).catch((err) => {
        console.log(err.message);
    });
};
router = {
    '/': handlers.home,
    '/home': handlers.home,
    '/new': handlers.new,
    '/detail': handlers.detailHome,
    '/delete': handlers.deleteHome,
};



server.listen(PORT, 'localhost', () => {
    console.log('server listening on port ' + PORT)
})