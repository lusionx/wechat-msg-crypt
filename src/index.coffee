_         = require 'lodash'
wxCrypto  = require 'wechat-crypto'
xml2js    = require 'xml2js'
crypto    = require 'crypto'

module.exports = class WechatMsg
  constructor: (token, aesKey, appId) ->
    @wx = new wxCrypto token, aesKey, appId

  valida: (timestamp, nonce) ->
    shasum = crypto.createHash('sha1')
    arr = [@wx.token, timestamp, nonce].sort()
    shasum.update arr.join('')
    shasum.digest('hex')

  decryptMsg: (msg_signature, timestamp, nonce, xml, callback) ->
    wx = @wx
    xml2js.parseString xml, (err, result) ->
      enMsg = result.xml.Encrypt[0]
      sign = wx.getSignature timestamp, nonce, enMsg
      return callback Error 'sign err' if sign isnt msg_signature
      deMsg = wx.decrypt enMsg
      return callback Error 'appid err' if deMsg.id isnt wx.id
      xml2js.parseString deMsg.message, (err, result) ->
        kv = {}
        _.each result.xml, (v, k) -> kv[k] = v[0]
        callback null, kv

  encryptMsg: (timestamp, nonce, msg) ->
    if _.isString msg
      xml = msg
    else
      xml = '<xml>'
      _.each msg, (v, k) ->
        v = "![CDATA[" + v + "]]" if _.isString v
        xml =+ "<#{k}>#{v}</#{k}>"
      xml = '</xml>'
    enMsg = @wx.encrypt xml
    sign = @wx.getSignature timestamp, nonce, enMsg
    "<xml> <Encrypt><![CDATA[#{enMsg}]]></Encrypt> <MsgSignature>#{sign}</MsgSignature> <TimeStamp>#{timestamp}</TimeStamp> <Nonce>#{nonce}</Nonce></xml>"

