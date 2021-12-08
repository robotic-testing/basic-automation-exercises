# frozen_string_literal: true

require './config/environment'

use TodoController
use SimpleLoginController
use SkeletonsController
use UsernameAvailabilityController

run HomeController
