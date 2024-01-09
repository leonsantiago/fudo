require 'async'
require_relative './main_controller.rb'
require_relative '../models/product.rb'

class ProductsController < MainController
  def initialize(app)
    @app = app
  end

  def call(request)
    case request.path_info
      when '/products'
        request.request_method == 'POST' ? create(request) : index
      else
        id = request.path_info.split('/').last
        show(id)
    end
  end

  def index
    products = Product.all

    build_response(products, status: 200)
  end

  # Create
  def create(request)
    Async do
      name = request.params['name']
      if name
        product = Product.create(name)
        redirect_to "/products/#{product[:id]}"
      else
        bad_request_response
      end
    end.wait
  end

  # Show
  def show(id)
    product = Product.find(id.to_i)

    build_response(product, status: 200)
  end
end
