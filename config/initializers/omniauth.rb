Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['slack_client_id'], ENV['slack_client_secret'], scope: 'identity.basic'
  provider :census, ENV['census_id'], ENV['census_secret']
end
