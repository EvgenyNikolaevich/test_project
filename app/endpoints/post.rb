# frozen_string_literal: true

module Endpoints
  class Post < ApiController
    post '/posts', provides: :json do
      submit! form: Domains::Post::Forms::CreatePost, with: params do |form|
        check! form.result do |post|
          # I think we should return 201, not 200
          status 200
          Domains::Post::Serializer.serialize(post.data).to_json
        end
      end
    end

    post '/posts/rate', provides: :json do
      submit! form: Domains::Post::Forms::RatePost, with: params do |form|
        check! form.result do |_result|
          status 200
        end
      end
    end

    get '/posts', provides: :json do
      check! Domains::Post::Sequences::FindPosts.call(number: params[:number]) do |result|
        status 200
        Domains::Post::Serializer.serialize(result.data, is_collection: true).to_json
      end
    end
  end
end
