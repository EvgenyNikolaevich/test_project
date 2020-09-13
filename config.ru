# frozen_string_literal: false

require 'rack'
require 'rack/contrib'
require_relative 'config/boot'

use Rack::ApiCommonLogger
use Rack::PostBodyContentTypeParser
use Bugsnag::Rack

use Rack::Cors do
  allow do
    origins  '*'
    resource '*', headers: :any, methods: %i[get post put patch delete options]
  end
end

# TODO: Share static via Rack only in development mode
run Rack::URLMap.new(
  '/api/v1' => Api
)
