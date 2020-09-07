# frozen_string_literal: true

module Endpoints
  class Post < ApiController
    post '/posts', provides: :json do
      submit! form: Domains::Post::Forms::CreatePost, with: params do |form|
        # check! form.result do |create_order|
        #   status 201
        #   Domains::Post::Serializers::Order.serialize(create_order.data).to_json
        # end
      end
    end
  end
end
