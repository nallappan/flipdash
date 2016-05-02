require 'dashing'
require 'httparty'

configure do
  set :auth_token, 'tk'
  set :default_dashboard, 'flipdash'
  set :protection, :except => :frame_options

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
