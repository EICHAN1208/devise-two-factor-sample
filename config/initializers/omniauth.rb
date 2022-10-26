Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch("TWITTER_API_KEY"), ENV.fetch("TWITTER_API_SECRET"), callback_url: "http://127.0.0.1:3000/auth/twitter/callback"

  # omniauthの認証で、getも許可するようにした
  # この設定が良いのかどうかはよくわからない
  OmniAuth.config.allowed_request_methods = [:post, :get]
end
