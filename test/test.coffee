jsu = require('../lib/base')
_	= require('underscore')

cond = (i,p) -> 
  i >= p.start and i <= p.end

comp = (i,p,cb) ->
  cb(i * p.scale)

p = 
  start: 0
  end: 9
  scale: 3

list = [0...1000000]
opt = 
  list: list
  condition: cond
  compute: comp
  params: p
  res: []


nTrials = 1000

t1 = Date.now()

# j=0
# while (j < nTrials)
#   opt.res = [];
#   jsu.syncLoop opt, 0, (err) ->
#     if (err)
#       console.log err
#       throw err
#     else
#       # console.log 'all done, results ', opt.res
#   j++

comp2 = (i,p) -> i * p.scale
console.log('t1',Date.now()-t1)

t2 = Date.now()

# comp(i,p,null) for i in [0..10] when cond(i,p)
j=0
while (j < nTrials)
  newRes = for i in list when cond(i,p)
    comp2(i,p)
  # newRes = [0...10].map (i) ->
  #   comp2(i,p) if cond(i,p)
  # console.log 'all done, results ', newRes
  j++
console.log('t2',Date.now()-t2)

  