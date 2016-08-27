Recaptcha.configure do |config|
  config.public_key  = '6LeNoigTAAAAAMvU-WsKoW_fec9L6lDP3uTQd1Dm'
  config.private_key = '6LeNoigTAAAAABhGx8ruqeTlNw17rXu8mVV9CzFQ'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
  config.proxy = 'http://www.google.com/recaptcha/api/verify'
end
