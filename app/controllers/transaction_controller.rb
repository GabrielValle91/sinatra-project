class TransactionController < ApplicationController

  get '/transactions/shipping' do
    if logged_in?
      erb :"transactions/shipping/index"
    else
      redirect '/login'
    end
  end

  get '/transactions/shipping/new' do
    if logged_in?
      erb :"transactions/shipping/new"
    else
      redirect "/login"
    end
  end

  post '/transactions' do
    if !Transaction.where('reference = ? AND client_id = ?', params[:transaction_reference], params[:client_id])
      flash.now[:notice] = "That client already has a transaction with that reference"
      erb :"transactions/shipping/new"
    else
      transaction = Transaction.new
      transaction.reference = params[:transaction_reference]
      transaction.client_id = params[:client_id]
      transaction.transaction_type = "shipping"
      transaction.transaction_date = params[:transaction_date]
      transaction.status = "open"
      if transaction.save
        redirect  '/transactions/shipping'
      else
        redirect '/transactions/shipping/new'
      end
    end
  end
end
