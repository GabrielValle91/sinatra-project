class TransactionController < ApplicationController

  get '/transactions/shipping' do
    if logged_in?
      @current_user
      erb :"transactions/shipping/index"
    else
      redirect '/login'
    end
  end
end
