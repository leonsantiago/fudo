require 'async'
require 'byebug'
require_relative './main_controller.rb'
require_relative '../models/product.rb'

class ProductsController < MainController
  # GET /products
  def index
    products = Product.all

    build_response(products, status: 200)
  end

  # Create
  def create 
    Async do
      product = Product.create(params['name'])
      redirect_to "/products/#{product[:id]}"
    end.wait
  end

  # Show
  def show
    product = Product.find(params[:id])

    build_response(product, status: 200)
  end
end
