Airbrake.configure do |config|
  config.api_key = '8586dee9f026374153197c9aa3c98cb8'
  config.host    = 'err.notch8.com'
  config.port    = 80
  config.secure  = config.port == 443
end
