require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "3e927350c48848e2af1c93c9bde9376f", "8bf82ef52e944b2fa46bdc6c73812422", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify user-top-read streaming user-read-recently-played '
end
