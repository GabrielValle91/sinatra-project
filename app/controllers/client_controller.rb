class ClientController < ApplicationController

  get '/clients' do
    if logged_in?
      erb :"clients/index"
    else
      redirect "/login"
    end
  end

  get '/clients/new' do
    if logged_in?
      erb :"clients/new"
    else
      redirect '/login'
    end
  end

  post '/clients' do
    client = Client.new
    client.name = params[:client_name]
    client.user_id = current_user.id
    if client.save
      redirect '/clients'
    else
      redirect '/clients/new'
    end
  end
end
