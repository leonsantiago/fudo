require 'json'
require 'byebug'

class MainController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  private

  def build_response(body, status: 200)
    [status, { "Content-Type" => "application/json" }, [body.to_json]]
  end

  def redirect_to(uri)
    [302, { "Location" => uri, 'Content-Type' => 'application/json' }, []]
  end

  def unauthorized_response
    build_response('Unauthorized', status: 401)
  end

  def params
    request.params
  end
end
