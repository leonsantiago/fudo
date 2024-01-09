require_relative '../services/authentication_service.rb'

class AuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'].include?('/products')
      handle_protected_resource(env)
    else
      @app.call(env)
    end
  end

  def handle_protected_resource(env)
    request = Rack::Request.new(env)
    if AuthenticationService.authenticate?(request)
      @app.call(env)
    else
      [401, { "Content-Type" => "application/json" }, ['Unauthorized'.to_json]]
    end
  end

end
