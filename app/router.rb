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
    end
  end
end
