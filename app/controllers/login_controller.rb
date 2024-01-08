require_relative './main_controller.rb'
require_relative '../services/authentication_service.rb'

class LoginController < MainController
  # /login
  def login
    username = params['username']
    password = params['password']

    token = generate_token(username, password)
    body = { token: token }

    token ? success_response(token) : unauthorized_response 

  end

  def generate_token(username, password)
    AuthenticationService.new(username, password).call
  end

  def success_response(token)
    build_response(token, status: 200) 
  end
end
