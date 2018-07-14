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

  get '/transactions/shipping/:id/edit' do
    if logged_in?
      @transaction = Transaction.find(params[:id])
      if @transaction.client.user = current_user
        #binding.pry
        erb :"transactions/shipping/edit"
      else
        redirect '/transactions/shipping'
      end
    else
      redirect '/login'
    end
  end

  get '/transactions/shipping/:id' do
    if logged_in?
      @transaction = Transaction.find(params[:id])
      if @transaction.client.user = current_user
        erb :"transactions/shipping/show"
      else
        redirect '/transactions/shipping'
      end
    else
      redirect '/login'
    end
  end

  post '/transactions/shipping' do
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

  patch '/transactions/shipping/:id' do
    @transaction = Transaction.find(params[:id])
    params[:products].each do |product, quantity|
      if quantity.first.to_i > 0
        if lineitem = LineItem.find_by(:transaction_id => @transaction.id, :product_id => product.to_i)
          lineitem.quantity = quantity.first.to_i
          lineitem.save
        else
          lineitem = LineItem.new
          lineitem.transaction_id = @transaction.id
          lineitem.product_id = product.to_i
          lineitem.quantity = quantity.first.to_i
          lineitem.save
        end
      elsif quantity.first.to_i == 0 || !quantity.first
        if lineitem = LineItem.find_by(:transaction_id => @transaction.id, :product_id => product.to_i)
          lineitem.delete
        end
      end
    end
    redirect "/transactions/shipping/#{@transaction.id}"
  end
end
