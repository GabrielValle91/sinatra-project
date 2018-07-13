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

  post '/products' do
    if !Product.where('name = ? AND client_id = ?', params[:product_name], params[:client_id]).empty?
      flash.now[:notice] = "There is already a product for this client with that name"
      erb :"products/new"
    else
      binding.pry
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
end
