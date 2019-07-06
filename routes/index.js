var express = require('express');
var router = express.Router();
fun = require('../functions.js');

/* GET home page. */
router.get('/', function(req, res, next) {
  var ret = {};
  res.render('index', ret);
});

router.get('/people', function(req, res, next) {
  var ret = {
    formSpecs: fun.getFormSpecs(),
    tables: fun.getSampleData(),
  };
  res.render('people', ret);
});

router.get('/activities', function(req, res, next) {
  var ret = {
    formSpecs: fun.getFormSpecs(),
    tables: fun.getSampleData(),
  };
  res.render('activities', ret);
});

// Use the restrict middleware defined in functions.js as per <http://toon.io/on-passportjs-specific-use-cases/>
router.get('/activitiesjson', fun.restrict, function(req, res, next) {
	res.setHeader("content-type", "application/json; charset=utf-8");
	// MUST call res.send or call multiple res.write then one res.end:
	fun.listEntriesJSON(req, res, "ActivitiesTypes");
});

router.get('/scheduleitem', function(req, res, next) {
  var fwd = ["P_Id", "WSC_Id", "W_Id"];
  var ret = {
    errStr: null,
    formSpecs: fun.getFormSpecs(),
    tables: fun.getSampleData(),
  };
  var fwdLength = fwd.length;
  for (var i = 0; i < fwdLength; i++) {
    if (typeof req.query[fwd[i]] === 'undefined') {
      if (ret.errStr===null) ret.errStr="";
      ret.errStr+="Missing "+fwd[i]+". ";
      ret[fwd[i]] = null;
    }
    else ret[fwd[i]] = req.query[fwd[i]];
  }
  res.render('scheduleitem', ret);
});

module.exports = router;
