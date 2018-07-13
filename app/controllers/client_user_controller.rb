class ClientUserController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/homepage'
    else
      erb :"users/login"
    end
  end
end
