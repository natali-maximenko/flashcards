Mailgun.configure do |config|
  config.api_key = ENV['MAILGUN_KEY']
  config.domain = ENV['APP_DOMAIN']
end
