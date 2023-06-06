const BaseController = require("./base.controller");
const homeModel = require('../models/home.model');
const qs = require("qs");
const fs = require("fs");
const url = require('url');

class HomeController {
    async getHomePage(req, res) {
        let html = await BaseController.getTemplate('./src/views/home.html')
        let homeStays = await homeModel.getAllHomeStay()
        let listHomes  = ""
        let count = 0
        homeStays.forEach(home => {
            listHomes += `<tr>
            <th scope="row">${count++}</th>
            <td>${home.name}</td>
            <td>${home.country}</td>
            <td>${home.price}</td>
            <td>
                <a class="btn btn-outline-primary" href="/detail?id=${home.id}">edit</a>
                <a class="btn btn-outline-danger" href="/delete?id=${home.id}">delete</a>   
            <td>
          </tr>`
        });
        html = html.replace('{list-home}',listHomes)
        
        res.writeHead(200, {'Content-type': 'text/html'});
        res.write(html)
        res.end()
    }
    
    async newHome(req, res){
        if (req.method === 'GET') {
            let html = await BaseController.getTemplate('./src/views/new.html')
            res.writeHead(200, {'Content-type': 'text/html'});
            res.write(html)
            res.end()
        } else {
            let data =''
            req.on('data',chunk=>{
                data+=chunk
            })
            req.on('end',()=>{
                let reqData = qs.parse(data)
                let {name, country, count_bedrooms, count_toilets, description, price} = reqData
                homeModel.createHome(name, country, count_bedrooms, count_toilets, description, price)
                fs.readFile('./src/views/home.html','utf-8',function (err, dataHtml) {
                    res.writeHead(301,{location:`/home`})
                    res.write(dataHtml)
                    res.end()
                })
            })
        
        }
    }
    async deleteHome(req, res){
        let id = qs.parse(url.parse(req.url).query).id;
    
        if (id && homeModel.deleteHome(id)){
            fs.readFile('./src/views/home.html','utf-8',function (err, dataHtml) {
                res.writeHead(301,{location:`/home`})
                res.write(dataHtml)
                res.end()
            })
        } else {
            res.writeHead(301,{location:`/notfound`})
        }
        
    }
    
    async detailHome(req, res){
        let id = qs.parse(url.parse(req.url).query).id;
        if (id){
            fs.readFile('./src/views/detail.html','utf-8',function (err, dataHtml) {
                res.writeHead(301,{location:`/detail?id=${id}`})
                res.write(dataHtml)
                res.end()
            })
        } else {
            res.writeHead(301,{location:`/home`})
            res.end()
        }
        
    }

}
module.exports = new HomeController()