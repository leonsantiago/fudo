class Router
  def initialize(request)
    @request = request
  end

  def route!
    if klass = controller_class
      route_into_request_params!

      controller = klass.new(@request)
      action = route_info(:action)

      if controller.respondo_to?(action)
        return controller.public_send(action)
      end
    end

    not_found
  end

  private

  def controller_name
    "#{route_info[:resource].capitalize}Controller"
  end

  def controller_class
    Object.const_get(controller_name)
  rescue NameError
    nil
  end

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

  def route_into_request_params!
    @request.params.merge!(route_info)
  end
end
