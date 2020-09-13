# frozen_string_literal: true

module Endpoints
  class Health < Sinatra::Base
    get '/health' do
      'hello'
    end
  end
end
