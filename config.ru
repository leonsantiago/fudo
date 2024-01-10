require_relative './application.rb'
require_relative './app/middlewares/compression_middleware.rb'
require_relative './app/middlewares/auth_middleware.rb'

openapi_file_path = File.expand_path('openapi.yaml', __dir__)
authors_file_path = File.expand_path('AUTHORS', __dir__)

use CompressionMiddleware
use Rack::Reloader, 0
use AuthMiddleware 

map '/openapi.yaml' do
  run lambda { |env| [200, { 'Content-Type' => 'text/yaml' }, [File.read(openapi_file_path)]] }
end
map '/AUTHORS' do
  run lambda {|env|
    [
      200,
    {
      'Content-Type' => 'text/yaml',
      'Cache-Control' => 'public, max-age=15'
    },
      [File.read(authors_file_path)]
    ]
  }
end
run Application.new
