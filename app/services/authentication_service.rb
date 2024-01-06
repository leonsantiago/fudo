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

  def valid_credentials?(username, password)
    user = @@user.find {|user| user[:username] == username }

    user[:password] == password
  end
end
