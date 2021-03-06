// Generated by CoffeeScript 1.4.0
(function() {
  var copyObject, crypto, hash, keys, objMap, padNumToString, syncLoop, toNum, _;

  crypto = require('crypto');

  _ = require('underscore');

  hash = function(obj) {
    var oHash;
    oHash = void 0;
    oHash = crypto.createHash("sha1");
    oHash.update(JSON.stringify(obj));
    return oHash.digest("hex");
  };

  padNumToString = function(num, padString) {
    var p;
    p = padString;
    return p.slice(0, p.length - num.toString().length) + num.toString();
  };

  keys = function(obj) {
    return _.keys(obj);
  };

  toNum = function(obj) {
    return parseInt(obj, 10);
  };

  copyObject = function(obj) {
    return JSON.parse(JSON.stringify(obj));
  };

  objMap = function(f, obj) {
    var i, o;
    o = {};
    for (i in obj) {
      o[i] = f(obj[i]);
    }
    return o;
  };

  syncLoop = function(options) {
    var compute, condition, i, list, newRes, p;
    list = options.list;
    condition = options.condition;
    compute = options.compute;
    p = options.params;
    return newRes = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        i = list[_i];
        if (condition(i, p)) {
          _results.push(compute(i, p));
        }
      }
      return _results;
    })();
  };

  module.exports = {
    hash: hash,
    padNumToString: padNumToString,
    keys: keys,
    toNum: toNum,
    copyObject: copyObject,
    objMap: objMap,
    syncLoop: syncLoop
  };

}).call(this);
