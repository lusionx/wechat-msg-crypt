assert  = require 'assert'
Msg      = require './src'

do ->
  msg = new Msg

  assert.equal nx.lpad('12321', 7, 'a'), 'aa12321'

