# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require ::File.expand_path('../../config/environment',  __FILE__)
Rails.application.eager_load!

use ActionCable.server

run Rails.application
