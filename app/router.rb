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

  def route_info
    @route_info ||= begin
      resource = path_fragments[0] || 'main'
      id, action = get_id_and_action(path_fragments[1])
      
      { resource: resource, action: action, id: id }
    end
  end

  def get_id_and_action(fragmented_path)
    case fragmented_path
    when 'new'
      [nil, :new]
    when nil
      action = @request.get? ? :index, :create
      [nil, action]
    else
      [fragment, :show]
    end
  end
end
