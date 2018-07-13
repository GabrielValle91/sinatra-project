class UserController < ApplicationController

  get '/homepage' do
    erb :"/users/homepage"
  end
  get '/login' do
    if logged_in?
      redirect '/homepage'
    else
      erb :"users/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/homepage'
    else
      erb :"users/signup"
    end
  end

  get '/logout' do
    logout!
    redirect '/login'
  end

  post '/login' do
    login(params[:username], params[:password])
  end

  post '/signup' do
    @user = User.new
    @user.username = params[:username]
    @user.password = params[:password]
    if @user.save
      login(params[:username], params[:password])
    else
      redirect '/signup'
    end
  end
end
