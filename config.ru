# frozen_string_literal: true

require './config/environment'

use TodoController
use SimpleLoginController
use SkeletonsController
use UsernameAvailabilityController
use FilteringTableController

run HomeController
