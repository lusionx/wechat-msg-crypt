assert  = require 'assert'
WxMsg      = require './src'

conf =
  token: '112Ecdc1iY'
  aesKey: 'SZjGYWat8iOle7bZJ8pqmkzurUBld0xDfPAwjEELLU0'
  appId: 'wx6d745422f1fb6108'

do ->
  wx = new WxMsg conf.token, conf.aesKey, conf.appId
  xml = "
  <xml>
    <ToUserName><![CDATA[gh_c6cd7f443d76]]></ToUserName>
    <Encrypt><![CDATA[+9gN+BLI26oaFYDtEpDGw4J7nt7Cxvx7FSKwBxb/w0n36cOTqYGbOIQzMl9nrogqHXt3DnxCRKoPnifHzL8F04FNhWvomO0KLEOqvuncRvU5QoQlh2sMhh5Rrf7Jb4zv75RUqDNGqGsBfBbSgiQcSAAUnSZ4F9z8H872QVjG419rwYEyfp2oLZQgYVSxL+A5voKQ1Ui/NYPd3WDcwn32qthHGVGQSO7E7DRXzQJwqtYbNCkZiWiDn/DzH8D4Wij+TlfwYEZ1c/5y92/PIlVyRqb+zdQrTPU+jx4KoyzkmXD3+1GQ9fVVKYsuNTOac/ppkY7/hdZQK/tbvcAYVYA8jNkQGDWoB/sYT3nfE/qq2uhX4YUKabaexl76DFOc+Add4V0gG8Sa5EKGZUww3AA8P8+xc4go/JNfs+DYLPCmtbs=]]></Encrypt>
  </xml>"
  par =
    "appId":"wx6d745422f1fb6108"
    "signature":"f6fb226ad62a36d42a1ec2483764513b3aa36cb7"
    "timestamp":"1427612890"
    "nonce":"42737549"
    "encrypt_type":"aes"
    "msg_signature":"7fbb9120465932e6d41805372b454ec55d9670ef"

  wx.decryptMsg par.msg_signature, par.timestamp, par.nonce, xml, (err, msg) ->
    assert.equal msg.ToUserName, 'gh_c6cd7f443d76'
    assert.equal msg.FromUserName, 'oZ9F-jsydU2FZRVDQMYZ8rV4hrOU'
    assert.equal msg.CreateTime, 1427612890
    assert.equal msg.MsgType, 'text'
    assert.equal msg.Content, 'dev'
    assert.equal msg.MsgId, '6131550674102361012'


