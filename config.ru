require './tracking'

use Rack::RewindableInput::Middleware

run Tracking::API
