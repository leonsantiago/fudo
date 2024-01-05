class Router
  def initialize(request)
    @request = request
  end

  def route!
    if @request.path == '/'
      [200, { "Content-Type" => "application/json" }, ["Return 200 from router"]] 
    else
      not_found
    end
  end

  private

  def not_found(msg = 'Not Found')
    [404, { "Content-Type:" => "application/json" }, [msg]]
  end
end
