require './config/environment'

use Rack::MethodOverride
use ClientController
use ClientUserController
use CompanyUserController
use ProductController
use TransactionController
run ApplicationController
