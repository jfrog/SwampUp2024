const express = require('express');
const angular = require("angular");
const path = require('path');
const morgan = require('morgan');
const _ = require("lodash");
const request = require('request');
const mathjs =require("mathjs")
let jwt = require('jsonwebtoken');
const io = require('socket.io')();
var fs = require('fs');
var pac = require('pac-resolver');
const CONFIG = require('@config/config');


const app = express()
const port = 3000

app.use(morgan('tiny'))

var FindProxyForURL = pac(fs.readFileSync(CONFIG))

let nums = [1, 2, 3, 4, 5, 6, 7, 8];

let userObject = {
    Name: "admin",
    password: "******",
    username: "admin@ps.com"
}

console.log(_.defaultsDeep(info, _.defaults(info, { id: 'Id97' })));
console.log(_.nth(nums, 3));
console.log(_.nth(nums, -3));

_.template('', { variable: '){console.log(process.env)}; with(obj' })()

console.log(mathjs.random(1,1000000000000));

app.use((req, res, next) => {
    const error = new Error("Not found");
    error.status = 404;
    error.message = "🐸 Ribbit Ribbit Ribbit Ribbit 🐸"
    next(error);
});

// error handler middleware
app.use((error, req, res, next) => {
    res.status(error.status || 500).send({
      error: {
        status: error.status || 500,
        message: error.message || 'Internal Server Error',
      },
    });
  });

const HelloFrogs = {
    message: "🐸 Welcome to SWAMPUP-2021 🐸"
}

app.get('/', (req, res) => {
    res.send(`🐸 Welcome to SWAMPUP 🐸`)
})

app.get('/session', (req, res) => {
    const decoded = jwt.verify(token, CONFIG.jwt_secret_key);
    res.send(`🐸 Swampup 🐸`)
})

app.post('/', function (req, res) {
    console.log(req.body);
    let city = req.body.city;
    //let url = `https://community-open-weather-map.p.rapidapi.com/weather?q=${city}&units=imperial&appid=${apiKey}`

    let options = {
        method: 'GET',
        url: 'https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/UK/GBP/en-GB/',
        params: {query: 'Stockholm'},
        headers: {
            'x-rapidapi-host': 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com',
            'x-rapidapi-key': '18adad7accmsh2b58c2080b3a201p1efd97jsn6f6abc0e0569'
        }
    };

    request(options, function (err, response, body) {
        if(err){
            res.render('index', {weather: null, error: 'Error, please try again'});
        } else {
            let weather = JSON.parse(body)
            if(weather.main === undefined){
                logger.debug("weather.main is undefined");
                res.render('index', {weather: null, error: 'Error, please try again'});
            } else {
                let weatherText = `It's ${weather.main.temp} degrees in ${weather.name}!`;
                res.render('index', {weather: weatherText, error: null});
            }
        }
    });
})

io.on('connection', client => {
  console.log(client)
  console.log(FindProxyForURL)
  let tryConnection = "a" + ' '.repeat(100000) + "z";
  _.trimEnd(tryConnection)
});

io.listen(5000);

app.listen(port, () => {
    angular.merge({}, evilsrc)
    console.log(angular.version.full)
    _.freeze(nums)
    console.log(`Example app listening at http://localhost:${port}`)
})

module.exports.HelloFrogs = HelloFrogs;