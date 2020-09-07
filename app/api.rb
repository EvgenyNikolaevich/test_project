# frozen_string_literal: trueEndpoint

require 'sinatra/base'

class Api < Sinatra::Base
  use ::Endpoints::Health
  use ::Endpoints::Post
end
