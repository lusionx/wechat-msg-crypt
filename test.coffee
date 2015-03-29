assert  = require 'assert'
nx      = require './src'

do ->
  chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVTXYZ'
  assert.equal nx.toStr('38', chars), 'C'
  assert.equal nx.to10('C', chars), 38

  assert.equal nx.toStr('0580344', chars), '2qYo'
  assert.equal nx.to10('2qYo', chars), 580344

  assert.equal nx.toStr('4681516', chars), 'jDSk'
  assert.equal nx.toStr('jDSk', chars), 4681516

  assert.equal nx.lpad('12321', 7, 'a'), 'aa12321'

