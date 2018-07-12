class ApplicationController < Sinatra::Base

  config do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "programmingisfun"
  end

  get '/' do
    erb :index
  end
end
