require_relative './main_controller.rb'
require_relative '../services/authentication_service.rb'

class LoginController < MainController
  # /login
  def login
    username = params['username']
    password = params['password']

    token = { token: generate_token(username, password) }

    token ? success_response(token) : unauthorized_response

  end

  def generate_token(username, password)
    AuthenticationService.new(username, password).call
  end

  def success_response(token)
    build_response(token, status: 200) 
  end

  def unauthorized_response
    build_response('Unauthorized', status: 401)
  end

end
