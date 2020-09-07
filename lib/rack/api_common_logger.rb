# frozen_string_literal: true

module Rack
  # Disable logging for `GET /health` endpoint
  class ApiCommonLogger < CommonLogger
    def log(env, status, header, began_at)
      return if env['sinatra.route'] == 'GET /health'

      super
    end
  end
end
