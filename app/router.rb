require 'json'

class Router
  def initialize(request)
    @request = request
  end

  def call
    case @request.path_info
    when '/login'
      LoginController.new(@app).call(@request)
    when '/products', %r{/products/\d+}
      ProductsController.new(@app).call(@request)
    else
      not_found
    end
  end

  private

  def not_found
    [404, { "Content-Type" => "application/json" }, ['Not found'.to_json]]
  end
end
