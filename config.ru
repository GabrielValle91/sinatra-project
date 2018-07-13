require './config/environment'

use Rack::Session::Cookie
use Rack::Flash
use Rack::MethodOverride
use ClientController
use UserController
use ProductController
use TransactionController
run ApplicationController
