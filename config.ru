require_relative './application.rb'
require_relative './app/middlewares/compression_middleware.rb'
require_relative './app/middlewares/auth_middleware.rb'

use CompressionMiddleware
use Rack::Reloader, 0
use AuthMiddleware 

run Application.new
