require './config/environment'

use Rack::MethodOverride

use UsersController
use StatesController
use TrailsController
run ApplicationController
