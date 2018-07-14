class ProductController < ApplicationController
  get '/products' do
    if logged_in?
      erb :"products/index"
    else
      redirect '/login'
    end
  end

  get '/products/new' do
    if logged_in?
      erb :"products/new"
    else
      redirect '/login'
    end
  end

  get '/products/:id/edit' do
    if logged_in?
      @product = Product.find(params[:id])
      if @product.client.user_id = @current_user.id
        erb :"products/edit"
      else
        redirect '/products'
      end
    else
      redirect '/login'
    end
  end

  get '/products/:id' do
    if logged_in?
      @product = Product.find(params[:id])
      if @product.client.user_id = @current_user.id
        erb :"products/show"
      else
        redirect '/products'
      end
    else
      redirect '/login'
    end
  end

  post '/products' do
    if !Product.where('name = ? AND client_id = ?', params[:product_name], params[:client_id]).empty?
      flash.now[:notice] = "There is already a product for this client with that name"
      erb :"products/new"
    else
      product = Product.new
      product.name = params[:product_name]
      product.description = params[:product_description]
      product.quantity = 0
      product.client_id = params[:client_id]
      if product.save
        redirect '/products'
      else
        redirect '/products/new'
      end
    end
  end

  patch '/products/:id' do
    product = Product.find(params[:id])
    product.description = params[:product_description]
    product.client_id = params[:client_id]
    if product.save
      redirect '/products'
    else
      redirect "/products/#{params[:id]/edit}"
    end
  end
end
