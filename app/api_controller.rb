# frozen_string_literal: true

require 'sinatra/base'

class ApiController < Sinatra::Base
  include Endpoints::Helper

  set :show_exceptions, false
  set :raise_errors, true

  error 404 do
    status 404
    JSONAPI::Serializer.serialize_errors('Not found').to_json
  end

  error 500 do
    status 500
    JSONAPI::Serializer.serialize_errors('Internal server error').to_json
  end
end
