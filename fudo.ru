require './application.rb'

use Rack::Reloader, 0
run Application.new
