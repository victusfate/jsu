jsu = require('../jsu')
_	  = require('underscore')
log = console.log


# syncLoop testing

cond = (i,p) -> 
  i >= p.start and i <= p.end

comp2 = (i,p) -> i * p.scale

dim = 100000

p = 
  start: 0
  end: dim * 0.8
  scale: 3

list = [0...dim]
opt = 
  list: list
  condition: cond
  compute: comp2
  params: p
  res: []


nTrials = 100

t1 = Date.now()

j=0
while (j < nTrials)
  newRes = jsu.syncLoop(opt)
  j++

log 't1 syncLoop', Date.now()-t1


# objMap

obj = {}
for i in list
  obj[i] = list[i]

dub = (o) -> 2*o
dubr = (m,v,k,o) -> 
  m[k] = 2*v
  m

t1 = Date.now()

j=0
while (j < nTrials)
  newRes = jsu.objMap( dub, obj)
  j++

log 't2 objMap on object', Date.now() - t1


t1 = Date.now()

j=0
while (j < nTrials)
  newRes = jsu.objMap( dub, list)
  j++

log 't3 objMap on array', Date.now() - t1


t1 = Date.now()

j=0
while (j < nTrials)
  newRes = _(obj).reduce dubr, {}
  j++

log 't4 _.reduce on obj', Date.now() - t1

t1 = Date.now()

j=0
while (j < nTrials)
  newRes = _(list).map dub
  j++

log 't5 _.map on array', Date.now() - t1

