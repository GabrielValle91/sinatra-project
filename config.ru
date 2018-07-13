require './config/environment'

use Rack::MethodOverride
use ClientController
use UserController
use ProductController
use TransactionController
run ApplicationController
