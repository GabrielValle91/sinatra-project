require 'sinatra/base'
require 'rack-flash'
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

  get '/clients/:id/edit' do
    if logged_in?
      @client = Client.find(params[:id])
      if @client.user_id == current_user.id
        erb :"clients/edit"
      else
        redirect '/clients'
      end
    else
      redirect '/login'
    end
  end

  get '/clients/:id' do
    if logged_in?
      @client = Client.find(params[:id])
      if @client.user_id == current_user.id
        erb :"clients/show"
      else
        redirect '/clients'
      end
    else
      redirect '/login'
    end
  end

  post '/clients' do
    if !Client.where('name = ? AND user_id = ?', params[:client_name], current_user.id).empty?
      flash.now[:notice] = "There is already a client with that name"
      erb :"clients/new"
    else
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

  patch '/clients/:id' do
    if !Client.where('name = ? AND user_id = ?', params[:client_name], current_user.id).empty?
      flash.now[:notice] = "There is already a client with that name"
      @client = Client.find(params[:id])
      erb :"clients/edit"
    else
      client = Client.find(params[:id])
      client.name = params[:client_name]
      if client.save
        redirect '/clients'
      else
        redirect "/clients/#{params[:id]}/edit"
      end
    end
  end
end
