require 'jwt'

class AuthenticationService
  attr_accessor :username, :password
  @@user =[
    username: 'username',
    password: 'easypassword'
  ]
  

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    if valid_credentials?(username, password)
      token = generate_token(username)
    end
  end

  def generate_token(username)
    payload = { sub: username, exp: Time.now.to_i + 3600 }

    JWT.encode(payload, 'thissecretkey', 'HS256')
  end

  def self.extract_token(request)
    auth_header = request.env['HTTP_AUTHORIZATION']
    return unless auth_header

    _, token = auth_header.split(' ', 2)
    return token
  end

  def self.authenticate?(request)
    begin
      token = self.extract_token(request)
      decoded_token = JWT.decode(token, 'thissecretkey', true, algorithm: 'HS256')
      return true
    rescue JWT::DecodeError
      return false 
    end

  end

  def valid_credentials?(username, password)
    user = @@user.find {|user| user[:username] == username }

    user[:password] == password
  end

  def self.not_found
    [404, { "Content-Type" => "application/json" }, ['Not found'.to_json]]
  end

end
