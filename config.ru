require_relative './application.rb'
require_relative './compression_middleware.rb'

use CompressionMiddleware
use Rack::Reloader, 0
run Application.new
