class TransactionController < ApplicationController

    #controller action for shipping transactions
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
      if @transaction.client.user == current_user
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
      if @transaction.client.user == current_user
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
    @transaction.status = params[:status]
    @transaction.save
    params[:products].each do |product, quantity|
      cur_product = Product.find(product.to_i)
      if quantity.first.to_i > 0
        if lineitem = LineItem.find_by(:transaction_id => @transaction.id, :product_id => product.to_i)
          cur_product.quantity += lineitem.quantity
          lineitem.quantity = quantity.first.to_i
          lineitem.save
        else
          lineitem = LineItem.new
          lineitem.transaction_id = @transaction.id
          lineitem.product_id = product.to_i
          lineitem.quantity = quantity.first.to_i
          lineitem.save
        end
        cur_product.quantity -= lineitem.quantity
        cur_product.save
      elsif quantity.first.to_i == 0 || !quantity.first
        if lineitem = LineItem.find_by(:transaction_id => @transaction.id, :product_id => product.to_i)
          cur_product = Product.find(product.to_i)
          cur_product.quantity += lineitem.quantity
          cur_product.save
          lineitem.delete
        end
      end
    end
    redirect "/transactions/shipping/#{@transaction.id}"
  end

  #controller action for receiving transactions
  get '/transactions/receiving' do
    if logged_in?
      erb :"transactions/receiving/index"
    else
      redirect '/login'
    end
  end

  get '/transactions/receiving/new' do
    if logged_in?
      erb :"transactions/receiving/new"
    else
      redirect "/login"
    end
  end

  get '/transactions/receiving/:id/edit' do
    if logged_in?
      @transaction = Transaction.find(params[:id])
      if @transaction.client.user == current_user
        erb :"transactions/receiving/edit"
      else
        redirect '/transactions/receiving'
      end
    else
      redirect '/login'
    end
  end

  get '/transactions/receiving/:id' do
    if logged_in?
      @transaction = Transaction.find(params[:id])
      if @transaction.client.user == current_user
        erb :"transactions/receiving/show"
      else
        redirect '/transactions/receiving'
      end
    else
      redirect '/login'
    end
  end

  post '/transactions/receiving' do
    if !Transaction.where('reference = ? AND client_id = ?', params[:transaction_reference], params[:client_id])
      flash.now[:notice] = "That client already has a transaction with that reference"
      erb :"transactions/receiving/new"
    else
      transaction = Transaction.new
      transaction.reference = params[:transaction_reference]
      transaction.client_id = params[:client_id]
      transaction.transaction_type = "receiving"
      transaction.transaction_date = params[:transaction_date]
      transaction.status = "open"
      if transaction.save
        redirect '/transactions/receiving'
      else
        redirect '/transactions/receiving/new'
      end
    end
  end

  patch '/transactions/receiving/:id' do
    @transaction = Transaction.find(params[:id])
    @transaction.status = params[:status]
    @transaction.save
    params[:products].each do |product, quantity|
      cur_product = Product.find(product.to_i)
      if quantity.first.to_i > 0
        if lineitem = LineItem.find_by(:transaction_id => @transaction.id, :product_id => product.to_i)
          cur_product.quantity -= lineitem.quantity
          lineitem.quantity = quantity.first.to_i
          lineitem.save
        else
          lineitem = LineItem.new
          lineitem.transaction_id = @transaction.id
          lineitem.product_id = product.to_i
          lineitem.quantity = quantity.first.to_i
          lineitem.save
        end
        cur_product.quantity += lineitem.quantity
        cur_product.save
      elsif quantity.first.to_i == 0 || !quantity.first
        if lineitem = LineItem.find_by(:transaction_id => @transaction.id, :product_id => product.to_i)
          cur_product = Product.find(product.to_i)
          cur_product.quantity -= lineitem.quantity
          cur_product.save
          lineitem.delete
        end
      end
    end
    redirect "/transactions/receiving/#{@transaction.id}"
  end
end
