const express = require('express');
const router = express.Router();
const os = require('os');
const pj = require('../package.json');
const emoji = require('node-emoji');


/* GET home page. */
router.get('/', function(req, res, next) {
  const os_hostname = os.hostname();
  const os_arch = os.arch();
  const os_ni = os.networkInterfaces();
  // console.log(os_ni);
  // var os_ip = JSON.stringify(os_ni)
  // os_ip = JSON.parse(os_ip);
  // os_ip = os_ip.eth0[0].address;
  // console.log(os_ip);
  const app_version = pj.version
  const emojiMsgFrog = emoji.emojify(':frog:');
  res.render('index', { 
    version: app_version,
    os: {
      hostname: os_hostname,
      arch: os_arch
      // ip: os_ip
    },
    e1: emojiMsgFrog
  });
});

module.exports = router;