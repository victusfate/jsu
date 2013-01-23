crypto  = require('crypto')
_       = require('underscore')

hash = (obj) ->
  oHash = undefined
  oHash = crypto.createHash("sha1")
  oHash.update JSON.stringify(obj)
  oHash.digest "hex"

padNumToString = (num, padString) ->
  p = padString # ie '0000'
  p.slice(0, p.length - num.toString().length) + num.toString()

keys = (obj) ->
  # keys = []
  # for i of obj
  #   keys.push i  if obj.hasOwnProperty(i)
  # keys
  _.keys(obj)

toNum = (obj) ->
  parseInt obj, 10

copyObject = (obj) ->
  JSON.parse JSON.stringify(obj)

objMap = (f, obj) ->
  o = {}
  for i of obj
    o[i] = f(obj[i])
  o

syncLoop = (options, i, cb) ->
  list = options.list
  condition = options.condition
  compute = options.compute
  params = options.params
  res = options.res

  if i < list.length
    item = list[i]
    if condition(item, params)
      compute item, params, (r) =>
        res.push r
        syncLoop options, i + 1, cb
    else
      syncLoop options, i + 1, cb
  else
    cb null, res


module.exports =
  hash: hash
  padNumToString: padNumToString
  keys: keys
  toNum: toNum
  copyObject: copyObject
  objMap: objMap
  syncLoop: syncLoop