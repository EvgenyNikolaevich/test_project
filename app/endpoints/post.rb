# frozen_string_literal: true

module Endpoints
  class Post < ApiController
    post '/posts', provides: :json do
      submit! form: Domains::Post::Forms::CreatePost, with: params do |form|
        check! form.result do |post|
          status 201
          Domains::Post::Serializers::Post.serialize(post.data).to_json
        end
      end
    end

    post '/posts/rate', provides: :json do
      submit! form: Domains::Post::Forms::RatePost, with: params do |form|
        check! form.result do |result|
          status 200
          result.data.to_json
        end
      end
    end

    get '/posts', provides: :json do
      check! Domains::Post::Sequences::FindTopPosts.call(number: params[:number]) do |result|
        status 200
        Domains::Post::Serializers::Post.serialize(result.data, is_collection: true).to_json
      end
    end

    get '/posts/ip', provides: :json do
      check! Domains::Post::Sequences::FindPostsWithSameIp.call do |result|
        status 200
        Domains::Post::Serializers::AuthorInfo.serialize(result.data, is_collection: true).to_json
      end
    end
  end
end
